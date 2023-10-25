import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:online_book_store/models/book.dart';
import 'package:online_book_store/providers/bookmarks_provider.dart';
import 'package:online_book_store/screens/book_details_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:online_book_store/widgets/home/icon_button.dart';
import 'package:online_book_store/widgets/home/rating.dart';

class BookContainerVertical extends ConsumerWidget {
  const BookContainerVertical({
    super.key,
    required this.width,
    required this.book,
    required this.bottom,
    required this.height,
    required this.rating,
  });

  final double width, height, bottom, rating;
  final Book book;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarks = ref.watch(bookmarksProvider);
    bool check = false;

    if (bookmarks != []) {
      for (Map<String, dynamic> bookmark in bookmarks!) {
        if (bookmark['title'] == book.title) {
          check = true;
          break;
        }
      }
    }

    return Padding(
      padding: EdgeInsets.only(
        bottom: bottom,
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.of(context).push(
            PageTransition(
              child: BookDetails(
                book: book,
              ),
              type: PageTransitionType.fade,
            ),
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.24),
                    offset: const Offset(0, 4),
                    blurRadius: 18, // Blur radius of the shadow
                    spreadRadius: 2, // Spread radius of the shadow
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    offset: Offset(8, 0),
                    blurRadius: 18, // Blur radius of the shadow
                    spreadRadius: 10, // Spread radius of the shadow
                  ),
                ],
              ),
              height: height,
              width: width,
              child: Image(
                image: AssetImage(
                  book.image,
                ),
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 26,
                top: 8,
                bottom: 0.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    book.subtitle,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  StarRating(rating: book.rating),
                ],
              ),
            ),
            const Spacer(),
            IconButtonWidget(
              book: book,
              padding: 2,
              alignment: Alignment.topRight,
              isBookmarked: check ? true : false,
            )
          ],
        ),
      ),
    );
  }
}
