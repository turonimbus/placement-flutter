import 'package:flutter/material.dart';

import '../shared/loadingPage.dart';
import '../viewmodels/ResumeListViewModel.dart';
import 'baseView.dart';

class ResumeListView extends StatelessWidget {
  const ResumeListView({super.key});

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;

    return BaseView<ResumeListViewModel>(
      onModelReady: (model) {
        model.getResumes();
      },
      builder: (context, model, child) =>
          _resumeScaffold(context, model, _width),
    );
  }

  Widget _resumeScaffold(
      BuildContext context, ResumeListViewModel model, double _width) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Resumes"),
      ),
      body: _scaffoldBody(context, model, _width),
    );
  }

  Widget _scaffoldBody(
      BuildContext context, ResumeListViewModel model, double _width) {
    if (model.isBusy)
      return Center(
        child: LoadingPage(),
      );
    if (model.isEmpty)
      return Center(
        child: Text("No Resumes Found"),
      );
    return _resumeList(context, model, _width);
  }

  Widget _resumeList(
      BuildContext context, ResumeListViewModel model, double _width) {
    return ListView.builder(
      itemCount: model.resumes.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.only(bottom: 1),
          elevation: 0.3,
          child: ListTile(
            onTap: () async {
              await model.launchURL(model.resumes[index].resumeUrl!);
            },
            title: Text(
              model.resumes[index].title!,
              style: TextStyle(
                  fontWeight: FontWeight.bold, height: 1.1, fontSize: 15),
            ),
            subtitle: Text(
              "Verified: " + (model.resumes[index].isVerified! ? "Yes" : "No"),
              style: TextStyle(height: 1.85),
            ),
          ),
        );
      },
    );
  }
}
