import 'package:e_commece/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_title_subtitle.dart';
import '../auth/login/login.dart';
import '../auth/register/register.dart';


class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset("assets/images/welcome.png"),
            const CustomTitleAndSubtitle(
              title: 'Discover Your\nDream Job here',
              subtitle: 'Explore all the existing job roles based on your interest and study major',
            ),
            const SizedBox(),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    title: 'Login',
                    onTap: () => Get.to(() => const LoginScreen()),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: CustomButton(
                    title: 'Register',
                    backgroundColor: Colors.transparent,
                    textColor: Colors.black,
                    onTap: () => Get.to(() => const RegisterScreen()),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
