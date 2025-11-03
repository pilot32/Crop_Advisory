/// Authentication Provider
/// 
/// Manages authentication state and user authentication operations

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../services/supabase_service.dart';
import '../../../models/user_model.dart';
import '../../../core/constants/app_constants.dart';

part 'auth_provider.g.dart';

/// Auth state provider - watches for authentication changes
@riverpod
Stream<AuthState> authStateChanges(AuthStateChangesRef ref) {
  final supabaseService = ref.watch(supabaseServiceProvider);
  return supabaseService.authStateChanges;
}

/// Current user provider
@riverpod
User? currentUser(CurrentUserRef ref) {
  final supabaseService = ref.watch(supabaseServiceProvider);
  return supabaseService.currentUser;
}

/// Auth controller provider
@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {
    // Initialize state
  }

  /// Sign up with email and password
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String fullName,
    String? phoneNumber,
  }) async {
    state = const AsyncLoading();
    
    state = await AsyncValue.guard(() async {
      final supabaseService = ref.read(supabaseServiceProvider);
      
      final response = await supabaseService.signUpWithEmail(
        email: email,
        password: password,
        userData: {
          'full_name': fullName,
          'phone_number': phoneNumber,
        },
      );

      if (response.user == null) {
        throw Exception('Sign up failed. Please try again.');
      }

      // Create user profile in database
      if (response.user != null) {
        await supabaseService.insert(
          table: DatabaseConstants.usersTable,
          data: {
            'id': response.user!.id,
            'email': email,
            'full_name': fullName,
            'phone_number': phoneNumber,
            'created_at': DateTime.now().toIso8601String(),
          },
        );
      }
    });
  }

  /// Sign in with email and password
  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    
    state = await AsyncValue.guard(() async {
      final supabaseService = ref.read(supabaseServiceProvider);
      
      final response = await supabaseService.signInWithEmail(
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
    state = const AsyncLoading();
    
    state = await AsyncValue.guard(() async {
      final supabaseService = ref.read(supabaseServiceProvider);
      await supabaseService.signInWithPhone(phoneNumber);
    });
  }

  /// Verify phone OTP
  Future<void> verifyPhoneOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    state = const AsyncLoading();
    
    state = await AsyncValue.guard(() async {
      final supabaseService = ref.read(supabaseServiceProvider);
      
      final response = await supabaseService.verifyPhoneOtp(
        phone: phoneNumber,
        token: otp,
      );

      if (response.user == null) {
        throw Exception('OTP verification failed. Please try again.');
      }
    });
  }

  /// Sign out
  Future<void> signOut() async {
    state = const AsyncLoading();
    
    state = await AsyncValue.guard(() async {
      final supabaseService = ref.read(supabaseServiceProvider);
      await supabaseService.signOut();
    });
  }

  /// Reset state
  void reset() {
    state = const AsyncData(null);
  }
}
