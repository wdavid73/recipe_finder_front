DateTime parseStringToDateTime(String date) {
  List<String> dateParts = date.split('-');

  int year = int.parse(dateParts[0]);
  int month = int.parse(dateParts[1]);
  int day = int.parse(dateParts[2]);

  DateTime dateParsed = DateTime(year, month, day);

  return dateParsed;
}
