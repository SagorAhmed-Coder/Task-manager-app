class TaskModel {
  final String id;
  final String tile;
  final String description;
  final String status;
  final String email;
  final String createdDate;

  TaskModel({
    required this.id,
    required this.tile,
    required this.description,
    required this.status,
    required this.email,
    required this.createdDate,
  });

  factory TaskModel.formJson(Map<String, dynamic> jsonData) {
    return TaskModel(
      id: jsonData['_id'],
      tile: jsonData['title'],
      description: jsonData['description'],
      status: jsonData['status'],
      email: jsonData['email'],
      createdDate: jsonData['createdDate'],
    );
  }
}

// {
// "_id": "69281351880cc5d30a300c2b",
// "title": "gfgrawr",
// "description": "wertrt",
// "status": "New",
// "email": "sagorr@gmail.com",
// "createdDate": "2025-10-02T06:21:45.327Z"
// },
