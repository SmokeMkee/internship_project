import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:internship_project/model/Order.dart';
import 'package:internship_project/model/Product.dart';
import 'package:internship_project/model/User.dart';

class BusketScreen extends StatefulWidget {
  User user;
  BusketScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<BusketScreen> createState() => _BusketScreenState();
}

class _BusketScreenState extends State<BusketScreen> {
  Future<List<Product?>> getBasketProduct() async {
    var busketProducts = widget.user.basket;
    return busketProducts;
  }

  Future<User> buttunPay() async {
    var user = widget.user;
    var sumProduct = 0;
    for (int i = 0; i < user.basket.length; ++i) {
      sumProduct += user.basket[i].priceProduct;
    }
    if (user.basket.isNotEmpty) {
      user.order.add(Order(
          id: user.order.length + 1,
          orderNumber: user.order.length + 1,
          amountProduct: sumProduct,
          listProducts: List.from(user.basket)));
      Navigator.of(context).popAndPushNamed('/main_screen/profile',
          arguments: {'user': user, 'selected_index': 2});
      user.basket.clear();
    }

    return user;
  }

  void deleteProductFromBasket(int index) {
    widget.user.basket.remove(widget.user.basket[index]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // final products = as();
    return Scaffold(
        body: FutureBuilder(
      future: getBasketProduct(),
      builder: (BuildContext context, AsyncSnapshot<List<Product?>> snapshot) {
        if (snapshot.data == null) {
          return const Center(
            child: Text('loading...'),
          );
        } else {
          return Stack(children: [
            ListView.separated(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: Column(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        snapshot.data![index]!.nameProduct,
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
                                        snapshot.data![index]!.rating
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    snapshot.data![index]!.priceProduct
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
                                deleteProductFromBasket(index);
                              },
                              icon: SvgPicture.asset(
                                'assets/delete.svg',
                                width: 45,
                                height: 45,
                              ),
                            )
                          ],
                        ),
                      ],
                    ));
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  height: 1,
                  thickness: 1,
                  indent: 130,
                );
              },
            ),
            Positioned(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    const Color.fromRGBO(12, 63, 166, 1),
                                  ),
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.symmetric(vertical: 15)),
                                  shape: MaterialStateProperty.all(
                                    const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          bottom: Radius.circular(8),
                                          top: Radius.circular(8)),
                                    ),
                                  )),
                              onPressed: () {
                                buttunPay();
                              },
                              child: const Text(
                                'Оплатить',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ]);
        }
      },
    ));
  }
}
