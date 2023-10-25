import 'package:flutter_riverpod/flutter_riverpod.dart';

class VisiblityNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void change(bool isVisible) {
    state = isVisible;
  }
}

final visibilityProvider = NotifierProvider<VisiblityNotifier, bool>(
  () => VisiblityNotifier(),
);
