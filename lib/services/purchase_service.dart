import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import 'package:flashchords/data/settings_repository.dart';

class PurchaseService {
  PurchaseService._internal();
  static final PurchaseService instance = PurchaseService._internal();

  static const String upgradeProductId =
      'com.colinhoughton.flashchords.pro';

  final InAppPurchase _iap = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _subscription;

  bool _available = false;
  ProductDetails? _upgradeProduct;
  final ValueNotifier<bool> upgraded = ValueNotifier(false);

  bool get isAvailable => _available;
  ProductDetails? get upgradeProduct => _upgradeProduct;

  Future<void> init() async {
    if (_subscription != null) return;

    _available = await _iap.isAvailable();
    if (!_available) return;

    upgraded.value = await SettingsRepository().loadIsUpgraded();

    _subscription = _iap.purchaseStream.listen(
      _onPurchaseUpdated,
      onError: (error) {
        debugPrint('🛒 purchaseStream error: $error');
      },
    );

    await _queryProducts();
  }

  Future<void> dispose() async {
    await _subscription?.cancel();
    _subscription = null;
  }

  Future<void> _queryProducts() async {
    final response =
        await _iap.queryProductDetails({upgradeProductId});
    if (response.error != null) {
      debugPrint('🛒 queryProductDetails error: ${response.error}');
      return;
    }
    if (response.productDetails.isEmpty) {
      debugPrint('🛒 No products returned for $upgradeProductId');
      return;
    }
    _upgradeProduct = response.productDetails.first;
  }

  Future<bool> buyUpgrade() async {
    if (!_available) {
      await init();
    }
    if (!_available) return false;

    if (_upgradeProduct == null) {
      await _queryProducts();
    }
    final product = _upgradeProduct;
    if (product == null) return false;

    final param = PurchaseParam(productDetails: product);
    return _iap.buyNonConsumable(purchaseParam: param);
  }

  Future<bool> restorePurchases() async {
    if (!_available) {
      await init();
    }
    if (!_available) return false;
    await _iap.restorePurchases();
    return true;
  }

  Future<void> _onPurchaseUpdated(
      List<PurchaseDetails> purchases) async {
    for (final purchase in purchases) {
      switch (purchase.status) {
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          await _deliverUpgrade();
          break;
        case PurchaseStatus.error:
          debugPrint('🛒 purchase error: ${purchase.error}');
          break;
        case PurchaseStatus.canceled:
          debugPrint('🛒 purchase canceled');
          break;
        case PurchaseStatus.pending:
          debugPrint('🛒 purchase pending');
          break;
      }

      if (purchase.pendingCompletePurchase) {
        await _iap.completePurchase(purchase);
      }
    }
  }

  Future<void> _deliverUpgrade() async {
    await SettingsRepository().saveIsUpgraded(true);
    upgraded.value = true;
  }
}
