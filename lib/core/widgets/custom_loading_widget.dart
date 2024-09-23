import 'package:flutter/material.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Image.asset(
            'assets/images/logo.png',
          ),
          const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
