import 'package:flutter/material.dart';
import 'package:placement/shared/loadingPage.dart';
import 'package:placement/viewmodels/ResultsBranchWiseViewModel.dart';
import 'package:placement/views/baseView.dart';

class ResultsBranchWiseView extends StatelessWidget {
  final int yearSelector, internSwitch, sortSwitch;

  // FIX 1: Updated to modern, required constructor parameters.
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
      return Center(
        child: LoadingPage(),
      );
    }
    
    if (model.branchResults == null) {
      return const Center(
        child: Text("No Results Found"),
      );
    }

    return RefreshIndicator(
      onRefresh: model.refreshResults,
      child: ListView.builder(
        itemCount: model.branchResults.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          final result = model.branchResults[index];
          return Card(
            elevation: 0.3,
            margin: const EdgeInsets.only(bottom: 1),
            child: ListTile(
              title: Text(
                result.studentBranchName!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                  fontSize: 15,
                ),
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // FIX 3: Using string interpolation for better readability.
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