import 'package:flutter/material.dart';

class ElevatedButtonSmall extends StatelessWidget {
  const ElevatedButtonSmall(
      {super.key, required this.icon, required this.text});

  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width * 0.41,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 16, // Blur radius of the shadow
            spreadRadius: 2, // Spread radius of the shadow
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          foregroundColor: Colors.grey.withOpacity(0.5),
          surfaceTintColor: const Color(
            0xFFFDFDFD,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              height: 24,
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
