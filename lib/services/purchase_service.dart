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

  static Future<bool> purchasePackage(Package package) async {
    try {
      await Purchases.purchasePackage(package);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> isProMember() async {
    PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();
    return (purchaserInfo.entitlements.active.isNotEmpty);
  }
  //
  // Future fetchoffers(BuildContext context) async {
  //   final offering = await PurchaseService.fetchOffers();
  //   if (offering.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar((const SnackBar(
  //       content: Text('No Plans Found'),
  //     )));
  //   } else {
  //     final packages = offering
  //         .map((offer) => offer.availablePackages)
  //         .expand((pair) => pair)
  //         .toList();
  //
  //     showModalBottomSheet(
  //         isScrollControlled: true,
  //         context: context,
  //         builder: (context) => PayWallScreen(
  //             title: 'Unlock Everything',
  //             description:
  //                 'Unlock all essential oils and there recipes and much more !',
  //             packages: packages,
  //             onClickedPackage: (package) async {
  //               await PurchaseService.purchasePackage(package);
  //               Navigator.pop(context);
  //             }),
  //         backgroundColor: kPrimaryColor);
  //   }
  // }
}
