import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_book_store/widgets/cart/book_listview_vertical.dart';

class ShoppingCartBody extends ConsumerWidget {
  const ShoppingCartBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const BookListViewVertical();
  }
}
