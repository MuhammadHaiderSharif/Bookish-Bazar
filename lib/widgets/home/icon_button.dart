import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_book_store/models/book.dart';
import 'package:online_book_store/providers/bookmarks_provider.dart';
import 'package:online_book_store/screens/added_screen.dart';
import 'package:online_book_store/screens/wait_screen.dart';
import 'package:page_transition/page_transition.dart';

// ignore: must_be_immutable
class IconButtonWidget extends ConsumerStatefulWidget {
  IconButtonWidget(
      {super.key,
      required this.book,
      required this.padding,
      required this.alignment,
      this.isBookmarked = false});

  final double padding;
  final AlignmentGeometry alignment;
  final Book book;
  bool isBookmarked;

  @override
  ConsumerState<IconButtonWidget> createState() => _IconButtonWidgetState();
}

class _IconButtonWidgetState extends ConsumerState<IconButtonWidget> {
  Future<void> done(String text) async {
    Navigator.of(context).push(
      PageTransition(
        child: AddedScreen(
          text: text,
        ),
        type: PageTransitionType.fade,
        duration: const Duration(milliseconds: 200),
      ),
    );

    await Future.delayed(
      const Duration(milliseconds: 800),
    );
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  Future<void> saveBookmarks() async {
    DocumentSnapshot bookmarksSnapshot = await FirebaseFirestore.instance
        .collection('saved')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    try {
      if (!bookmarksSnapshot.exists) {
        Map<String, dynamic> book = widget.book.toMapBookmark();
        await FirebaseFirestore.instance
            .collection('saved')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
          'bookmarks': [book]
        });
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
        done('Bookmark added.');
        ref.read(bookmarksProvider.notifier).changeBookmarksList([book]);
      } else {
        Map<String, dynamic> data =
            bookmarksSnapshot.data() as Map<String, dynamic>;
        Map<String, dynamic> book = widget.book.toMapBookmark();
        List<dynamic> bookmarksList = data['bookmarks'];
        bookmarksList.add(book);
        await FirebaseFirestore.instance
            .collection('saved')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({'bookmarks': bookmarksList});
        // busy = false;
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
        done('Bookmark added.');
        ref.read(bookmarksProvider.notifier).changeBookmarksList(bookmarksList);
      }
    } on FirebaseException catch (error) {
      Text(error.message!);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }
  }

  Future<void> deleteBookmarks() async {
    DocumentSnapshot bookmarksSnapshot = await FirebaseFirestore.instance
        .collection('saved')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    try {
      Map<String, dynamic> data =
          bookmarksSnapshot.data() as Map<String, dynamic>;
      Map<String, dynamic> book = widget.book.toMapBookmark();
      List<dynamic> bookmarksList = data['bookmarks'];
      bookmarksList = bookmarksList
          .where(
            (b) => b['title'].toString() != book['title'].toString(),
          )
          .toList();

      await FirebaseFirestore.instance
          .collection('saved')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(
        {'bookmarks': bookmarksList},
      );
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      done('Bookmark removed');
      await Future.delayed(
        const Duration(seconds: 1),
      );
      ref.read(bookmarksProvider.notifier).changeBookmarksList(bookmarksList);
    } on FirebaseException catch (error) {
      Text(error.message!);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      highlightColor: Colors.transparent,
      alignment: Alignment.center,
      onPressed: () {
        widget.isBookmarked = !widget.isBookmarked;
        if (widget.isBookmarked) {
          Navigator.of(context).push(
            PageTransition(
              child: const WaitScreen(),
              type: PageTransitionType.fade,
            ),
          );
          setState(() {});
          saveBookmarks();
        } else {
          Navigator.of(context).push(
            PageTransition(
              child: const WaitScreen(),
              type: PageTransitionType.fade,
            ),
          );
          setState(() {});
          deleteBookmarks();
        }
      },
      padding: EdgeInsets.only(
        top: widget.padding,
      ),
      icon: Icon(
        widget.isBookmarked == true
            ? Icons.bookmark_sharp
            : Icons.bookmark_outline_sharp,
      ),
      key: ValueKey(
        widget.isBookmarked,
      ),
    );
  }
}
