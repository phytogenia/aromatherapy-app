import 'package:aromatherapy/utils/secret_keys.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseApi {
  static Future init() async {
    await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup(revenuecatApiKey);
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