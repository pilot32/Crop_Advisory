-- Crop Advisory Database Schema
-- 
-- This file contains all table definitions for the Crop Advisory app.
-- Run this SQL in your Supabase SQL Editor to set up the database.

-- Enable necessary extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ============================================================================
-- FARMER PROFILES TABLE
-- Stores farmer profile information beyond basic auth
-- ============================================================================
CREATE TABLE IF NOT EXISTS farmer_profiles (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
    full_name TEXT NOT NULL,
    phone_number TEXT,
    location TEXT, -- District/State
    preferred_language TEXT DEFAULT 'en',
    farm_size_acres DECIMAL(10, 2),
    primary_crops TEXT[], -- Array of crops
    soil_type TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(user_id)
);

-- ============================================================================
-- CROPS TABLE
-- Reference data for different crop types
-- ============================================================================
CREATE TABLE IF NOT EXISTS crops (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL UNIQUE,
    scientific_name TEXT,
    category TEXT, -- Cereal, Pulse, Vegetable, etc.
    season TEXT[], -- Kharif, Rabi, Zaid
    description TEXT,
    image_url TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ============================================================================
-- ADVISORIES TABLE
-- Stores AI-generated crop advisories
-- ============================================================================
CREATE TABLE IF NOT EXISTS advisories (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
    crop_type TEXT NOT NULL,
    soil_type TEXT,
    season TEXT,
    location TEXT,
    advisory_text TEXT NOT NULL,
    language TEXT DEFAULT 'en',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Index for faster queries
CREATE INDEX IF NOT EXISTS idx_advisories_user_id ON advisories(user_id);
CREATE INDEX IF NOT EXISTS idx_advisories_created_at ON advisories(created_at DESC);

-- ============================================================================
-- CHAT HISTORY TABLE
-- Stores conversation history with AI chatbot
-- ============================================================================
CREATE TABLE IF NOT EXISTS chat_history (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
    message_role TEXT NOT NULL CHECK (message_role IN ('user', 'assistant')),
    message_content TEXT NOT NULL,
    language TEXT DEFAULT 'en',
    session_id UUID, -- Group messages by conversation session
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes for efficient queries
CREATE INDEX IF NOT EXISTS idx_chat_history_user_id ON chat_history(user_id);
CREATE INDEX IF NOT EXISTS idx_chat_history_session_id ON chat_history(session_id);
CREATE INDEX IF NOT EXISTS idx_chat_history_created_at ON chat_history(created_at DESC);

-- ============================================================================
-- SOIL DATA TABLE
-- Stores soil test results and health data
-- ============================================================================
CREATE TABLE IF NOT EXISTS soil_data (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
    farm_location TEXT,
    ph_level DECIMAL(4, 2),
    nitrogen_n DECIMAL(10, 2),
    phosphorus_p DECIMAL(10, 2),
    potassium_k DECIMAL(10, 2),
    organic_carbon DECIMAL(10, 2),
    soil_texture TEXT, -- Sandy, Loamy, Clay, etc.
    moisture_level TEXT, -- Low, Medium, High
    test_date DATE NOT NULL DEFAULT CURRENT_DATE,
    lab_name TEXT,
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Index for user queries
CREATE INDEX IF NOT EXISTS idx_soil_data_user_id ON soil_data(user_id);
CREATE INDEX IF NOT EXISTS idx_soil_data_test_date ON soil_data(test_date DESC);

-- ============================================================================
-- WEATHER DATA TABLE
-- Stores weather information for farmer locations
-- ============================================================================
CREATE TABLE IF NOT EXISTS weather_data (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    location TEXT NOT NULL,
    latitude DECIMAL(10, 6),
    longitude DECIMAL(10, 6),
    temperature DECIMAL(5, 2), -- in Celsius
    humidity DECIMAL(5, 2), -- percentage
    rainfall DECIMAL(10, 2), -- in mm
    wind_speed DECIMAL(5, 2), -- in km/h
    weather_condition TEXT, -- Sunny, Rainy, Cloudy, etc.
    forecast_date DATE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes for location and date queries
CREATE INDEX IF NOT EXISTS idx_weather_data_location ON weather_data(location);
CREATE INDEX IF NOT EXISTS idx_weather_data_forecast_date ON weather_data(forecast_date DESC);

-- ============================================================================
-- PEST DETECTION TABLE
-- Stores pest/disease detection results from image analysis
-- ============================================================================
CREATE TABLE IF NOT EXISTS pest_detection (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
    crop_type TEXT,
    image_url TEXT NOT NULL, -- Stored in Supabase Storage
    pest_name TEXT,
    disease_name TEXT,
    severity_level TEXT CHECK (severity_level IN ('mild', 'moderate', 'severe')),
    affected_parts TEXT[], -- Leaves, stems, fruits, etc.
    treatment_recommendation TEXT,
    ai_analysis TEXT NOT NULL, -- Full AI response
    confidence_score DECIMAL(5, 2), -- 0-100
    detection_date TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_pest_detection_user_id ON pest_detection(user_id);
CREATE INDEX IF NOT EXISTS idx_pest_detection_date ON pest_detection(detection_date DESC);

-- ============================================================================
-- MARKET PRICES TABLE
-- Stores crop market prices for different locations
-- ============================================================================
CREATE TABLE IF NOT EXISTS market_prices (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    crop_name TEXT NOT NULL,
    location TEXT NOT NULL, -- Market location
    state TEXT,
    district TEXT,
    price_min DECIMAL(10, 2), -- Minimum price in INR per quintal
    price_max DECIMAL(10, 2), -- Maximum price in INR per quintal
    price_modal DECIMAL(10, 2), -- Most common/modal price
    unit TEXT DEFAULT 'quintal',
    price_date DATE NOT NULL DEFAULT CURRENT_DATE,
    source TEXT, -- Data source (API, manual entry, etc.)
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes for efficient price lookups
CREATE INDEX IF NOT EXISTS idx_market_prices_crop ON market_prices(crop_name);
CREATE INDEX IF NOT EXISTS idx_market_prices_location ON market_prices(location);
CREATE INDEX IF NOT EXISTS idx_market_prices_date ON market_prices(price_date DESC);

-- ============================================================================
-- ROW LEVEL SECURITY (RLS) POLICIES
-- Ensures users can only access their own data
-- ============================================================================

-- Enable RLS on all tables
ALTER TABLE farmer_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE advisories ENABLE ROW LEVEL SECURITY;
ALTER TABLE chat_history ENABLE ROW LEVEL SECURITY;
ALTER TABLE soil_data ENABLE ROW LEVEL SECURITY;
ALTER TABLE pest_detection ENABLE ROW LEVEL SECURITY;

-- Farmer Profiles Policies
CREATE POLICY "Users can view their own profile"
    ON farmer_profiles FOR SELECT
    USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own profile"
    ON farmer_profiles FOR INSERT
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own profile"
    ON farmer_profiles FOR UPDATE
    USING (auth.uid() = user_id);

-- Advisories Policies
CREATE POLICY "Users can view their own advisories"
    ON advisories FOR SELECT
    USING (auth.uid() = user_id);

CREATE POLICY "Users can create their own advisories"
    ON advisories FOR INSERT
    WITH CHECK (auth.uid() = user_id);

-- Chat History Policies
CREATE POLICY "Users can view their own chat history"
    ON chat_history FOR SELECT
    USING (auth.uid() = user_id);

CREATE POLICY "Users can create their own chat messages"
    ON chat_history FOR INSERT
    WITH CHECK (auth.uid() = user_id);

-- Soil Data Policies
CREATE POLICY "Users can view their own soil data"
    ON soil_data FOR SELECT
    USING (auth.uid() = user_id);

CREATE POLICY "Users can create their own soil data"
    ON soil_data FOR INSERT
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own soil data"
    ON soil_data FOR UPDATE
    USING (auth.uid() = user_id);

-- Pest Detection Policies
CREATE POLICY "Users can view their own pest detections"
    ON pest_detection FOR SELECT
    USING (auth.uid() = user_id);

CREATE POLICY "Users can create their own pest detections"
    ON pest_detection FOR INSERT
    WITH CHECK (auth.uid() = user_id);

-- Crops table is public (read-only for all authenticated users)
ALTER TABLE crops ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Authenticated users can view crops"
    ON crops FOR SELECT
    TO authenticated
    USING (true);

-- Weather data is public (read-only for all authenticated users)
ALTER TABLE weather_data ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Authenticated users can view weather data"
    ON weather_data FOR SELECT
    TO authenticated
    USING (true);

-- Market prices are public (read-only for all authenticated users)
ALTER TABLE market_prices ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Authenticated users can view market prices"
    ON market_prices FOR SELECT
    TO authenticated
    USING (true);

-- ============================================================================
-- FUNCTIONS AND TRIGGERS
-- ============================================================================

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Triggers to auto-update updated_at
CREATE TRIGGER update_farmer_profiles_updated_at
    BEFORE UPDATE ON farmer_profiles
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_crops_updated_at
    BEFORE UPDATE ON crops
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_soil_data_updated_at
    BEFORE UPDATE ON soil_data
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- ============================================================================
-- SAMPLE DATA (Optional - for testing)
-- ============================================================================

-- Insert some common Indian crops
INSERT INTO crops (name, scientific_name, category, season, description) VALUES
('Rice', 'Oryza sativa', 'Cereal', ARRAY['kharif'], 'Major cereal crop grown during monsoon season'),
('Wheat', 'Triticum aestivum', 'Cereal', ARRAY['rabi'], 'Primary winter crop in northern India'),
('Cotton', 'Gossypium', 'Cash Crop', ARRAY['kharif'], 'Important fiber crop'),
('Sugarcane', 'Saccharum officinarum', 'Cash Crop', ARRAY['kharif', 'rabi'], 'Major sugar-producing crop'),
('Maize', 'Zea mays', 'Cereal', ARRAY['kharif', 'rabi'], 'Versatile crop grown in multiple seasons'),
('Pulses', 'Fabaceae', 'Pulse', ARRAY['rabi'], 'Protein-rich legume crops'),
('Tomato', 'Solanum lycopersicum', 'Vegetable', ARRAY['kharif', 'rabi'], 'Popular vegetable crop'),
('Potato', 'Solanum tuberosum', 'Vegetable', ARRAY['rabi'], 'Widely grown tuber crop')
ON CONFLICT (name) DO NOTHING;

-- Note: Run this schema in your Supabase SQL Editor
-- Then test the RLS policies and functions
