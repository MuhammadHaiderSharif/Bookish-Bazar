import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_book_store/models/book.dart';

import 'package:online_book_store/providers/bookmarks_provider.dart';
import 'package:online_book_store/widgets/bookmark/upper_body.dart';
import 'package:online_book_store/widgets/home/book_container_vertical.dart';

class BookListViewVertical extends ConsumerWidget {
  const BookListViewVertical({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarks = ref.watch(bookmarksProvider);
    return bookmarks!.isEmpty
        ? Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('assets/icons/nobookmark.png'),
                height: 70,
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                'No Bookmarks Yet',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
              ),
            ],
          ))
        : SingleChildScrollView(
            child: Column(
              children: [
                const UpperBody(),
                SizedBox(
                  height: ((MediaQuery.of(context).size.height * 0.165) *
                          bookmarks.length) +
                      25,
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, bottom: 20),
                    children: List.generate(
                      bookmarks.length,
                      (index) => BookContainerVertical(
                        height: 105,
                        width: 75,
                        bottom: index == bookmarks.length - 1 ? 0.0 : 20,
                        book: toBookBookmark(bookmarks[index]),
                        rating: toBookBookmark(bookmarks[index]).rating,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
