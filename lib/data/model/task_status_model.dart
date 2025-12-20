class TaskStatusModel {
  final String id;
  final int sum;

  TaskStatusModel({required this.id, required this.sum});

  factory TaskStatusModel.fromJson(Map<String, dynamic> TaskStatusData) {
    return TaskStatusModel(
      id: TaskStatusData['_id'],
      sum: TaskStatusData['sum'],
    );
  }
}
