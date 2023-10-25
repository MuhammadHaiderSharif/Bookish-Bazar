import 'package:flutter/material.dart';
import 'package:online_book_store/screens/login_screen.dart';
import 'package:online_book_store/widgets/login/custom_text.dart';

import 'package:online_book_store/widgets/signup/signup_form.dart';
import 'package:page_transition/page_transition.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              top: 65,
              right: 14,
              left: 14,
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.873,
              child: Column(
                children: [
                  Hero(
                    tag: 'assets/images/background.png',
                    child: Image.asset(
                      'assets/images/background.png',
                      height: MediaQuery.of(context).size.height * 0.19,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Let\'s Begin',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Create an account',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 13,
                        ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  const SignUpForm(),
                  const Spacer(),
                  CustomText(
                    text1: 'Already have an account?',
                    text2: ' Sign In',
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
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
    );
  }
}
