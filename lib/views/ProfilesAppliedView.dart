import 'package:flutter/material.dart';

import '../models/profilesModel.dart';
import '../shared/loadingPage.dart';
import '../viewmodels/ProfilesAppliedViewModel.dart';
import 'baseView.dart';

class ProfilesAppliedView extends StatelessWidget {
  const ProfilesAppliedView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ProfilesAppliedViewModel>(
      onModelReady: (model) {
        model.fetchProfilesApplied();
      },
      builder: (context, model, child) => _profilesScaffold(context, model),
    );
  }

  Widget _profilesScaffold(
      BuildContext context, ProfilesAppliedViewModel model) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Applications"),
        ),
        body: _profilesBody(context, model));
  }

  Widget _profilesBody(BuildContext context, ProfilesAppliedViewModel model) {
    if (model.isBusy)
      return Center(
        child: LoadingPage(),
      );
    final profiles = model.profiles;
    if (profiles == null){
      return Center(child: Text("Something went Wrong"),);
    }
    if (model.isEmpty)
      return const Center(
        child: Text("No Applications found"),
      );
    return _profilesList(context, model, profiles);
  }

  Widget _profilesList(BuildContext context, ProfilesAppliedViewModel model, List<ProfilesModel> profiles) {
    return ListView.builder(
      padding: EdgeInsets.all(0),
      itemCount: profiles.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.only(bottom: 1),
          child: ListTile(
            title: Text(
              profiles[index].companyName,
              style: TextStyle(fontWeight: FontWeight.bold, height: 1.5),
            ),
            subtitle: Text(
              _subTitleText(model, profiles, index),
              style: TextStyle(height: 1.85),
            ),
          ),
        );
      },
    );
  }

  String _subTitleText(ProfilesAppliedViewModel model, List<ProfilesModel> profiles, int index) {
    String? resumeTitle = profiles[index].application.resume.title;
    if (resumeTitle == null){
      return "Resume sent";
    }
    return  (resumeTitle+" sent, "+ model.profileStatus(index));
  }
}
