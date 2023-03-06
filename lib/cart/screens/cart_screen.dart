import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../provider/cart_repository.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider).carts;
    final totalPrice = ref.watch(cartProvider).getTotalCart();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Giỏ hàng"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 450,
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 130,
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              width: 1,
                              color: const Color(0xffE8E8E8),
                              style: BorderStyle.solid)),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: SizedBox(
                              width: 120,
                              height: 120,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: CachedNetworkImage(
                                    imageUrl: (Uri.tryParse(
                                                    cartItems[index].images)!
                                                .hasAbsolutePath ==
                                            true)
                                        ? cartItems[index].images
                                        : 'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg',
                                    placeholder: (context, url) => Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: const [
                                        CircularProgressIndicator()
                                      ],
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cartItems[index].name,
                                    style: const TextStyle(
                                        fontFamily: 'Oswald',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        color: Color(0xff222222)),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          NumberFormat.simpleCurrency(
                                                  locale: 'vi-VN',
                                                  decimalDigits: 0)
                                              .format(cartItems[index].price),
                                          style: const TextStyle(
                                            fontFamily: 'Oswald',
                                            fontSize: 15,
                                            color: Color(0xff222222),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 30,
                                              height: 30,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  ref
                                                      .read(
                                                      cartProvider.notifier)
                                                      .minusCart(
                                                      cartItems[index]);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  shape: const CircleBorder(),
                                                  side: const BorderSide(
                                                      color: Color(0xffFB9116)),
                                                  backgroundColor: Colors.white,
                                                  padding: EdgeInsets.zero,
                                                  tapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                ),
                                                child: const Text(
                                                  '-',
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Color(0xffFB9116)),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 35,
                                              width: 35,
                                              margin: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      width: 2,
                                                      color: const Color(
                                                          0xffDDDDE3))),
                                              child: Center(
                                                child: Text(
                                                  cartItems[index]
                                                      .quantity
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 30,
                                              height: 30,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  ref
                                                      .read(
                                                          cartProvider.notifier)
                                                      .addToCart(
                                                          cartItems[index]);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  shape: const CircleBorder(),
                                                  side: const BorderSide(
                                                      color: Color(0xffFB9116)),
                                                  backgroundColor: Colors.white,
                                                  padding: EdgeInsets.zero,
                                                  tapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                ),
                                                child: const Text(
                                                  '+',
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Color(0xffFB9116)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                decoration: BoxDecoration(
                    color: const Color(0xffFBF4ED),
                    borderRadius: BorderRadius.circular(20)),
                height: 220,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Tổng tạm tính',
                          style: TextStyle(
                              fontFamily: 'Oswald',
                              color: Color(0xff525252),
                              fontWeight: FontWeight.w300,
                              fontSize: 15),
                        ),
                        Text(
                          NumberFormat.simpleCurrency(locale: 'vi-VN', decimalDigits: 0).format(totalPrice),
                          style: const TextStyle(
                              fontFamily: 'Oswald',
                              fontSize: 15,
                              color: Color(0xff222222),
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Khuyến mãi',
                          style: TextStyle(
                              fontFamily: 'Oswald',
                              color: Color(0xff525252),
                              fontWeight: FontWeight.w300,
                              fontSize: 15),
                        ),
                        Text(
                          NumberFormat.simpleCurrency(
                                  locale: 'vi-VN', decimalDigits: 0)
                              .format(0),
                          style: const TextStyle(
                              fontFamily: 'Oswald',
                              fontSize: 15,
                              color: Color(0xff222222),
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Tổng cộng',
                          style: TextStyle(
                              fontFamily: 'Oswald',
                              color: Color(0xff525252),
                              fontSize: 15),
                        ),
                        Text(
                          NumberFormat.simpleCurrency(locale: 'vi-VN', decimalDigits: 0).format(totalPrice),
                          style: const TextStyle(
                              fontFamily: 'Oswald',
                              fontSize: 15,
                              color: Color(0xff222222)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 180,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          backgroundColor: const Color(0xffFB9116),
                        ),
                        child: const Center(
                            child: Text('Tiếp Tục',
                                style: TextStyle(
                                    fontFamily: 'Oswald',
                                    fontSize: 16,
                                    color: Colors.white))),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
