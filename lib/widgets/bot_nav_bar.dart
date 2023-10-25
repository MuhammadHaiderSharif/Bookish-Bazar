import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_book_store/providers/pageindex_provider.dart';

class BotNavBar extends ConsumerWidget {
  const BotNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageIndex = ref.watch(pageIndexProvider);
    return Positioned(
      right: 20,
      left: 20,
      bottom: 20,
      child: Container(
        height: 75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: Colors.black.withOpacity(0.5),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(7, 8, 14, 0.05),
              offset: Offset(0, 2), // Offset of the shadow
              blurRadius: 8, // Blur radius of the shadow
              spreadRadius: 6, // Spread radius of the shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                ref.read(pageIndexProvider.notifier).changeIndex(0);
              },
              icon: Image.asset(
                'assets/icons/home.png',
                height: pageIndex == 0 ? 20 : 18,
                color: pageIndex == 0 ? Colors.white : Colors.grey.shade500,
              ),
            ),
            IconButton(
              onPressed: () {
                ref.read(pageIndexProvider.notifier).changeIndex(1);
              },
              iconSize: pageIndex == 1 ? 26 : 24,
              icon: Icon(
                Icons.bookmark_outline_sharp,
                color: pageIndex == 1 ? Colors.white : Colors.grey.shade500,
              ),
            ),
            IconButton(
              onPressed: () {
                ref.read(pageIndexProvider.notifier).changeIndex(2);
              },
              icon: Image.asset(
                'assets/icons/shopping.png',
                height: pageIndex == 2 ? 22 : 20,
                color: pageIndex == 2 ? Colors.white : Colors.grey.shade500,
              ),
            ),
            IconButton(
              onPressed: () {
                ref.read(pageIndexProvider.notifier).changeIndex(3);
              },
              icon: Image.asset(
                'assets/icons/setting.png',
                height: pageIndex == 3 ? 22 : 20,
                color: pageIndex == 3 ? Colors.white : Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
