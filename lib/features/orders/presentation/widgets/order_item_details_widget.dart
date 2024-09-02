import 'package:alamri_adm/features/orders/domain/entities/item_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderItemDetailsWidget extends StatelessWidget {
  const OrderItemDetailsWidget(
      {super.key, required this.quanity, required this.itemOrder});

  final int quanity;
  final ItemOrder itemOrder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: .008.sh,
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 5.w,
                  color: Colors.grey.withOpacity(.5),
                  spreadRadius: 5.w)
            ]),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: .01.sh, horizontal: .05.sw),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemOrder.name!,
                    style: TextStyle(
                        fontSize: 18.spMax, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'سعر العبوه : ${itemOrder.price} جنيه',
                    style: TextStyle(fontSize: 16.spMax),
                  ),
                  Text(
                    'وزن العبوه : ${itemOrder.wieght} جرام',
                    style: TextStyle(fontSize: 16.spMax),
                  ),
                  Text(
                    overflow: TextOverflow.clip,
                    "عدد العبوات المطلوبه :  $quanity",
                    style: TextStyle(fontSize: 18.spMax),
                  ),
                ],
              ),
              Container(
                height: .2.sw,
                width: .2.sw,
                decoration: BoxDecoration(
                    boxShadow: [BoxShadow(blurRadius: 3.w, spreadRadius: 3.w)]),
                child: Image.asset('assets/icons/gallery.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
