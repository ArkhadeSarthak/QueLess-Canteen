import 'package:queue_less/screens/home_screen.dart';
import 'package:queue_less/screens/menu_screen.dart';
import 'package:queue_less/screens/orders_screen.dart';
import 'package:queue_less/screens/profile_screen.dart';
import 'package:queue_less/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottonNavigationBar extends StatefulWidget {
  const BottonNavigationBar({super.key});

  @override
  State<BottonNavigationBar> createState() => _BottonNavigationBarState();
}

class _BottonNavigationBarState extends State<BottonNavigationBar> {
  int _currentIndex = 0;

  List<Widget> pages = [
    HomeScreen(),
    MenuScreen(),
    OrdersScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryBackground,
      bottomNavigationBar: SalomonBottomBar(
        selectedItemColor: AppColors.darkGreen,
        unselectedItemColor: AppColors.badgeBack,
        currentIndex: _currentIndex,
        backgroundColor: AppColors.white,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        onTap: (i) => setState(() {
          _currentIndex = i;
        }),
        items: [
          SalomonBottomBarItem(
            icon: Icon(Icons.home_outlined),
            title: Text("Home", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.restaurant_menu),
            title: Text("Menu", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            title: Text(
              "Orders",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.person_outlined),
            title: Text(
              "Profile",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: IndexedStack(index: _currentIndex, children: pages),
    );
  }
}
