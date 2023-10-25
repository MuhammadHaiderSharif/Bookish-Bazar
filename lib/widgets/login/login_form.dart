// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:online_book_store/providers/visibility_provider.dart';

import 'package:online_book_store/widgets/onboard/elevated_button_big.dart';

final _firebase = FirebaseAuth.instance;

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _form = GlobalKey<FormState>();
  var _enteredEmail = '';
  var _enteredPassword = '';
  bool _isAuthenticating = false;

  void _submit() async {
    setState(() {
      _isAuthenticating = true;
    });
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      setState(() {
        _isAuthenticating = false;
      });
      return;
    }
    _form.currentState!.save();

    try {
      await _firebase.signInWithEmailAndPassword(
        email: _enteredEmail,
        password: _enteredPassword,
      );

      Navigator.of(context).pop();

      setState(() {
        _isAuthenticating = false;
      });
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        //
      }

      ScaffoldMessenger.of(context).clearSnackBars();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.message ?? 'Authentication Failed',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isVisible = ref.watch(visibilityProvider);

    return Container(
      height: 260,
      color: Colors.transparent,
      child: Form(
        key: _form,
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              textCapitalization: TextCapitalization.none,
              cursorColor: Colors.black,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: const Icon(Icons.email),
                fillColor: const Color(0xFFC4C4C4).withOpacity(
                  0.2,
                ),
                filled: true,
                labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty ||
                    !value.contains('@')) {
                  return 'Please enter a valid email address.';
                }
                return null;
              },
              onSaved: (value) {
                _enteredEmail = value!;
              },
            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              enableSuggestions: false,
              cursorColor: Colors.black,
              obscureText: isVisible,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  onPressed: () {
                    ref.read(visibilityProvider.notifier).change(!isVisible);
                  },
                  icon: isVisible
                      ? const Icon(Icons.visibility_off)
                      : const Icon(
                          Icons.visibility,
                        ),
                ),
                fillColor: const Color(0xFFC4C4C4).withOpacity(
                  0.2,
                ),
                filled: true,
                labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIconColor: Colors.black,
              ),
              validator: (value) {
                if (value == null || value.trim().length < 6) {
                  return 'Password must be at least 6 characters long.';
                }
                return null;
              },
              onSaved: (value) {
                _enteredPassword = value!;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButtonBig(
              widget: _isAuthenticating
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 5,
                    )
                  : Text(
                      'Login',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                    ),
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
