import 'package:alamri_adm/features/honey_type/domain/entities/type.dart';
import 'package:alamri_adm/config/routes/app_routes.dart';
import 'package:alamri_adm/core/apis/end_points.dart';
import 'package:alamri_adm/core/utils/app_colors.dart';
import 'package:alamri_adm/core/utils/functions.dart';
import 'package:alamri_adm/features/offer_feature/domain/entities/offer.dart';
import 'package:alamri_adm/features/offer_feature/presentation/bloc/offer_bloc.dart';
import 'package:alamri_adm/features/offer_feature/presentation/widgets/honey_type_widget_on_offer.dart';
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
                height: .3.sh,
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
                    child: MouseRegion(
                      child: HoneyTypeWidgetOnOffer(
                        types: types,
                        offer: offer,
                      ),
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
                      MouseRegion(
                        child: ElevatedButton(
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
                      ),
                      MouseRegion(
                        child: ElevatedButton(
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
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                Icon(
                                  Icons.delete,
                                  weight: 30.w,
                                  color: Colors.red.shade400,
                                ),
                              ],
                            )),
                      ),
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
