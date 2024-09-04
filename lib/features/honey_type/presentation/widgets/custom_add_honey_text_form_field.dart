import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAddHoneyTextFormField extends StatelessWidget {
  CustomAddHoneyTextFormField(
      {super.key,
      required this.webIcon,
      required this.textEditingController,
      required this.lable,
      minlines,
      required this.validator});
  final String lable;
  final Widget webIcon;
  final TextEditingController textEditingController;
  int? minlines;

  String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14.w),
      child: TextFormField(
        controller: textEditingController,
        validator: validator,
        decoration: InputDecoration(
            label: ScreenUtil().screenWidth < 600 ? Text(lable) : null,
            icon: ScreenUtil().screenWidth > 600
                ? IntrinsicWidth(
                    child: Row(
                      children: [
                        SizedBox(height: 30.w, width: 30.w, child: webIcon),
                        Text(
                          lable,
                          style: TextStyle(
                              fontSize: 16.w, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  )
                : null,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.w))),
      ),
    );
  }
}
