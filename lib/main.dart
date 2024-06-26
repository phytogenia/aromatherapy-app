import 'package:aromatherapy/screens/landing_screen.dart';
import 'package:aromatherapy/services/purchase_service.dart';
import 'package:aromatherapy/services/auth_service.dart';
import 'package:aromatherapy/services/revenuecat_provider.dart';
import 'package:aromatherapy/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PurchaseService.init();
  await Firebase.initializeApp();
  runApp(AromatherapyApp());
}

class AromatherapyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (context) => FirebaseAuthService(),
        ),
        ListenableProvider<RevenueCatProvider>(
          create: (context) => RevenueCatProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Aromatherapy App',
        home: const LandingScreen(),
        theme: theme(),
      ),
    );
  }
}
