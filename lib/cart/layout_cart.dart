import 'package:flutter/material.dart';
import 'package:milktea/cart/screens/cart_screen.dart';
import 'package:milktea/product/screens/product_screen.dart';

class LayoutCart extends StatefulWidget {
  const LayoutCart({super.key});

  @override
  State<LayoutCart> createState() => _LayoutCartState();
}

class _LayoutCartState extends State<LayoutCart> {
  @override
  Widget build(BuildContext context) {
    return CartScreen();
  }
}
