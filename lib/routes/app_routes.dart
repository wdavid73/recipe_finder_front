import 'package:flutter/material.dart';
import 'package:front_scaffold_flutter/routes/routes.dart';
import 'package:front_scaffold_flutter/ui/pages/home.dart';

Map<String, Widget Function(BuildContext)> get appRoutes => {
      Routes.home: (_) => const HomePage(),
    };
