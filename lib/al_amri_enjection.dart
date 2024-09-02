import 'package:alamri_adm/admain_feature/enjection_honey_type.dart';
import 'package:alamri_adm/features/orders/order_injection.dart';
import 'package:alamri_adm/item_feature/items_injection.dart';

import 'package:alamri_adm/offer_feature/presentation/offer_injection.dart';
import 'package:get_it/get_it.dart';

final ls = GetIt.instance;

class AlAmriEnjection {
  init() {
    EnjectionHoneyType().init();
    ItemsInjection().init();
    OfferInjection().init();
    OrderInjection().init();
  }
}
