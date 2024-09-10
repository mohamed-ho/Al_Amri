// ignore: must_be_immutable
import 'package:alamri_adm/core/utils/functions.dart';
import 'package:alamri_adm/features/honey_type/domain/entities/type.dart';
import 'package:alamri_adm/features/offer_feature/domain/entities/offer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HoneyTypeWidgetOnOffer extends StatelessWidget {
  HoneyTypeWidgetOnOffer({
    super.key,
    required this.types,
    required this.offer,
  });

  final List<HoneyType> types;
  final Offer offer;
  bool valid = false;
  @override
  Widget build(BuildContext context) {
    if (types.length == offer.quantity.length) {
      valid = true;
    }
    return SizedBox(
      height: .15.sh,
      child: ListView.builder(
          itemCount: types.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  children: [
                    Image.asset(
                      'assets/icons/type.png',
                      height: 30.w,
                      width: 30.w,
                    ),
                    Text(
                      "${getTranslation("type", context)}${index + 1}  ${types[index].name}",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/number_of_jar.png',
                      height: 30.w,
                      width: 30.w,
                    ),
                    Text(
                      "${getTranslation("lable_honey_type_number_of_jar", context)}  ${offer.quantity[index]}",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/weight.png',
                      height: 30.w,
                      width: 30.w,
                    ),
                    Text(
                      "${getTranslation("weight", context)}  ${types[index].jarQuantity}",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                const Divider()
              ],
            );
          }),
    );
  }
}
