import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:queue_less/theme/app_colors.dart';

class AllUsersScreen extends StatefulWidget {
  const AllUsersScreen({super.key});

  @override
  State<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? searchText;
  String _selectedStatus = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryBackground,
      body: SafeArea(
        child: Stack(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.arrow_back_ios),
                              ),
                              Text(
                                "Campus Directory",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              FilledButton(
                                onPressed: () {},
                                style: FilledButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 1,
                                    horizontal: 10,
                                  ),
                                  backgroundColor: AppColors.lightGreen,
                                  foregroundColor: AppColors.white,
                                  minimumSize: Size(0, 35),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.person_add_alt, size: 18),
                                    SizedBox(width: 5),
                                    Text(
                                      "Add User",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            style: GoogleFonts.outfit(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.darkGreen,
                            ),
                            controller: _searchController,
                            onChanged: (value) {
                              setState(() {
                                searchText = value;
                              });
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.white.withValues(alpha: 0.5),
                              prefixIcon: Icon(
                                Icons.search,
                                color: AppColors.darkGreen,
                              ),
                              hintText: "Search user name",
                              hintStyle: GoogleFonts.outfit(
                                color: AppColors.darkGreen,
                                fontSize: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: AppColors.white),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: AppColors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: AppColors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: AppColors.white),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: AppColors.white),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                FilledButton(
                                  onPressed: () {
                                    setState(() {
                                      _selectedStatus = "All";
                                    });
                                  },
                                  style: FilledButton.styleFrom(
                                    backgroundColor: _selectedStatus == "All"
                                        ? AppColors.lightGreen
                                        : AppColors.white.withValues(
                                            alpha: 0.8,
                                          ),
                                    foregroundColor: _selectedStatus == "All"
                                        ? AppColors.white
                                        : AppColors.darkGreen,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        "All",
                                        style: GoogleFonts.outfit(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 1,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.subtitle.withValues(
                                            alpha: 0.2,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Text("2,845"),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                FilledButton(
                                  onPressed: () {
                                    setState(() {
                                      _selectedStatus = "Student";
                                    });
                                  },
                                  style: FilledButton.styleFrom(
                                    backgroundColor:
                                        _selectedStatus == "Student"
                                        ? AppColors.lightGreen
                                        : AppColors.white.withValues(
                                            alpha: 0.8,
                                          ),
                                    foregroundColor:
                                        _selectedStatus == "Student"
                                        ? AppColors.white
                                        : AppColors.darkGreen,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Students",
                                        style: GoogleFonts.outfit(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 1,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.subtitle.withValues(
                                            alpha: 0.2,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Text("2,410"),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                FilledButton(
                                  onPressed: () {
                                    setState(() {
                                      _selectedStatus = "Staff";
                                    });
                                  },
                                  style: FilledButton.styleFrom(
                                    backgroundColor: _selectedStatus == "Staff"
                                        ? AppColors.lightGreen
                                        : AppColors.white.withValues(
                                            alpha: 0.8,
                                          ),
                                    foregroundColor: _selectedStatus == "Staff"
                                        ? AppColors.white
                                        : AppColors.darkGreen,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Faculty & Staff",
                                        style: GoogleFonts.outfit(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 1,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.subtitle.withValues(
                                            alpha: 0.2,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Text("320"),
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
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
