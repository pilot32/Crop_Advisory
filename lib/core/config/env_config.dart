/// Environment Configuration
/// 
/// This file manages all environment variables and app configuration.
/// It uses flutter_dotenv to load environment variables from .env file.
/// All sensitive data like API keys should be stored in .env and never committed to git.

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'env_config.g.dart';

/// Environment configuration class that holds all app configuration values
class EnvConfig {
  /// Supabase project URL for backend connection
  final String supabaseUrl;
  
  /// Supabase anonymous key for public API access
  final String supabaseAnonKey;
  
  /// Google Gemini API key for AI chatbot functionality
  final String geminiApiKey;
  
  /// Weather API key for weather data (optional)
  final String? weatherApiKey;
  
  /// Market price API key (optional)
  final String? marketApiKey;

  const EnvConfig({
    required this.supabaseUrl,
    required this.supabaseAnonKey,
    required this.geminiApiKey,
    this.weatherApiKey,
    this.marketApiKey,
  });

  /// Factory constructor to create EnvConfig from environment variables
  factory EnvConfig.fromEnv() {
    return EnvConfig(
      supabaseUrl: dotenv.get('SUPABASE_URL', fallback: ''),
      supabaseAnonKey: dotenv.get('SUPABASE_ANON_KEY', fallback: ''),
      geminiApiKey: dotenv.get('GEMINI_API_KEY', fallback: ''),
      weatherApiKey: dotenv.maybeGet('WEATHER_API_KEY'),
      marketApiKey: dotenv.maybeGet('MARKET_API_KEY'),
    );
  }

  /// Validates that all required configuration values are present
  bool get isValid {
    return supabaseUrl.isNotEmpty &&
        supabaseAnonKey.isNotEmpty &&
        geminiApiKey.isNotEmpty;
  }
}

/// Riverpod provider for EnvConfig
/// 
/// This provider makes the environment configuration available throughout the app.
/// It's a singleton that loads configuration once and reuses it.
@Riverpod(keepAlive: true)
EnvConfig envConfig(EnvConfigRef ref) {
  return EnvConfig.fromEnv();
}
