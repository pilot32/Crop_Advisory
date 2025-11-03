# Crop Advisory - Smart Farming Assistant

A multilingual, AI-powered mobile application that provides real-time, location-specific crop advisory services to small and marginal farmers in India.

## Problem Statement

Small and marginal farmers in India rely on traditional knowledge, local shopkeepers, or guesswork for crop selection, pest control, and fertilizer use. This leads to:
- Poor crop yield
- Excessive input costs
- Environmental degradation due to chemical overuse
- Language barriers and low digital literacy limiting access to modern agri-tech

## Solution

Crop Advisory empowers farmers with scientific insights in their native language, helping them make informed decisions through:
- AI-based personalized recommendations
- Real-time weather and soil data
- Pest/disease detection via image analysis
- Market price tracking
- Voice support for low-literate users

## Features

### Core Features
- **Multilingual AI Chatbot**: Powered by Google Gemini API for intelligent crop advisory
- **Real-time Crop Advisory**: Location-specific recommendations based on soil type, weather, and crop history
- **Soil Health Analysis**: Personalized fertilizer and soil management guidance
- **Weather Alerts**: Weather-based predictions and alerts
- **Pest/Disease Detection**: Upload images for AI-powered pest and disease identification
- **Market Price Tracking**: Real-time market prices for crops
- **Voice Support**: Voice input/output for low-literate farmers
- **Offline Mode**: Basic features available without internet connectivity

### Technical Features
- **Authentication**: Secure user authentication via Supabase
- **Database**: Cloud-based data storage using Supabase
- **AI Integration**: Google Gemini API for intelligent responses
- **Cross-platform**: Built with Flutter for Android and iOS

## Tech Stack

- **Frontend**: Flutter/Dart
- **Backend**: Supabase (Database + Authentication)
- **AI/ML**: Google Gemini API
- **State Management**: Provider/Riverpod
- **Local Storage**: Hive/SharedPreferences
- **Image Processing**: TensorFlow Lite (optional for offline detection)

## Prerequisites

Before running this project, ensure you have:

- Flutter SDK (>= 3.0.0)
- Dart SDK (>= 3.0.0)
- Android Studio / Xcode (for mobile development)
- Git

## Setup Instructions

### 1. Clone the Repository

```bash
git clone <repository-url>
cd crop_advisory
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Configure Environment Variables

Create a `.env` file in the root directory:

```env
SUPABASE_URL=your_supabase_project_url
SUPABASE_ANON_KEY=your_supabase_anon_key
GEMINI_API_KEY=your_gemini_api_key
```

### 4. Supabase Setup

1. Create a project at [supabase.com](https://supabase.com)
2. Copy your project URL and anon key
3. Set up database tables (schemas provided in `/supabase` folder)
4. Enable authentication methods (Email, Phone, etc.)

### 5. Gemini API Setup

1. Get your API key from [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Add the key to your `.env` file

### 6. Run the Application

```bash
# For Android
flutter run

# For iOS
flutter run

# For a specific device
flutter run -d <device-id>
```

## Project Structure

```
crop_advisory/
├── lib/
│   ├── core/
│   │   ├── config/          # App configuration
│   │   ├── constants/       # Constants and enums
│   │   ├── utils/           # Utility functions
│   │   └── theme/           # App theme
│   ├── features/
│   │   ├── auth/            # Authentication
│   │   ├── home/            # Home dashboard
│   │   ├── chatbot/         # AI chatbot
│   │   ├── crop_advisory/   # Crop recommendations
│   │   ├── soil_health/     # Soil analysis
│   │   ├── weather/         # Weather alerts
│   │   ├── pest_detection/  # Pest/disease detection
│   │   ├── market_prices/   # Market price tracking
│   │   └── profile/         # User profile
│   ├── models/              # Data models
│   ├── services/            # API services
│   ├── widgets/             # Reusable widgets
│   └── main.dart            # Entry point
├── assets/
│   ├── images/
│   ├── icons/
│   └── translations/        # Language files
├── test/                    # Unit and widget tests
├── supabase/                # Database schemas
└── pubspec.yaml
```

## Key Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  supabase_flutter: ^latest
  google_generative_ai: ^latest
  provider: ^latest
  image_picker: ^latest
  geolocator: ^latest
  permission_handler: ^latest
  speech_to_text: ^latest
  flutter_tts: ^latest
  cached_network_image: ^latest
  intl: ^latest
  shared_preferences: ^latest
```

## Supported Languages

- English
- Hindi (हिंदी)
- Bengali (বাংলা)
- Telugu (తెలుగు)
- Marathi (मराठी)
- Tamil (தமிழ்)
- Gujarati (ગુજરાતી)
- Kannada (ಕನ್ನಡ)
- Malayalam (മലയാളം)
- Punjabi (ਪੰਜਾਬੀ)

## Expected Outcomes

- Increased crop productivity for small farmers
- Reduced input costs through optimized fertilizer use
- Sustainable farming practices
- Improved farmer livelihoods
- Enhanced food security
- Reduced environmental impact

## Contributing

Contributions are welcome! Please read our contributing guidelines before submitting PRs.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For issues and questions, please open an issue on GitHub or contact the development team.

## Roadmap

- [ ] Phase 1: Core app with chatbot and authentication
- [ ] Phase 2: Pest detection and soil analysis
- [ ] Phase 3: Weather integration and market prices
- [ ] Phase 4: Voice support and multilingual expansion
- [ ] Phase 5: Offline mode and advanced analytics
- [ ] Phase 6: Community features and farmer networks

## Acknowledgments

Built to empower small and marginal farmers in India with modern agricultural technology.
