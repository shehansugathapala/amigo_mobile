class User {
  final String id;
  final String name;
  final String email;
  final String token;
  final String password;
  final bool isAdmin;
  final String serial; // Add serial property

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
    required this.password,
    required this.isAdmin,
    required this.serial, // Initialize serial property
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      token: json['token'],
      password: json['password'],
      isAdmin: json['isAdmin'],
      serial: json['serial'], // Parse serial property
    );
  }
}
