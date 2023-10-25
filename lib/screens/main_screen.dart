import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_book_store/providers/bookmarks_provider.dart';
import 'package:online_book_store/providers/cart_provider.dart';
import 'package:online_book_store/providers/email_provider.dart';
import 'package:online_book_store/providers/pageindex_provider.dart';
import 'package:online_book_store/providers/username_provider.dart';
import 'package:online_book_store/screens/splash_screen.dart';

import 'package:online_book_store/widgets/body/shopping_cart_body.dart';
import 'package:online_book_store/widgets/body/bookmark_body.dart';
import 'package:online_book_store/widgets/body/settings_body.dart';
import 'package:online_book_store/widgets/body/home_body.dart';
import 'package:online_book_store/widgets/bot_nav_bar.dart';

class MainScreen extends ConsumerWidget {
  MainScreen({super.key});

  final pages = [
    const HomeBody(),
    const BookmarkBody(),
    const ShoppingCartBody(),
    const SettingsBody(),
  ];
  final CollectionReference userRef =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference bookmarksRef =
      FirebaseFirestore.instance.collection('saved');
  final CollectionReference cartRef =
      FirebaseFirestore.instance.collection('added');
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageIndex = ref.watch(pageIndexProvider);

    return ref.read(userNameProvider) == ''
        ? FutureBuilder(
            future: Future.wait(
              [
                userRef.doc(FirebaseAuth.instance.currentUser!.uid).get(),
                bookmarksRef.doc(FirebaseAuth.instance.currentUser!.uid).get(),
                cartRef.doc(FirebaseAuth.instance.currentUser!.uid).get(),
              ],
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SplashScreen();
              }
              if (snapshot.connectionState == ConnectionState.done) {
                List<DocumentSnapshot> documentSnapShot = snapshot.data!;

                var userDetailDocSnap = documentSnapShot[0];

                Future(
                  () {
                    ref
                        .read(userNameProvider.notifier)
                        .changeUserName(userDetailDocSnap['username']);
                    ref
                        .read(emailProvider.notifier)
                        .changeEmail(userDetailDocSnap['email']);
                  },
                );
                if (documentSnapShot[1].exists) {
                  Map<String, dynamic> data =
                      documentSnapShot[1].data()! as Map<String, dynamic>;
                  List<dynamic> bookmarks = data['bookmarks'];
                  Future(
                    () {
                      ref
                          .watch(bookmarksProvider.notifier)
                          .changeBookmarksList(bookmarks);
                    },
                  );
                }
                if (documentSnapShot[2].exists) {
                  Map<String, dynamic> data =
                      documentSnapShot[2].data()! as Map<String, dynamic>;
                  List<dynamic> cart = data['cart'];
                  Future(
                    () {
                      ref.watch(cartProvider.notifier).changeCartList(cart);
                    },
                  );
                }
              }

              return Scaffold(
                body: SafeArea(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child:
                              SingleChildScrollView(child: pages[pageIndex])),
                      const BotNavBar(),
                    ],
                  ),
                ),
              );
            },
          )
        : Scaffold(
            body: SafeArea(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  pages[pageIndex],
                  const BotNavBar(),
                ],
              ),
            ),
          );
  }
}
