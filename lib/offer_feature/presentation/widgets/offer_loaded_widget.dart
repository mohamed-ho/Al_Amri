import 'package:alamri_adm/admain_feature/domain/entities/type.dart';
import 'package:alamri_adm/config/routes/app_routes.dart';
import 'package:alamri_adm/core/apis/end_points.dart';
import 'package:alamri_adm/core/utils/app_colors.dart';
import 'package:alamri_adm/core/utils/functions.dart';
import 'package:alamri_adm/offer_feature/domain/entities/offer.dart';
import 'package:alamri_adm/offer_feature/presentation/bloc/offer_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OfferLoadedWidget extends StatelessWidget {
  const OfferLoadedWidget(
      {super.key, required this.offer, required this.types});
  final Offer offer;
  final List<HoneyType> types;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 5.w),
      margin: EdgeInsets.symmetric(vertical: 10.w, horizontal: 5.w),
      decoration: BoxDecoration(
          color: AppColors.thirdColor,
          borderRadius: BorderRadius.circular(10.w),
          boxShadow: [BoxShadow(blurRadius: 5.w, color: Colors.grey)]),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
                height: 100.h,
                margin: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.w),
                    color: Colors.blue,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 5.w,
                          color: AppColors.primaryColor,
                          spreadRadius: 5.w)
                    ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.w),
                  child: CachedNetworkImage(
                    imageUrl: EndPoints.imageRoot + offer.image,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) {
                      return Text('image is not found ${error.toString()}');
                    },
                    fit: BoxFit.fill,
                  ),
                )),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    offer.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    offer.description,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: HoneyTypeWidgetOnOffer(
                      types: types,
                      offer: offer,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/icons/price.png',
                            width: 30.w,
                            height: 30.w,
                          ),
                          Text(
                            " ${getTranslation("price", context)} ${offer.price.toString()}  ${getTranslation("pound", context)}",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/icons/offer.png",
                            width: 30.w,
                            height: 30.w,
                          ),
                          Text(
                            "${getTranslation('disCount', context)} ${offer.discount.toString()}  ${getTranslation("pound", context)}",
                            style: Theme.of(context).textTheme.titleSmall,
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.addOfferScreen,
                              arguments: offer);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.thirdColor,
                            shadowColor: AppColors.primaryColor),
                        child: Row(
                          children: [
                            Text(
                              getTranslation("update", context),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Icon(
                              Icons.mode,
                              weight: 30.w,
                              color: Colors.yellow.shade400,
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<OfferBloc>(context)
                                .add(DeleteOfferEvent(offer: offer));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.thirdColor,
                              shadowColor: AppColors.primaryColor),
                          child: Row(
                            children: [
                              Text(
                                getTranslation("delete", context),
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Icon(
                                Icons.delete,
                                weight: 30.w,
                                color: Colors.red.shade400,
                              ),
                            ],
                          )),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
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
      height: 100.h,
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
              ],
            );
          }),
    );
  }
}
