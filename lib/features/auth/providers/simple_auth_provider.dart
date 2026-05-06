/// Simple Authentication Provider
/// 
/// Simplified auth provider without code generation for quick development

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/constants/app_constants.dart';

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
          'id': response.user!.id,
          'email': email,
          'full_name': fullName,
          'phone_number': phoneNumber,
          'created_at': DateTime.now().toIso8601String(),
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

/// Alias for compatibility
final authProvider = authStateProvider;
