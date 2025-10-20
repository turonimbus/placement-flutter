import '../locator.dart';
import '../models/branchConciseModel.dart';
import '../services/generic/resultService.dart';
import '../shared/GlobalCache.dart';
import 'BaseViewModel.dart';

class ResultsBranchWiseViewModel extends BaseViewModel {

  ResultService _resultService = locator<ResultService>();
  GlobalCache _cache = locator<GlobalCache>();

  List<BranchConciseModel>? _branchResults = [];
  List<BranchConciseModel>? get branchResults => _branchResults;

  late int _yearIndex, _internSwitch, _sortSwitch;
  int get yearIndex => _yearIndex;
  int get internSwitch => _internSwitch;
  int get sortSwitch => _sortSwitch;

  Future<void> setResultFilter(int yrIndex, int internSwitcher, int sortSwitch) async {
    _yearIndex = yrIndex;
    _internSwitch = internSwitcher;
    _sortSwitch = sortSwitch;
    await _populateResults();
  }

  Future<void> refreshResults() async {
    _cache.branchWiseResults = null;
    await _populateResults();
  }

  Future<void> _populateResults() async {
    setLoading();
    _branchResults = await _resultService.branchWiseResults(_yearIndex, _internSwitch);
    if(_sortSwitch == 1) {
      _branchResults?.sort(
        (a,b) => a.studentBranchName.compareTo(b.studentBranchName)
      );
    }
    setIdle();
  }
}
