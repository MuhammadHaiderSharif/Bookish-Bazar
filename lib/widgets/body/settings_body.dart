import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:online_book_store/providers/bookmarks_provider.dart';
import 'package:online_book_store/providers/cart_provider.dart';
import 'package:online_book_store/providers/email_provider.dart';
import 'package:online_book_store/providers/pageindex_provider.dart';
import 'package:online_book_store/providers/username_provider.dart';
import 'package:online_book_store/widgets/settings/settings_container.dart';

class SettingsBody extends ConsumerWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String userName = ref.watch(userNameProvider);
    String email = ref.watch(emailProvider);
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 60,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 75,
              width: 327,
              padding: const EdgeInsets.only(
                top: 13,
                bottom: 13,
                right: 16,
                left: 16,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFC4C4C4).withOpacity(
                  0.1,
                ),
                borderRadius: BorderRadius.circular(11),
                border: Border.all(
                  width: 0.8,
                  color: Colors.black,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      border: Border.all(
                        width: 0.7,
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(45),
                    ),
                    child: Text(
                      userName != '' ? userName[0] : '',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 28,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Text(
                        email,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                      )
                    ],
                  ),
                  const Spacer(),
                  const Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 22,
                        child: Icon(
                          Icons.notifications_outlined,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 7.2,
                          backgroundColor: Colors.red,
                          child: Center(
                            child: Text(
                              '3',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              height: 75,
              width: 327,
              padding: const EdgeInsets.only(
                top: 13,
                bottom: 13,
                right: 22,
                left: 16,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFC4C4C4).withOpacity(
                  0.1,
                ),
                borderRadius: BorderRadius.circular(11),
                border: Border.all(
                  width: 0.8,
                  color: Colors.black,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.account_circle,
                    size: 35,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    'Account settings',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const Spacer(),
                  IconButton(
                    constraints:
                        BoxConstraints.loose(const Size(0.0, double.infinity)),
                    iconSize: 22,
                    icon: const Icon(
                      Icons.edit_sharp,
                      color: Colors.black,
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
                height: 218,
                width: 327,
                padding: const EdgeInsets.only(
                  top: 12,
                  bottom: 12,
                  right: 4,
                  left: 16,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFC4C4C4).withOpacity(
                    0.1,
                  ),
                  borderRadius: BorderRadius.circular(11),
                  border: Border.all(
                    width: 0.8,
                    color: Colors.black,
                  ),
                ),
                child: const Column(
                  children: [
                    SettingsContainer(
                      iconStart: Icons.g_translate,
                      title: 'Langauge',
                    ),
                    SettingsContainer(
                      iconStart: Icons.message,
                      title: 'Feedback',
                    ),
                    SettingsContainer(
                      iconStart: Icons.star,
                      title: 'Rate us',
                    ),
                    SettingsContainer(
                      iconStart: Icons.download,
                      title: 'New Version',
                    ),
                  ],
                )),
            const SizedBox(
              height: 35,
            ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                ref.read(userNameProvider.notifier).changeUserName('');
                ref.read(cartProvider.notifier).changeCartList([]);
                ref.read(bookmarksProvider.notifier).changeBookmarksList([]);
                ref.read(pageIndexProvider.notifier).changeIndex(0);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    11,
                  ),
                ),
                fixedSize: const Size(111, 35),
                backgroundColor: Colors.black,
                foregroundColor: const Color(0xffFFFFFF),
              ),
              child: Text(
                'Logout',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
