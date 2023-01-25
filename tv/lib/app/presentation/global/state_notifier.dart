import 'package:flutter/foundation.dart';

abstract class StateNotifier<S> extends ChangeNotifier {
  S _state;
  S _old;
  bool _mounted = true;

  StateNotifier(this._state) : _old = _state;

  S get state => _state;

  S get old => _old;

  bool get mounted => _mounted;

  set state(S newState) {
    _update(newState);
  }

  void onlyUpdate(S newState) {
    _update(newState, notifier: false);
  }

  void _update(
    S newState, {
    bool notifier = true,
  }) {
    if (_state != newState) {
      _old = _state;
      _state = newState;
      if (notifier) {
        notifyListeners();
      }
    }
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }
}
