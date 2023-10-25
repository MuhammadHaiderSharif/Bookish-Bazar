import 'package:flutter/material.dart';
import 'package:online_book_store/widgets/home/book_listview_vertical.dart';

import 'package:online_book_store/widgets/home/book_listview_horizontal.dart';
import 'package:online_book_store/widgets/home/upper_body.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          UpperBody(),
          BookListViewHorizontal(),
          BookListViewVertical(),
        ],
      ),
    );
  }
}
