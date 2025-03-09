import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commece/utils/config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_single_product_grid.dart';
import '../cart/cart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: CustomAppBar(title: AppConfig.appname,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const CartScreen());
            },
            icon: const Icon(Icons.shopping_cart),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(user!.email) // Fetch only the current user's document
                    .snapshots(),
                builder: (__, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return Text("User not found");
                  }

                  String name = snapshot.data!['full_name'] ?? 'Unknown';

                  return Text(
                    'Hello $name 👋',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  );
                },
              ),
              Text(
                'Let’s start shopping!',
                style: TextStyle(
                  color: Colors.black.withOpacity(.5),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              /*CarouselSlider.builder(
                itemCount: slider.length,
                // itemCount: snapshot.data!.docs.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(slider[itemIndex]
                          // snapshot.data!.docs[itemIndex].data()['data']
                          ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                options: CarouselOptions(
                  height: 140,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                ),
              ),*/
              StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('banner').snapshots(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Text("No banners available");
                  }

                  return CarouselSlider.builder(
                    itemCount: snapshot.data!.docs.length, // Use dynamic length
                    itemBuilder: (BuildContext context, int itemIndex,
                        int pageViewIndex) {
                      var bannerData = snapshot.data!.docs[itemIndex].data();
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(bannerData['url'] ?? ''),
                            // Ensure 'url' exists
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: 140,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Categories',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'View All',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('categorys')
                      .snapshots(),
                  builder: (_, snapshots) {
                    if (snapshots.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else {
                      return SizedBox(
                        height: 80,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshots.data!.docs.length,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (_, index) {
                            //final data = snapshots.data!.docs[index];
                            return Container(
                              margin: const EdgeInsets.only(right: 10),
                              width: 80,
                              decoration: BoxDecoration(
                                color: AppColors.catBackground,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.black.withOpacity(.1),
                                  width: 2,
                                ),
                              ),
                              // child: Image.network(data['icon']),
                              child: Image.asset(
                                  snapshots.data!.docs[index]['icon']),
                            );
                          },
                        ),
                      );
                    }
                  }),
              const SizedBox(
                height: 20,
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("products")
                      .snapshots(),
                  builder: (_, snapshots) {
                    if (snapshots.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else {
                      return GridView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: snapshots.data!.docs.length,
                        // itemCount: snapshot.data!.docs.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: .8,
                        ),
                        itemBuilder: (_, index) {
                          return CustomSingleProductGrid(
                            // product: snapshot.data!.docs[index],
                            product: snapshots.data!.docs[index],
                          );
                        },
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
