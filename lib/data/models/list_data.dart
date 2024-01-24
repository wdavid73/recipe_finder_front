class ListData {
  final int total;
  final List<dynamic> data;

  ListData({required this.total, required this.data});

  factory ListData.fromJson(
      Map<String, dynamic> json, List<dynamic> dataParsed) {
    return ListData(total: json['total'] as int, data: dataParsed);
  }

  @override
  String toString() {
    return "ListData: {\ntotal: $total,\ndata: $data\n}";
  }
}
