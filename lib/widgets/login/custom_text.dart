import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {super.key,
      required this.text1,
      required this.text2,
      required this.onPressed});

  final String text1;
  final String text2;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text1,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14),
        ),
        TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(0.0),
          ).copyWith(
            overlayColor: const MaterialStatePropertyAll(
              Colors.transparent,
            ),
          ),
          child: Text(
            text2,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
          ),
        )
      ],
    );
  }
}
