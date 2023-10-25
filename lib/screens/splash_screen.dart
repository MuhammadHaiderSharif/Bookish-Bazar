import 'package:flutter/material.dart';
import 'package:online_book_store/models/book.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: login
          ? Center(
              child: Image.asset(
                'assets/images/background.png',
                height: MediaQuery.of(context).size.height * 0.21,
              ),
            )
          : Center(
              child: Text(
                'Loading...',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 24,
                    ),
              ),
            ),
    );
  }
}
