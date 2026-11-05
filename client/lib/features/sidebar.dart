import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:queue_less/services/token_services.dart';
import 'package:queue_less/theme/app_colors.dart';

class Sidebar extends StatefulWidget {
  final Function(int) navigate;
  const Sidebar({super.key, required this.navigate});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  bool _isAdministrator = false;

  Future<void> getMe() async {
    Map<String, dynamic>? userJson = await getUserJson();
    setState(() {
      _isAdministrator =
          userJson?["role"]?.toString().toLowerCase() == "administrator";
    });
  }

  @override
  void initState() {
    super.initState();
    getMe();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.secondaryBackground,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton.filled(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: IconButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: AppColors.lightGreen,
                      foregroundColor: AppColors.white,
                      minimumSize: Size(30, 30),
                    ),
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  widget.navigate(3);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.manage_accounts_rounded,
                      color: AppColors.darkGreen,
                      size: 22,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "View Profile",
                      style: GoogleFonts.outfit(
                        color: AppColors.darkGreen,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              if (_isAdministrator)
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/all-users");
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.list_alt_outlined,
                        color: AppColors.darkGreen,
                        size: 22,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "All Users",
                        style: GoogleFonts.outfit(
                          color: AppColors.darkGreen,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
