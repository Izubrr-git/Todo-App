class ToDo {
  String? id;
  String? taskText;
  bool isDone;

  ToDo({
    this.id,
    required this.taskText,
    this.isDone = false,
  });

  // Метод для создания объекта task из JSON
  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
      id: json['id'],
      taskText: json['taskText'],
      isDone: json['isDone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'taskText': taskText,
      'isDone': isDone,
    };
  }

  static List<ToDo> todoList() {
    return [
      ToDo(id: '1', taskText: 'Morning Exercise', isDone: true),
      ToDo(id: '2', taskText: 'Buy Groceries', isDone: true),
      ToDo(id: '3', taskText: 'Check Emails', isDone: true),
      ToDo(id: '4', taskText: 'Work on Mobile App'),
      ToDo(id: '5', taskText: 'Dinner with Family'),
      ToDo(id: '6', taskText: 'Team Meeting', ),
    ];
  }
}