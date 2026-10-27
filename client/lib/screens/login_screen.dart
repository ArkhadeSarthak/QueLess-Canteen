import 'package:queue_less/services/auth_services.dart';
import 'package:queue_less/theme/app_colors.dart';
import 'package:queue_less/theme/app_strings.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obsecureText = true;
  bool _isChecked = false;
  bool _isLoading = false;

  void changeObsecure() {
    setState(() {
      _obsecureText = !_obsecureText;
    });
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final AuthServices _authServices = AuthServices();

  Future<void> login() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      _authServices.loginUser(
        context: context,
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryBackground,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: LayoutBuilder(
          builder: (_, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: SafeArea(
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage("assets/images/skip_wait.png"),
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppStrings.logo,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.black,
                                ),
                              ),
                              SizedBox(width: 10),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 1,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: AppColors.subtitle.withValues(
                                    alpha: 0.2,
                                  ),
                                ),
                                child: Text(
                                  AppStrings.dining,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.darkGreen,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 7,
                              horizontal: 15,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.subtitle.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.cabin_outlined,
                                  color: AppColors.deepGreen,
                                  size: 16,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Student & staff portal",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 1,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: AppColors.subtitle.withValues(
                                      alpha: 0.5,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: AppColors.deepGreen,
                                        size: 11,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "Campus food hall",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.darkGreen,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Text(
                                AppStrings.greeting,
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text("🖐️"),
                            ],
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              "Sign in to order your favorites and skip canteen lines.",
                              style: TextStyle(
                                color: AppColors.darkGreen,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "College / Student Email",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.darkGreen,
                                ),
                              ),
                              Text(
                                "e.g.. edu / campus id",
                                style: TextStyle(
                                  color: AppColors.secondaryGreen,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          TextFormField(
                            controller: _emailController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: TextStyle(
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
                              hintStyle: TextStyle(
                                color: AppColors.darkGreen,
                                fontSize: 12,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter email";
                              }
                              if (!value.contains("@") ||
                                  !value.contains(".")) {
                                return "Enter valid email";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              "Password",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.darkGreen,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          TextFormField(
                            controller: _passwordController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            obscureText: _obsecureText,
                            style: TextStyle(
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
                                  _obsecureText
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: AppColors.secondaryGreen,
                                  size: 18,
                                ),
                              ),
                              hintText: "-------",
                              hintStyle: TextStyle(
                                color: AppColors.darkGreen,
                                fontSize: 12,
                                letterSpacing: 3,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter Password";
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
                                "Remember me",
                                style: TextStyle(
                                  color: AppColors.darkGreen,
                                  fontSize: 12,
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {},
                                child: Text(
                                  "Forgot password?",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.darkGreen,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          if (!_isLoading)
                            FilledButton(
                              onPressed: () {
                                login();
                              },
                              style: FilledButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                backgroundColor: AppColors.darkGreen,
                                foregroundColor: AppColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    8,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Login to ${AppStrings.logo}",
                                    style: TextStyle(
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
                            Container(
                              padding: EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                color: AppColors.badgeBack,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    color: AppColors.white,
                                    strokeAlign: 0.1,
                                    padding: EdgeInsets.zero,
                                  ),
                                ],
                              ),
                            ),
                          SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  color: AppColors.deepGreen,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(width: 5),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, "/signup");
                                },
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.deepGreen,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shield_outlined,
                                color: AppColors.darkGreen,
                                size: 14,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Official Dining Partner",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.deepGreen,
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
          },
        ),
      ),
    );
  }
}
