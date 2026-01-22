# Supabase Integration Guide

## 📋 Overview

Your Crop Advisory app already has Supabase fully integrated! This guide will help you understand how to use it effectively.

## ✅ What's Already Set Up

### 1. **Supabase Service** (`lib/services/supabase_service.dart`)
A complete service class with methods for:
- ✅ Authentication (email, phone, OTP)
- ✅ Database operations (CRUD)
- ✅ File storage
- ✅ Real-time subscriptions

### 2. **Initialization** (`lib/main.dart`)
Supabase is automatically initialized when the app starts (lines 79-88).

### 3. **Environment Configuration** (`.env` file)
Your app loads Supabase credentials from the `.env` file.

---

## 🚀 Getting Started

### Step 1: Set Up Your Supabase Project

1. **Go to [Supabase Dashboard](https://supabase.com/dashboard)**
2. **Create a new project** (or use existing one)
3. **Get your credentials:**
   - Go to Settings → API
   - Copy the **Project URL**
   - Copy the **anon/public key**

### Step 2: Configure Environment Variables

1. **Open your `.env` file** (in the root directory)
2. **Add your Supabase credentials:**

```env
# Supabase Configuration
SUPABASE_URL=https://your-project-id.supabase.co
SUPABASE_ANON_KEY=your-anon-key-here

# Other configurations...
GEMINI_API_KEY=your_gemini_api_key_here
WEATHER_API_KEY=your_weather_api_key_here
```

3. **Save the file**

### Step 3: Restart Your App

After updating the `.env` file, restart your Flutter app:

```bash
# Stop the current app (Ctrl+C in terminal)
# Then run again
flutter run
```

---

## 📊 Setting Up Your Database

### Create Tables in Supabase

Go to your Supabase Dashboard → SQL Editor and run these queries:

#### 1. **Users Profile Table**
```sql
CREATE TABLE farmer_profiles (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES auth.users NOT NULL,
  name TEXT,
  phone TEXT,
  location TEXT,
  farm_size NUMERIC,
  crops JSONB,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Enable Row Level Security
ALTER TABLE farmer_profiles ENABLE ROW LEVEL SECURITY;

-- Policy: Users can only read/write their own profile
CREATE POLICY "Users can manage own profile"
  ON farmer_profiles
  FOR ALL
  USING (auth.uid() = user_id);
```

#### 2. **Chat History Table**
```sql
CREATE TABLE chat_history (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES auth.users NOT NULL,
  message TEXT NOT NULL,
  response TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

ALTER TABLE chat_history ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can manage own chat history"
  ON chat_history
  FOR ALL
  USING (auth.uid() = user_id);
```

#### 3. **Advisories Table**
```sql
CREATE TABLE advisories (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES auth.users NOT NULL,
  crop_name TEXT NOT NULL,
  advisory_type TEXT NOT NULL,
  content TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

ALTER TABLE advisories ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can manage own advisories"
  ON advisories
  FOR ALL
  USING (auth.uid() = user_id);
```

---

## 🔐 Using Authentication

### Example 1: Sign Up with Email

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/supabase_service.dart';

class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final supabaseService = ref.watch(supabaseServiceProvider);
    
    return ElevatedButton(
      onPressed: () async {
        try {
          final response = await supabaseService.signUpWithEmail(
            email: 'farmer@example.com',
            password: 'secure_password',
            userData: {
              'name': 'John Farmer',
              'phone': '+91-9876543210',
            },
          );
          
          print('User signed up: ${response.user?.email}');
        } catch (e) {
          print('Error: $e');
        }
      },
      child: Text('Sign Up'),
    );
  }
}
```

### Example 2: Sign In with Email

```dart
try {
  final response = await supabaseService.signInWithEmail(
    email: 'farmer@example.com',
    password: 'secure_password',
  );
  
  print('User signed in: ${response.user?.email}');
  // Navigate to home screen
} catch (e) {
  print('Login failed: $e');
}
```

### Example 3: Check Current User

```dart
final supabaseService = ref.watch(supabaseServiceProvider);
final currentUser = supabaseService.currentUser;

if (currentUser != null) {
  print('Logged in as: ${currentUser.email}');
} else {
  print('Not logged in');
}
```

### Example 4: Sign Out

```dart
await supabaseService.signOut();
```

---

## 💾 Using Database Operations

### Example 1: Insert Data

```dart
// Save a farmer profile
try {
  final data = await supabaseService.insert(
    table: 'farmer_profiles',
    data: {
      'user_id': supabaseService.currentUser!.id,
      'name': 'John Farmer',
      'phone': '+91-9876543210',
      'location': 'Punjab',
      'farm_size': 5.5,
      'crops': ['wheat', 'rice', 'cotton'],
    },
  );
  
  print('Profile created: $data');
} catch (e) {
  print('Error: $e');
}
```

### Example 2: Fetch Data

```dart
// Get all chat history for current user
try {
  final chatHistory = await supabaseService.fetchMany(
    table: 'chat_history',
    filters: {
      'user_id': supabaseService.currentUser!.id,
    },
    orderBy: 'created_at',
    ascending: false,
    limit: 50,
  );
  
  print('Found ${chatHistory.length} messages');
} catch (e) {
  print('Error: $e');
}
```

### Example 3: Update Data

```dart
// Update farmer profile
try {
  final updated = await supabaseService.update(
    table: 'farmer_profiles',
    id: 'profile-id-here',
    data: {
      'farm_size': 6.0,
      'crops': ['wheat', 'rice', 'cotton', 'sugarcane'],
    },
  );
  
  print('Profile updated: $updated');
} catch (e) {
  print('Error: $e');
}
```

### Example 4: Delete Data

```dart
// Delete a chat message
try {
  await supabaseService.delete(
    table: 'chat_history',
    id: 'message-id-here',
  );
  
  print('Message deleted');
} catch (e) {
  print('Error: $e');
}
```

---

## 📁 Using File Storage

### Step 1: Create Storage Bucket

1. Go to Supabase Dashboard → Storage
2. Create a new bucket (e.g., `crop-images`)
3. Set it to **Public** if you want images to be accessible without auth

### Step 2: Upload Files

```dart
import 'dart:io';
import 'package:image_picker/image_picker.dart';

// Pick an image
final picker = ImagePicker();
final pickedFile = await picker.pickImage(source: ImageSource.gallery);

if (pickedFile != null) {
  // Read file as bytes
  final bytes = await File(pickedFile.path).readAsBytes();
  
  // Upload to Supabase
  try {
    final userId = supabaseService.currentUser!.id;
    final fileName = 'crop_${DateTime.now().millisecondsSinceEpoch}.jpg';
    
    final path = await supabaseService.uploadFile(
      bucket: 'crop-images',
      path: '$userId/$fileName',
      file: bytes,
    );
    
    // Get public URL
    final url = supabaseService.getPublicUrl(
      bucket: 'crop-images',
      path: path,
    );
    
    print('Image uploaded: $url');
  } catch (e) {
    print('Upload failed: $e');
  }
}
```

---

## 🔄 Real-Time Subscriptions

### Listen to Auth State Changes

```dart
class MyApp extends ConsumerStatefulWidget {
  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    
    final supabaseService = ref.read(supabaseServiceProvider);
    
    // Listen to auth state changes
    supabaseService.authStateChanges.listen((authState) {
      final user = authState.session?.user;
      
      if (user != null) {
        print('User logged in: ${user.email}');
        // Navigate to home
      } else {
        print('User logged out');
        // Navigate to login
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

---

## 🎯 Practical Integration Examples

### Example: Complete Login Flow

Update your `simple_auth_provider.dart` to use Supabase:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/supabase_service.dart';

class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  final SupabaseService _supabaseService;
  
  AuthNotifier(this._supabaseService) : super(const AsyncValue.loading()) {
    // Check initial auth state
    state = AsyncValue.data(_supabaseService.currentUser);
  }
  
  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    
    try {
      final response = await _supabaseService.signInWithEmail(
        email: email,
        password: password,
      );
      
      state = AsyncValue.data(response.user);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
  
  Future<void> signOut() async {
    await _supabaseService.signOut();
    state = const AsyncValue.data(null);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AsyncValue<User?>>((ref) {
  final supabaseService = ref.watch(supabaseServiceProvider);
  return AuthNotifier(supabaseService);
});
```

---

## 🛠️ Troubleshooting

### Issue: "Invalid API key" or "Project not found"

**Solution:** Double-check your `.env` file has the correct credentials from Supabase dashboard.

### Issue: "Row Level Security policy violation"

**Solution:** Make sure you've created the RLS policies in your database (see database setup section).

### Issue: "User not authenticated"

**Solution:** Check if user is logged in before making authenticated requests:

```dart
if (supabaseService.currentUser == null) {
  // Navigate to login
  return;
}
```

---

## 📚 Additional Resources

- [Supabase Documentation](https://supabase.com/docs)
- [Supabase Flutter Guide](https://supabase.com/docs/guides/getting-started/tutorials/with-flutter)
- [Your Supabase Service Code](lib/services/supabase_service.dart)

---

## ✨ Next Steps

1. ✅ Set up your Supabase project
2. ✅ Add credentials to `.env` file
3. ✅ Create database tables
4. ✅ Update your auth provider to use Supabase
5. ✅ Test authentication flow
6. ✅ Implement data persistence for your features

Your Supabase integration is ready to use! 🚀
