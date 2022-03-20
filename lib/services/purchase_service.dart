import 'dart:io';

import 'package:aromatherapy/utils/secret_keys.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseService {
  static Future init() async {
    await Purchases.setDebugLogsEnabled(true);

    if (Platform.isAndroid) {
      await Purchases.setup(revenuecatApiKey);
    } else if (Platform.isIOS) {
      await Purchases.setup("public_ios_sdk_key"); //TODO :: config
    }
  }

  static Future<List<Offering>> fetchOffers() async {
    try {
      final offering = await Purchases.getOfferings();
      final current = offering.current;

      return current == null ? [] : [current];
    } on PlatformException catch (e) {
      return [];
    }
  }

  static Future<bool> PurchasePackage(Package package) async {
    try {
      await Purchases.purchasePackage(package);

      return true;
    } catch (e) {
      return false;
    }
  }
}
