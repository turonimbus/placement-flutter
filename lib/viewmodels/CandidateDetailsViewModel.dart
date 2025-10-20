import 'package:url_launcher/url_launcher_string.dart';

import '../locator.dart';
import '../models/candidateModel.dart';
import '../services/auth/auth_service.dart';
import '../services/generic/applyService.dart';
import 'BaseViewModel.dart';
import '../models/placement_exception.dart';

class CandidateDetailsViewModel extends BaseViewModel {
  ApplyService _applyService = locator<ApplyService>();
  AuthService _auth = AuthService();
  CandidateModel? _candidate;
  CandidateModel? get candidate => _candidate;

  Future<void> fetchCandidate() async {
    setLoading();
    _candidate = await _applyService.getCandidateProfile();
    setIdle();
  }

  Future<void> launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw PlacementException('Could not launch $url');
    }
  }

  Future<void> logout() async {
    await _auth.logOut();
  }
}
