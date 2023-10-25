import 'package:flutter/material.dart';

class SettingsContainer extends StatelessWidget {
  const SettingsContainer(
      {required this.iconStart, required this.title, super.key});

  final IconData iconStart;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconStart,
          color: Colors.black,
        ),
        const SizedBox(
          width: 24,
        ),
        SizedBox(
          width: 252,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
