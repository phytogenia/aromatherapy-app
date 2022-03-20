import 'dart:ffi';

import 'package:aromatherapy/services/purchase_service.dart';
import 'package:aromatherapy/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import 'paywall_screen.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import '../services/database_service.dart';
import 'auth/login_screen.dart';
import 'home/home_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // bool subs = false;
    // void isSubs() async {
    //   PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();
    //   if (purchaserInfo.entitlements.active.isNotEmpty) {
    //     subs=true;
    //   } else {
    //     subs=false;
    //   }
    // }
    final authProvider = context.read<AuthService>();
    // isSubs();
    // if (subs) {
    // } else {
    //   fetchoffers(context);
    // }
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
              // child: subs ? const Home() : Container(),
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
