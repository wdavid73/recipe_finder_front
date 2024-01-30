import 'package:recipe_finder/data/models/recipe.dart';
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

class FullUser extends User {
  int totalRecipe;
  int totalRecipeEnable;
  int totalRecipeDisable;
  int totalRecipeHide;
  double averageRating;
  double averageTime;
  List<Recipe> recipeFavorites;

  FullUser({
    required super.idUser,
    required super.username,
    required super.name,
    required super.email,
    required super.birthday,
    super.profilePicture,
    this.totalRecipe = 0,
    this.totalRecipeDisable = 0,
    this.totalRecipeEnable = 0,
    this.totalRecipeHide = 0,
    this.averageRating = 0,
    this.averageTime = 0,
    this.recipeFavorites = const <Recipe>[],
  });

  factory FullUser.fromJson(Map<String, dynamic> json) {
    User user = User.fromJson(json["user"]);
    List<Recipe> recipeFavorites = parseRecipes(json['recipe_favorite']);
    return FullUser(
      idUser: user.id,
      username: user.username,
      name: user.name,
      birthday: user.birthday,
      profilePicture: user.profilePicture,
      email: user.email,
      averageRating: json["average_rating"] as double,
      averageTime: json["average_time"] as double,
      totalRecipe: json["total_recipes"] as int,
      totalRecipeDisable: json["total_recipe_disable"] as int,
      totalRecipeEnable: json["total_recipe_enable"] as int,
      totalRecipeHide: json["total_recipe_hide"] as int,
      recipeFavorites: recipeFavorites,
    );
  }
}
