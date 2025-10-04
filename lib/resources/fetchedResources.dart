class FetchedResources {
  FetchedResources._internal();

  static final _instance = FetchedResources._internal();
  factory FetchedResources() => _instance;

  final Map<String, dynamic> _resultsBranchWise = {
    'initialised': false,
    'data': null
  };
  Map<String, dynamic> get resultsBranchWise => _resultsBranchWise;

  final Map<String, dynamic> _resultsCompanyWise = {
    'initialised': false,
    'data': null
  };
  Map<String, dynamic> get resultsCompanyWise => _resultsCompanyWise;

  final Map<String, dynamic> _applyForAll = {
    'initialised': false,
    'data': null
  };
  Map<String, dynamic> get applyForAll => _applyForAll;

  final Map<String, dynamic> _applyForMe = {
    'initialised': false,
    'data': null
  };
  Map<String, dynamic> get applyForMe => _applyForMe;



  final Map<String, dynamic> _candidateProfile = {
    'initialised': false,
    'data': null
  };
  Map<String, dynamic> get candidateProfile => _candidateProfile;

  void setResultsBranchWise(dynamic results) {
    _resultsBranchWise['initialised'] = true;
    _resultsBranchWise['data'] = results;
  }

  void setResultsCompanyWise(dynamic results) {
    _resultsCompanyWise['initialised'] = true;
    _resultsCompanyWise['data'] = results;
  }

  void setApplyForMe(dynamic results) {
    _applyForMe['initialised'] = true;
    _applyForMe['data'] = results;
  }

  void setApplyForAll(dynamic results) {
    _applyForAll['initialised'] = true;
    _applyForAll['data'] = results;
  }

  void setCandidateProfile(dynamic results) {
    _candidateProfile['initialised'] = true;
    _candidateProfile['data'] = results;
  }
}