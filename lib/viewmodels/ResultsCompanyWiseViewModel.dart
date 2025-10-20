import '../locator.dart';
import '../models/companyConciseModel.dart';
import '../services/generic/resultService.dart';
import '../shared/GlobalCache.dart';
import 'BaseViewModel.dart';

class ResultsCompanyWiseViewModel extends BaseViewModel {

  ResultService _resultService = locator<ResultService>();
  GlobalCache _cache = locator<GlobalCache>();

  List<CompanyConciseModel>? _companyResults = [];
  List<CompanyConciseModel>? get companyResults => _companyResults;

  late int _yearIndex, _internSwitch, _sortSwitch;
  int get yearIndex => _yearIndex;
  int get internSwitch => _internSwitch;
  int get sortSwitch => _sortSwitch;

  Future<void> setResultFilter(int yrIndex, int internSwitcher, int sortIndex) async {
    _yearIndex = yrIndex;
    _internSwitch = internSwitcher;
    _sortSwitch = sortIndex;
    await _populateResults();
  }

  Future<void> refreshResults() async {
    _cache.companyWiseResults = null;
    await _populateResults();
  }

  Future<void> _populateResults() async {
    setLoading();
    _companyResults = await _resultService.companyWiseResults(_yearIndex, _internSwitch);
    if(_sortSwitch == 1) _companyResults?.sort(
      (a,b) => a.companyName.compareTo(b.companyName)
    );
    setIdle();
  }
}
