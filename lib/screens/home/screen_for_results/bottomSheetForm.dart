import 'package:flutter/material.dart';

import '../../../resources/R.dart';
import '../../../resources/modelResources.dart';

class BottomSheetForm extends StatefulWidget {
  BottomSheetForm({
      super.key,
      required this.yearSelectionVariable,
      required this.resultTypeVariable,
      required this.sortVariable
    });
  final int yearSelectionVariable;
  final int resultTypeVariable;
  final int sortVariable;

  @override
  _BottomSheetFormState createState() => _BottomSheetFormState();
}

class _BottomSheetFormState extends State<BottomSheetForm> {
  late int yearSelectionVariable;
  late int resultTypeVariable;
  late int sortVariable;
  // GlobalCache _cache = locator<GlobalCache>();

  @override
  void initState() {
    yearSelectionVariable = widget.yearSelectionVariable;
    resultTypeVariable = widget.resultTypeVariable;
    sortVariable = widget.sortVariable;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _yearCard(context),
          _typeCard(context),
          _sortCard(context),
          _filterButton(context),
        ],
      ),
    );
  }

  Widget _filterButton(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            Theme.of(context).primaryColor,
          ),
        ),
        child: const Text(
          'Get Results',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          Navigator.pop(
            context,
            {
              'year': yearSelectionVariable,
              'type': resultTypeVariable,
              'sort': sortVariable
            },
          );
        },
      ),
    );
  }

  Widget _yearCard(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          Text(
            "Select Year",
            style: TextStyle(color: R.textColPrimary),
          ),
          const SizedBox(
            height: 10,
          ),
          RadioGroup<int>(
            groupValue: yearSelectionVariable,
            onChanged: (val) => _setYear(val),
            child: Column(
              children: ModelResources.yearOptions().map((year) {
                return RadioListTile<int>(
                  value: year.key,
                  title: Text(year.value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sortCard(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          Text(
            "Sort By",
            style: TextStyle(color: R.textColPrimary),
          ),
          const SizedBox(
            height: 10,
          ),
          RadioGroup<int>(
            groupValue: sortVariable,
            onChanged: (val) => _setSortVar(val),
            child: Column(
              children: ModelResources.SORT_OPTIONS.map((resultType) {
                return RadioListTile(
                  value: resultType.key,
                  title: Text(resultType.value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _typeCard(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          Text(
            "Select Results type",
            style: TextStyle(color: R.textColPrimary),
          ),
          const SizedBox(
            height: 10,
          ),
          RadioGroup<int>(
            groupValue: resultTypeVariable,
            onChanged: (val) => _setResultType(val),
            child: Column(
              children: ModelResources.RESULT_OPTIONS.map((resultType) {
                return RadioListTile(
                  value: resultType.key,
                  title: Text(resultType.value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  _setYear(val) {
    setState(() {
      yearSelectionVariable = val;
    });
  }

  _setResultType(val) {
    setState(() {
      resultTypeVariable = val;
    });
  }

  _setSortVar(val) {
    setState(() {
      sortVariable = val;
    });
  }
}
