import 'package:flutter_modern_animated_loader/flutter_animated_loader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:queue_less/services/auth_services.dart';
import 'package:queue_less/theme/app_colors.dart';
import 'package:queue_less/theme/app_strings.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obsecureText = true;
  bool _isChecked = false;
  bool _isMatched = false;

  void changeObsecure() {
    setState(() {
      _obsecureText = !_obsecureText;
    });
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
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

  bool _isDisabled = true;

  void _checkIsDisabled() {
    if (_formkey.currentState!.validate()) {
      if (_isMatched) {
        setState(() {
          _isDisabled = false;
        });
      } else {
        setState(() {
          _isDisabled = true;
        });
      }
    } else {
      setState(() {
        _isDisabled = true;
      });
    }
  }

  bool _isLoading = false;
  final AuthServices _authServices = AuthServices();
  Future<void> signUp() async {
    setState(() {
      _isLoading = true;
    });
    try {
      _authServices.createUser(
        context: context,
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        rollNo: _idController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } catch (e) {
      throw Exception('Failed to create user : $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryBackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: SafeArea(
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Image(
                    image: AssetImage("assets/images/skip_wait.png"),
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                  Row(
                    children: [
                      Text(
                        "Create your account",
                        style: GoogleFonts.outfit(
                          color: AppColors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text("🎓"),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Join ${AppStrings.logo} to order food ahead and collect with zero wating between lectures.",
                      style: GoogleFonts.outfit(
                        color: AppColors.darkGreen,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Full Name",
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkGreen,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: _nameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (value) => _checkIsDisabled(),
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.darkGreen,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.white,
                      isDense: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.white),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.white),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.white),
                      ),
                      prefixIcon: Icon(
                        Icons.person_2_outlined,
                        color: AppColors.secondaryGreen,
                        size: 18,
                      ),
                      hintText: "Student Name",
                      hintStyle: GoogleFonts.outfit(
                        color: AppColors.darkGreen,
                        fontSize: 12,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter name";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Text(
                        "Student Email Id",
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkGreen,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.verified_outlined,
                        color: AppColors.secondaryGreen,
                        size: 14,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Verified Domain",
                        style: GoogleFonts.outfit(
                          color: AppColors.secondaryGreen,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: _emailController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (value) => _checkIsDisabled(),
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.darkGreen,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.white,
                      isDense: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.white),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.white),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.white),
                      ),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: AppColors.secondaryGreen,
                        size: 18,
                      ),
                      hintText: "student@college.edu",
                      hintStyle: GoogleFonts.outfit(
                        color: AppColors.darkGreen,
                        fontSize: 12,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "please enter email";
                      }
                      if (!value.contains("@") || !value.contains(".")) {
                        return "please enter valid email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "College Roll No / ID",
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkGreen,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: _idController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (value) => _checkIsDisabled(),
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.darkGreen,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.white,
                      isDense: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.white),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.white),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.white),
                      ),
                      prefixIcon: Icon(
                        Icons.medical_information_outlined,
                        color: AppColors.secondaryGreen,
                        size: 18,
                      ),
                      hintText: "student@college.edu",
                      hintStyle: GoogleFonts.outfit(
                        color: AppColors.darkGreen,
                        fontSize: 12,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter roll no / id";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Create Password",
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkGreen,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: _passwordController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: _obsecureText,
                    onChanged: (_) {
                      _checkIsMatched();
                      _checkIsDisabled();
                    },
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.darkGreen,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.white,
                      isDense: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.white),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.white),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.white),
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
                      hintText: "Pass@123",
                      hintStyle: GoogleFonts.outfit(
                        color: AppColors.darkGreen,
                        fontSize: 12,
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
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Confirm Password",
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkGreen,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: _confirmPasswordController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: true,
                    onChanged: (_) {
                      _checkIsMatched();
                      _checkIsDisabled();
                    },
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.darkGreen,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.white,
                      isDense: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.white),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.white),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.white),
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
                      hintText: "Pass@123",
                      hintStyle: GoogleFonts.outfit(
                        color: AppColors.darkGreen,
                        fontSize: 12,
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
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Checkbox(
                        value: _isChecked,
                        onChanged: (value) {
                          setState(() {
                            _isChecked = !_isChecked;
                          });
                        },
                        checkColor: AppColors.white,
                        activeColor: AppColors.darkGreen,
                      ),
                      Text(
                        "I agree to the Campus Dining Terms and \nacknowledge the Privacy Policy.",
                        style: GoogleFonts.outfit(
                          color: AppColors.darkGreen,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  if (!_isLoading)
                    FilledButton(
                      onPressed: _isDisabled
                          ? null
                          : () {
                              if (_formkey.currentState!.validate()) {
                                signUp();
                              }
                            },
                      style: FilledButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: AppColors.lightGreen,
                        foregroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Create ${AppStrings.logo} Account",
                            style: GoogleFonts.outfit(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(Icons.arrow_forward, size: 16),
                        ],
                      ),
                    )
                  else
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: null,
                        style: FilledButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 7),
                          backgroundColor: AppColors.darkGreen,
                          foregroundColor: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8),
                          ),
                        ),
                        child: FlutterAnimatedLoader.horizontalSpin(
                          color: AppColors.darkGreen,
                          size: 35,
                        ),
                      ),
                    ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account",
                        style: GoogleFonts.outfit(
                          color: AppColors.deepGreen,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(width: 5),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Sign In",
                          style: GoogleFonts.outfit(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.deepGreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
