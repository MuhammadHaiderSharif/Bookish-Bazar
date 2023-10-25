import 'package:flutter/material.dart';

class ElevatedButtonBig extends StatelessWidget {
  const ElevatedButtonBig({
    super.key,
    required this.widget,
    required this.onPressed,
  });

  final Widget widget;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(7, 8, 14, 0.05),
            offset: Offset(0, 2), // Offset of the shadow
            blurRadius: 10, // Blur radius of the shadow
            spreadRadius: 6, // Spread radius of the shadow
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.grey.withOpacity(0.5),
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: widget,
      ),
    );
  }
}
