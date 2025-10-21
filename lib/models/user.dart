// lib/models/user.dart
abstract class BaseModel {
  Map<String, dynamic> toJson();
}

class User extends BaseModel {
  String _username;
  String _email;

  User({
    required String username,
    required String email,
  })  : _username = username,
        _email = email;

  // Getter & Setter
  String get username => _username;
  set username(String value) => _username = value;

  String get email => _email;
  set email(String value) => _email = value;

  // JSON serialization
  @override
  Map<String, dynamic> toJson() => {
        'username': _username,
        'email': _email,
      };

  // JSON deserialization
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
    );
  }

  @override
  String toString() => 'User(username: $_username, email: $_email)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User && _username == other._username && _email == other._email;

  @override
  int get hashCode => _username.hashCode ^ _email.hashCode;
}
