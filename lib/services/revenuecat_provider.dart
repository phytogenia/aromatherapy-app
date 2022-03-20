import 'package:flutter/cupertino.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../models/entitlement.dart';

class RevenueCatProvider extends ChangeNotifier {
  RevenueCatProvider() {
    init();
  }

  Entitlement _entitlement = Entitlement.free;
  Entitlement get entitlement => _entitlement;

  init() {
    Purchases.addPurchaserInfoUpdateListener((purchaserInfo) {
      updatePurchasesStatus();
    });
  }

  Future updatePurchasesStatus() async {
    final purchasesInfo = await Purchases.getPurchaserInfo();
    final entitlement = purchasesInfo.entitlements.active.values.toList();
    _entitlement =
        entitlement.isEmpty ? Entitlement.free : Entitlement.allContent;
    notifyListeners();
  }
}
