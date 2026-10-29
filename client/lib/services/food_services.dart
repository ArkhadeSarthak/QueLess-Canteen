import 'dart:convert';
import 'dart:io';

import 'package:queue_less/models/food_items_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FoodServices {
  static String baseURL = "http://10.0.2.2:8000/food";

  Future<List<GetAllFoodItemsModel>> featchFoodItems() async {
    final response = await http.get(Uri.parse("$baseURL/"));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => GetAllFoodItemsModel.fromJson(item)).toList();
    } else {
      throw HttpException(
        'Failed to load food items (Status Code: ${response.statusCode})',
      );
    }
  }

  Future<GetAllFoodItemsModel> createFoodItem({
    required String name,
    required String description,
    required double price,
    required String category,
    required String imageUrl,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString("access_token");

    final response = await http.post(
      Uri.parse("$baseURL/new-item"),
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode({
        "name": name,
        "description": description,
        "price": price,
        "category": category,
        "image_url": imageUrl,
      }),
    );

    if (response.statusCode == 201) {
      final dynamic data = jsonDecode(response.body);
      return GetAllFoodItemsModel.fromJson(data);
    } else {
      throw HttpException(
        "Failed to create food item (Status Code: ${response.statusCode})",
      );
    }
  }

  Future<bool> deleteFoodItem(int id) async {
    final response = await http.delete(Uri.parse('$baseURL/$id'));

    if (response.statusCode == 200) {
      return true;
    } else {
      throw HttpException(
        "Failed to delete food item (Status Code: ${response.statusCode})",
      );
    }
  }

  Future<GetAllFoodItemsModel> updateFoodItem({
    required int id,
    required String name,
    required String description,
    required double price,
    required String category,
    required String imageUrl,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString("access_token");

    final response = await http.put(
      Uri.parse("$baseURL/update-item/$id"),
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode({
        "name": name,
        "description": description,
        "price": price,
        "category": category,
        "image_url": imageUrl,
      }),
    );

    if (response.statusCode == 200) {
      final dynamic data = jsonDecode(response.body);
      return GetAllFoodItemsModel.fromJson(data);
    } else {
      throw HttpException(
        "Failed to update food item (Status Code: ${response.statusCode})",
      );
    }
  }
}
