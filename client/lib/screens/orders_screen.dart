import 'package:google_fonts/google_fonts.dart';
import 'package:queue_less/features/profile_image.dart';
import 'package:queue_less/features/top_bar.dart';
import 'package:queue_less/theme/app_colors.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _isZoomed = false;

  void zoomIn() {
    setState(() {
      _isZoomed = true;
    });
  }

  void zoomOut() {
    setState(() {
      _isZoomed = false;
    });
  }

  String _selectedStatus = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryBackground,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TopBar(zoomIn: zoomIn, zoomOut: zoomOut),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          "My Orders",
                          style: GoogleFonts.outfit(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.subtitle.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Text("5"),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.subtitle.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.search, color: AppColors.darkGreen),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          FilledButton(
                            onPressed: () {
                              setState(() {
                                _selectedStatus = "All";
                              });
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: _selectedStatus == "All"
                                  ? AppColors.lightGreen
                                  : AppColors.white,
                              foregroundColor: _selectedStatus == "All"
                                  ? AppColors.white
                                  : AppColors.darkGreen,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "All",
                                  style: GoogleFonts.outfit(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 1,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.subtitle.withValues(
                                      alpha: 0.2,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text("5"),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          FilledButton(
                            onPressed: () {
                              setState(() {
                                _selectedStatus = "Active";
                              });
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: _selectedStatus == "Active"
                                  ? AppColors.lightGreen
                                  : AppColors.white,
                              foregroundColor: _selectedStatus == "Active"
                                  ? AppColors.white
                                  : AppColors.darkGreen,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "Active",
                                  style: GoogleFonts.outfit(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 1,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.subtitle.withValues(
                                      alpha: 0.2,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text("1"),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          FilledButton(
                            onPressed: () {
                              setState(() {
                                _selectedStatus = "Completed";
                              });
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: _selectedStatus == "Completed"
                                  ? AppColors.lightGreen
                                  : AppColors.white,
                              foregroundColor: _selectedStatus == "Completed"
                                  ? AppColors.white
                                  : AppColors.darkGreen,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "Completed",
                                  style: GoogleFonts.outfit(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 1,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.subtitle.withValues(
                                      alpha: 0.2,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text("4"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          colors: [
                            AppColors.darkGreen,
                            AppColors.deepGreen,
                            AppColors.orange,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withValues(alpha: 0.2),
                            blurRadius: 10,
                            spreadRadius: 1,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(15),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: AppColors.lightGreen.withValues(
                                        alpha: 0.2,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.circle,
                                          color: AppColors.darkGreen,
                                          size: 12,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "LIVE IN PROGRESS",
                                          style: GoogleFonts.outfit(
                                            color: AppColors.darkGreen,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: AppColors.orange.withValues(
                                        alpha: 0.2,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.soup_kitchen,
                                          color: AppColors.darkGreen,
                                          size: 18,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "Preparing (~12 mins)",
                                          style: GoogleFonts.outfit(
                                            color: AppColors.redOrange,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15),
                            Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: AppColors.secondaryBackground.withValues(
                                  alpha: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Pickup Token",
                                        style: GoogleFonts.outfit(
                                          fontSize: 16,
                                          color: AppColors.darkGreen,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "Q-023",
                                        style: GoogleFonts.outfit(
                                          color: AppColors.deepGreen,
                                          fontSize: 26,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Order ID",
                                        style: GoogleFonts.outfit(
                                          fontSize: 16,
                                          color: AppColors.darkGreen,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "#102",
                                        style: GoogleFonts.outfit(
                                          fontSize: 18,
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    10,
                                  ),
                                  child: Image(
                                    image: NetworkImage(
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTEswRLca8fCkYpHQ_LQsBmY-kfA54nhXi7bQ1_iD19IBVu6ct6l_Sqk5Mw&s=10",
                                    ),
                                    height: 60,
                                    width: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  children: [
                                    Text(
                                      "1x Paneer Kathi Roll",
                                      style: GoogleFonts.outfit(
                                        fontSize: 18,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "1x Classic Cold Coffee",
                                      style: GoogleFonts.outfit(
                                        fontSize: 16,
                                        color: AppColors.darkGreen,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                color: AppColors.secondaryBackground.withValues(
                                  alpha: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.storefront_outlined,
                                    size: 20,
                                    color: AppColors.darkGreen,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "Main Engg. Canteen",
                                    style: GoogleFonts.outfit(
                                      color: AppColors.darkGreen,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(
                                    Icons.circle,
                                    color: AppColors.darkGreen,
                                    size: 5,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "Counter 2",
                                    style: GoogleFonts.outfit(
                                      color: AppColors.darkGreen,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  "170",
                                  style: GoogleFonts.outfit(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: AppColors.orange.withValues(
                                      alpha: 0.2,
                                    ),
                                  ),
                                  child: Text(
                                    "Pay at Counter",
                                    style: GoogleFonts.outfit(
                                      color: AppColors.redOrange,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "2 items total",
                                  style: GoogleFonts.outfit(
                                    fontSize: 14,
                                    color: AppColors.black,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            FilledButton(
                              onPressed: () {},
                              style: FilledButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 10,
                                ),
                                backgroundColor: AppColors.deepGreen,
                                foregroundColor: AppColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    10,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.track_changes_outlined, size: 22),
                                  SizedBox(width: 5),
                                  Text(
                                    "Track Live Status",
                                    style: GoogleFonts.outfit(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Order History",
                          style: GoogleFonts.outfit(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Past Campus Meals",
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            color: AppColors.darkGreen,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        
            if (_isZoomed) ProfileImage(),
          ],
        ),
      ),
    );
  }
}
