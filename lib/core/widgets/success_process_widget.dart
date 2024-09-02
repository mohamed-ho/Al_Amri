import 'package:alamri_adm/config/routes/app_routes.dart';
import 'package:alamri_adm/core/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuccessProcess extends StatelessWidget {
  const SuccessProcess({
    super.key,
    required this.title,
    required this.content,
    required this.onTap,
  });
  final String title;
  final String content;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.green,
      elevation: 5,
      child: Center(
        child: AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              onPressed: onTap,
              style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.green)),
              child: Text(getTranslation('ok', context)),
            )
          ],
          title: Row(
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.green),
              ),
              Image.asset(
                'assets/icons/correct.png',
                width: 30.w,
                height: 30.w,
              )
            ],
          ),
          content: Text(content),
        ),
      ),
    );
  }
}
