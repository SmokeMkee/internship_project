import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:internship_project/model/Product.dart';
import 'package:internship_project/model/User.dart';

class ProductDetailsScreen extends StatefulWidget {
   ProductDetailsScreen({Key? key, required this.id, required this.user , required this.productCategoryName})
      : super(key: key);
  final int id;
  final String productCategoryName ;
  final User user;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  List<Product> _products = [];
  Future<List<Product>> _product() async {
    _products = [
      Product(
          id: 1,
          categoryId: 1,
          nameProduct: 'Товар 1',
          rating: 4.1,
          priceProduct: 700),
      Product(
          id: 2,
          categoryId: 2,
          nameProduct: 'Товар 2',
          rating: 4.2,
          priceProduct: 800),
      Product(
          id: 3,
          categoryId: 3,
          nameProduct: 'Товар 3',
          rating: 4.3,
          priceProduct: 900),
      Product(
          id: 4,
          categoryId: 4,
          nameProduct: 'Товар 4',
          rating: 4.4,
          priceProduct: 600),
      Product(
          id: 5,
          categoryId: 5,
          nameProduct: 'Товар 5',
          rating: 4.5,
          priceProduct: 500),
      Product(
          id: 6,
          categoryId: 1,
          nameProduct: 'Товар 6 ',
          rating: 4.1,
          priceProduct: 700),
      Product(
          id: 7,
          categoryId: 2,
          nameProduct: 'Товар 7 ',
          rating: 4.2,
          priceProduct: 800),
      Product(
          id: 8,
          categoryId: 3,
          nameProduct: 'Товар 8 ',
          rating: 4.3,
          priceProduct: 900),
      Product(
          id: 9,
          categoryId: 4,
          nameProduct: 'Товар 9 ',
          rating: 4.4,
          priceProduct: 600),
      Product(
          id: 10,
          categoryId: 5,
          nameProduct: 'Товар 10',
          rating: 4.5,
          priceProduct: 500),
    ];
    return _products;
  }

  Future<Product> _onProductTap(int index) async {
    var product;
    for (int i = 0; i < _products.length; ++i) {
      if (_products[i].categoryId == widget.id && _products[i].id == index) {
        product = _products[i];
      }
    }

    widget.user.basket.add(product);
    Navigator.of(context).pushReplacementNamed('/main_screen/basket',
        arguments: {'user': widget.user, 'selected_index' : 1});
    return product;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.productCategoryName , style: TextStyle(
            color: Colors.white
          ),),
          backgroundColor: Color.fromRGBO(12, 64, 166, 1),
        ),
        body: FutureBuilder(
          future: _product(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: Text('loading...'),
              );
            } else {
              return Stack(children: [
                ListView.builder(
                    itemCount: (snapshot.data!
                            .where((element) => element.categoryId == widget.id)
                            .toList())
                        .length,
                    itemExtent: 120,
                    itemBuilder: (BuildContext context, int index) {
                      final filteredProducts = snapshot.data!
                          .where((element) => element.categoryId == widget.id)
                          .toList();
                      return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Stack(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: const DecorationImage(
                                            image: NetworkImage(
                                                'https://img2.akspic.ru/previews/4/9/4/6/6/166494/166494-igra_v_kalmara_squid_game-500x.jpg'),
                                            fit: BoxFit.cover)),
                                    width: 100,
                                    height: 80,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              filteredProducts[index]
                                                  .nameProduct,
                                              style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            SvgPicture.asset(
                                              'assets/star.svg',
                                              width: 25,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              filteredProducts[index]
                                                  .rating
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          filteredProducts[index]
                                                  .priceProduct
                                                  .toString() +
                                              ' ₽',
                                          style: const TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        _onProductTap(
                                            filteredProducts[index].id);
                                      },
                                      icon: SvgPicture.asset(
                                        'assets/busket_button.svg',
                                        width: 45,
                                        height: 45,
                                      ))
                                ],
                              ),
                            ],
                          ));
                    })
              ]);
            }
          },
        ));
  }
}
