import 'package:flutter/material.dart';

import 'package:online_book_store/data/books_list_horizontal.dart';
import 'package:online_book_store/widgets/home/book_container_horizontal.dart';

class BookListViewHorizontal extends StatelessWidget {
  const BookListViewHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Text(
            'Popular Books',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        SizedBox(
          height: 275,
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 0.0,
            ),
            scrollDirection: Axis.horizontal,
            children: List.generate(
              booksHorizontal.length,
              (index) => BookContainerHorizontal(
                height: 190,
                width: 130,
                right: index == booksHorizontal.length - 1 ? 0.0 : 20,
                book: booksHorizontal[index],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
