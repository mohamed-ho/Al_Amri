import 'package:alamri_adm/features/honey_type/domain/entities/type.dart';
import 'package:alamri_adm/config/routes/app_routes.dart';
import 'package:alamri_adm/core/apis/end_points.dart';
import 'package:alamri_adm/core/utils/app_colors.dart';
import 'package:alamri_adm/core/utils/functions.dart';
import 'package:alamri_adm/features/item_feature/domain/entities/item.dart';
import 'package:alamri_adm/features/item_feature/presentation/bloc/items_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemLoadedWidget extends StatelessWidget {
  const ItemLoadedWidget({super.key, required this.item, required this.type});
  final Item item;
  final HoneyType type;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: .31.sh,
      padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 5.w),
      margin: EdgeInsets.symmetric(vertical: 10.w, horizontal: 5.w),
      decoration: BoxDecoration(
          color: AppColors.thirdColor,
          borderRadius: BorderRadius.circular(10.w),
          boxShadow: [BoxShadow(blurRadius: 5.w, color: Colors.grey)]),
      child: ListView(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                    height: .25.sh,
                    margin: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.w),
                        color: Colors.blue,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5.r,
                              color: AppColors.primaryColor,
                              spreadRadius: 5.r)
                        ]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.w),
                      child: CachedNetworkImage(
                        imageUrl: EndPoints.imageRoot + item.image,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) {
                          print(error.toString());
                          return Text('image is not found ${error.toString()}');
                        },
                        fit: BoxFit.fill,
                      ),
                    )),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        type.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        type.description,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/icons/weight.png',
                                height: 30.w,
                                width: 30.w,
                              ),
                              Text(
                                "${getTranslation("lable_honey_type_jar_quantity", context)} ${type.jarQuantity}${getTranslation("gram", context)}",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'assets/icons/price.png',
                            height: 30.w,
                            width: 30.w,
                          ),
                          Text(
                            "${getTranslation("price", context)} ${item.price}${getTranslation("pound", context)}",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MouseRegion(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, Routes.addItemScreen,
                                    arguments: item);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.thirdColor,
                                  shadowColor: AppColors.primaryColor),
                              child: Row(
                                children: [
                                  Text(
                                    getTranslation("update", context),
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
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
                                  BlocProvider.of<ItemsBloc>(context)
                                      .add(DeleteItemEvent(item: item));
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.thirdColor,
                                    shadowColor: AppColors.primaryColor),
                                child: Row(
                                  children: [
                                    Text(
                                      getTranslation("delete", context),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
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
        ],
      ),
    );
  }
}
