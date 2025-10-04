class CompantWiseStudentModel {
  final String? studentEnrolmentNumber;
  final String studentName;
  final String studentBranchName;
  final String? studentDegree;
  final String? studentContactNo;
  final String? studentEmail;
  final String hasAccepted;

  CompantWiseStudentModel({
    this.studentEnrolmentNumber,
    required this.studentName,
    required this.studentBranchName,
    required this.studentDegree,
    this.studentContactNo,
    this.studentEmail,
    required this.hasAccepted
  });

  factory CompantWiseStudentModel.fromJson(Map<String, dynamic> _json) {
    return CompantWiseStudentModel(
      studentEnrolmentNumber: _json['studentEnrolmentNumber'] ?? '',
      studentName: _json['studentName'] ?? '',
      studentBranchName: _json['studentBranchName'] ?? '',
      studentDegree: _json['studentDegree'] ?? '',
      studentContactNo: _json['studentContactNo'] ?? '',
      studentEmail: _json['studentEmail'] ?? '',
      hasAccepted: _json['hasAccepted'] ?? ''
    );
  }
}