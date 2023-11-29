import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front_scaffold_flutter/app/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}
