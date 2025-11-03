// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gemini_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$geminiModelHash() => r'f320cf0baa42b47066b247e4f15c3cdfb27b455a';

/// Gemini model provider
///
/// Provides access to the Gemini generative model with API key from environment.
/// This is a singleton that persists for the lifetime of the app.
///
/// Copied from [geminiModel].
@ProviderFor(geminiModel)
final geminiModelProvider = Provider<GenerativeModel>.internal(
  geminiModel,
  name: r'geminiModelProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$geminiModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GeminiModelRef = ProviderRef<GenerativeModel>;
String _$geminiVisionModelHash() => r'a054f56f39a97de45a13a7f0bce094df42762d4c';

/// Gemini vision model provider for image analysis
///
/// Provides access to Gemini Pro Vision model for image-based tasks like pest detection.
///
/// Copied from [geminiVisionModel].
@ProviderFor(geminiVisionModel)
final geminiVisionModelProvider = Provider<GenerativeModel>.internal(
  geminiVisionModel,
  name: r'geminiVisionModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$geminiVisionModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GeminiVisionModelRef = ProviderRef<GenerativeModel>;
String _$geminiServiceHash() => r'9e2a2e925628e21a10b670ab8f85e1cde5ca1372';

/// Gemini service provider
///
/// Provides the GeminiService instance with dependency injection.
///
/// Copied from [geminiService].
@ProviderFor(geminiService)
final geminiServiceProvider = Provider<GeminiService>.internal(
  geminiService,
  name: r'geminiServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$geminiServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GeminiServiceRef = ProviderRef<GeminiService>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
