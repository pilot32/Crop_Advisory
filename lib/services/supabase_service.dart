/// Supabase Service
/// 
/// This service handles all interactions with Supabase backend including:
/// - Database operations (CRUD)
/// - Authentication
/// - Real-time subscriptions
/// - File storage operations

import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart';
import '../core/config/env_config.dart';

part 'supabase_service.g.dart';

/// Supabase client provider
/// 
/// Provides access to the initialized Supabase client throughout the app.
/// This is a singleton that persists for the lifetime of the app.
@Riverpod(keepAlive: true)
SupabaseClient supabaseClient(SupabaseClientRef ref) {
  return Supabase.instance.client;
}

/// Supabase service provider
/// 
/// Provides the SupabaseService instance with dependency injection.
@Riverpod(keepAlive: true)
SupabaseService supabaseService(SupabaseServiceRef ref) {
  final client = ref.watch(supabaseClientProvider);
  return SupabaseService(client);
}

/// Service class for Supabase operations
class SupabaseService {
  /// Supabase client instance
  final SupabaseClient _client;
  
  /// Logger instance for debugging and error tracking
  final Logger _logger = Logger();

  SupabaseService(this._client);

  // ============================================================================
  // AUTHENTICATION METHODS
  // ============================================================================

  /// Sign up a new user with email and password
  /// 
  /// Parameters:
  /// - [email]: User's email address
  /// - [password]: User's password
  /// - [userData]: Additional user profile data (optional)
  /// 
  /// Returns: AuthResponse containing user and session data
  /// Throws: AuthException if signup fails
  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
    Map<String, dynamic>? userData,
  }) async {
    try {
      _logger.i('Attempting to sign up user with email: $email');
      
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: userData,
      );
      
      _logger.i('User signed up successfully');
      return response;
    } catch (e) {
      _logger.e('Error signing up user: $e');
      rethrow;
    }
  }

  /// Sign in an existing user with email and password
  /// 
  /// Parameters:
  /// - [email]: User's email address
  /// - [password]: User's password
  /// 
  /// Returns: AuthResponse containing user and session data
  /// Throws: AuthException if signin fails
  Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      _logger.i('Attempting to sign in user with email: $email');
      
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      
      _logger.i('User signed in successfully');
      return response;
    } catch (e) {
      _logger.e('Error signing in user: $e');
      rethrow;
    }
  }

  /// Sign in with phone number and OTP
  /// 
  /// Parameters:
  /// - [phone]: User's phone number with country code
  /// 
  /// Returns: void (OTP sent to phone)
  /// Throws: AuthException if request fails
  Future<void> signInWithPhone(String phone) async {
    try {
      _logger.i('Sending OTP to phone: $phone');
      
      await _client.auth.signInWithOtp(
        phone: phone,
      );
      
      _logger.i('OTP sent successfully');
    } catch (e) {
      _logger.e('Error sending OTP: $e');
      rethrow;
    }
  }

  /// Verify phone number with OTP
  /// 
  /// Parameters:
  /// - [phone]: User's phone number
  /// - [token]: OTP code received
  /// 
  /// Returns: AuthResponse containing user and session data
  /// Throws: AuthException if verification fails
  Future<AuthResponse> verifyPhoneOtp({
    required String phone,
    required String token,
  }) async {
    try {
      _logger.i('Verifying OTP for phone: $phone');
      
      final response = await _client.auth.verifyOTP(
        phone: phone,
        token: token,
        type: OtpType.sms,
      );
      
      _logger.i('Phone verified successfully');
      return response;
    } catch (e) {
      _logger.e('Error verifying OTP: $e');
      rethrow;
    }
  }

  /// Sign out the current user
  /// 
  /// Returns: void
  /// Throws: AuthException if signout fails
  Future<void> signOut() async {
    try {
      _logger.i('Signing out user');
      await _client.auth.signOut();
      _logger.i('User signed out successfully');
    } catch (e) {
      _logger.e('Error signing out: $e');
      rethrow;
    }
  }

  /// Get current authenticated user
  /// 
  /// Returns: User object if authenticated, null otherwise
  User? get currentUser => _client.auth.currentUser;

  /// Get current session
  /// 
  /// Returns: Session object if authenticated, null otherwise
  Session? get currentSession => _client.auth.currentSession;

  /// Stream of authentication state changes
  /// 
  /// Emits AuthState whenever user signs in, signs out, or token refreshes
  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;

  // ============================================================================
  // DATABASE METHODS
  // ============================================================================

  /// Insert a new record into a table
  /// 
  /// Parameters:
  /// - [table]: Name of the database table
  /// - [data]: Map containing the data to insert
  /// 
  /// Returns: Inserted data
  /// Throws: PostgrestException if insert fails
  Future<dynamic> insert({
    required String table,
    required Map<String, dynamic> data,
  }) async {
    try {
      _logger.i('Inserting data into table: $table');
      
      final response = await _client
          .from(table)
          .insert(data)
          .select()
          .single();
      
      _logger.i('Data inserted successfully');
      return response;
    } catch (e) {
      _logger.e('Error inserting data: $e');
      rethrow;
    }
  }

  /// Update an existing record in a table
  /// 
  /// Parameters:
  /// - [table]: Name of the database table
  /// - [data]: Map containing the data to update
  /// - [id]: ID of the record to update
  /// 
  /// Returns: Updated data
  /// Throws: PostgrestException if update fails
  Future<dynamic> update({
    required String table,
    required Map<String, dynamic> data,
    required String id,
  }) async {
    try {
      _logger.i('Updating data in table: $table with id: $id');
      
      final response = await _client
          .from(table)
          .update(data)
          .eq('id', id)
          .select()
          .single();
      
      _logger.i('Data updated successfully');
      return response;
    } catch (e) {
      _logger.e('Error updating data: $e');
      rethrow;
    }
  }

  /// Delete a record from a table
  /// 
  /// Parameters:
  /// - [table]: Name of the database table
  /// - [id]: ID of the record to delete
  /// 
  /// Returns: void
  /// Throws: PostgrestException if delete fails
  Future<void> delete({
    required String table,
    required String id,
  }) async {
    try {
      _logger.i('Deleting data from table: $table with id: $id');
      
      await _client
          .from(table)
          .delete()
          .eq('id', id);
      
      _logger.i('Data deleted successfully');
    } catch (e) {
      _logger.e('Error deleting data: $e');
      rethrow;
    }
  }

  /// Fetch a single record from a table
  /// 
  /// Parameters:
  /// - [table]: Name of the database table
  /// - [id]: ID of the record to fetch
  /// 
  /// Returns: Record data as Map
  /// Throws: PostgrestException if fetch fails
  Future<Map<String, dynamic>> fetchOne({
    required String table,
    required String id,
  }) async {
    try {
      _logger.i('Fetching record from table: $table with id: $id');
      
      final response = await _client
          .from(table)
          .select()
          .eq('id', id)
          .single();
      
      _logger.i('Record fetched successfully');
      return response;
    } catch (e) {
      _logger.e('Error fetching record: $e');
      rethrow;
    }
  }

  /// Fetch multiple records from a table with optional filters
  /// 
  /// Parameters:
  /// - [table]: Name of the database table
  /// - [filters]: Map of column-value pairs to filter by
  /// - [orderBy]: Column to order results by
  /// - [ascending]: Sort order (default: true)
  /// - [limit]: Maximum number of records to return
  /// 
  /// Returns: List of records
  /// Throws: PostgrestException if fetch fails
  Future<List<Map<String, dynamic>>> fetchMany({
    required String table,
    Map<String, dynamic>? filters,
    String? orderBy,
    bool ascending = true,
    int? limit,
  }) async {
    try {
      _logger.i('Fetching records from table: $table');
      
      var query = _client.from(table).select();
      
      // Apply filters if provided
      if (filters != null) {
        filters.forEach((column, value) {
          query = query.eq(column, value);
        });
      }
      
      // Apply ordering if provided
      if (orderBy != null) {
        query = query.order(orderBy, ascending: ascending) as dynamic;
      }
      
      // Apply limit if provided
      if (limit != null) {
        query = query.limit(limit) as dynamic;
      }
      
      final response = await query;
      
      _logger.i('Records fetched successfully: ${response.length} records');
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      _logger.e('Error fetching records: $e');
      rethrow;
    }
  }

  // ============================================================================
  // FILE STORAGE METHODS
  // ============================================================================

  /// Upload a file to Supabase storage
  /// 
  /// Parameters:
  /// - [bucket]: Name of the storage bucket
  /// - [path]: Path where the file should be stored
  /// - [file]: File data as bytes
  /// 
  /// Returns: File path in storage
  /// Throws: StorageException if upload fails
  Future<String> uploadFile({
    required String bucket,
    required String path,
    required List<int> file,
  }) async {
    try {
      _logger.i('Uploading file to bucket: $bucket at path: $path');
      
      await _client.storage
          .from(bucket)
          .uploadBinary(path, Uint8List.fromList(file));
      
      _logger.i('File uploaded successfully');
      return path;
    } catch (e) {
      _logger.e('Error uploading file: $e');
      rethrow;
    }
  }

  /// Get public URL for a file in storage
  /// 
  /// Parameters:
  /// - [bucket]: Name of the storage bucket
  /// - [path]: Path of the file
  /// 
  /// Returns: Public URL string
  String getPublicUrl({
    required String bucket,
    required String path,
  }) {
    try {
      _logger.i('Getting public URL for file: $path in bucket: $bucket');
      return _client.storage.from(bucket).getPublicUrl(path);
    } catch (e) {
      _logger.e('Error getting public URL: $e');
      rethrow;
    }
  }

  /// Delete a file from storage
  /// 
  /// Parameters:
  /// - [bucket]: Name of the storage bucket
  /// - [path]: Path of the file to delete
  /// 
  /// Returns: void
  /// Throws: StorageException if delete fails
  Future<void> deleteFile({
    required String bucket,
    required String path,
  }) async {
    try {
      _logger.i('Deleting file from bucket: $bucket at path: $path');
      
      await _client.storage
          .from(bucket)
          .remove([path]);
      
      _logger.i('File deleted successfully');
    } catch (e) {
      _logger.e('Error deleting file: $e');
      rethrow;
    }
  }
}
