class Todo {
  int? id;
  final String description;
  final String title;
  DateTime createdTime;
  bool isChecked;

  Todo({
    this.id,
    required this.title,
    required this.createdTime,
    required this.isChecked,
    required this.description,
  });

  // to save this data in database we need to convert it to a map

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'title': title,
      'createdTime': createdTime.toString(),
      'isChecked': isChecked ? 1 : 0,
    };
  }
}
