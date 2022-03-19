import 'package:aromatherapy/services/revenuecat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../services/auth_service.dart';
import '../services/database_service.dart';
import 'auth/login_screen.dart';
import 'home/home_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthService>();
    return StreamBuilder<MyUser?>(
        stream: authProvider.onChangeUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;
            if (user == null) {
              return const LoginScreen();
            }
            return Provider<DatabaseService>(
              create: (_) => FirebaseDatabaseService(uid: user.uid),
              child: const Home(),
            );
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
