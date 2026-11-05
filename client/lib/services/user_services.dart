import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:queue_less/models/user_model.dart';
import 'package:queue_less/theme/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServices {
  // static String baseURL = "https://queueless-canteen-rho.vercel.app/users";
  static String baseURL = "http://10.0.2.2:8000/users";

  Future<List<GetAllUsersModel>> featchUsers(BuildContext context) async {
    final response = await http.get(Uri.parse("$baseURL/"));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => GetAllUsersModel.fromJson(item)).toList();
    } else if (response.statusCode == 401) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "You can't see other user profile",
            style: TextStyle(color: AppColors.white),
          ),
          backgroundColor: AppColors.redOrange,
        ),
      );
      throw HttpException("You can't see other users");
    } else {
      throw HttpException(
        "Failed to load users, statuscode : ${response.statusCode}",
      );
    }
  }

  Future<void> updateUser({
    required BuildContext context,
    required String id,
    required String name,
    required String rollNo,
    required String university,
    required String course,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString("access_token");
    final response = await http.put(
      Uri.parse("$baseURL/$id"),
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode({
        "name": name,
        "roll_no": rollNo,
        "university": university,
        "course": course,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Profile updated successfully",
            style: TextStyle(color: AppColors.white),
          ),
          backgroundColor: AppColors.lightGreen,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Can't update profile (Status code : ${response.statusCode})",
            style: TextStyle(color: AppColors.white),
          ),
          backgroundColor: AppColors.orange,
        ),
      );
      throw Exception(
        'Failed to update profile (Status Code: ${response.statusCode})',
      );
    }
  }

  Future<void> updateProfileImage({
    required BuildContext context,
    required String id,
    required String? imageUrl,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString("access_token");
    final response = await http.patch(
      Uri.parse("$baseURL/$id/profile-image"),
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode({"profile_image": imageUrl}),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            imageUrl != null
                ? "Image changed successfully"
                : "Image deleted successfully",
            style: TextStyle(color: AppColors.white),
          ),
          backgroundColor: AppColors.lightGreen,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Can't change profile image (Status code : ${response.statusCode})",
            style: TextStyle(color: AppColors.white),
          ),
          backgroundColor: AppColors.orange,
        ),
      );
    }
  }

  Future<bool> changePassword({
    required BuildContext context,
    required String id,
    required String oldPassword,
    required String newPassword,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString("access_token");
    final response = await http.patch(
      Uri.parse("$baseURL/$id/change-password"),
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode({
        "old_password": oldPassword,
        "new_password": newPassword,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Password changed successfully",
            style: TextStyle(color: AppColors.white),
          ),
          backgroundColor: AppColors.lightGreen,
        ),
      );
      return true;
    } else if (response.statusCode == 401) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Old password does not match",
            style: TextStyle(color: AppColors.white),
          ),
          backgroundColor: AppColors.redOrange,
        ),
      );
      return false;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Can't change password (Status code : ${response.statusCode})",
            style: TextStyle(color: AppColors.white),
          ),
          backgroundColor: AppColors.orange,
        ),
      );
      return false;
    }
  }
}
