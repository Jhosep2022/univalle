import 'package:flutter/material.dart';
import 'package:madamecosmetics/pages/CartPage.dart';
import 'package:madamecosmetics/pages/login_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,

      ),
      routes: {
        "/":(context) => LoginScreen(),
        "cartPage":(context) => CartPage(),
      },
    );
  }
}