import 'package:recipe_finder/i10n/locale/es.dart';
import 'package:recipe_finder/i10n/locale/en.dart';

Map<String, String> getTranslations(String languageCode) {
  switch (languageCode) {
    case 'es':
      return es;
    default:
      return en;
  }
}
