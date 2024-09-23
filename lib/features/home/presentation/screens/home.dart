import 'package:alamri_adm/core/utils/app_colors.dart';
import 'package:alamri_adm/features/honey_type/presentation/widgets/type_panel_widget.dart';
import 'package:alamri_adm/features/item_feature/presentation/widgets/item_panel_widget.dart';
import 'package:alamri_adm/features/offer_feature/presentation/widgets/offer_panel_widget.dart';
import 'package:alamri_adm/features/orders/presentation/screens/orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> _screens = [
    const TypePanelWidget(),
    const ItemPanelWidget(),
    const OfferPanelWidget(),
    const OrdersScreen()
  ];
  int screensController = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Visibility(
              visible: ScreenUtil().screenWidth > 600,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        width: 80.w,
                        height: 80.w,
                      )
                    ],
                  ),
                  MouseRegion(
                    child: Row(
                      verticalDirection: VerticalDirection.down,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextBarButton(
                            buttonText: 'انواع العسل',
                            onPressed: () {
                              screensController = 0;
                              setState(() {});
                            }),
                        TextBarButton(
                          buttonText: "المنتجات",
                          onPressed: () {
                            screensController = 1;
                            setState(() {});
                          },
                        ),
                        TextBarButton(
                          buttonText: "العروض",
                          onPressed: () {
                            screensController = 2;
                            setState(() {});
                          },
                        ),
                        TextBarButton(
                          buttonText: "الطلابات",
                          onPressed: () {
                            screensController = 3;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          Expanded(child: _screens[screensController])
        ],
      ),
    );
  }
}

class TextBarButton extends StatelessWidget {
  TextBarButton({super.key, required this.buttonText, required this.onPressed});
  Function()? onPressed;
  String buttonText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: TextButton(
        style: ButtonStyle(
            overlayColor: const WidgetStatePropertyAll(Colors.transparent),
            foregroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> state) {
              if (state.contains(WidgetState.hovered)) {
                return AppColors.logoColor;
              }
              return Colors.black;
            })),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
