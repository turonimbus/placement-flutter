import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/placement_exception.dart';
import '../models/resumeModel.dart';
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
    final resumes = model.resumes;
    if (resumes == null){
      return Center(child: Text("Something went Wrong"),);
    }
    if (model.isEmpty)
      return Center(
        child: Text("No Resumes Found"),
      );
    return _resumeList(context, model, resumes, _width);
  }

  Widget _resumeList(
      BuildContext context, ResumeListViewModel model, List<ResumeModel> resumes, double _width) {
    return ListView.builder(
      itemCount: resumes.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.only(bottom: 1),
          elevation: 0.3,
          child: ListTile(
            onTap: () async {
              await launchURL(model, resumes, index);
            },
            title: Text(
              resumes[index].title,
              style: TextStyle(
                  fontWeight: FontWeight.bold, height: 1.1, fontSize: 15),
            ),
            subtitle: Text(
              "Verified: " + (resumes[index].isVerified ? "Yes" : "No"),
              style: TextStyle(height: 1.85),
            ),
          ),
        );
      },
    );
  }

  Future<void> launchURL(ResumeListViewModel model, List<ResumeModel> resumes, int index) async {
    String? resumeUrl = resumes[index].resumeUrl;
    if (resumeUrl != null){
      try {
        await model.launchURL(resumeUrl);
      } on PlacementException catch (e) {
       Fluttertoast.showToast(msg: e.message); 
      }
    } else {
      Fluttertoast.showToast(msg: "Resume URL not found");
    }
  }
}
