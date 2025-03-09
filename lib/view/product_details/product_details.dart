import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commece/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';

class ProductDetailsScreen extends StatelessWidget {
  final QueryDocumentSnapshot product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final controller = Get.put(ProductController());
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const CustomAppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: size.height * .4,
                    color: AppColors.catBackground,
                    padding: EdgeInsets.all(30),
                    child: Center(
                      child: Image.network(
                          product['image']),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                             product['name'],
                            // "Apple Watch Series 6",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.orangeAccent,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.orangeAccent,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.orangeAccent,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.orangeAccent,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.orangeAccent,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                     '\$${product['discount_price']}',
                                    // "45,000",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'Available in stock',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'About',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18
                            ),
                          ),
                          Text(
                             product['about'],
                            // "The upgraded S6 SiP runs up to 20 percent faster, allowing apps to also launch 20 percent faster, while maintaining the same all-day 18-hour battery life.",
                            style: TextStyle(
                              color: Colors.black.withOpacity(.5),
                              fontSize: 15
                            ),
                          )
                        ],
                      )
                  )
                ],
              ),
            )
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('products')
                        .doc(product.id)
                        .snapshots(),
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else {
                        return SizedBox(
                          height: 40,
                          child: ListView.builder(
                            itemCount: snapshot.data!.data()!['size'].length,
                            shrinkWrap: true,
                            primary: false,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              return Obx(
                                    () => InkWell(
                                  onTap: () {
                                    controller.selectedIndex.value = index;
                                    controller.selectedSize.value = snapshot.data!
                                        .data()!['size'][index]
                                        .toString();
                                  },
                                  child: Container(
                                    width: 40,
                                    margin: const EdgeInsets.only(
                                      right: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                      controller.selectedIndex.value == index
                                          ? AppColors.primaryColor
                                          : null,
                                      border: Border.all(
                                        color: Colors.black.withOpacity(.1),
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        snapshot.data!
                                            .data()!['size'][index]
                                            .toString(),
                                        style: TextStyle(
                                          color: controller.selectedIndex.value ==
                                              index
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                    title: 'Add to cart',
                    onTap: () => controller.addToCart(product),
                  ),
                ],
              ),
            )
      
          ],
        ),
      ),
    );
  }
}
