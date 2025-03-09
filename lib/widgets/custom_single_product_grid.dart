import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';
import '../view/product_details/product_details.dart';

class CustomSingleProductGrid extends StatelessWidget {
  final QueryDocumentSnapshot product;
  const CustomSingleProductGrid({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double originalPrice =double.parse(product?['original_price']) ;
    double discountPrice = double.parse(product?['discount_price']);
    double discountPercentage = (((originalPrice - discountPrice) / originalPrice) * 100).toPrecision(1);
    return InkWell(
      onTap: () => Get.to(() => ProductDetailsScreen(
        product: product,
      )),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.catBackground,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                  child: Image.network(
                    product?['image'] ?? 'https://mi-home.lv/cdn/shop/files/14170_Redmi_Watch_Black_4-1.png?v=1705914029&width=1260',
                   //  'https://mi-home.lv/cdn/shop/files/14170_Redmi_Watch_Black_4-1.png?v=1705914029&width=1260',
                    height: 100,
                  ),
                ),
                Text(
                  product?['name'],
                  // "Apple Watch Series 6",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (product?['discount_price'] != "0") ...[
                      Text(
                        '\$${product?['discount_price']}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$${product?['original_price']}',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black.withOpacity(.5),
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ] else ...[
                      Text(
                        '\$${product?['original_price']}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ],
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 20,
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: Center(
                    child: Text(
                      '$discountPercentage% Discount',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black.withOpacity(.5),
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.favorite_border,
                      size: 20,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
