class PhotoGroup {
  int id;
  String? name;
  DateTime date;
  List<String> photos;

  PhotoGroup({required this.id, this.name, required this.date, required this.photos});
}