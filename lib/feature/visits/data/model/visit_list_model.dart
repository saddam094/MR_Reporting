class VisitListModel {
  final bool valid;
  final String message;
  final List<Assignment> assignments;

  VisitListModel({
    required this.valid,
    required this.message,
    required this.assignments,
  });

  factory VisitListModel.fromJson(Map<String, dynamic> json) {
    return VisitListModel(
      valid: json['valid'] ?? false,
      message: json['message'] ?? '',
      assignments: (json['assignments'] as List<dynamic>?)
          ?.map((e) => Assignment.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'valid': valid,
      'message': message,
      'assignments': assignments.map((e) => e.toJson()).toList(),
    };
  }
}

class Assignment {
  final String assignmentId;
  final String status;
  final String doctorId;
  final String doctorName;
  final String mrId;
  final String startDatetime;
  final String endDatetime;

  Assignment({
    required this.assignmentId,
    required this.status,
    required this.doctorId,
    required this.doctorName,
    required this.mrId,
    required this.startDatetime,
    required this.endDatetime,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      assignmentId: json['assignment_id'] ?? '',
      status: json['status'] ?? '',
      doctorId: json['doctor_id'] ?? '',
      doctorName: json['doctor_name'] ?? '',
      mrId: json['mr_id'] ?? '',
      startDatetime: json['start_datetime'] ?? '',
      endDatetime: json['end_datetime'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'assignment_id': assignmentId,
      'status': status,
      'doctor_id': doctorId,
      'doctor_name': doctorName,
      'mr_id': mrId,
      'start_datetime': startDatetime,
      'end_datetime': endDatetime,
    };
  }
}
