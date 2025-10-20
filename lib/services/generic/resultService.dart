
import '../../locator.dart';
import '../../models/branchConciseModel.dart';
import '../../models/companyConciseModel.dart';
import '../../resources/endpoints.dart';
import '../../shared/GlobalCache.dart';
import 'requestService.dart';

class ResultService {

  final RequestService _requestService = locator<RequestService>();
  final GlobalCache _cache = locator<GlobalCache>();

  Future<List<CompanyConciseModel>?> companyWiseResults(int yearIndex, int internSwitch) async {
    if(_cache.companyWiseResults != null) {
      return _cache.companyWiseResults;
    }
    List<CompanyConciseModel> _companyResults = [];
    var _data = await _requestService.makeGetRequest(
      EndPoints.RESULTS_HOST + EndPoints.year(yearIndex) + EndPoints.RESULTS_COMPANY[internSwitch] + EndPoints.WITH_INDEX
    );
    if(_data == -2) return null;
    if(_data != -1 && _data != -2) {
      for (var r in _data) {
        _companyResults.add(CompanyConciseModel.fromJson(r));
      }
      if(_companyResults.length >= 0) {
        _cache.companyWiseResults = _companyResults;
      }
    }
    return _companyResults;
  }

  Future<List<BranchConciseModel>?> branchWiseResults(int yearIndex, int internSwitch) async {
    if(_cache.branchWiseResults != null) {
      return _cache.branchWiseResults;    
    }
    List<BranchConciseModel> _branchResults = [];
    var _data = await _requestService.makeGetRequest(
      EndPoints.RESULTS_HOST + EndPoints.year(yearIndex) + EndPoints.RESULTS_BRANCH[internSwitch] + EndPoints.WITH_INDEX
    );
    if(_data == -2) return null;
    if(_data != -1 && _data != -2) {
      for (var r in _data) {
        _branchResults.add(BranchConciseModel.fromJson(r));
      }
      if(_branchResults.length >= 0) _cache.branchWiseResults = _branchResults;
    }
    return _branchResults;
  }
}
