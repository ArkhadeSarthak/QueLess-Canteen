import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modern_animated_loader/flutter_animated_loader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:queue_less/models/food_items_model.dart';
import 'package:queue_less/services/food_services.dart';
import 'package:queue_less/theme/app_colors.dart';
import 'package:http/http.dart' as http;

class UpdateFoodItem extends StatefulWidget {
  final int id;
  final String imageUrl;
  final String selectedCategory;
  final String name;
  final String description;
  final double price;
  final Function deleteFoodItem;
  final List<GetAllFoodItemsModel> foodItems;

  const UpdateFoodItem({
    super.key,
    required this.id,
    required this.imageUrl,
    required this.selectedCategory,
    required this.name,
    required this.description,
    required this.price,
    required this.deleteFoodItem,
    required this.foodItems,
  });

  @override
  State<UpdateFoodItem> createState() => _UpdateFoodItemState();
}

class _UpdateFoodItemState extends State<UpdateFoodItem> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int _nameLength = 0;
  int _descLength = 0;

  List<Map<String, dynamic>> categories = [
    {"id": 2, "icon": Icons.cookie_outlined, "text": "Snacks"},
    {"id": 3, "icon": Icons.lunch_dining, "text": "Meals"},
    {"id": 4, "icon": Icons.local_cafe_outlined, "text": "Beverages"},
    {"id": 5, "icon": Icons.category_outlined, "text": "Other"},
  ];
  String? _selectedCategory;

  XFile? _selectedImage;
  bool _isUploading = false;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 85,
    );

    if (image == null || !mounted) return;

    setState(() {
      _selectedImage = image;
    });
  }

  String? uplodedImageUrl;

  Future<bool> _uploadImage() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please select an image")));

      return false;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      final url = Uri.parse("https://queueless-canteen-rho.vercel.app/images/upload");
      final request = http.MultipartRequest("POST", url);

      request.files.add(
        await http.MultipartFile.fromPath("file", _selectedImage!.path),
      );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (!mounted) return false;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          uplodedImageUrl = data["image_url"];
        });

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Image uploaded successfully!")));
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Upload failed: ${response.body}")),
        );
        return false;
      }
    } catch (e) {
      if (!mounted) return false;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error uploading image: $e')));
      return false;
    } finally {
      if (mounted) {
        setState(() => _isUploading = false);
      }
    }
  }

  void updateFoodItemList(GetAllFoodItemsModel updatedItem) {
    final index = widget.foodItems.indexWhere(
      (item) => item.id == updatedItem.id,
    );

    if (index != -1) {
      setState(() {
        widget.foodItems[index] = updatedItem;
      });
    }
  }

  final FoodServices _foodServices = FoodServices();
  late Future<GetAllFoodItemsModel> foodItem;

  Future<void> updateFoodItem() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please fill all fields")));

      return;
    }

    if (_selectedCategory == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please select category")));

      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      if (_selectedImage != null) {
        final bool uploaded = await _uploadImage();
        if (!uploaded) return;
      }

      final GetAllFoodItemsModel updatedItem = await _foodServices
          .updateFoodItem(
            id: widget.id,
            name: _nameController.text.trim(),
            description: _descriptionController.text.trim(),
            price: double.tryParse(_priceController.text) ?? 0.0,
            category: _selectedCategory ?? "",
            imageUrl: uplodedImageUrl ?? widget.imageUrl,
          );

      updateFoodItemList(updatedItem);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Food item updated successfully")),
      );

      Navigator.pop(context, updatedItem);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to update food item: $e")));
    } finally {
      if (mounted) {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState;
    setState(() {
      _selectedCategory = widget.selectedCategory;
      _nameController.text = widget.name;
      _descriptionController.text = widget.description;
      _priceController.text = widget.price.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.green.withValues(alpha: 0.3),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.circle,
                              color: AppColors.darkGreen,
                              size: 8,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Live on Menu",
                              style: TextStyle(
                                color: AppColors.darkGreen,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          widget.deleteFoodItem(widget.id, widget.foodItems);
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.red.withValues(alpha: 0.1),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete_outline_rounded,
                                color: AppColors.red,
                                size: 16,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Delete Item",
                                style: TextStyle(
                                  color: AppColors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_a_photo_outlined,
                              size: 20,
                              color: AppColors.deepGreen,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Dish Photography",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "JPG, PNG • Max 5MB",
                              style: TextStyle(
                                color: AppColors.darkGreen,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: AppColors.secondaryBackground,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadiusGeometry.circular(
                                      10,
                                    ),
                                    child: _selectedImage != null
                                        ? Image.file(
                                            File(_selectedImage!.path),
                                            height: 200,
                                            width: 200,
                                            fit: BoxFit.cover,
                                          )
                                        : (widget.imageUrl.isNotEmpty)
                                        ? Image.network(
                                            widget.imageUrl,
                                            height: 200,
                                            width: 200,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                                  return const Center(
                                                    child: Text(
                                                      "Failed to load image",
                                                    ),
                                                  );
                                                },
                                          )
                                        : Container(
                                            height: 200,
                                            width: 200,
                                            color: AppColors.badgeBack
                                                .withValues(alpha: 0.1),
                                            child: Center(
                                              child: Text("Add Image"),
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: FilledButton(
                                      onPressed: () {
                                        _pickImage(ImageSource.camera);
                                      },
                                      style: FilledButton.styleFrom(
                                        backgroundColor: AppColors.lightGreen,
                                        foregroundColor: AppColors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadiusGeometry.circular(10),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.camera_alt_outlined,
                                            size: 20,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            "Upload Photo",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  IconButton(
                                    onPressed: () {
                                      _pickImage(ImageSource.gallery);
                                    },
                                    style: IconButton.styleFrom(
                                      padding: EdgeInsets.all(10),
                                      backgroundColor: AppColors.darkGreen
                                          .withValues(alpha: 0.1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadiusGeometry.circular(10),
                                      ),
                                    ),
                                    icon: Icon(
                                      Icons.photo_library_outlined,
                                      color: AppColors.deepGreen,
                                      size: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.edit_note_rounded,
                              size: 22,
                              color: AppColors.deepGreen,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Item Details",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black,
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Text(
                              "Food Item Name *",
                              style: TextStyle(
                                color: AppColors.black.withValues(alpha: 0.8),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "$_nameLength/60",
                              style: TextStyle(
                                fontSize: 15,
                                color: AppColors.darkGreen,
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: _nameController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 16,
                          ),
                          onChanged: (value) {
                            setState(() {
                              _nameLength = value.trim().length;
                            });
                          },
                          maxLength: 60,

                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.secondaryBackground,
                            isDense: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.secondaryBackground,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.secondaryBackground,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.secondaryBackground,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.secondaryBackground,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.secondaryBackground,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.secondaryBackground,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            hintText: "Food Name",
                            hintStyle: TextStyle(
                              color: AppColors.badgeBack,
                              fontSize: 16,
                            ),
                            counterText: "",
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Please enter name";
                            }
                            if (value.trim().length < 3) {
                              return "Please enter min 3 char of name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Text(
                              "Short Description",
                              style: TextStyle(
                                color: AppColors.black.withValues(alpha: 0.8),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "$_descLength/150",
                              style: TextStyle(
                                fontSize: 15,
                                color: AppColors.darkGreen,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 90,
                          child: TextFormField(
                            controller: _descriptionController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 16,
                            ),
                            onChanged: (value) {
                              setState(() {
                                _descLength = value.trim().length;
                              });
                            },
                            maxLength: 150,
                            maxLines: 3,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.secondaryBackground,
                              isDense: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.secondaryBackground,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.secondaryBackground,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.secondaryBackground,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.secondaryBackground,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.secondaryBackground,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.secondaryBackground,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              hintText: "Write Description",
                              hintStyle: TextStyle(
                                color: AppColors.badgeBack,
                                fontSize: 16,
                              ),
                              counterText: "",
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Please enter description";
                              }
                              if (value.trim().length < 10) {
                                return "Please enter min 10 char of description";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Menu Category",
                          style: TextStyle(
                            color: AppColors.black.withValues(alpha: 0.8),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (int i = 0; i < categories.length; i++) ...[
                                if (i > 0) SizedBox(width: 10),
                                FilledButton(
                                  onPressed: () {
                                    setState(() {
                                      _selectedCategory = categories[i]["text"];
                                    });
                                  },
                                  style: FilledButton.styleFrom(
                                    backgroundColor:
                                        _selectedCategory ==
                                            categories[i]["text"]
                                        ? AppColors.lightGreen
                                        : AppColors.secondaryBackground,
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
                        SizedBox(height: 15),
                        Text(
                          "Base Price (INR) *",
                          style: TextStyle(
                            color: AppColors.black.withValues(alpha: 0.8),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextFormField(
                          controller: _priceController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d{0,2}'),
                            ),
                          ],
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.secondaryBackground,
                            isDense: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.secondaryBackground,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.secondaryBackground,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.secondaryBackground,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.secondaryBackground,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.secondaryBackground,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.secondaryBackground,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            hintText: "Food Name",
                            hintStyle: TextStyle(
                              color: AppColors.badgeBack,
                              fontSize: 16,
                            ),
                            prefixIcon: Center(
                              widthFactor: 1.0,
                              heightFactor: 1.0,
                              child: Text(
                                '₹',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.darkGreen,
                                ),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Please enter price";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        FilledButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.badgeBack.withValues(
                              alpha: 0.2,
                            ),
                            foregroundColor: AppColors.darkGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(10),
                            ),
                          ),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: _isUploading
                              ? FilledButton(
                                  onPressed: null,
                                  style: FilledButton.styleFrom(
                                    backgroundColor: AppColors.lightGreen,
                                    foregroundColor: AppColors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadiusGeometry.circular(10),
                                    ),
                                  ),
                                  child: FlutterAnimatedLoader.horizontalSpin(
                                    color: AppColors.darkGreen,
                                    size: 35,
                                  ),
                                )
                              : FilledButton(
                                  onPressed: () async {
                                    await updateFoodItem();
                                  },
                                  style: FilledButton.styleFrom(
                                    backgroundColor: AppColors.lightGreen,
                                    foregroundColor: AppColors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadiusGeometry.circular(10),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Save changes",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Icon(Icons.arrow_forward, size: 18),
                                    ],
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
