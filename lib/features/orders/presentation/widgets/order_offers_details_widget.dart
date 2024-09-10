import 'package:alamri_adm/core/apis/end_points.dart';
import 'package:alamri_adm/features/offer_feature/domain/entities/offer.dart';
import 'package:alamri_adm/features/orders/domain/entities/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderOffersDetailsWidget extends StatelessWidget {
  const OrderOffersDetailsWidget(
      {super.key, required this.offers, required this.order});

  final List<Offer?> offers;
  final Orders order;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: offers.length,
        itemBuilder: (context, index) {
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
                padding:
                    EdgeInsets.symmetric(vertical: .01.sh, horizontal: .05.sw),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          offers[index]!.title,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'سعر العرض : ${offers[index]!.price}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          'عدد طلب العرض : ${order.offersQuantities![index]}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Container(
                      height: .2.sw,
                      width: .2.sw,
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(blurRadius: 3.w, spreadRadius: 3.w)
                      ]),
                      child: Image.network(EndPoints.imageRoot+offers[index]!.image),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
