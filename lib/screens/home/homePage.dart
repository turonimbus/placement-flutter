import 'package:flutter/material.dart';

import '../../resources/R.dart';
import '../../views/CandidateDetailsView.dart';
import '../../views/ResultPageView.dart';
import '../../views/calendarView.dart';
import 'applyPage.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Tab> _bottomTab = const <Tab>[
    Tab(
      icon: Icon(Icons.check_circle),
      text: 'Apply',
    ),
    Tab(
      icon: Icon(Icons.insert_drive_file),
      text: 'Results',
    ),
    Tab(
      icon: Icon(Icons.perm_contact_calendar),
      text: 'Calendar',
    ),
    Tab(
      icon: Icon(Icons.person),
      text: 'Profile',
    )
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _homePageScaffold(context);
  }

  Widget _homePageScaffold(BuildContext context) {
    return ColoredBox(
      color: R.primaryCol,
      child: SafeArea(
        left: false,
        right: false,
        child:Scaffold(
              body: TabBarView(
                controller: _tabController,
                children: _tabSelector(),
              ),
              bottomNavigationBar: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                      offset: Offset(0, -5),
                    ),
                  ]),
                  child: TabBar(
                    controller: _tabController,
                    tabs: _bottomTab,
                    indicatorPadding: EdgeInsets.all(5.0),
                    indicatorColor: R.primaryCol,
                    labelColor: R.primaryCol,
                    unselectedLabelColor: Colors.grey,
                  ))),
        ),
    )
    ;
  }

  List<Widget> _tabSelector() {
    return <Widget>[
      ApplyPage(),
      ResultPageView(),
      CalendarView(),
      CandidateDetailsView(),
    ];
  }
}
