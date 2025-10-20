import 'package:flutter/material.dart';

class ErrorWidgetWithRefreshCallback extends StatelessWidget {
  final RefreshCallback onRefresh;
  const ErrorWidgetWithRefreshCallback({
    super.key,
    required this.onRefresh
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: const CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        slivers: <Widget>[
          SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("(ㅠ﹏ㅠ)", style: TextStyle(fontSize: 24)),
                  SizedBox(height: 8),
                  Text("Something went Wrong"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
