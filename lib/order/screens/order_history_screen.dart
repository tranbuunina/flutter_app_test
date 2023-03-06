import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milktea/order/screens/widgets/item_oder_widget.dart';
import '../model/order_model.dart';
import '../provider/order_controller.dart';

class OrderHistory extends ConsumerStatefulWidget {

  const OrderHistory({Key? key}) : super(key: key);

  @override
  _OrderHistory createState() => _OrderHistory();

}
class _OrderHistory extends ConsumerState<OrderHistory> with TickerProviderStateMixin {



  @override
  Widget build(BuildContext context) {
    final _listOderStatusNew = ref.watch(OrderController.futureOrderProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lịch sử đơn hàng",
            style: TextStyle(
                fontFamily: 'Oswald',
                color: Color(0xff222222),
                fontSize: 18,
                fontWeight: FontWeight.w500)),
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
                  return  OrderWidget(item: data[index]);
                });
          },
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}