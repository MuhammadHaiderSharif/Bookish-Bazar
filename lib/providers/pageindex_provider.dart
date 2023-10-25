import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageIndexNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void changeIndex(int pageIndex) {
    state = pageIndex;
  }
}

final pageIndexProvider = NotifierProvider<PageIndexNotifier, int>(
  () => PageIndexNotifier(),
);
