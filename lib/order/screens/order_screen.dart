import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milktea/order/screens/widgets/item_oder_widget.dart';
import '../model/order_model.dart';
import '../provider/order_controller.dart';
import 'order_empty_screen.dart';
import 'order_history_screen.dart';

class Order extends ConsumerStatefulWidget {

  const Order({Key? key}) : super(key: key);

  @override
  _OrderState createState() => _OrderState();

}

class _OrderState extends ConsumerState<Order> with TickerProviderStateMixin {
  @override

  Widget build(BuildContext context) {
    final _listOderStatusNew = ref.watch(OrderController.futureOrderStatusNewProvider("1"));
    if (_listOderStatusNew.value == null) {
      return OrderEmpty();
    }else{
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const OrderHistory()));
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
        backgroundColor: const Color(0xffF5F5FA),
        body: SingleChildScrollView(
          child: _listOderStatusNew.when(
            error: (err, stack) => Text('Error: $err'),
            data: (List<OrderModel>? data) {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    return OrderWidget(item: data[index]);
                  });
            },
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
        ),
      );
    }
  }
}
