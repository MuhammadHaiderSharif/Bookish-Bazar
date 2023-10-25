import 'package:flutter/material.dart';

import 'package:online_book_store/data/book_list_vertical.dart';
import 'package:online_book_store/widgets/home/book_container_vertical.dart';

class BookListViewVertical extends StatelessWidget {
  const BookListViewVertical({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Newest',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.grey,
                ).copyWith(
                  overlayColor:
                      const MaterialStatePropertyAll(Colors.transparent),
                ),
                onPressed: () {},
                child: Row(
                  children: [
                    Text(
                      'See All',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Icon(
                      size: 14,
                      Icons.arrow_forward_ios,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        SizedBox(
          height: 415,
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
            children: List.generate(
              booksVertical.length - 2,
              (index) => BookContainerVertical(
                height: 105,
                width: 75,
                bottom: index == booksVertical.length - 1 ? 0.0 : 20,
                book: booksVertical[index],
                rating: booksVertical[index].rating,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
