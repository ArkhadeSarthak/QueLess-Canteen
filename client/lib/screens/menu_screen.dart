import 'package:google_fonts/google_fonts.dart';
import 'package:queue_less/features/profile_image.dart';
import 'package:queue_less/features/top_bar.dart';
import 'package:queue_less/features/update_food_item.dart';
import 'package:queue_less/models/food_items_model.dart';
// import 'package:queue_less/services/auth_services.dart';
import 'package:queue_less/services/food_services.dart';
import 'package:queue_less/services/token_services.dart';
import 'package:queue_less/theme/app_colors.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final TextEditingController _searchController = TextEditingController();
  // final AuthServices _authServices = AuthServices();
  List<Map<String, dynamic>> categories = [
    {"id": 1, "icon": Icons.restaurant, "text": "All", "showtext": "All items"},
    {"id": 2, "icon": Icons.tapas, "text": "Snack", "showtext": "Snack Corner"},
    {"id": 3, "icon": Icons.lunch_dining, "text": "Meals", "showtext": "Meals"},
    {
      "id": 4,
      "icon": Icons.local_cafe_outlined,
      "text": "Beverages",
      "showtext": "Beverages",
    },
  ];
  String _selectedCategory = "All";

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

  Map<String, dynamic>? user;
  bool isLoading = false;

  bool _isChief = false;
  bool _isStudent = false;
  bool _isAdministrator = false;

  Future<void> getMe() async {
    Map<String, dynamic>? userJson = await getUserJson();
    setState(() {
      user = userJson;
      _isChief = userJson?["role"]?.toString().toLowerCase() == "chief";
      _isStudent = userJson?["role"]?.toString().toLowerCase() == "student";
      _isAdministrator =
          userJson?["role"]?.toString().toLowerCase() == "administrator";
    });
  }

  final FoodServices _foodServices = FoodServices();
  late Future<List<GetAllFoodItemsModel>> foodItems;

  Future<void> featchFoodItems() async {
    foodItems = _foodServices.featchFoodItems();
  }

  String? searchText;

  Future<void> deleteFoodItem(
    int id,
    List<GetAllFoodItemsModel> foodItems,
  ) async {
    try {
      await _foodServices.deleteFoodItem(id);

      setState(() {
        foodItems.removeWhere((item) => item.id == id);
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Food item deleted successfully")),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error : $e")));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getMe();
    featchFoodItems();
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
                                      style: GoogleFonts.outfit(
                                        color: AppColors.darkGreen,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      "Explore Menu",
                                      style: GoogleFonts.outfit(
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
                                        style: GoogleFonts.outfit(
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
                            style: GoogleFonts.outfit(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.darkGreen,
                            ),
                            controller: _searchController,
                            onChanged: (value) {
                              setState(() {
                                searchText = value;
                              });
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.white,
                              prefixIcon: Icon(
                                Icons.search,
                                color: AppColors.darkGreen,
                              ),
                              hintText: "Search in canteen menu",
                              hintStyle: GoogleFonts.outfit(
                                color: AppColors.darkGreen,
                                fontSize: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: AppColors.white),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: AppColors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: AppColors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: AppColors.white),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
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
                                          categories[i]["showtext"],
                                          style: GoogleFonts.outfit(
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
                          FutureBuilder(
                            future: foodItems,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return _buildLoadingView();
                              }

                              if (snapshot.hasError) {
                                return _buildErrorView(
                                  snapshot.error.toString(),
                                );
                              }

                              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                return _buildEmptyView();
                              }

                              final foodItems = snapshot.data!;

                              return _buildFoodItemsList(
                                foodItems,
                                searchText ?? "",
                              );
                            },
                          ),
                          if (_isStudent || _isAdministrator)
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
                                  style: GoogleFonts.outfit(
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
                                  style: GoogleFonts.outfit(
                                    color: AppColors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "140",
                              style: GoogleFonts.outfit(
                                color: AppColors.white,
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
                                style: GoogleFonts.outfit(
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

  Widget _buildLoadingView() {
    return Center(child: CircularProgressIndicator(color: AppColors.deepGreen));
  }

  Widget _buildFoodItemsList(
    List<GetAllFoodItemsModel> foodItems,
    String searchText,
  ) {
    final filteredItems = foodItems.where((foodItem) {
      return foodItem.name.toLowerCase().contains(searchText.toLowerCase());
    }).toList();

    if (filteredItems.isEmpty) {
      return _buildEmptyView();
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        return _buildFoodItem(filteredItems[index], foodItems);
      },
    );
  }

  Widget _buildFoodItem(
    GetAllFoodItemsModel foodItem,
    List<GetAllFoodItemsModel> foodItems,
  ) {
    if (foodItem.category == _selectedCategory || _selectedCategory == "All") {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            foodItem.imageUrl != null
                ? Image(
                    image: NetworkImage(foodItem.imageUrl),
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryBackground,
                    ),
                    child: Center(
                      child: Text(
                        "No image",
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          color: AppColors.deepGreen,
                        ),
                      ),
                    ),
                  ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    foodItem.name,
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  Text(
                    foodItem.description,
                    style: GoogleFonts.outfit(color: AppColors.darkGreen, fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "${foodItem.price}",
                        style: GoogleFonts.outfit(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      Spacer(),
                      if (_isChief || _isAdministrator) ...[
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => UpdateFoodItem(
                                id: foodItem.id,
                                imageUrl: foodItem.imageUrl,
                                selectedCategory: foodItem.category,
                                name: foodItem.name,
                                description: foodItem.description,
                                price: foodItem.price,
                                deleteFoodItem: deleteFoodItem,
                                foodItems: foodItems,
                              ),
                            );
                          },
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.redOrange.withValues(
                              alpha: 0.2,
                            ),
                            foregroundColor: AppColors.redOrange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(10),
                            ),
                            minimumSize: Size(20, 22),
                          ),
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            deleteFoodItem(foodItem.id, foodItems);
                          },
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.red.withValues(
                              alpha: 0.2,
                            ),
                            foregroundColor: AppColors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(10),
                            ),
                            minimumSize: Size(20, 22),
                          ),
                          icon: Icon(Icons.delete_outline),
                        ),
                      ],
                      if (_isStudent || _isAdministrator)
                        FilledButton(
                          onPressed: () {},
                          style: FilledButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 15,
                            ),
                            backgroundColor: AppColors.lightGreen,
                            foregroundColor: AppColors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(15),
                            ),
                            minimumSize: Size(0, 32),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.add, size: 18),
                              SizedBox(width: 5),
                              Text(
                                "Add",
                                style: GoogleFonts.outfit(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return SizedBox();
  }

  Widget _buildErrorView(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 50, color: Colors.redAccent),
            const SizedBox(height: 12),
            Text(
              'Error: $error',
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(color: Colors.black, fontSize: 14),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.orange,
                foregroundColor: AppColors.white,
              ),
              onPressed: () {
                featchFoodItems();
              },
              child: const Text("Retry"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyView() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: Text(
          "No Food Items Found",
          style: GoogleFonts.outfit(fontSize: 16, color: AppColors.red),
        ),
      ),
    );
  }
}
