import 'package:recipe_finder/domain/entity/user_entity.dart';
import 'package:recipe_finder/utils/functions.dart';

class User extends UserEntity {
  int idUser;
  String username;
  String name;
  String? profilePicture;
  DateTime birthday;
  String email;

  User({
    required this.idUser,
    required this.username,
    required this.name,
    this.profilePicture,
    required this.email,
    required this.birthday,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": idUser,
      "username": username,
      "name": name,
      "profile_picture": profilePicture,
      "birthday": birthday,
      'email': email,
    };
  }

  @override
  int get id => idUser;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      idUser: json['id'] as int,
      username: json['username'] as String,
      name: json['name'] as String,
      birthday: parseStringToDateTime(json['birthday'] as String),
      profilePicture: json['profile_picture'] as String?,
      email: json["email"] as String,
    );
  }

  @override
  String toString() {
    return "User: $id, $name, $email";
  }
}
