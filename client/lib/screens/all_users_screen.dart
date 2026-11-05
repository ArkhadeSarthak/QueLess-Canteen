import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:queue_less/features/custom_input.dart';
import 'package:queue_less/models/user_model.dart';
import 'package:queue_less/services/token_services.dart';
import 'package:queue_less/services/user_services.dart';
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

  // Map<String, dynamic>? user;
  bool isLoading = false;

  // bool _isChief = false;
  bool _isAdministrator = false;

  Future<void> getMe() async {
    Map<String, dynamic>? userJson = await getUserJson();
    setState(() {
      // user = userJson;
      // _isChief = userJson?["role"]?.toString().toLowerCase() == "chief";
      _isAdministrator =
          userJson?["role"]?.toString().toLowerCase() == "administrator";
    });
  }

  final UserServices _userServices = UserServices();
  late Future<List<GetAllUsersModel>> users;

  Future<void> featchUsers() async {
    users = _userServices.featchUsers(context);
  }

  @override
  void initState() {
    super.initState();
    getMe();
    featchUsers();
  }

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
                          CustomInput(
                            controller: _searchController,
                            onChanged: (value) {
                              setState(() {
                                searchText = value;
                              });
                            },
                            prefixIcon: Icons.search,
                            hintText: "Search user's by name",
                            borderRadius: 15,
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
                          FutureBuilder(
                            future: users,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return _buildLoadingView();
                              }

                              if (snapshot.hasError) {
                                return _buildErrorView(
                                  snapshot.error.toString(),
                                );
                              }

                              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                return _buildEmptyView();
                              }

                              final users = snapshot.data!;

                              return _buildUsersList(
                                users,
                                searchText ?? "",
                              );
                            },
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

  Widget _buildLoadingView() {
    return Center(child: CircularProgressIndicator(color: AppColors.deepGreen));
  }

  Widget _buildUsersList(List<GetAllUsersModel> users, String searchText) {
    final filteredItems = users.where((user) {
      return user.name.toLowerCase().contains(searchText.trim().toLowerCase()) && user.role != "";
    }).toList();

    if (filteredItems.isEmpty) {
      return _buildEmptyView();
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        return _buildUser(filteredItems[index], users);
      },
    );
  }

  Widget _buildUser(GetAllUsersModel user, List<GetAllUsersModel> users) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          user.profileImage != null
              ? Image(
                  image: NetworkImage(user.profileImage),
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                )
              : Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryBackground,
                  ),
                  child: Center(
                    child: Text(
                      "No image",
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        color: AppColors.deepGreen,
                      ),
                    ),
                  ),
                ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      user.name,
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.subtitle.withValues(alpha: 0.2),
                      ),
                      child: Text(
                        user.rollNo,
                        style: GoogleFonts.outfit(
                          color: AppColors.darkGreen,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  user.email,
                  style: GoogleFonts.outfit(
                    color: AppColors.darkGreen,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Text(
                        user.course,
                        style: GoogleFonts.outfit(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(width: 10),
                      if (_isAdministrator) ...[
                        IconButton(
                          onPressed: () {},
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.redOrange.withValues(
                              alpha: 0.2,
                            ),
                            foregroundColor: AppColors.redOrange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(10),
                            ),
                            minimumSize: Size(20, 22),
                          ),
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor:
                                      AppColors.secondaryBackground,
                                  title: Text(
                                    "Delete user",
                                    style: GoogleFonts.outfit(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.red,
                                    ),
                                  ),
                                  content: Text(
                                    "Are you sure you want to delete this user?",
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
                                      },
                                      child: const Text(
                                        "Delete",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.red.withValues(
                              alpha: 0.2,
                            ),
                            foregroundColor: AppColors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(10),
                            ),
                            minimumSize: Size(20, 22),
                          ),
                          icon: Icon(Icons.delete_outline),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 50, color: Colors.redAccent),
            const SizedBox(height: 12),
            Text(
              'Error: $error',
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(color: Colors.black, fontSize: 14),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.orange,
                foregroundColor: AppColors.white,
              ),
              onPressed: () {
                featchUsers();
              },
              child: const Text("Retry"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyView() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: Text(
          "No Users Found",
          style: GoogleFonts.outfit(fontSize: 16, color: AppColors.red),
        ),
      ),
    );
  }
}
