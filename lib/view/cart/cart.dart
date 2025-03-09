import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commece/view/payment/payment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    var cartData;
    return Scaffold(
      appBar: const CustomAppBar(title: "My Cart"),
      body: Column(
        children: [
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user!.email)
                  .collection('cart')
                  .snapshots(),
              builder: (_, snapshots) {
                // print(snapshots.data!.docs[1].data());
                if (snapshots.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: snapshots.data!.docs.length,
                      itemBuilder: (_, index) {
                        final product = snapshots.data!.docs[index];
                        var cartItem = product.data() as Map<String, dynamic>;
                        cartData = cartItem;


                        //var cartItem = snapshots.data!.docs[index].data();
                       // List<Map<String, dynamic>>   cartData =  cartItem as List<Map<String, dynamic>>;
                        //print(cartItem);
                        Future<DocumentSnapshot<Map<String, dynamic>>> q;
                        return ListTile(
                          leading: Image.network(product['image']),
                          title: Text(
                            product['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text('\$${product['price']}'),
                          trailing: Column(
                            children: [
                              Text('Size: ${product['variant']}'),
                              Container(
                                height: 40,
                                width: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: AppColors.primaryColor,
                                    )),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () => {
                                        if (product['quantity'] > 1)
                                          {
                                            q = FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(user.email)
                                                .collection('cart')
                                                .doc(product.id)
                                                .get(),
                                            FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(user!.email)
                                                .collection('cart')
                                                .doc(product.id)
                                                .update({
                                              'quantity':
                                                  product.data()!['quantity'] -
                                                      1
                                            })
                                          }
                                        else
                                          {
                                            print(product['quantity']),
                                            FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(user.email)
                                                .collection('cart')
                                                .doc(product.id)
                                                .delete(),
                                            Get.snackbar(
                                              'Success',
                                              'Product successfully remove to cart',
                                              colorText: AppColors.primaryColor,
                                            )
                                          }
                                      },
                                      child: const Icon(
                                        Icons.remove,
                                      ),
                                    ),
                                    Text(
                                      product['quantity'].toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () => {
                                        q = FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(user.email)
                                            .collection('cart')
                                            .doc(product.id)
                                            .get(),
                                        // product['quantity'],
                                        print(product['quantity']),
                                        FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(user!.email)
                                            .collection('cart')
                                            .doc(product.id)
                                            .update({
                                          'quantity':
                                              product.data()!['quantity'] + 1
                                        }),
                                      },
                                      child: Icon(
                                        Icons.add,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              }),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.email)
                            .collection('cart')
                            .snapshots(),
                        builder: (_, snapshots) {
                          if (snapshots.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else {
                            final product = snapshots.data!.docs;
                            double totalPrice = 0;
                            // print(snapshots.data!.docs[1].data());
                            for (var i in product) {
                              totalPrice +=
                                  i['quantity'] * int.parse(i['price']);
                              //print(totalPrice);
                            }
                            return Text(
                              "\$$totalPrice",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                            );
                          }
                        })
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomButton(
                  title: 'Buy Now',
                  onTap: () {
                    print(cartData);
                    //Get.to(()=>PaymentScreen(cartData: cartData));

                    /*final cartItem = controller.cart;
                    List<Map<String, dynamic>> cartData = cartItem
                        .map((cart) => cart.data() as Map<String, dynamic>)
                        .toList();

                    Get.to(
                      () => PaymentView(
                        cartData: cartData,
                        totalAmount: controller.totalPrice.value,
                      ),
                    );*/
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
