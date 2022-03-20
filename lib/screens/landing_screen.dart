import 'dart:ffi';

import 'package:aromatherapy/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../components/PayWallWidget.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import '../services/database_service.dart';
import '../services/revenuecat.dart';
import 'auth/login_screen.dart';
import 'home/home_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool subs = false;
    void isSubs() async {
      PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();
      if (purchaserInfo.entitlements.active.isNotEmpty) {
        subs=true;
      } else {
        subs=false;
      }
    }
    final authProvider = context.read<AuthService>();
    isSubs();
    if (subs) {
    } else {
      fetchoffers(context);
    }
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
              child: subs?const Home():Container(),
            );
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  Future fetchoffers(BuildContext context) async {
    final offering = await PurchaseApi.fetchOffers();
    if (offering.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar((const SnackBar(
        content: Text('No Plans Found'),
      )));
    } else {
      final packages = offering
          .map((offer) => offer.availablePackages)
          .expand((pair) => pair)
          .toList();

      showModalBottomSheet(
          isScrollControlled:true,
          context: context,
          builder: (context) => PayWallWidget(
              title: 'Unlock Everything',
              description:
                  'Unlock all essential oils and there recipes and much more !',
              packages: packages,
              onClickedPackage: (package) async {
                await PurchaseApi.PurchasePackage(package);
                Navigator.pop(context);
              }),
          backgroundColor: kPrimaryColor);
    }
  }

}
