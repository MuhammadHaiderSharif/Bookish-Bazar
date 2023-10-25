import 'package:flutter/material.dart';
import 'package:online_book_store/screens/login_screen.dart';
import 'package:online_book_store/widgets/onboard/elevated_button_big.dart';

import 'package:page_transition/page_transition.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 30,
            bottom: 12,
            right: 14,
            left: 14,
          ),
          child: Center(
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/books.png',
                      height: MediaQuery.of(context).size.height * 0.5,
                    ),
                    Text(
                      'Your Book Library\nMake Your Own Space',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Text(
                      'Buy a best trending books here & manage\nyour ebooks in your space. ',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            height: 1.5,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    // const SizedBox(
                    //   height: 105,
                    // ),
                    const Spacer(),
                    ElevatedButtonBig(
                      widget: Text(
                        'Get Started',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 18,
                            ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          PageTransition(
                            child: const LoginScreen(),
                            type: PageTransitionType.fade,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
