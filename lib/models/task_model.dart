class TaskModel {
  final String id;
  final String taskId;
  final String task;
  final String? note;
  final String taskStatus;
  final String? taskPriority;
  final DateTime taskDueDate;
  final TaskAssignedTo taskAssignedTo;
  final String? taskAssignedBy;
  final String? addedFor;
  final String? addedForId;
  final String? tradename;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? version;

  TaskModel({
    required this.id,
    required this.taskId,
    required this.task,
    this.note,
    required this.taskStatus,
    this.taskPriority,
    required this.taskDueDate,
    required this.taskAssignedTo,
    this.taskAssignedBy,
    this.addedFor,
    this.addedForId,
    this.tradename,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['_id'],
      taskId: json['taskId'],
      task: json['task'],
      note: json['note'],
      taskStatus: json['taskStatus'],
      taskPriority: json['taskPriority'],
      taskDueDate: DateTime.parse(json['taskDueDate']),
      taskAssignedTo: TaskAssignedTo.fromJson(json['taskAssignedTo']),
      taskAssignedBy: json['taskAssignedBy'],
      addedFor: json['addedFor'],
      addedForId: json['addedForId'],
      tradename: json['tradename'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      version: json['__v'],
    );
  }
}

class TaskAssignedTo {
  final String id;
  final String name;
  final String mobileNumber;
  final String email;

  TaskAssignedTo({
    required this.id,
    required this.name,
    required this.mobileNumber,
    required this.email,
  });

  factory TaskAssignedTo.fromJson(Map<String, dynamic> json) {
    return TaskAssignedTo(
      id: json['_id'],
      name: json['name'],
      mobileNumber: json['mobileNumber'],
      email: json['email'],
    );
  }
}
