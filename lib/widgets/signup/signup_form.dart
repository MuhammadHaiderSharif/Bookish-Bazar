// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:online_book_store/providers/visibility_provider.dart';
import 'package:online_book_store/widgets/onboard/elevated_button_big.dart';

final _firebase = FirebaseAuth.instance;

class SignUpForm extends ConsumerStatefulWidget {
  const SignUpForm({super.key});

  @override
  ConsumerState<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends ConsumerState<SignUpForm> {
  final _form = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredEmail = '';
  var _enteredPassword = '';
  bool _isLoading = false;

  void _submit() async {
    setState(() {
      _isLoading = true;
    });
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    _form.currentState!.save();

    try {
      final userCredentials = await _firebase.createUserWithEmailAndPassword(
        email: _enteredEmail,
        password: _enteredPassword,
      );
      Navigator.of(context).pop();
      setState(() {
        _isLoading = false;
      });

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredentials.user!.uid)
          .set(
        {
          'uid': userCredentials.user!.uid,
          'username': _enteredName,
          'email': _enteredEmail,
        },
      );
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
      setState(
        () {
          _isLoading = false;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isVisible = ref.watch(visibilityProvider);
    return SizedBox(
      height: 335,
      child: Form(
        key: _form,
        child: Column(
          children: [
            TextFormField(
              cursorColor: Colors.black,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    // height: 0.9,
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
              decoration: InputDecoration(
                labelText: 'Full Name',
                prefixIcon: const Icon(Icons.person),
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
                if (value == null || value.trim().isEmpty || value.length < 2) {
                  return 'Please enter your full name.';
                }
                return null;
              },
              onSaved: (value) {
                _enteredName = value!;
              },
            ),
            const SizedBox(
              height: 12,
            ),
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
                suffixIconColor: Colors.black,
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
              cursorColor: Colors.black,
              obscureText: isVisible,
              enableSuggestions: false,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 13,
                    color: Colors.black,
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
              widget: _isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 5,
                    )
                  : Text(
                      'Sign Up',
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
