import 'package:queue_less/features/profile_image.dart';
import 'package:queue_less/features/top_bar.dart';
import 'package:queue_less/services/auth_services.dart';
import 'package:queue_less/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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

  Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("access_token");
    Navigator.pushReplacementNamed(context, "/login");
  }

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
    return Scaffold(
      backgroundColor: AppColors.secondaryBackground,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TopBar(zoomIn: zoomIn, zoomOut: zoomOut),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.white,
                      ),
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipOval(
                                  child: user?["profile_image"] != null
                                      ? Image(
                                          image: NetworkImage(
                                            user?["profile_image"],
                                          ),
                                          fit: BoxFit.cover,
                                          height: 80,
                                          width: 80,
                                        )
                                      : Container(
                                          height: 80,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            color: AppColors.badgeBack,
                                          ),
                                          child: Center(
                                            child: Text(
                                              "SA",
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                        ),
                                ),
                                SizedBox(width: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${user?["name"] ?? "User Name"}",
                                          style: TextStyle(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 24,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Icon(
                                          Icons.verified,
                                          color: AppColors.darkGreen,
                                          size: 26,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${user?["email"] ?? "user.email@college.edu"}",
                                      style: TextStyle(
                                        color: AppColors.darkGreen,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      "University xyz Active",
                                      style: TextStyle(
                                        color: AppColors.darkGreen,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 5),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.edit_outlined,
                                    color: AppColors.darkGreen,
                                    size: 28,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: AppColors.badgeBack.withValues(
                                    alpha: 0.1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.badge_outlined,
                                      color: AppColors.black,
                                      size: 20,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "${user?["roll_no"] ?? "2026-CS-104"}",
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: AppColors.badgeBack.withValues(
                                    alpha: 0.1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.apartment,
                                      color: AppColors.black,
                                      size: 20,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "B.Tech CSE",
                                      style: TextStyle(
                                        color: AppColors.black,
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
                    SizedBox(height: 15),
                    Text(
                      "APP & SUPPORT",
                      style: TextStyle(
                        color: AppColors.darkGreen,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.white,
                      ),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryBackground
                                        .withValues(alpha: 0.7),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Icon(
                                    Icons.vibration,
                                    size: 30,
                                    color: AppColors.darkGreen,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Notifications & Live Chimes",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "Haptic chime when token is called",
                                      style: TextStyle(
                                        color: AppColors.darkGreen,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Icon(
                                  Icons.keyboard_arrow_right_rounded,
                                  color: AppColors.lightGreen,
                                  size: 34,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryBackground
                                        .withValues(alpha: 0.7),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Icon(
                                    Icons.help_outline,
                                    size: 30,
                                    color: AppColors.darkGreen,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Help & Canteen Desk Support",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "FAQs, refund queries & chef notes",
                                      style: TextStyle(
                                        color: AppColors.darkGreen,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Icon(
                                  Icons.keyboard_arrow_right_rounded,
                                  color: AppColors.lightGreen,
                                  size: 34,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryBackground
                                        .withValues(alpha: 0.7),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Icon(
                                    Icons.info_outline,
                                    size: 30,
                                    color: AppColors.darkGreen,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "About QueueLess",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "v2.4.0",
                                      style: TextStyle(
                                        color: AppColors.darkGreen,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Icon(
                                  Icons.keyboard_arrow_right_rounded,
                                  color: AppColors.lightGreen,
                                  size: 34,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    FilledButton(
                      onPressed: () {
                        logOut();
                      },
                      style: FilledButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 10,
                        ),
                        backgroundColor: AppColors.orange.withValues(
                          alpha: 0.15,
                        ),
                        foregroundColor: AppColors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.logout_outlined, size: 22),
                          SizedBox(width: 5),
                          Text(
                            "Log Out of Campus Portal",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.lock_outline, size: 17),
                          SizedBox(width: 10),
                          Text(
                            "QueueLess Smart Dining",
                            style: TextStyle(
                              color: AppColors.darkGreen,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.circle,
                            size: 5,
                            color: AppColors.darkGreen,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Secured with University UOM",
                            style: TextStyle(
                              color: AppColors.darkGreen,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Encrypted End-to-End",
                          style: TextStyle(
                            color: AppColors.darkGreen,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(Icons.circle, size: 5, color: AppColors.darkGreen),
                        SizedBox(width: 5),
                        Text(
                          "Campus Card Network",
                          style: TextStyle(
                            color: AppColors.darkGreen,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          if (_isZoomed) ProfileImage(),
        ],
      ),
    );
  }
}
