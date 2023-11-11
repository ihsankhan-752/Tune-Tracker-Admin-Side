import 'package:flutter/material.dart';

class PickStartAndEndTimeProvider extends ChangeNotifier {
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();

  TimeOfDay get startTime => _startTime;
  TimeOfDay get endTime => _endTime;

  setStartTime({required BuildContext context}) async {
    TimeOfDay? pickedStartTime = await showTimePicker(
      context: context,
      initialTime: _startTime,
    );
    if (pickedStartTime != null && pickedStartTime != _startTime) {
      _startTime = pickedStartTime;
      notifyListeners();
    }
  }

  setEndTime({required BuildContext context}) async {
    TimeOfDay? pickedStartTime = await showTimePicker(
      context: context,
      initialTime: _endTime,
    );
    if (pickedStartTime != null && pickedStartTime != _endTime) {
      _endTime = pickedStartTime;
      notifyListeners();
    }
  }
}
