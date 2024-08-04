import 'package:lean_requester/observable.dart';

extension ObservableBoolExt on Observable<bool> {
  void enable() => value = true;
  void disable() => value = false;
}

extension ObservablOptionaleBoolExt on Observable<bool?> {
  void enable() => value = true;
  void disable() => value = false;
}

extension ObsUsefullUpdater<T> on Observable<T?> {
  Future<bool> updateIfDifferent(T? newValue) {
    if (value != newValue) {
      value = newValue;
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }
}
