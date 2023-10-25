import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpperBody extends ConsumerWidget {
  const UpperBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Bookmarks',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            'Ready to Buy? Check Your Bookmarks',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
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
                0.2,
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
