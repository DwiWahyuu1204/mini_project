class TodoLokal {
  final String id;
  final String title;
  final String description;
  final DateTime deadline;

  TodoLokal({
    required this.id,
    required this.title,
    required this.description,
    required this.deadline,
  });

  factory TodoLokal.fromJson(Map<String, dynamic> json) {
    return TodoLokal(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      deadline: DateTime.parse(json['deadline']),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'deadline': deadline.toString(),
    };
  }
}
