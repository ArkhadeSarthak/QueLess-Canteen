import 'package:google_fonts/google_fonts.dart';
import 'package:queue_less/services/token_services.dart';
import 'package:queue_less/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_modern_animated_loader/flutter_animated_loader.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("access_token");
    await prefs.remove("current_user");
    Navigator.pushReplacementNamed(context, "/login");
  }

  Map<String, dynamic>? user;

  Future<void> getMe() async {
    Map<String, dynamic>? userJson = await getUserJson();
    setState(() {
      user = userJson;
    });
  }

  bool isEditing = false;
  bool isUploading = false;
  bool _obsecureText = true;
  bool _obsecureTextNew = true;
  bool _isMatched = false;
  bool _isPasswordChanging = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rollNoController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formkey = GlobalKey<FormState>();

  void _checkIsMatched() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      setState(() {
        _isMatched = true;
      });
    } else {
      setState(() {
        _isMatched = false;
      });
    }
  }

  void changeObsecure() {
    setState(() {
      _obsecureText = !_obsecureText;
    });
  }

  void startEditing() {
    setState(() {
      isEditing = true;
      _nameController.text = user?["name"];
      _rollNoController.text = user?["roll_no"];
    });
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
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                              user?["name"].substring(0, 1) ??
                                                  "",
                                              style: GoogleFonts.outfit(
                                                color: AppColors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30,
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
                                          style: GoogleFonts.outfit(
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
                                      style: GoogleFonts.outfit(
                                        color: AppColors.darkGreen,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      user?["university"] ??
                                          "University xyz Active",
                                      style: GoogleFonts.outfit(
                                        color: AppColors.darkGreen,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 5),
                                if (!isEditing)
                                  IconButton(
                                    onPressed: () {
                                      startEditing();
                                    },
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
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
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
                                        "${user?["roll_no"] ?? "xyzabxxx"}",
                                        style: GoogleFonts.outfit(
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
                                        user?["course"] ?? "Course Name",
                                        style: GoogleFonts.outfit(
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
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    if (isEditing)
                      Form(
                        key: _formkey,
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.white.withValues(alpha: 0.7),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Name *",
                                style: GoogleFonts.outfit(
                                  color: AppColors.black.withValues(alpha: 0.8),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 5),
                              TextFormField(
                                controller: _nameController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                style: GoogleFonts.outfit(
                                  color: AppColors.black,
                                  fontSize: 16,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.secondaryBackground,
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.secondaryBackground,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.secondaryBackground,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.secondaryBackground,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.secondaryBackground,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.secondaryBackground,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.secondaryBackground,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  hintText: "User Name",
                                  hintStyle: GoogleFonts.outfit(
                                    color: AppColors.badgeBack,
                                    fontSize: 16,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Please enter your name";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 15),
                              Text(
                                "Roll No *",
                                style: GoogleFonts.outfit(
                                  color: AppColors.black.withValues(alpha: 0.8),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 5),
                              TextFormField(
                                controller: _rollNoController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                style: GoogleFonts.outfit(
                                  color: AppColors.black,
                                  fontSize: 16,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.secondaryBackground,
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.secondaryBackground,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.secondaryBackground,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.secondaryBackground,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.secondaryBackground,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.secondaryBackground,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.secondaryBackground,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  hintText: "Your roll no",
                                  hintStyle: GoogleFonts.outfit(
                                    color: AppColors.badgeBack,
                                    fontSize: 16,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Please enter your roll no";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 5),
                              if (!_isPasswordChanging)
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _isPasswordChanging = true;
                                    });
                                  },
                                  child: Text(
                                    "Want to change password?",
                                    style: GoogleFonts.outfit(
                                      color: AppColors.red.withValues(
                                        alpha: 0.8,
                                      ),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              if (_isPasswordChanging)
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _isPasswordChanging = false;
                                    });
                                  },
                                  child: Text(
                                    "Don't want to change password?",
                                    style: GoogleFonts.outfit(
                                      color: AppColors.darkGreen.withValues(
                                        alpha: 0.8,
                                      ),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              if (_isPasswordChanging) ...[
                                SizedBox(height: 15),
                                Text(
                                  "Old Password *",
                                  style: GoogleFonts.outfit(
                                    color: AppColors.black.withValues(
                                      alpha: 0.8,
                                    ),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 5),
                                TextFormField(
                                  controller: _oldPasswordController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  obscureText: _obsecureText,
                                  style: GoogleFonts.outfit(
                                    color: AppColors.black,
                                    fontSize: 16,
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: AppColors.secondaryBackground,
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.secondaryBackground,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.secondaryBackground,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.secondaryBackground,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.secondaryBackground,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.secondaryBackground,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.secondaryBackground,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.lock_outline,
                                      color: AppColors.secondaryGreen,
                                      size: 18,
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        changeObsecure();
                                      },
                                      icon: Icon(
                                        Icons.visibility_outlined,
                                        color: AppColors.secondaryGreen,
                                        size: 18,
                                      ),
                                    ),
                                    hintText: "xyz@123",
                                    hintStyle: GoogleFonts.outfit(
                                      color: AppColors.badgeBack,
                                      fontSize: 16,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "Please enter password";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 15),
                                Text(
                                  "New Password *",
                                  style: GoogleFonts.outfit(
                                    color: AppColors.black.withValues(
                                      alpha: 0.8,
                                    ),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 5),
                                TextFormField(
                                  controller: _passwordController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  obscureText: _obsecureTextNew,
                                  onChanged: (_) {
                                    _checkIsMatched();
                                  },
                                  style: GoogleFonts.outfit(
                                    color: AppColors.black,
                                    fontSize: 16,
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: AppColors.secondaryBackground,
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.secondaryBackground,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.secondaryBackground,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.secondaryBackground,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.secondaryBackground,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.secondaryBackground,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.secondaryBackground,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.lock_outline,
                                      color: AppColors.secondaryGreen,
                                      size: 18,
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _obsecureTextNew = !_obsecureTextNew;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.visibility_outlined,
                                        color: AppColors.secondaryGreen,
                                        size: 18,
                                      ),
                                    ),
                                    hintText: "xyz@123",
                                    hintStyle: GoogleFonts.outfit(
                                      color: AppColors.badgeBack,
                                      fontSize: 16,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "Please enter password";
                                    }
                                    if (value == value.toLowerCase()) {
                                      return "Please add one capital letter";
                                    }
                                    if (value == value.toUpperCase()) {
                                      return "Please add one small letter";
                                    }
                                    if (value.length < 6) {
                                      return "Password must be atleast 6 char long";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 15),
                                Text(
                                  "Confirm Password *",
                                  style: GoogleFonts.outfit(
                                    color: AppColors.black.withValues(
                                      alpha: 0.8,
                                    ),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 5),
                                TextFormField(
                                  controller: _confirmPasswordController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  obscureText: true,
                                  onChanged: (_) {
                                    _checkIsMatched();
                                  },
                                  style: GoogleFonts.outfit(
                                    color: AppColors.black,
                                    fontSize: 16,
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: AppColors.secondaryBackground,
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.secondaryBackground,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.secondaryBackground,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.secondaryBackground,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.secondaryBackground,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.secondaryBackground,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.secondaryBackground,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.check_box_outlined,
                                      color: AppColors.secondaryGreen,
                                      size: 18,
                                    ),
                                    suffixIcon: Icon(
                                      _isMatched ? Icons.check_circle : null,
                                      color: AppColors.secondaryGreen,
                                      size: 18,
                                    ),
                                    hintText: "xyz@123",
                                    hintStyle: GoogleFonts.outfit(
                                      color: AppColors.badgeBack,
                                      fontSize: 16,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "Please enter password";
                                    }
                                    return null;
                                  },
                                ),
                              ],
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  FilledButton(
                                    onPressed: () {
                                      setState(() {
                                        isEditing = false;
                                        _isPasswordChanging = false;
                                      });
                                    },
                                    style: FilledButton.styleFrom(
                                      backgroundColor: AppColors.badgeBack
                                          .withValues(alpha: 0.2),
                                      foregroundColor: AppColors.red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadiusGeometry.circular(10),
                                      ),
                                    ),
                                    child: Text(
                                      "Cancel",
                                      style: GoogleFonts.outfit(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: isUploading
                                        ? FilledButton(
                                            onPressed: null,
                                            style: FilledButton.styleFrom(
                                              backgroundColor:
                                                  AppColors.lightGreen,
                                              foregroundColor: AppColors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadiusGeometry.circular(
                                                      10,
                                                    ),
                                              ),
                                            ),
                                            child:
                                                FlutterAnimatedLoader.horizontalSpin(
                                                  color: AppColors.darkGreen,
                                                  size: 35,
                                                ),
                                          )
                                        : FilledButton(
                                            onPressed: () async {},
                                            style: FilledButton.styleFrom(
                                              backgroundColor:
                                                  AppColors.lightGreen,
                                              foregroundColor: AppColors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadiusGeometry.circular(
                                                      10,
                                                    ),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Save profile",
                                                  style: GoogleFonts.outfit(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Icon(
                                                  Icons.arrow_forward,
                                                  size: 18,
                                                ),
                                              ],
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(height: 15),
                    Text(
                      "APP & SUPPORT",
                      style: GoogleFonts.outfit(
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
                                      style: GoogleFonts.outfit(
                                        fontSize: 18,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "Haptic chime when token is called",
                                      style: GoogleFonts.outfit(
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
                                      style: GoogleFonts.outfit(
                                        fontSize: 18,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "FAQs, refund queries & chef notes",
                                      style: GoogleFonts.outfit(
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
                                      style: GoogleFonts.outfit(
                                        fontSize: 18,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "v2.4.0",
                                      style: GoogleFonts.outfit(
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
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: AppColors.secondaryBackground,
                              title: Text(
                                "Logout",
                                style: GoogleFonts.outfit(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.red,
                                ),
                              ),
                              content: Text(
                                "Are you sure you want to logout?",
                                style: GoogleFonts.outfit(
                                  color: AppColors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    logOut();
                                  },
                                  child: const Text(
                                    "Logout",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
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
                            style: GoogleFonts.outfit(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage("assets/images/favicon.png"),
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ],
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
                            style: GoogleFonts.outfit(
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
                            style: GoogleFonts.outfit(
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
                          style: GoogleFonts.outfit(
                            color: AppColors.darkGreen,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(Icons.circle, size: 5, color: AppColors.darkGreen),
                        SizedBox(width: 5),
                        Text(
                          "Campus Card Network",
                          style: GoogleFonts.outfit(
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
          ],
        ),
      ),
    );
  }
}
