import 'package:recipe_finder/i10n/locale/en/en.dart';
import 'package:recipe_finder/i10n/locale/es/es.dart';

Map<String, String> getTranslations(String languageCode) {
  switch (languageCode) {
    case 'es':
      return es;
    default:
      return en;
  }
}
