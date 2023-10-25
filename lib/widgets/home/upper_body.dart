import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_book_store/providers/username_provider.dart';

class UpperBody extends ConsumerWidget {
  const UpperBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String userName = ref.watch(userNameProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName != '' ? 'Hi, ${userName.split(' ')[0]}' : '',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    'What book you want to read today?',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
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
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 26,
          ),
          TextField(
            cursorColor: const Color(0xFF9D9D9D).withOpacity(
              0.8,
            ),
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
            decoration: InputDecoration(
              labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
              prefixIconConstraints: const BoxConstraints(
                maxWidth: 20,
              ),
              suffixIcon: const Icon(
                Icons.search,
              ),
              suffixIconColor: Colors.black,
              labelText: 'Search book here',
              fillColor: const Color(0xFFC4C4C4).withOpacity(
                0.1,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(
                  8,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
