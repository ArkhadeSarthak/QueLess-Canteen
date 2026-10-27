import 'dart:async';

import 'package:queue_less/services/auth_services.dart';
import 'package:queue_less/theme/app_colors.dart';
import 'package:queue_less/theme/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modern_animated_loader/flutter_animated_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double progess = 0;
  Timer? timer;
  bool visible = false;

  void startProgress() {
    timer?.cancel();
    timer = Timer.periodic(Duration(milliseconds: 20), (timer) {
      if (progess >= 1) {
        timer.cancel();
        return;
      }
      setState(() {
        progess += 0.01;
        visible = true;
      });
    });
  }

  void _navigateToLogin() {
    Navigator.pushReplacementNamed(context, "/login");
  }

  final AuthServices _authServices = AuthServices();

  Future<void> chechAuth() async {
    Timer(Duration(seconds: 2), () async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("access_token");

      if (token == null || token.isEmpty) {
        if (!mounted) return;
        _navigateToLogin();
        timer?.cancel();
        setState(() {
          progess = 1;
          visible = true;
        });
        return;
      }

      try {
        await _authServices.getCurrentUser();
        if (!mounted) return;

        Navigator.pushReplacementNamed(context, "/home");
      } catch (e) {
        await prefs.remove("access_token");
        if (!mounted) return;
        _navigateToLogin();
      } finally {
        timer?.cancel();
        setState(() {
          progess = 1;
          visible = true;
        });
      }
    });
  }

  @override
  void initState() {
    startProgress();
    chechAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splash_screen_back.png"),
            opacity: 0.9,
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.subtitle.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.circle, color: AppColors.orange, size: 11),
                    SizedBox(width: 10),
                    Text(
                      AppStrings.network,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              AnimatedOpacity(
                opacity: visible ? 1.0 : 0.0,
                duration: Duration(milliseconds: 1000),
                child: Image(
                  image: AssetImage("assets/images/lightning_cloche.png"),
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ),
              AnimatedOpacity(
                opacity: visible ? 1.0 : 0.0,
                duration: Duration(milliseconds: 1000),
                child: ShaderMask(
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      colors: [AppColors.white, AppColors.green],
                    ).createShader(bounds);
                  },
                  child: Text(
                    AppStrings.logo,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.subtitle.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.cabin_outlined,
                      color: AppColors.secondaryText,
                      size: 12,
                    ),
                    SizedBox(width: 10),
                    Text(
                      AppStrings.dining,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.secondaryText,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Text(
                "${AppStrings.skipQueue} \n${AppStrings.hotMeal}",
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.white, fontSize: 17),
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.subtitle.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.qr_code_scanner,
                          color: AppColors.secondaryText,
                          size: 16,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Digital Token",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.subtitle.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          color: AppColors.secondaryText,
                          size: 16,
                        ),
                        SizedBox(width: 5),
                        Text(
                          AppStrings.eta,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(),
              SizedBox(
                width: 200,
                child: LinearProgressIndicator(
                  backgroundColor: AppColors.orange.withValues(alpha: 0.15),
                  minHeight: 5,
                  value: progess,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.acentOrange,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.locating,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 10),
                  FlutterAnimatedLoader.auroraWave(
                    color: AppColors.white,
                    size: 20,
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.verified, color: AppColors.orange, size: 14),
                  SizedBox(width: 5),
                  Text(
                    AppStrings.powerings,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
