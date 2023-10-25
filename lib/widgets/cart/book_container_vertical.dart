import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:online_book_store/models/book.dart';
import 'package:online_book_store/providers/cart_provider.dart';
import 'package:online_book_store/screens/added_screen.dart';
import 'package:online_book_store/screens/book_details_screen.dart';
import 'package:online_book_store/screens/wait_screen.dart';
import 'package:page_transition/page_transition.dart';

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
    Future<void> done(String text) async {
      Navigator.of(context).push(
        PageTransition(
          child: AddedScreen(
            text: text,
          ),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 500),
        ),
      );
      await Future.delayed(
        const Duration(seconds: 1),
      );
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }

    Future<void> add() async {
      DocumentSnapshot cartSnapshot = await FirebaseFirestore.instance
          .collection('added')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      try {
        Map<String, dynamic> data = cartSnapshot.data() as Map<String, dynamic>;
        Map<String, dynamic> itemConverted = book.toMapCart();
        List<dynamic> cart = data['cart'];
        final indexToUpdate = cart.indexWhere(
          (item) => item['title'] == itemConverted['title'],
        );

        itemConverted['quantity'] = itemConverted['quantity'] + 1;
        cart[indexToUpdate] = itemConverted;

        await FirebaseFirestore.instance
            .collection('added')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({'cart': cart});
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();

        ref.read(cartProvider.notifier).changeCartList(cart);
      } on FirebaseException catch (error) {
        Text(error.message!);
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
      }
    }

    Future<void> subtract() async {
      DocumentSnapshot cartSnapshot = await FirebaseFirestore.instance
          .collection('added')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      try {
        Map<String, dynamic> data = cartSnapshot.data() as Map<String, dynamic>;
        Map<String, dynamic> itemConverted = book.toMapCart();
        List<dynamic> cart = data['cart'];
        final indexToUpdate = cart.indexWhere(
          (item) => item['title'] == itemConverted['title'],
        );

        itemConverted['quantity'] = itemConverted['quantity'] - 1;
        cart[indexToUpdate] = itemConverted;

        await FirebaseFirestore.instance
            .collection('added')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({'cart': cart});
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();

        ref.read(cartProvider.notifier).changeCartList(cart);
      } on FirebaseException catch (error) {
        Text(error.message!);
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
      }
    }

    return Padding(
      padding: EdgeInsets.only(
        bottom: bottom,
        right: 20,
        left: 20,
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
            SizedBox(
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
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (book.quantity != 1) {
                            Navigator.of(context).push(
                              PageTransition(
                                  child: const WaitScreen(),
                                  type: PageTransitionType.fade),
                            );
                            subtract();
                          } else {
                            done('Limit Reached.');
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.black),
                          ),
                          child: const Icon(
                            Icons.remove,
                            size: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        book.quantity.toString(),
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            PageTransition(
                                child: const WaitScreen(),
                                type: PageTransitionType.fade),
                          );
                          add();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.black),
                          ),
                          child: const Icon(
                            Icons.add,
                            size: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
              ),
              child: Text(
                '\$${book.price.toString()}',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
