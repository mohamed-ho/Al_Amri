import 'package:alamri_adm/features/auth/presentation/screens/login_screen.dart';
import 'package:alamri_adm/features/honey_type/domain/entities/type.dart';
import 'package:alamri_adm/features/honey_type/presentation/screens/add_honey_type_screen.dart';
import 'package:alamri_adm/features/honey_type/presentation/screens/home_admin_screen.dart';
import 'package:alamri_adm/features/orders/domain/entities/order.dart';
import 'package:alamri_adm/features/orders/presentation/screens/order_details_on_phone.dart';
import 'package:alamri_adm/features/item_feature/domain/entities/item.dart';
import 'package:alamri_adm/features/item_feature/presentation/screen/add_item_screen.dart';
import 'package:alamri_adm/features/offer_feature/domain/entities/offer.dart';
import 'package:alamri_adm/features/offer_feature/presentation/screens/add_offer_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String inisialRoute = '/';
  static const String addHoneyTypeScreen = '/AddHoneyTypeScreen';
  static const String addItemScreen = '/addItemScreen';
  static const String addOfferScreen = '/addOfferScreen';
  static const String orderDetails = '/orderDetails';
  static const String loginScreen = 'loginScreen';
}

class AppRoutes {
  static Route onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      case Routes.inisialRoute:
        int? selectItem =
            setting.arguments != null ? setting.arguments as int : null;
        return MaterialPageRoute(
            builder: (context) => HomeAdminScreen(
                  selectedIndex: selectItem,
                ));
      case Routes.addHoneyTypeScreen:
        HoneyType? honeyType =
            setting.arguments != null ? setting.arguments as HoneyType : null;
        return MaterialPageRoute(
            builder: (context) => AddHoneyTypeScreen(honeyType: honeyType));
      case Routes.addItemScreen:
        Item? item =
            setting.arguments != null ? setting.arguments as Item : null;
        return MaterialPageRoute(
            builder: (context) => AddItemScreen(
                  item: item,
                ));
      case Routes.addOfferScreen:
        Offer? offer =
            setting.arguments != null ? setting.arguments as Offer : null;
        return MaterialPageRoute(
            builder: (context) => AddOfferScreen(
                  offer: offer,
                ));
      case Routes.orderDetails:
        Orders? order = setting.arguments as Orders;
        return MaterialPageRoute(
            builder: (context) => OrderDetailsOnPhone(
                  orders: order,
                ));
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      default:
        return unDefinedRoute();
    }
  }

  static Route unDefinedRoute() {
    return MaterialPageRoute(
        builder: (context) => const Scaffold(
              body: Center(
                child: Text('you do not have page route'),
              ),
            ));
  }
}
