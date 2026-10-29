import 'package:queue_less/services/auth_services.dart';
import 'package:queue_less/theme/app_colors.dart';
import 'package:queue_less/theme/app_strings.dart';
import 'package:flutter/material.dart';

class TopBar extends StatefulWidget {
  final Function zoomIn;
  final Function zoomOut;
  const TopBar({super.key, required this.zoomIn, required this.zoomOut});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
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
    return Row(
      children: [
        Image(
          image: AssetImage("assets/images/logo.png"),
          height: 30,
          width: 30,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 10),
        Text(
          AppStrings.logo,
          style: TextStyle(
            color: AppColors.lightGreen,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        Spacer(),
        // IconButton(
        //   onPressed: () {},
        //   icon: Icon(Icons.notifications_outlined, color: AppColors.darkGreen),
        // ),
        SizedBox(width: 10),
        GestureDetector(
          onTapDown: (details) => widget.zoomIn(),
          onTapUp: (details) => widget.zoomOut(),
          onTapCancel: () => widget.zoomOut(),
          child: ClipOval(
            child: user?["profile_image"] != null
                ? Image(
                    image: NetworkImage(user?["profile_image"] ?? ""),
                    height: 35,
                    width: 35,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(color: AppColors.badgeBack),
                    child: Center(
                      child: Text(
                        user?["name"].substring(0, 1) ?? "",
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
