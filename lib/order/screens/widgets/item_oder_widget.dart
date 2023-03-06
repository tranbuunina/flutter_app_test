// ignore_for_file: unrelated_type_equality_checks, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/order_model.dart';
import '../order_detail_screen.dart';

class OrderWidget extends StatelessWidget {
  final OrderModel item;
  OrderWidget({Key? key, required this.item}) : super(key: key);
  var bgStatus;
  var colorStatus;
  @override
  Widget build(BuildContext context) {
    var checkColor = item.orderStatus!.classOrder.toString();
    if (checkColor == "text-primary") {
      bgStatus = "0xffFFF5EB";
      colorStatus = "0xffFB9116";
    }else if (checkColor == "text-info") {
      bgStatus = "0xffFFF5EB";
      colorStatus = "0xffFB9116";
    }else if (checkColor == "text-warning") {
      bgStatus = "0xffEFFFF4";
      colorStatus = "0xff00AB56";
    }else if (checkColor == "text-success") {
      bgStatus = "0xffEFFFF4";
      colorStatus = "0xff00AB56";
    }else {
      bgStatus = "0xffFFF0F1";
      colorStatus = "0xffFF424E";
    }
    bgStatus = int.parse(bgStatus);
    colorStatus = int.parse(colorStatus);

    return Container(
      margin: const EdgeInsets.only(left: 0, top: 5, right: 0, bottom: 5),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => OrderDetail(id: int.parse(item!.id.toString()), code: item!.code.toString())));
        },
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 90,
                  height: 35,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(bgStatus),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    item.orderStatus!.namevi.toString(),
                    style: TextStyle(
                        fontFamily: 'Oswald',
                        color: Color(colorStatus),
                        fontSize: 13,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const Spacer(),
                Text(item.dateCreated.toString(),
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                        fontFamily: 'Oswald',
                        color: Color(0xff808089),
                        fontSize: 13,
                        fontWeight: FontWeight.w300)),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  child: Image.asset("assets/images/icon_home.png", width: 24),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      left: 10, top: 0, right: 0, bottom: 0),
                  child: Text(
                    item.address.toString(),
                    style: const TextStyle(
                        fontFamily: 'Oswald',
                        color: Color(0xff222222),
                        fontSize: 13,
                        fontWeight: FontWeight.w300),
                    textAlign: TextAlign.left,
                  ),
                )
              ],
            ),
            Container(
              margin:
              const EdgeInsets.only(left: 0, top: 10, right: 0, bottom: 5),
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 0.5,
                      color: const Color(0xffEBEBF0),
                      strokeAlign: BorderSide.strokeAlignCenter)),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Align(
                  child: Image.asset("assets/images/icon_map.png",
                      width: 24, fit: BoxFit.contain),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      left: 10, top: 0, right: 0, bottom: 0),
                  child: Text(
                    item.address.toString(),
                    style: const TextStyle(
                        fontFamily: 'Oswald',
                        color: Color(0xff222222),
                        fontSize: 13,
                        fontWeight: FontWeight.w300),
                    textAlign: TextAlign.left,
                  ),
                )
              ],
            ),
            const SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text(
                    item.product!.map((var e) => e.name).toString(),
                    style: const TextStyle(
                        fontSize: 13,
                        fontFamily: 'Oswald',
                        color: Color(0xff222222),
                        fontWeight: FontWeight.w300),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    NumberFormat.simpleCurrency(
                        locale: 'vi-VN', decimalDigits: 0)
                        .format(item.totalPrice),
                    style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Oswald',
                        color: Color(0xff222222),
                        fontWeight: FontWeight.w300),
                    textAlign: TextAlign.right,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
