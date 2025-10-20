import 'package:jiffy/jiffy.dart';

import '../locator.dart';
import '../models/profilesModel.dart';
import '../resources/modelResources.dart';
import '../services/generic/applyService.dart';
import 'BaseViewModel.dart';

class ProfilesAppliedViewModel extends BaseViewModel {

  ApplyService _applyService = locator<ApplyService>();
  List<ProfilesModel>? _profiles = [];
  List<ProfilesModel>? get profiles => _profiles;

  bool get isEmpty => (!isBusy)&&(_profiles?.length==0);

  String formatDate(String it) {
    if(it == "") return "-";
    return Jiffy.parse(it).toLocal().yMMMd + " - " + Jiffy.parse(it).toLocal().Hm;
  }

  String profileStatus(int index) {
    final profiles = _profiles;
    if (profiles == null) {
      return "-";
    };
    if(profiles[index].status == "locked") return profiles[index].application.statusDisplayName ?? '-';
    else if(profiles[index].status == "open" && profiles[index].applicationDeadline !=null) {
      String date = "Apply before " + formatDate(profiles[index].applicationDeadline!);
      return date;
    } else if (profiles[index].status == "withdrawable") {
      final title = profiles[index].application?.resume?.title ?? "";
      return title.isNotEmpty ? "$title Sent" : "Application Sent";
    }
    return ModelResources.analyseProfileStatus(profiles[index].status);
  }

  Future<void> fetchProfilesApplied() async {
    setLoading();
    _profiles = await _applyService.fetchProfileApplied();
    setIdle();
  }
}