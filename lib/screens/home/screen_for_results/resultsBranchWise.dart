import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/branchConciseModel.dart';
import '../../../resources/endpoints.dart';
import '../../../resources/fetchedResources.dart';
import '../../../services/api_models/fetchService.dart';
import '../../../shared/dataProvider.dart';
import '../../../shared/loadingPage.dart';

class ResultsBranchWise extends StatefulWidget {
  final int? yearSelectionVariable;
  const ResultsBranchWise({
    super.key, this.yearSelectionVariable,
  });

  @override
  _ResultsBranchWiseState createState() => _ResultsBranchWiseState();
}

class _ResultsBranchWiseState extends State<ResultsBranchWise> {
  var _fetch;
  var _fetchedResources;
  List<BranchConciseModel> _results = [];

  @override
  void initState() {
    super.initState();
    _fetch = FetchService();
    _fetchedResources = FetchedResources();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, data, child) {
        return Container(child: _resultDisplay(context, data.yearSelector));
      },
    );
  }

  Widget _resultDisplay(BuildContext context, int yearSelector) {
    return FutureBuilder(
      future: _futureOfResults(context, yearSelector),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return LoadingPage();
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          padding: EdgeInsets.all(0),
          itemBuilder: (context, index) {
            return Card(
              elevation: 0.2,
              margin: EdgeInsets.only(bottom: 1, top: 0),
              child: ListTile(
                title: Text(
                  snapshot.data![index].studentBranchName!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "Degree: " + snapshot.data![index].studentDegree!,
                  style: TextStyle(height: 1.85),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('/result_details_branchwise',
                      arguments: snapshot.data![index].studentDetails);
                },
              ),
            );
          },
        );
      },
    );
  }

  Future<List<BranchConciseModel>> _futureOfResults(
      BuildContext context, int yearSelector) async {
    if (!_fetchedResources.resultsBranchWise['initialised']) {
      var _data = await _fetch.fetchDataService(EndPoints.RESULTS_HOST +
          EndPoints.RESULTS_BRANCH[yearSelector] +
          EndPoints.WITH_INDEX);
      for (var r in _data) {
        _results.add(BranchConciseModel.fromJson(r));
      }
      _fetchedResources.setResultsBranchWise(_results);
      return _results;
    } else {
      return _fetchedResources.resultsBranchWise['data'];
    }
  }
}
