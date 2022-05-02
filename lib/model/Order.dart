import 'package:internship_project/model/Product.dart';

class Order {
  int id = 0;
  int orderNumber = 0;
  int amountProduct = 0;
  String date = DateTime.now().toString();
  List<Product> listProducts;

  Order(
      {required this.id,
      required this.orderNumber,
      required this.amountProduct,
      required this.listProducts});
}
