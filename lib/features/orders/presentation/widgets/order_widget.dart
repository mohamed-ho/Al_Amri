import 'package:alamri_adm/config/routes/app_routes.dart';
import 'package:alamri_adm/features/orders/domain/entities/order.dart';
import 'package:alamri_adm/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({super.key, required this.order});
  final Orders order;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(blurRadius: 5.w, color: Colors.grey, spreadRadius: 5.w)
      ], borderRadius: BorderRadius.circular(9), color: Colors.white),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: .05.sw, vertical: .03.sh),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'معلومات العميل',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const Divider(),
            Text(
              "الاسم :  ${order.name}",
              style:
                  TextStyle(fontSize: 16, color: Colors.black.withOpacity(.5)),
            ),
            Text(
              "البريد :  ${order.email}",
              style:
                  TextStyle(fontSize: 16, color: Colors.black.withOpacity(.5)),
            ),
            Text("رقم الهاتف :  ${order.phone}",
                style: TextStyle(
                    fontSize: 16, color: Colors.black.withOpacity(.5))),
            const Text(
              " العنوان بالتفصيل",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            const Divider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: .01.sw),
              child: Column(
                children: [
                  Text('محافظة:${order.gover}',
                      style: TextStyle(
                          fontSize: 16, color: Colors.black.withOpacity(.5))),
                  Text('مدينة:${order.city}',
                      style: TextStyle(
                          fontSize: 16, color: Colors.black.withOpacity(.5))),
                  Text('العنوان:${order.address}',
                      style: TextStyle(
                          fontSize: 16, color: Colors.black.withOpacity(.5))),
                ],
              ),
            ),
            const Divider(),
            Text('سعر الطلب : ${order.totalPrice} جنية',
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                    fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    BlocProvider.of<OrdersBloc>(context)
                        .add(DeleteOrderEvent(orderId: order.id!));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white),
                  child: const Text('تم شحن الطلب'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.orderDetails,
                        arguments: order);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber[400],
                      foregroundColor: Colors.white),
                  child: const Text('عرض التفاصيل'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
