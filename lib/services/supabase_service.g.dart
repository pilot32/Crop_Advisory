// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supabase_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$supabaseClientHash() => r'deacb610ba5a2a6164a9836f0ed10a1e9de80426';

/// Supabase client provider
///
/// Provides access to the initialized Supabase client throughout the app.
/// This is a singleton that persists for the lifetime of the app.
///
/// Copied from [supabaseClient].
@ProviderFor(supabaseClient)
final supabaseClientProvider = Provider<SupabaseClient>.internal(
  supabaseClient,
  name: r'supabaseClientProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$supabaseClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SupabaseClientRef = ProviderRef<SupabaseClient>;
String _$supabaseServiceHash() => r'e3697ec3ef90e9deca67e10f019643c5b5a40913';

/// Supabase service provider
///
/// Provides the SupabaseService instance with dependency injection.
///
/// Copied from [supabaseService].
@ProviderFor(supabaseService)
final supabaseServiceProvider = Provider<SupabaseService>.internal(
  supabaseService,
  name: r'supabaseServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$supabaseServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SupabaseServiceRef = ProviderRef<SupabaseService>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
