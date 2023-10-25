import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailNotifier extends Notifier<String> {
  @override
  String build() => '';

  void changeEmail(String email) {
    state = email;
  }
}

final emailProvider = NotifierProvider<EmailNotifier, String>(
  () => EmailNotifier(),
);
