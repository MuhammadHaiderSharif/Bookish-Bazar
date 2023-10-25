import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpperBody extends ConsumerWidget {
  const UpperBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 18,
        left: 18,
        top: 24,
        bottom: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Cart',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                'Review and Checkout',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
