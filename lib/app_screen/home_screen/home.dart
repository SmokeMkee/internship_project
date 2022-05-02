import 'package:flutter/material.dart';
import 'package:internship_project/model/Product_Category.dart';
import 'package:internship_project/model/User.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _productCategory = [
    ProductCategory(id: 1, name: 'Овощи', productCount: 80),
    ProductCategory(id: 2, name: 'Молочка', productCount: 90),
    ProductCategory(id: 3, name: 'Бакалея', productCount: 100),
    ProductCategory(id: 4, name: 'Снэки', productCount: 110),
    ProductCategory(id: 5, name: 'Овощи', productCount: 120),
    ProductCategory(id: 6, name: 'Молочка', productCount: 130),
    ProductCategory(id: 7, name: 'Бакалея', productCount: 100),
    ProductCategory(id: 8, name: 'Снэки', productCount: 110),
    ProductCategory(id: 9, name: 'Овощи', productCount: 120),
    ProductCategory(id: 10, name: 'Молочка', productCount: 130),
  ];
  void _onProductTap(int index) {
    final id = _productCategory[index].id;
    final productCategoryName = _productCategory[index].name;
    Navigator.of(context).pushNamed('/main_screen/home_screen/product_details',
        arguments: {'user': widget.user, 'id': id , 'productCategoryName' : productCategoryName});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                mainAxisExtent: 250,
                childAspectRatio: 3 / 2,
              ),
              itemCount: _productCategory.length,
              itemBuilder: (BuildContext ctx, index) {
                final news = _productCategory[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: SizedBox(
                    height: 25,
                    child: Stack(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: const DecorationImage(
                                          image: NetworkImage(
                                              'https://img2.akspic.ru/previews/4/9/4/6/6/166494/166494-igra_v_kalmara_squid_game-500x.jpg'),
                                          fit: BoxFit.cover)),
                                  width: MediaQuery.of(context).size.width - 40,
                                  height: 150,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        news.name,
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Text(
                                      news.productCount.toString() + ' шт',
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            onTap: () => _onProductTap(index),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
