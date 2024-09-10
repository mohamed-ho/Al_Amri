import 'package:alamri_adm/features/honey_type/presentation/widgets/type_panel_widget.dart';
import 'package:alamri_adm/config/locale/app_localizations.dart';
import 'package:alamri_adm/core/utils/app_colors.dart';
import 'package:alamri_adm/core/utils/functions.dart';
import 'package:alamri_adm/features/orders/presentation/screens/orders_screen.dart';
import 'package:alamri_adm/features/item_feature/presentation/widgets/item_panel_widget.dart';
import 'package:alamri_adm/features/offer_feature/presentation/widgets/offer_panel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sidebarx/sidebarx.dart';

class HomeAdminScreen extends StatelessWidget {
  HomeAdminScreen({super.key, this.selectedIndex});
  int? selectedIndex;

  late SidebarXController _controller;
  @override
  Widget build(BuildContext context) {
    if (selectedIndex != null) {
      _controller =
          SidebarXController(selectedIndex: selectedIndex!, extended: true);
    } else {
      _controller = SidebarXController(selectedIndex: 0, extended: true);
    }
    return Scaffold(
      appBar: ScreenUtil().screenWidth < 600
          ? AppBar(
              title:
                  Text(AppLocalizations.of(context)!.translate('admin_panel')!),
              centerTitle: true,
              backgroundColor: Colors.transparent)
          : null,
      drawer: ExampleSidebarX(
        controller: _controller,
      ),
      body: Row(
        children: [
          Visibility(
            visible: ScreenUtil().screenWidth > 600,
            child: ExampleSidebarX(
              controller: _controller,
            ),
          ),
          Expanded(
            child: _ScreensExample(
              controller: _controller,
            ),
          ),
        ],
      ),
    );
  }
}

class ExampleSidebarX extends StatelessWidget {
  const ExampleSidebarX({
    super.key,
    required SidebarXController controller,
  }) : _controller = controller;

  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        width: 50.w,
        margin: const EdgeInsets.all(10).w,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: AppColors.primaryColor,
        textStyle: TextStyle(
            fontSize: 14.spMax,
            fontWeight: FontWeight.bold,
            color: Colors.white.withOpacity(.3)),
        selectedTextStyle: Theme.of(context).textTheme.labelSmall,
        hoverTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        itemTextPadding: const EdgeInsets.only(left: 30).w,
        selectedItemTextPadding: const EdgeInsets.only(left: 30).w,
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.primaryColor,
          ),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.primaryColor.withOpacity(0.37),
          ),
          gradient: LinearGradient(
            colors: [AppColors.primaryColor, AppColors.secondColor],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.28),
              blurRadius: 30.w,
            )
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.white.withOpacity(0.7),
          size: 20.w,
        ),
        selectedIconTheme: IconThemeData(
          color: Colors.white,
          size: 30.w,
        ),
      ),
      extendedTheme: SidebarXTheme(
        width: 200.w,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
        ),
      ),
      footerDivider: Divider(
        color: Colors.white.withOpacity(.3),
      ),
      headerBuilder: (context, extended) {
        return SizedBox(
          height: 100.w,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset('assets/images/logo.png'),
          ),
        );
      },
      items: [
        SidebarXItem(
          iconBuilder: (selected, hovered) => Image.asset(
            'assets/icons/type.png',
            width: 30.w,
            height: 30.w,
          ),
          label: getTranslation('honey_Type', context),
          //onTap: () => const TypePanelWidget()
        ),
        SidebarXItem(
          iconBuilder: (selected, hovered) => Image.asset(
            'assets/icons/item.png',
            width: 30.w,
            height: 30.w,
          ),
          label: getTranslation('items', context),
        ),
        SidebarXItem(
            iconBuilder: (selected, hovered) => Image.asset(
                  'assets/icons/offer.png',
                  width: 30.w,
                  height: 30.w,
                ),
            label: getTranslation("offers", context)),
        SidebarXItem(
            iconBuilder: (selected, hovered) => Image.asset(
                  'assets/icons/orders.png',
                  width: 30.w,
                  height: 30.w,
                ),
            label: getTranslation("orders", context))
      ],
    );
  }
}

class _ScreensExample extends StatelessWidget {
  const _ScreensExample({
    super.key,
    required this.controller,
  });

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        switch (controller.selectedIndex) {
          case 0:
            return const TypePanelWidget();
          case 1:
            return const ItemPanelWidget();
          case 2:
            return const OfferPanelWidget();
          case 3:
            return const OrdersScreen();
          default:
            return Text(
              'no page',
              style: theme.textTheme.headlineSmall,
            );
        }
      },
    );
  }
}
