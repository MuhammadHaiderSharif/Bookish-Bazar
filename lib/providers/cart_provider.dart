import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartNotifier extends StateNotifier<List<dynamic>?> {
  CartNotifier() : super([]);

  void changeCartList(List<dynamic> cartList) {
    state = [...cartList];
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<dynamic>?>((ref) {
  return CartNotifier();
});
