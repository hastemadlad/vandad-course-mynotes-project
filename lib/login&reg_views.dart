import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:learningdart/constants/routes.dart';
import 'package:learningdart/services/auth/auth_exceptions.dart';
import 'package:learningdart/services/auth/auth_service.dart';
import 'package:learningdart/utilities/errordialogue.dart';
import 'dart:developer' as devtools show log;

//LOGINVIEW FOR THEM LOGINS
//wearacidbd@gmail.com
//password is waterdog123

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 19, 19),
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.amberAccent,
      ),
      body: Column(
        children: [
          TextField(
            style: TextStyle(color: const Color.fromARGB(255, 236, 216, 216)),
            controller: _email,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Enter your email babygirl',
              hintStyle: TextStyle(
                color: const Color.fromARGB(255, 173, 171, 163),
              ),
            ),
          ),
          TextField(
            controller: _password,
            style: TextStyle(color: const Color.fromARGB(255, 236, 216, 216)),
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
              hintText: 'Enter your password which I will not encrypt confirm',
              hintStyle: TextStyle(
                color: const Color.fromARGB(255, 173, 171, 163),
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await AuthService.firebase().login(
                  email: email,
                  password: password,
                );
                final user = AuthService.firebase().currentUser;

                if (user?.isEmailVerified ?? false) {
                  //ifverified what happens
                  Navigator.of(
                    context,
                  ).pushNamedAndRemoveUntil(notesRoute, (route) => false);
                } else {
                  //if not verified what happens
                  devtools.log('error- ${user?.isEmailVerified}');
                  Navigator.of(context).pushNamed(verifyEmailRoute);
                }
              } on UserNotFoundAuthException {
                await showErrorDialog(context, 'user not found');
              } on WrongPasswordAuthException {
                await showErrorDialog(context, 'areh bhai bhul password diso');
              } on InvalidEmailAuthException {
                await showErrorDialog(context, 'Invalid Email');
              } on GenericAuthException {
                await showErrorDialog(context, 'Authentication Error');
              }
            },
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(registerRoute, (route) => false);
            },
            child: const Text('Go to Registration'),
          ),
        ],
      ),
    );
  }
}

//REGISTER VIEW FOR THEM REGISTERING
///////
//    //
//     ///
///////
///    //
///      //
///        //
///          //

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 19, 19),
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: Colors.amberAccent,
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            style: TextStyle(color: const Color.fromARGB(255, 236, 216, 216)),
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Enter your email babygirl',
              hintStyle: TextStyle(
                color: const Color.fromARGB(255, 173, 171, 163),
              ),
            ),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            style: TextStyle(color: const Color.fromARGB(255, 236, 216, 216)),
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
              hintText: 'Enter your password which I will not encrypt confirm',
              hintStyle: TextStyle(
                color: const Color.fromARGB(255, 173, 171, 163),
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                final userid = await AuthService.firebase().createUser(
                  email: email,
                  password: password,
                );

                Navigator.of(context).pushNamed(verifyEmailRoute);
                final user = AuthService.firebase().currentUser;
                await AuthService.firebase().sendEmailVerification();
              } on WeakPasswordAuthException {
                await showErrorDialog(context, "Weak-Password");
              } on EmailAlreadyInUseAuthException {
                await showErrorDialog(context, 'email already in use');
              } on InvalidEmailAuthException {
                await showErrorDialog(context, 'email is invalid');
              } on GenericAuthException {
                await showErrorDialog(context, 'Authentication Error');
              }

              ///try catch
            },
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(loginRoute, (route) => false);
            },
            child: const Text('Go to Login'),
          ),
        ],
      ),
    );
  }
}
