import 'Order.dart';
import 'Product.dart';

class User {
  int id = 0;
  String name = "";
  String surname = "";
  String avatar = "";
  String email = "";
  String password = "";
  List<Product> basket = [];
  List<Order> order = [];

  User(
      {required this.id,
      required this.name,
      required this.surname,
      required this.avatar,
      required this.password,
      required this.email,
      required this.basket,
      required this.order});
}
