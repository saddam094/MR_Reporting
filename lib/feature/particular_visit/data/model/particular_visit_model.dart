class ParticularVisitModel {
  final String id;
  final String doctor;
  final DateTime startTime;
  final DateTime endTime;
  final String status;
  final String notes;
  final VisitTimestamps timestamps;

  ParticularVisitModel({
    required this.id,
    required this.doctor,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.notes,
    required this.timestamps,
  });

  factory ParticularVisitModel.fromJson(Map<String, dynamic> json) {
    return ParticularVisitModel(
      id: json['id'] ?? '',
      doctor: json['doctor'] ?? '',
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      status: json['status'] ?? '',
      notes: json['notes'] ?? '',
      timestamps: VisitTimestamps.fromJson(json['timestamps'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctor': doctor,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'status': status,
      'notes': notes,
      'timestamps': timestamps.toJson(),
    };
  }
}

class VisitTimestamps {
  final DateTime? assigned;
  final DateTime? started;
  final DateTime? reached;
  final DateTime? completed;

  VisitTimestamps({
    this.assigned,
    this.started,
    this.reached,
    this.completed,
  });

  factory VisitTimestamps.fromJson(Map<String, dynamic> json) {
    return VisitTimestamps(
      assigned: json['assigned'] != null ? DateTime.parse(json['assigned']) : null,
      started: json['started'] != null ? DateTime.parse(json['started']) : null,
      reached: json['reached'] != null ? DateTime.parse(json['reached']) : null,
      completed: json['completed'] != null ? DateTime.parse(json['completed']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'assigned': assigned?.toIso8601String(),
      'started': started?.toIso8601String(),
      'reached': reached?.toIso8601String(),
      'completed': completed?.toIso8601String(),
    };
  }
}
