import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserNameNotifier extends Notifier<String> {
  @override
  String build() => '';

  void changeUserName(String userName) {
    state = userName;
  }
}

final userNameProvider = NotifierProvider<UserNameNotifier, String>(
  () => UserNameNotifier(),
);
