import 'package:alamri_adm/core/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomErrorWidget extends StatelessWidget {
  CustomErrorWidget(
      {super.key,
      required this.title,
      required this.content,
      required this.ontap});
  final String title;
  final String content;
  Function() ontap;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: AlertDialog(
          title: Row(
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.red, fontSize: 16.sp),
              ),
              Image.asset(
                "assets/icons/error.png",
                width: 30.w,
                height: 30.w,
              )
            ],
          ),
          content: Text(content),
          actions: [
            ElevatedButton(
              onPressed: ontap,
              style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.red),
                  foregroundColor: WidgetStatePropertyAll(Colors.white)),
              child: Text(
                getTranslation('ok', context),
              ),
            )
          ],
          actionsAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
