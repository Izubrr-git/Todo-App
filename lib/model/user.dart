class User {
  final String id;
  final String username;
  final String email;
  final String? avatarUrl;
  final String password;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    this.avatarUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      avatarUrl: json['avatarUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'avatarUrl': avatarUrl,
    };
  }

  User copyWith({
    String? id,
    String? username,
    String? email,
    String? password,
    String? avatarUrl,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  @override
  String toString() {
    return 'User(id: $id, username: $username, email: $email, avatarUrl: $avatarUrl)';
  }
}