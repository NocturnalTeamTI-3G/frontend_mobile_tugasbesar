class UserModel {
  final int id;
  final String email;
  final String username;
  final String profileImg;
  final String gender;
  final int roleId;

  UserModel({required this.id, required this.roleId, required this.username, required this.email, required this.gender, required this.profileImg});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      roleId: json['role_id'],
      username: json['username'],
      email: json['email'],
      gender: json['gender'],
      profileImg: json['profile_img'],
    );
  }
}
