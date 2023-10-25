import 'package:flutter/material.dart';

import 'package:online_book_store/models/book.dart';
import 'package:online_book_store/screens/book_details_screen.dart';
import 'package:page_transition/page_transition.dart';

class BookContainerHorizontal extends StatelessWidget {
  const BookContainerHorizontal({
    super.key,
    required this.width,
    required this.right,
    required this.height,
    required this.book,
  });

  final double width, height, right;

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: right,
        bottom: 10,
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
        child: Hero(
          tag: book.image.split(''),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      offset: const Offset(0, 16),
                      blurRadius: 16, // Blur radius of the shadow
                      spreadRadius: 2, // Spread radius of the shadow
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
              const SizedBox(
                height: 20,
              ),
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
            ],
          ),
        ),
      ),
    );
  }
}
