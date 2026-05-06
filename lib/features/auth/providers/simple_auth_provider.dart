/// Simple Authentication Provider
/// 
/// Simplified auth provider without code generation for quick development

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/constants/app_constants.dart';
import '../../../services/biometric_service.dart';

/// Current user provider
final currentUserProvider = Provider<User?>((ref) {
  final supabase = Supabase.instance.client;
  return supabase.auth.currentUser;
});

/// Auth state provider
final authStateProvider = StateNotifierProvider<AuthNotifier, AsyncValue<void>>((ref) {
  return AuthNotifier();
});

/// Auth notifier for managing authentication state
class AuthNotifier extends StateNotifier<AsyncValue<void>> {
  AuthNotifier() : super(const AsyncValue.data(null));

  final _supabase = Supabase.instance.client;

  /// Sign up with email and password
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String fullName,
    String? phoneNumber,
  }) async {
    state = const AsyncValue.loading();
    
    state = await AsyncValue.guard(() async {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': fullName,
          'phone_number': phoneNumber,
        },
      );

      if (response.user == null) {
        throw Exception('Sign up failed. Please try again.');
      }

      // Create user profile in database
      if (response.user != null) {
        await _supabase.from(DatabaseConstants.farmerProfilesTable).insert({
          'user_id': response.user!.id,
          //'email': email,
          'full_name': fullName,
          'phone_number': phoneNumber,
          //'created_at': DateTime.now().toIso8601String(),
        });
      }
    });
  }

  /// Sign in with email and password
  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    
    state = await AsyncValue.guard(() async {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw Exception('Sign in failed. Please check your credentials.');
      }
    });
  }

  /// Sign in with phone OTP
  Future<void> signInWithPhone(String phoneNumber) async {
    state = const AsyncValue.loading();
    
    state = await AsyncValue.guard(() async {
      await _supabase.auth.signInWithOtp(phone: phoneNumber);
    });
  }

  /// Verify phone OTP
  Future<void> verifyPhoneOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    state = const AsyncValue.loading();
    
    state = await AsyncValue.guard(() async {
      final response = await _supabase.auth.verifyOTP(
        phone: phoneNumber,
        token: otp,
        type: OtpType.sms,
      );

      if (response.user == null) {
        throw Exception('OTP verification failed. Please try again.');
      }
    });
  }

  /// Sign out
  Future<void> signOut() async {
    state = const AsyncValue.loading();
    
    state = await AsyncValue.guard(() async {
      await _supabase.auth.signOut();
    });
  }

  /// Reset state
  void reset() {
    state = const AsyncValue.data(null);
  }
}
/// Biometric service provider
final biometricServiceProvider = Provider<BiometricService>((ref) {
  return BiometricService();
});
/// Biometric Auth Notifier
///
/// Handles biometric login flow: authenticate → retrieve credentials → sign in
class BiometricAuthNotifier extends StateNotifier<AsyncValue<void>> {
  final BiometricService _bioService;
  final AuthNotifier _authNotifier;

  BiometricAuthNotifier(this._bioService, this._authNotifier)
      : super(const AsyncValue.data(null));

  /// Check if biometric login is available and enabled
  Future<bool> isBiometricAvailable() async {
    final canAuth = await _bioService.canAuthenticate();
    final isEnabled = await _bioService.isEnabled();
    return canAuth && isEnabled;
  }

  /// Perform biometric login
  ///
  /// 1. Show biometric prompt
  /// 2. If authenticated, retrieve stored credentials
  /// 3. Sign in with Supabase using stored credentials
  Future<void> authenticateWithBiometrics() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      // Step 1: Biometric scan
      final authenticated = await _bioService.authenticate(
        reason: 'Scan your fingerprint to login',
      );
      if (!authenticated) {
        throw Exception('Biometric authentication cancelled');
      }

      // Step 2: Get stored credentials
      final creds = await _bioService.getCredentials();
      if (creds == null) {
        throw Exception('No saved credentials found. Please login with email/password.');
      }

      // Step 3: Sign in with Supabase
      await _authNotifier.signInWithEmail(
        email: creds['email']!,
        password: creds['password']!,
      );
    });
  }

  /// Save credentials after successful email login (user opted in)
  Future<void> enableBiometric({
    required String email,
    required String password,
  }) async {
    await _bioService.saveCredentials(email: email, password: password);
  }

  /// Disable biometric login (clears stored credentials)
  Future<void> disableBiometric() async {
    await _bioService.clearCredentials();
  }

  /// Check if biometric hardware is available
  Future<bool> canUseBiometric() async {
    return await _bioService.canAuthenticate();
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}

/// Biometric auth provider
final biometricAuthProvider = StateNotifierProvider<BiometricAuthNotifier, AsyncValue<void>>((ref) {
  final bioService = ref.watch(biometricServiceProvider);
  final authNotifier = ref.watch(authStateProvider.notifier);
  return BiometricAuthNotifier(bioService, authNotifier);
});
/// Alias for compatibility
final authProvider = authStateProvider;
