import 'package:flutter/material.dart';

class AddedScreen extends StatelessWidget {
  const AddedScreen({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.6),
      body: Center(
        child: Container(
          height: 110,
          width: 200,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Column(
            children: [
              const Icon(
                Icons.done_rounded,
                color: Colors.green,
                size: 32,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
