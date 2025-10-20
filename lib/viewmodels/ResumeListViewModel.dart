import 'package:url_launcher/url_launcher_string.dart';

import '../locator.dart';
import '../models/placement_exception.dart';
import '../models/resumeModel.dart';
import '../services/generic/applyService.dart';
import 'BaseViewModel.dart';

class ResumeListViewModel extends BaseViewModel {
  List<ResumeModel>? _resumes = [];
  ApplyService _applyService = locator<ApplyService>();

  List<ResumeModel>? get resumes => _resumes;
  bool get isEmpty => (!isBusy) && (_resumes?.length == 0);

  Future<void> getResumes() async {
    setLoading();
    _resumes = await _applyService.fetchResumes();
    setIdle();
  }

  Future<void> launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw PlacementException('Could not launch "$url"');
    }
  }
}
