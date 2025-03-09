import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commece/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ProductController {
  RxInt selectedIndex = RxInt(0);
  RxString selectedSize = RxString('');

  RxList sizes = [].obs;

  final user = FirebaseAuth.instance.currentUser;

  addToCart(QueryDocumentSnapshot product) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.email)
        .collection('cart')
        .add({
      'user_email': user!.email,
      'product_id': product.id,
      'name': product['name'],
      'price': product['discount_price'] ?? product['original_price'],
      'image': product['image'],
      'variant': selectedSize.value,
      'quantity': 1,
    }).then((value) {
      Get.snackbar(
        'Success',
        'Product successfully added to cart',
        colorText: AppColors.primaryColor,
      );
    });
  }
}