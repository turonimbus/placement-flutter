import 'package:flutter/material.dart';

import '../resources/R.dart';
import '../shared/ErrorWidget.dart';
import '../shared/loadingPage.dart';
import '../viewmodels/ResultsCompanyWiseViewModel.dart';
import 'baseView.dart';

class ResultsCompanyWiseView extends StatelessWidget {
  final int yearSelector, internSwitch, sortSwitch;
  const ResultsCompanyWiseView({
    super.key, 
    required this.yearSelector,
    required this.internSwitch,
    required this.sortSwitch
  });

  @override
  Widget build(BuildContext context) {
    return BaseView<ResultsCompanyWiseViewModel>(
      onModelReady: (model) {
        model.setResultFilter(yearSelector, internSwitch, sortSwitch);
      },
      builder: (context, model, child) => _resultDisplay(context, model),
    );
  }

  Widget _resultDisplay(
      BuildContext context, ResultsCompanyWiseViewModel model) {
    bool filtersHaveChanged = (model.yearIndex != yearSelector) ||
        (model.internSwitch != internSwitch) ||
        (model.sortSwitch != sortSwitch);
    if (filtersHaveChanged){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        model.setResultFilter(yearSelector, internSwitch, sortSwitch);
      });
    }

    if (model.isBusy){
      return Center(child: LoadingPage());
    }
    final companyResults = model.companyResults;
    if (companyResults == null){
      return ErrorWidgetWithRefreshCallback(onRefresh: model.refreshResults);
    }
    return (companyResults.isEmpty)
      ? const Center(
          child: Text("No Results Found"),
        )
      : RefreshIndicator(
          onRefresh: model.refreshResults,
          child: ListView.builder(
            padding: const EdgeInsets.all(0),
            itemCount: companyResults.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 0.3,
                margin: const EdgeInsets.only(bottom: 1),
                child: ListTile(
                  title: Text(
                    companyResults[index].companyName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        height: 1.1,
                        fontSize: 15),
                  ),
                  subtitle: Wrap(
                    children: <Widget>[
                      const Text(
                        "Selected: ",
                        style: TextStyle(height: 1.85),
                      ),
                      Text(
                        companyResults[index].selected,
                        style: TextStyle(
                            height: 1.85,
                            color: R.primaryCol,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        '/result_details_companywise',
                        arguments: {
                          'url': companyResults[index].detail,
                          'sort': model.sortSwitch
                        });
                  },
                ),
              );
            },
          ),
        );
  }
}
