import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString("access_token", token);
}

Future<void> saveUserJson(Map<String, dynamic> userJson) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setString("current_user", jsonEncode(userJson));
}

Future<Map<String, dynamic>?> getUserJson() async {
  final prefs = await SharedPreferences.getInstance();
  final String? storedJson = prefs.getString("current_user");

  if (storedJson == null) {
    return null;
  }

  return jsonDecode(storedJson) as Map<String, dynamic>;
}
