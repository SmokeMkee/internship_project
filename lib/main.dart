import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:internship_project/app_screen/busket_screen/busket.dart';
import 'package:internship_project/app_screen/home_screen/home.dart';
import 'package:internship_project/app_screen/home_screen/product_details_screen/product_details.dart';
import 'package:internship_project/app_screen/profile_screen/profile.dart';
import 'package:internship_project/model/User.dart';
import 'package:intl/locale.dart';
import 'app_screen/login/login.dart';
import 'generated/l10n.dart';
import 'navigation_bar/navigation_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.grey,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            showUnselectedLabels: true,
            selectedItemColor: Color.fromRGBO(68, 167, 184, 1),
            unselectedItemColor: Color.fromRGBO(144, 153, 170, 1),
            unselectedLabelStyle:
                TextStyle(color: Color.fromRGBO(144, 153, 170, 1)),
            selectedLabelStyle:
                TextStyle(color: Color.fromRGBO(144, 153, 170, 1)),
          )),
      routes: {
        '/auth': (context) => const LoginPage(),
        '/main_screen': (context) {
          final user = ModalRoute.of(context)!.settings.arguments as User;
          return NavBar(
            user: user,
            selected_index: 0,
          );
        },
        '/main_screen/home_screen': (context) {
          final user = ModalRoute.of(context)!.settings.arguments as User;
          return HomeScreen(user: user);
        },
        '/main_screen/home_screen/product_details': (context) {
          final id =
              ModalRoute.of(context)!.settings.arguments as Map<String, Object>;

          return ProductDetailsScreen(
            id: id['id'] as int,
            user: id['user'] as User,
            productCategoryName: id['productCategoryName'] as String,
          );
        },
        '/main_screen/basket': (context) {
          final user =
              ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
          return NavBar(
            user: user['user'] as User,
            selected_index: user['selected_index'] as int,
          );
        },
        '/main_screen/profile': (context) {
          final user =
              ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
          return NavBar(
            user: user['user'] as User,
            selected_index: user['selected_index'] as int,
          );
        },
      },
      initialRoute: '/auth',
    );
  }
}
