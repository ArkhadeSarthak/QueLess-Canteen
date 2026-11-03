class GetAllUsersModel {
  final String id;
  final String name;
  final String rollNo;
  final String role;
  final String email;
  final dynamic profileImage;
  final String university;
  final String course;

  GetAllUsersModel({
    required this.id,
    required this.name,
    required this.rollNo,
    required this.role,
    required this.email,
    required this.profileImage,
    required this.university,
    required this.course,
  });

  factory GetAllUsersModel.fromJson(Map<String, dynamic> json) =>
      GetAllUsersModel(
        id: json["id"],
        name: json["name"],
        rollNo: json["roll_no"],
        role: json["role"],
        email: json["email"],
        profileImage: json["profile_image"],
        university: json["university"],
        course: json["course"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "roll_no": rollNo,
    "role": role,
    "email": email,
    "profile_image": profileImage,
    "university": university,
    "course": course,
  };
}
