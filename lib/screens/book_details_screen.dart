import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:online_book_store/models/book.dart';
import 'package:online_book_store/providers/bookmarks_provider.dart';
import 'package:online_book_store/widgets/book_details/elevated_button_large.dart';
import 'package:online_book_store/widgets/book_details/elevated_button_small.dart';
import 'package:online_book_store/widgets/home/icon_button.dart';
import 'package:online_book_store/widgets/home/rating.dart';

class BookDetails extends ConsumerWidget {
  const BookDetails({
    super.key,
    required this.book,
  });

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
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButtonWidget(
            padding: 0,
            alignment: Alignment.center,
            book: book,
            isBookmarked: check ? true : false,
          ),
          IconButton(
            onPressed: () {},
            highlightColor: Colors.transparent,
            icon: const Icon(Icons.more_vert),
          ),
          const SizedBox(
            width: 12,
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.85,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Hero(
                  tag: book.image.split(''),
                  child: Container(
                    height: 300,
                    width: 200,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          offset: const Offset(0, 32),
                          blurRadius: 22, // Blur radius of the shadow
                          spreadRadius: 4, // Spread radius of the shadow
                        ),
                      ],
                    ),
                    child: Image(
                      image: AssetImage(
                        book.image,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Text(
                  book.title,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  book.subtitle,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 14,
                      ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StarRating(
                      rating: book.rating,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${book.rating}',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 14,
                          ),
                    ),
                    Text(
                      ' / 5.0',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 14,
                          ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                Text(
                  book.description,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 24,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButtonSmall(
                      icon: 'assets/icons/menu.png',
                      text: 'Preview',
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    ElevatedButtonSmall(
                      icon: 'assets/icons/reviews.png',
                      text: 'Reviews',
                    ),
                  ],
                ),
                const Spacer(),
                ElevatedButtonLarge(
                  text: 'Buy Now for \$${book.price}',
                  book: book,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
