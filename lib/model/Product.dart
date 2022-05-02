class Product {
  int id = 0;
  int categoryId = 0;
  String nameProduct = "";
  double rating = 0.0;
  int priceProduct = 0;

  Product(
      {required this.id,
      required this.categoryId,
      required this.nameProduct,
      required this.rating,
      required this.priceProduct});
}
