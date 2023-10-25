import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:online_book_store/models/book.dart';
import 'package:online_book_store/providers/cart_provider.dart';
import 'package:online_book_store/screens/added_screen.dart';
import 'package:online_book_store/screens/wait_screen.dart';
import 'package:online_book_store/widgets/cart/lower_body.dart';
import 'package:online_book_store/widgets/cart/upper_body.dart';
import 'package:online_book_store/widgets/cart/book_container_vertical.dart';
import 'package:page_transition/page_transition.dart';

class BookListViewVertical extends ConsumerWidget {
  const BookListViewVertical({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

    Future<void> deleteItem(Map<String, dynamic> item) async {
      DocumentSnapshot bookmarksSnapshot = await FirebaseFirestore.instance
          .collection('added')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      try {
        Map<String, dynamic> data =
            bookmarksSnapshot.data() as Map<String, dynamic>;
        List<dynamic> cart = data['cart'];
        cart = cart
            .where(
              (i) => i['title'].toString() != item['title'].toString(),
            )
            .toList();

        await FirebaseFirestore.instance
            .collection('added')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set(
          {'cart': cart},
        );
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
        // ignore: use_build_context_synchronously
        done('Item Deleted');
        await Future.delayed(
          const Duration(seconds: 1),
        );
        ref.read(cartProvider.notifier).changeCartList(cart);
      } on FirebaseException catch (error) {
        Text(error.message!);
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
      }
    }

    final cart = ref.watch(cartProvider);
    double total = 0.0;

    for (var item in cart!) {
      total += item['price'] * item['quantity'];
    }

    return cart.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.remove_shopping_cart_outlined,
                  size: 70,
                ),
                const SizedBox(
                  height: 14,
                ),
                Text(
                  'No Items Yet',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                ),
              ],
            ),
          )
        : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const UpperBody(),
                SizedBox(
                  height: (MediaQuery.of(context).size.height * 0.165) * 3 + 20,
                  child: Scrollbar(
                    child: ListView(
                      padding: const EdgeInsets.only(
                        bottom: 20,
                        top: 20,
                      ),
                      children: List.generate(
                        cart.length,
                        (index) => Dismissible(
                          background: Container(
                            color: Colors.black,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(
                                right: 20), // Background color when swiping
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 36,
                            ),
                          ),
                          key: ValueKey(cart[index]),
                          onDismissed: (direction) {
                            Navigator.of(context).push(
                              PageTransition(
                                child: const WaitScreen(),
                                type: PageTransitionType.fade,
                              ),
                            );
                            deleteItem(cart[index]);
                          },
                          child: BookContainerVertical(
                            height: 105,
                            width: 75,
                            bottom: index == cart.length - 1 ? 0.0 : 20,
                            book: toBookCart(cart[index]),
                            rating: toBookCart(cart[index]).rating,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                LowerBody(total: total),
              ],
            ),
          );
  }
}
