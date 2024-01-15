class Validations {
  static const _emailRegex =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  static String? isNotEmpty(String? value, {String? message}) =>
      value != null && value.isNotEmpty ? null : message ?? 'Is Empty';

  static String? isRequired(value, {String? message}) =>
      value != null ? null : message ?? 'Is required';

  static String? isEmail(String? email, {String? message}) =>
      email != null && RegExp(_emailRegex).hasMatch(email)
          ? null
          : message ?? 'No email format';
  static String? isNotEmptyDate(dynamic value, {String? message}) =>
      value != null && value.isNotEmpty ? null : message ?? 'Is Empty';

  static String? isNotEmptyList(List<dynamic> list, {String? message}) =>
      list.isNotEmpty ? null : message ?? 'Is Empty';

  static String? isEqual(String value, String compare, {String? message}) =>
      value == compare ? null : message ?? 'Values are not equal';
}

T? pipeFirstNotNullOrNull<T, U>(U input, List<Function(U)> functions) {
  T? result;

  for (final func in functions) {
    result = func(input);
    if (result != null) {
      break;
    }
  }

  return result;
}
