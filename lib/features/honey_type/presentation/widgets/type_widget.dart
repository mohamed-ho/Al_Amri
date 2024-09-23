import 'package:alamri_adm/config/routes/app_routes.dart';
import 'package:alamri_adm/core/utils/app_colors.dart';
import 'package:alamri_adm/features/honey_type/domain/entities/type.dart';
import 'package:alamri_adm/features/honey_type/presentation/bloc/honey_type_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TypeWidget extends StatelessWidget {
  const TypeWidget({super.key, required this.honeyType});
  final HoneyType honeyType;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10.w),
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.thirdColor),
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            honeyType.name,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Padding(
                            padding: EdgeInsets.all(5.w),
                            child: Text(
                              honeyType.description,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Column(
                        children: [
                          MouseRegion(
                            child: IconButton(
                              onPressed: () {
                                BlocProvider.of<HoneyTypeBloc>(context).add(
                                    DeleteHoneyTypeEven(honeyId: honeyType.id));
                              },
                              hoverColor: AppColors.scaffoldColor,
                              icon: Padding(
                                padding: const EdgeInsets.all(10).w,
                                child: Icon(
                                  Icons.delete,
                                  size: 30.w,
                                  color: Colors.red.shade300,
                                ),
                              ),
                            ),
                          ),
                          MouseRegion(
                            child: IconButton(
                              onPressed: () => Navigator.pushNamed(
                                  context, Routes.addHoneyTypeScreen,
                                  arguments: honeyType),
                              hoverColor: AppColors.scaffoldColor,
                              icon: Padding(
                                padding: const EdgeInsets.all(10).w,
                                child: Icon(
                                  Icons.edit,
                                  size: 30.w,
                                  color: Colors.yellow.shade300,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Image.asset(
                            'assets/icons/number_of_jar.png',
                            width: 30.w,
                            height: 30.w,
                          ),
                        ),
                        Text(
                          'عدد العبوات',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Text(honeyType.numberOfJar.toString(),
                              style: Theme.of(context).textTheme.titleMedium),
                        )
                      ],
                    )),
                    Expanded(
                        child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Image.asset(
                            'assets/icons/weight.png',
                            width: 30.w,
                            height: 30.w,
                          ),
                        ),
                        Text('وزن العبوه الواحده',
                            style: Theme.of(context).textTheme.titleMedium),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Text(honeyType.jarQuantity.toString(),
                              style: Theme.of(context).textTheme.titleMedium),
                        )
                      ],
                    ))
                  ],
                ),
              ],
            ),
          ],
        )

        // const ListTile(
        //   title: Text('عسل سجر'),
        //   subtitle: Text(
        //       'اللغة العربية هي لغة سامية تتحدثها العديد من الشعوب في منطقة الشرق الأوسط وشمال أفريقيا. تتميز بجمال حروفها وتاريخها العريق. تستخدم اللغة العربية في العديد من المجالات مثل الأدب والعلوم والدين. تعتبر اللغة العربية الفصحى هي النسخة الرسمية التي تُستخدم في الكتابة والوسائل الإعلامية، بينما تُستخدم اللهجات المحلية في الحياة اليومية'),
        //   trailing:
        // ),
        );
  }
}
