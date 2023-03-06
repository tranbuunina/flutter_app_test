import 'package:flutter/material.dart';
import 'package:milktea/product/screens/product_screen.dart';

class LayoutProduct extends StatefulWidget {
  const LayoutProduct({super.key});

  @override
  State<LayoutProduct> createState() => _LayoutProductState();
}

class _LayoutProductState extends State<LayoutProduct> {
  @override
  Widget build(BuildContext context) {
    return ProductScreen();
  }
}
