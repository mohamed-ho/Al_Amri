import 'package:alamri_adm/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChooseImageButton extends StatelessWidget {
  ChooseImageButton(
      {super.key,
      required this.image,
      required this.title,
      required this.onPressed});
  final String image;
  final String title;
  Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.w)),
            backgroundColor: Colors.white.withOpacity(.5),
            elevation: 5,
            shadowColor: AppColors.primaryColor),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 10.w),
          child: Row(
            children: [
              Image.asset(
                image,
                width: 30.w,
                height: 30.w,
              ),
              Text(title)
            ],
          ),
        ),
      ),
    );
  }
}
