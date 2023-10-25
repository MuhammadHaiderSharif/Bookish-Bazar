import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookmarksNotifier extends StateNotifier<List<dynamic>?> {
  BookmarksNotifier() : super([]);

  void changeBookmarksList(List<dynamic> bookmarksList) {
    state = [...bookmarksList];
  }
}

final bookmarksProvider =
    StateNotifierProvider<BookmarksNotifier, List<dynamic>?>((ref) {
  return BookmarksNotifier();
});
