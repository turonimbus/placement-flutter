import 'dart:developer';

import 'package:placement/locator.dart';
import 'package:placement/models/calendarEventModel.dart';
import 'package:placement/services/generic/calendarService.dart';
import 'package:placement/viewmodels/BaseViewModel.dart';

class CalendarViewModel extends BaseViewModel {
  // CalendarController _calendarController = CalendarController();
  List<CalendarEventModel> _events = [];
  List<CalendarEventModel> _upcomingEvents = [];
  List<CalendarEventModel> _selectedEvents = [];
  CalendarService _calendarService = locator<CalendarService>();
  Map<DateTime, List<CalendarEventModel>?> _eventMap = {};
  bool _displayUpcoming = true;
  bool _isDisposed = false;

  // CalendarController get calendarController => _calendarController;
  Map<DateTime, List<CalendarEventModel>?> get eventMap => _eventMap;
  List<CalendarEventModel> get displayEvents => (_displayUpcoming)
      ? _upcomingEvents
      : _sortedCalendarModel(_selectedEvents);
  bool get displayUpcoming => _displayUpcoming;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  List<CalendarEventModel> _sortedCalendarModel(
      List<CalendarEventModel> unsorted) {
    unsorted.sort((a, b) {
      DateTime aDate = DateTime.parse(a.dateTime);
      DateTime bDate = DateTime.parse(b.dateTime);
      return aDate.compareTo(bDate);
    });
    return unsorted;
  }

  void _notif() {
    if (!_isDisposed) notifyListeners();
  }

  Future<void> populateCalendar() async {
    setLoading();
    _events = await _calendarService.fetchEvents();
    if (_events.length > 0) {
      DateTime today = DateTime.now();
      for (var item in _events) {
        DateTime eveDay;
        try {
          eveDay = DateTime.parse(item.dateTime);
        } catch (e) {
          print(e);
          continue;
        }
        DateTime createDay = DateTime(eveDay.year, eveDay.month, eveDay.day);
        
        _eventMap.putIfAbsent(createDay, () => [])!.add(item);
        
        if (today.isBefore(eveDay)) _upcomingEvents.add(item);
      }
      _upcomingEvents = _sortedCalendarModel(_upcomingEvents);
      log("UPCOMING! ${_upcomingEvents.length}");
    }
    setIdle();
  }

  void onSelect(List<CalendarEventModel>? _seEvents) {
    if (_seEvents != null && _seEvents.isNotEmpty) {
      _selectedEvents = _seEvents;
      _displayUpcoming = false;
    } else {
      _displayUpcoming = true;
    }
    _notif();
  }
}
