import 'package:flutter/material.dart';
import 'package:online_book_store/widgets/login/login_form.dart';
import 'package:online_book_store/screens/signup_screen.dart';
import 'package:online_book_store/widgets/login/custom_text.dart';

import 'package:page_transition/page_transition.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: 65,
            right: 14,
            left: 14,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.873,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: 'assets/images/background.png',
                  child: Image.asset(
                    'assets/images/background.png',
                    height: MediaQuery.of(context).size.height * 0.21,
                  ),
                ),
                const Spacer(),
                Text(
                  'Welcome Back',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Login to your account',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 14,
                      ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const LoginForm(),
                const Spacer(),
                CustomText(
                  text1: 'Don\'t have an account?',
                  text2: ' Sign Up',
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      PageTransition(
                        child: const SignUpScreen(),
                        type: PageTransitionType.fade,
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
