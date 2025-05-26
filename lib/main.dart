import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickuplines/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:pickuplines/flirt_app.dart';
import 'package:pickuplines/features/auth/services/auth_service.dart';
import 'package:pickuplines/features/home/controller/flirt_services.dart';
import 'package:pickuplines/features/first_line/controller/first_line_controller.dart';
import 'package:pickuplines/features/favourite/controller/favorites_controller.dart';

bool _initialized = false;

Future<void> initializeFirebase() async {
  if (_initialized) return;
  
  try {
    print('Initializing Firebase...');
    final app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase app initialized: ${app.name}');
    // Initialize Auth and verify it's working
    final auth = FirebaseAuth.instance;
    
    // Wait for auth state to be determined
    await auth.authStateChanges().first;
    print('Firebase Auth initialized and working');
    
    _initialized = true;
    print('Firebase initialization complete');
  } catch (e, stack) {
    print('Firebase initialization error: $e');
    print('Stack trace: $stack');
    _initialized = false;
    rethrow; // Re-throw to prevent app from continuing with broken Firebase
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await initializeFirebase();
  
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => FlirtServices()),
        ChangeNotifierProvider(create: (_) => FirstLineController()),
        ChangeNotifierProvider(create: (_) => FavoritesController()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: const FlirtApp(),
      ),
    ),
  );
}
