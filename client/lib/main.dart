import 'package:queue_less/screens/botton_navigation_bar.dart';
import 'package:queue_less/screens/login_screen.dart';
import 'package:queue_less/screens/new_food_item_screen.dart';
import 'package:queue_less/screens/sign_up_screen.dart';
import 'package:queue_less/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      title: 'QueueLess Canteen',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      initialRoute: "/",
      routes: {
        "/": (context) => SplashScreen(),
        "/login": (context) => LoginScreen(),
        "/signup": (context) => SignUpScreen(),
        "/home": (context) => BottonNavigationBar(),
        "/new-item": (context) => NewFoodItemScreen(),
      },
    );
  }
}
