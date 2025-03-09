import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  final Map<String, dynamic> cartData;
  const PaymentScreen({super.key,required this.cartData});

  @override
  Widget build(BuildContext context) {
    print(cartData);
    return Scaffold();
  }
}
