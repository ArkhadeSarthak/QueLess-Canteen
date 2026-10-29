import 'package:queue_less/features/profile_image.dart';
import 'package:queue_less/features/top_bar.dart';
import 'package:queue_less/theme/app_colors.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<Map<String, dynamic>> categories = [
    {"id": 1, "icon": Icons.restaurant, "text": "All items"},
    {"id": 2, "icon": Icons.tapas, "text": "Snack Corner"},
    {"id": 3, "icon": Icons.lunch_dining, "text": "Meals"},
    {"id": 4, "icon": Icons.local_cafe_outlined, "text": "Beverages"},
  ];
  String _selectedCategory = "All items";

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryBackground,
      body: SafeArea(
        child: Stack(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TopBar(zoomIn: zoomIn, zoomOut: zoomOut),
                          SizedBox(height: 20),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "CAMPUS FOOD FALL",
                                      style: TextStyle(
                                        color: AppColors.darkGreen,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      "Explore Menu",
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 28,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 1,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: AppColors.subtitle.withValues(
                                      alpha: 0.3,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: AppColors.lightGreen,
                                        size: 14,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "Rush: Low (8 min wait)",
                                        style: TextStyle(
                                          color: AppColors.darkGreen,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.darkGreen,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.white,
                              prefixIcon: Icon(
                                Icons.search,
                                color: AppColors.darkGreen,
                              ),
                              hintText: "Search in canteen menu",
                              hintStyle: TextStyle(
                                color: AppColors.darkGreen,
                                fontSize: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: AppColors.white),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: AppColors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: AppColors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: AppColors.white),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: AppColors.white),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (int i = 0; i < categories.length; i++) ...[
                                  if (i > 0) SizedBox(width: 10),
                                  FilledButton(
                                    onPressed: () {
                                      setState(() {
                                        _selectedCategory =
                                            categories[i]["text"];
                                      });
                                    },
                                    style: FilledButton.styleFrom(
                                      backgroundColor:
                                          _selectedCategory ==
                                              categories[i]["text"]
                                          ? AppColors.lightGreen
                                          : AppColors.white,
                                      foregroundColor:
                                          _selectedCategory ==
                                              categories[i]["text"]
                                          ? AppColors.white
                                          : AppColors.darkGreen,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(categories[i]["icon"]),
                                        SizedBox(width: 5),
                                        Text(
                                          categories[i]["text"],
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: AppColors.darkGreen,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.badgeBack,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Icon(
                            Icons.shopping_bag_outlined,
                            size: 30,
                            color: AppColors.white,
                          ),
                        ),
                        SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "2 items added",
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Icon(
                                  Icons.circle,
                                  size: 5,
                                  color: AppColors.white,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Counter 2",
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "140",
                              style: TextStyle(
                                color: AppColors.black.withValues(alpha: 0.7),
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 5),
                        FilledButton(
                          onPressed: () {},
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.lightGreen,
                            foregroundColor: AppColors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(15),
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "View Cart",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(width: 5),
                              Icon(Icons.arrow_forward, size: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
