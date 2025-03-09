import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class CustomTitleAndSubtitle extends StatelessWidget {
  final String title;
  final String subtitle;
  const CustomTitleAndSubtitle({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.primaryColor,
            fontSize: 35,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black.withOpacity(.6),
          ),
        ),
      ],
    );
  }
}