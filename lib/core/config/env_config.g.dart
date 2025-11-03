// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'env_config.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$envConfigHash() => r'0a3fe574bd053fdb7a89cc5f625c0bb2370862e4';

/// Riverpod provider for EnvConfig
///
/// This provider makes the environment configuration available throughout the app.
/// It's a singleton that loads configuration once and reuses it.
///
/// Copied from [envConfig].
@ProviderFor(envConfig)
final envConfigProvider = Provider<EnvConfig>.internal(
  envConfig,
  name: r'envConfigProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$envConfigHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef EnvConfigRef = ProviderRef<EnvConfig>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
