import 'package:flutter/cupertino.dart';

class LoadingProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setLoading(newValue) {
    _isLoading = newValue;
    notifyListeners();
  }
}
