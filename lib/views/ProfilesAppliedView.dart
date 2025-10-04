import 'package:flutter/material.dart';

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
    if (model.isLoading)
      return Center(
        child: LoadingPage(),
      );
    if (model.isEmpty)
      return Center(
        child: Text("No Applications found"),
      );
    return Container(
      constraints: BoxConstraints.expand(),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _profilesList(context, model),
          ],
        ),
      ),
    );
  }

  Widget _profilesList(BuildContext context, ProfilesAppliedViewModel model) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      padding: EdgeInsets.all(0),
      itemCount: model.profiles.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.only(bottom: 1),
          child: ListTile(
            title: Text(
              model.profiles[index].companyName!,
              style: TextStyle(fontWeight: FontWeight.bold, height: 1.5),
            ),
            subtitle: Text(
              model.profiles[index].application.resume.title +
                  " sent" +
                  ", " +
                  model.profileStatus(index),
              style: TextStyle(height: 1.85),
            ),
          ),
        );
      },
    );
  }
}
