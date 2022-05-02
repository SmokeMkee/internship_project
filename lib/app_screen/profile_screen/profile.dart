// import 'dart:io';

import 'dart:io';

import 'package:flutter_svg/svg.dart';
// import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internship_project/model/Order.dart';
import 'package:internship_project/model/User.dart';

class ProfileScreen extends StatefulWidget {
  User user;
  ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<List<Order>> getUserOrder() async {
    var order = widget.user.order;

    return order;
  }

  @override
  Widget build(BuildContext context) {
    String user = widget.user.name + ' ' + widget.user.surname;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
               image_picker(  user:user,),
              FutureBuilder(
                future: getUserOrder(),
                builder: (BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
                  if (snapshot.data == null) {
                    return const Center(
                      child: Text('loading...'),
                    );
                  } else {
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          const Text('История покупок'),
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index1) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10 ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: const Color.fromRGBO(246, 246, 246, 1),
                                        borderRadius: BorderRadius.circular(12)),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                      vertical: 15, horizontal: 15),
                                                  child: Text(
                                                    'Заказ №' +
                                                        snapshot.data![index1].orderNumber
                                                            .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 17,
                                                        fontWeight: FontWeight.w600),
                                                  ),
                                                )),
                                            Text(
                                              snapshot.data![index1].amountProduct
                                                  .toString() +
                                                  ' ₽',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        ListView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: snapshot
                                                .data![index1].listProducts.length,
                                            itemBuilder:
                                                (BuildContext context, int index2) {
                                              return Row(
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets.symmetric(
                                                          vertical: 10,
                                                          horizontal: 15),
                                                      child: Text(
                                                        snapshot
                                                            .data![index1]
                                                            .listProducts[index2]
                                                            .nameProduct
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                            FontWeight.w400),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    snapshot
                                                        .data![index1]
                                                        .listProducts[index2]
                                                        .priceProduct
                                                        .toString() +
                                                        ' ₽',
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ],
                                              );
                                            })
                                      ],
                                    ),
                                  ),
                                );
                              })
                        ]);
                  }
                },
              ),
            ],
          )
        ),
      ),
    );
  }
}

class image_picker extends StatefulWidget {
  String user = "";
   image_picker( {Key? key ,required this.user }) : super(key: key);

  @override
  _image_pickerState createState() => _image_pickerState();
}

class _image_pickerState extends State<image_picker> {
  File? pickedImage;
  pickImages(ImageSource image)  async {
    final photo = await ImagePicker().pickImage(source: image);
    if (photo == null) {
      return;
    }
    final tempImage = File(photo.path);
    setState(() {
      pickedImage = tempImage;
    });
  }

  String imagePath = '';
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    String name = widget.user;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: const BoxDecoration(

          ),
          child: IconButton(
              onPressed: () async {
                pickImages(
                  ImageSource.gallery,
                );
              },
              icon: pickedImage != null
                  ? CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 100,
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: Image.file(
                      pickedImage!,
                      fit: BoxFit.fill,
                    ).image,
                  ))
                  : SvgPicture.asset(
                'assets/pick_profile.svg',
                fit: BoxFit.cover,
              )),
        ),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Text(
                name,
                style: const TextStyle(fontSize: 19 , fontWeight: FontWeight.w600),
              ),

            ],
          ),
        ),

      ],
    );
  }
}