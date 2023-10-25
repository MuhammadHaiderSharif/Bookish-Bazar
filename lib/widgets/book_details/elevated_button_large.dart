import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:online_book_store/models/book.dart';
import 'package:online_book_store/providers/cart_provider.dart';
import 'package:online_book_store/screens/added_screen.dart';
import 'package:online_book_store/screens/wait_screen.dart';
import 'package:page_transition/page_transition.dart';

class ElevatedButtonLarge extends ConsumerWidget {
  const ElevatedButtonLarge(
      {super.key, required this.text, required this.book});

  final String text;

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
          duration: const Duration(milliseconds: 200),
        ),
      );
      await Future.delayed(
        const Duration(milliseconds: 800),
      );
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }

    Future<void> addToCart() async {
      bool check = false;
      DocumentSnapshot cartSnapshot = await FirebaseFirestore.instance
          .collection('added')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      try {
        if (!cartSnapshot.exists) {
          Map<String, dynamic> itemConverted = book.toMapCart();
          await FirebaseFirestore.instance
              .collection('added')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .set({
            'cart': [itemConverted]
          });
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();
          done('Item Added to Cart');
          ref.read(cartProvider.notifier).changeCartList([itemConverted]);
        } else {
          Map<String, dynamic> data =
              cartSnapshot.data() as Map<String, dynamic>;
          Map<String, dynamic> itemConverted = book.toMapCart();
          List<dynamic> cart = data['cart'];

          for (Map<String, dynamic> item in cart) {
            if (item['title'] == itemConverted['title']) {
              check = true;
              break;
            }
          }
          if (check != true) {
            cart.add(itemConverted);

            await FirebaseFirestore.instance
                .collection('added')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .set({'cart': cart});
            // ignore: use_build_context_synchronously
            Navigator.of(context).pop();
            done('Item Added to Cart');
            ref.read(cartProvider.notifier).changeCartList(cart);
          } else {
            // ignore: use_build_context_synchronously
            Navigator.of(context).pop();
            done('Already Added to Cart');
          }
        }
      } on FirebaseException catch (error) {
        Text(error.message!);
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
      }
    }

    return Container(
      height: 60,
      width: double.infinity,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(7, 8, 14, 0.05),
            offset: Offset(0, 2), // Offset of the shadow
            blurRadius: 16, // Blur radius of the shadow
            spreadRadius: 6, // Spread radius of the shadow
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            PageTransition(
              child: const WaitScreen(),
              type: PageTransitionType.fade,
            ),
          );
          addToCart();
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.grey.withOpacity(0.5),
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
