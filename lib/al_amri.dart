import 'package:alamri_adm/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:alamri_adm/features/honey_type/presentation/bloc/honey_type_bloc.dart';
import 'package:alamri_adm/al_amri_enjection.dart';
import 'package:alamri_adm/config/locale/app_localizations_setup.dart';
import 'package:alamri_adm/config/routes/app_routes.dart';
import 'package:alamri_adm/config/themes/app_themes.dart';
import 'package:alamri_adm/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:alamri_adm/features/item_feature/presentation/bloc/items_bloc.dart';
import 'package:alamri_adm/features/offer_feature/presentation/bloc/offer_bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlAmri extends StatelessWidget {
  const AlAmri({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ls<HoneyTypeBloc>()),
        BlocProvider(create: (context) => ls<ItemsBloc>()),
        BlocProvider(create: (context) => ls<OfferBloc>()),
        BlocProvider(create: (context) => ls<OrdersBloc>()),
        BlocProvider(create: (context) => ls<AuthBloc>()),
      ],
      child: ScreenUtilInit(
          designSize: Size(height, width),
          builder: (context, widget) {
            return MaterialApp(
              theme: AppThemes.appTheme(),
              locale: const Locale('ar'),
              supportedLocales: AppLocalizationsSetup.supportedLocales,
              localeResolutionCallback:
                  AppLocalizationsSetup.localeResolutionCallback,
              localizationsDelegates:
                  AppLocalizationsSetup.localizationsDelegates,
              builder: DevicePreview.appBuilder,
              debugShowCheckedModeBanner: false,
              onGenerateRoute: AppRoutes.onGenerateRoute,
              initialRoute: Routes.loginScreen,
            );
          }),
    );
  }
}
