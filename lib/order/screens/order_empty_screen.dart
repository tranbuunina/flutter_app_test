import 'package:flutter/material.dart';

class OrderEmpty extends StatefulWidget {
  const OrderEmpty({Key? key}) : super(key: key);

  @override
  State<OrderEmpty> createState() => _OrderEmptyState();
}

class _OrderEmptyState extends State<OrderEmpty> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Đơn hàng",
            style: TextStyle(
                fontFamily: 'Oswald',
                color: Color(0xff222222),
                fontSize: 18,
                fontWeight: FontWeight.w500)),
        actions: <Widget>[
          TextButton(
            onPressed: () {

            },
            child: const Text('Lịch sử đặt hàng',
                style: TextStyle(
                    fontFamily: 'Oswald',
                    color: Color(0xff808089),
                    fontSize: 13,
                    fontWeight: FontWeight.w300)),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            child: Image.asset("assets/images/cart_emty.png"),
          ),
          Container(
            margin:
            const EdgeInsets.only(left: 0, top: 20, right: 0, bottom: 0),
            child: const Text("Bạn chưa có đơn đặt hàng",
                style: TextStyle(
                    fontFamily: 'Oswald',
                    color: Color(0xff222222),
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center),
          ),
          Container(
            margin:
            const EdgeInsets.only(left: 0, top: 5, right: 0, bottom: 20),
            child: const Text(
                "Bạn nghĩ thế nào về việc thử đồ uống mới của chúng tôi ?",
                style: TextStyle(
                    fontFamily: 'Oswald',
                    color: Color(0xff222222),
                    fontSize: 13,
                    fontWeight: FontWeight.w300),
                textAlign: TextAlign.center),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: const Color(0xffFB9116),
                minimumSize: const Size(350, 42) // NEW,
            ),
            onPressed: () {

            },
            child: const Text(
              'Đặt Hàng Ngay',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
