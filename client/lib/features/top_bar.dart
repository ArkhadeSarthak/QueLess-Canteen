// import 'package:queue_less/services/auth_services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:queue_less/services/token_services.dart';
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
  Map<String, dynamic>? user;

  Future<void> getMe() async {
    Map<String, dynamic>? userJson = await getUserJson();
    setState(() {
      user = userJson;
    });
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
        ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: [AppColors.black, AppColors.lightGreen, AppColors.green],
            ).createShader(bounds);
          },
          child: Text(
            AppStrings.logo,
            style: GoogleFonts.dancingScript(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: AppColors.white,
            ),
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
                        style: GoogleFonts.outfit(
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
