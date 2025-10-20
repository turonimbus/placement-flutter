import 'package:flutter/material.dart';

import '../shared/ErrorWidget.dart';
import '../shared/loadingPage.dart';
import '../viewmodels/ResultsBranchWiseViewModel.dart';
import 'baseView.dart';

class ResultsBranchWiseView extends StatelessWidget {
  final int yearSelector, internSwitch, sortSwitch;

  const ResultsBranchWiseView({
    super.key,
    required this.yearSelector,
    required this.internSwitch,
    required this.sortSwitch,
  });

  @override
  Widget build(BuildContext context) {
    return BaseView<ResultsBranchWiseViewModel>(
      onModelReady: (model) {
        model.setResultFilter(yearSelector, internSwitch, sortSwitch);
      },
      builder: (context, model, child) => _resultDisplay(context, model),
    );
  }

  Widget _resultDisplay(BuildContext context, ResultsBranchWiseViewModel model) {
    bool filtersHaveChanged = (model.yearIndex != yearSelector) ||
        (model.internSwitch != internSwitch) ||
        (model.sortSwitch != sortSwitch);

    if (filtersHaveChanged) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        model.setResultFilter(yearSelector, internSwitch, sortSwitch);
      });
    }
    if (model.isBusy){
      return Center(
        child: LoadingPage(),
      );
    }
    final branchResults = model.branchResults;
    if (branchResults == null){
      return ErrorWidgetWithRefreshCallback(onRefresh: model.refreshResults);
    }
    if (branchResults.isEmpty) {
      return const Center(
        child: Text("No Results Found"),
      );
    }
    return RefreshIndicator(
      onRefresh: model.refreshResults,
      child: ListView.builder(
        itemCount: branchResults.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          final result = branchResults[index];
          return Card(
            elevation: 0.3,
            margin: const EdgeInsets.only(bottom: 1),
            child: ListTile(
              title: Text(
                result.studentBranchName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                  fontSize: 15,
                ),
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Degree: ${result.studentDegree}",
                    style: const TextStyle(height: 1.85),
                  ),
                  Text(
                    "Selected: ${result.selected}",
                    style: const TextStyle(height: 1.85),
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context).pushNamed(
                  '/result_details_branchwise',
                  arguments: {
                    'url': result.studentDetails,
                    'sort': sortSwitch,
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
