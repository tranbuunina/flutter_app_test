import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:milktea/cart/model/cart_model.dart';

final cartProvider = ChangeNotifierProvider((ref) => CartRepository());

class CartRepository extends ChangeNotifier {
  List<CartModel> carts = Hive.box<CartModel>('CartBox').values.toList();
  var box = Hive.box<CartModel>('CartBox');

  void addToCart(CartModel cart) {
    int checkId = carts.indexWhere((e) => e.id == cart.id);
    if (checkId > -1) {
      carts[checkId].quantity += 1;
      box.putAt(checkId, carts[checkId]);
    } else {
      box.add(cart);
    }
    carts = Hive.box<CartModel>('CartBox').values.toList();
    notifyListeners();
  }

  void minusCart(CartModel cart) {
    int checkId = carts.indexWhere((e) => e.id == cart.id);
    if (checkId > -1) {
      if (carts[checkId].quantity > 1) {
        carts[checkId].quantity -= 1;
        box.putAt(checkId, carts[checkId]);
      } else {
        box.deleteAt(checkId);
      }
      carts = Hive.box<CartModel>('CartBox').values.toList();
      notifyListeners();
    }
  }

  double getTotalCart(){
    double total = 0;
    for (var e in carts) {
      total += (e.price * e.quantity);
    }

    return total;
  }
}
