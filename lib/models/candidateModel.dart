import 'BranchRequirementModel.dart';

class CandidateModel {
  int? candidateId;
  String? candidateName;
  int? departmentId;
  String? departmentCode;
  int? degreeId;
  String? degreeName;
  String? displayPicture;
  String? season;
  int? creditsPoolA;
  int? creditsPoolB;
  String? departmentName;
  int? currentYear;
  String? internshipStatus;
  BranchRequirementModel? branch;

  CandidateModel({
    this.candidateId,
    this.candidateName,
    this.departmentId,
    this.departmentCode,
    this.degreeId,
    this.degreeName,
    this.departmentName,
    this.currentYear,
    this.internshipStatus,
    this.branch,
    this.season,
    this.creditsPoolA,
    this.creditsPoolB,
    this.displayPicture
  });

  factory CandidateModel.fromJson(Map<String, dynamic> json) {
    return CandidateModel(
      candidateId: json['id'],
      candidateName: json['student']['person']['fullName'] ?? "-",
      departmentId: json['student']['branch']['department']['id'],
      departmentCode: json['student']['branch']['department']['code'],
      degreeId: json['student']['branch']['degree']['id'],
      degreeName: json['student']['branch']['degree']['name'] ?? "-",
      departmentName: json['student']['branch']['department']['name'] ?? "-",
      currentYear: json['student']['currentYear'] ?? "-",
      internshipStatus: json['status'] ?? "Closed",
      season: json['season'] ?? "Not Eligible",
      creditsPoolA: json['creditsPoolA'] ?? 100,
      creditsPoolB: json['creditsPoolB'] ?? 0,
      branch: BranchRequirementModel.fromJson(json['student']['branch'])
    );
  }
}