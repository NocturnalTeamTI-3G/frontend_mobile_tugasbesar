class UserType {
  final String id;
  final String name;
  final String email;
  final String password;
  final String? imgProfile;

  UserType(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      this.imgProfile});

  factory UserType.fromJson(Map<String, dynamic> json) {
    return UserType(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      imgProfile: json['imgProfile'],
    );
  }
}

class UserData {
  List<UserType> user = [
    UserType(
      id: '1',
      name: 'User 1',
      email: '',
      password: '',
      imgProfile: 'Image 1',
    ),
    UserType(
      id: '2',
      name: 'User 2',
      email: '',
      password: '',
      imgProfile: 'Image 2',
    ),
  ];

  List<UserType> getAllUsers() {
    return user;
  }
}
