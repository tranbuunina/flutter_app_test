
import 'package:hive/hive.dart';
part 'cart_model.g.dart';


@HiveType(typeId: 0)
class CartModel extends HiveObject {
  @HiveField(0)
  late String id;
  @HiveField(1)
  late String name;
  @HiveField(2)
  late double price;
  @HiveField(3)
  late String images;
  @HiveField(4)
  late int quantity;

  CartModel({required this.id, required this.name, required this.price, required this.images, required this.quantity});

}