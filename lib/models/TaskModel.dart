class Task {
  int id;
  DateTime dueToDay;
  String description;
  String title;
  Task({this.id, this.dueToDay, this.description, this.title});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dueToDay': dueToDay,
      'description': description,
      'title': title
    };
  } 
}