import 'package:queue_less/services/auth_services.dart';
import 'package:queue_less/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({super.key});

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  final AuthServices _authServices = AuthServices();
  Map<String, dynamic>? user;
  bool isLoading = false;

  Future<void> getMe() async {
    if (user != null || isLoading) return;
    setState(() {
      isLoading = true;
    });
    try {
      final response = await _authServices.getCurrentUser();

      if (!mounted) return;

      setState(() {
        user = response;
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error fetching user: $e"),
          backgroundColor: AppColors.redOrange,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getMe();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Center(
        child: SafeArea(
          child: user?["profile_image"] != null
              ? Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.badgeBack,
                  ),
                  child: ClipOval(
                    child: Image(
                      image: NetworkImage(user?["profile_image"]),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    color: AppColors.badgeBack,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      "SA",
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
