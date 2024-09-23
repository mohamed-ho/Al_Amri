import 'package:alamri_adm/core/apis/end_points.dart';
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
      padding: EdgeInsets.symmetric(vertical: .008.sh, horizontal: 10),
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
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      itemOrder.name!,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'سعر العبوه : ${itemOrder.price} جنيه',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'وزن العبوه : ${itemOrder.wieght} جرام',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      overflow: TextOverflow.clip,
                      "عدد العبوات المطلوبه :  $quanity",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              Container(
                height: .2.sh,
                width: .2.sh,
                decoration: const BoxDecoration(
                    boxShadow: [BoxShadow(blurRadius: 3, spreadRadius: 3)]),
                child: Image.network(EndPoints.imageRoot + itemOrder.image!),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
