import 'package:recipe_finder/domain/entity/user_entity.dart';
import 'package:recipe_finder/utils/functions.dart';

class User extends UserEntity {
  int idUser;
  String username;
  String name;
  String? profilePicture;
  DateTime birthday;

  User({
    required this.idUser,
    required this.username,
    required this.name,
    this.profilePicture,
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
    );
  }
}
