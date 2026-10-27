import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:queue_less/services/token_services.dart';
import 'package:http/http.dart' as http;
import 'package:queue_less/theme/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  static String baseURL = "http://10.0.2.2:8000/auth";

  Future<void> loginUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse("$baseURL/login"),
      headers: {"Content-Type": "application/json; charset=UTF-8"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      saveToken(data["access_token"]);
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data["message"]),
          backgroundColor: AppColors.white,
        ),
      );

      Navigator.pushReplacementNamed(context, "/home");
    } else {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            response.statusCode == 401
                ? "Invalid email or password"
                : "Login failed. Please try again.",
          ),
          backgroundColor: AppColors.redOrange,
        ),
      );
    }
  }

  Future<Map<String, dynamic>> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString("access_token");
    final response = await http.get(
      Uri.parse("$baseURL/me"),
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json; charset=UTF-8",
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return data;
    }

    if (response.statusCode == 401) {
      throw Exception("Unothorized: ${response.statusCode}");
    }

    throw Exception("Can't load user: ${response.statusCode}");
  }

  Future<void> createUser({
    required BuildContext context,
    required String name,
    required String email,
    required String rollNo,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse("$baseURL/register"),
      headers: {"Content-Type": "application/json; charset=UTF-8"},
      body: jsonEncode({
        "name": name,
        "email": email,
        "roll_no": rollNo,
        "password": password,
      }),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Account created successfully"),
          backgroundColor: AppColors.lightGreen,
        ),
      );
      loginUser(context: context, email: email, password: password);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Can't create account (Status code : ${response.statusCode})",
          ),
          backgroundColor: AppColors.lightGreen,
        ),
      );
      throw Exception(
        'Failed to create user (Status Code: ${response.statusCode})',
      );
    }
  }
}
