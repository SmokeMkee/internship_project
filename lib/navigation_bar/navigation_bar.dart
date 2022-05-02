import 'package:flutter/material.dart';
import 'package:internship_project/app_screen/busket_screen/busket.dart';
import 'package:internship_project/app_screen/home_screen/home.dart';
import 'package:internship_project/app_screen/profile_screen/profile.dart';
import 'package:internship_project/model/User.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';
class NavBar extends StatefulWidget {
  User user;
  int selected_index = 0;
  NavBar({Key? key, required this.user , required this.selected_index}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedPage = 0;
  @override
  initState(){
    _selectedPage = widget.selected_index;
    connection = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // whenevery connection status is changed.
      if(result == ConnectivityResult.none){
        //there is no any connection
        setState(() {
          isoffline = true;
        });
      }else if(result == ConnectivityResult.mobile){
        //connection is mobile data network
        setState(() {
          isoffline = false;
        });
      }else if(result == ConnectivityResult.wifi) {
        //connection is from wifi
        setState(() {
          isoffline = false;
        });
      }
    });
    super.initState();
  }
  @override
  void dispose() {
    connection!.cancel();
    super.dispose();
  }


  void onSelectPage(int index) {
    setState(() {
      _selectedPage = index;
    });
  }


  StreamSubscription? connection;
  bool isoffline = false;






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(isoffline?"Device is Offline":"Wish Swish" ,style: const TextStyle(
          color: Colors.white
        ),),
        backgroundColor: Color.fromRGBO(12, 64, 166, 1),
      ),
      body: Center(
        child: IndexedStack(
          index: _selectedPage,
          children: [
            HomeScreen(
              user: widget.user,
            ),
            BusketScreen(user: widget.user),
            ProfileScreen(user: widget.user)
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                size: 35,
              ),
              // SvgPicture.asset('assets/home.svg' , color: Colors.grey,)),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_bag_outlined,
                size: 35,
              ),
              label: 'Basket'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle_outlined,
                size: 35,
              ),
              label: 'Profile'),
        ],
        onTap: onSelectPage,
      ),
    );
  }
}
