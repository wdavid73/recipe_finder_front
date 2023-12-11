import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static late final String baseUrl;
  static late final bool debugMode;

  static void initialize() {
    baseUrl = dotenv.env['BASE_URL'] ?? '';
    debugMode = dotenv.env['DEBUG_MODE'] == 'true';
  }
}
