import 'package:aromatherapy/screens/landing_screen.dart';
import 'package:aromatherapy/services/revenuecat.dart';
import 'package:aromatherapy/services/auth_service.dart';
import 'package:aromatherapy/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PurchaseApi.init();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<AuthService>(
      create: (context) => FirebaseAuthService(),
      child: MaterialApp(
        title: 'Aromatherapy App',
        home: const LandingScreen(),
        theme: theme(),
      ),
    );
  }
}
