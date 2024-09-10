import 'package:flutter/material.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/logo.png',
          width: double.infinity,
          height: double.infinity,
        ),
        const Center(child: CircularProgressIndicator()),
      ],
    );
  }
}
