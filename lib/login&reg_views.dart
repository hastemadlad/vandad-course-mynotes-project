import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:learningdart/constants/routes.dart';
import 'package:learningdart/utilities/errordialogue.dart';
import 'firebase_options.dart';
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
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                final user = FirebaseAuth.instance.currentUser;
                if (user?.emailVerified ?? false) {
                  //ifverified what happens
                  Navigator.of(
                    context,
                  ).pushNamedAndRemoveUntil(notesRoute, (route) => false);
                } else {
                  //if not verified what happens
                  Navigator.of(context).pushNamed(verifyEmailRoute);
                }
              } on FirebaseAuthException catch (e) {
                if (e.code == 'wrong-password') {
                  await showErrorDialog(
                    context,
                    "Aymaan found invalid credential",
                  );
                } else if (e.code == 'user-not-found') {
                  await showErrorDialog(
                    context,
                    "No user found with that email",
                  );
                } else if (e.code == 'invalid-email') {
                  await showErrorDialog(context, "Invalid email");
                } else {
                  await showErrorDialog(context, "Error: ${e.code}");
                }
              } catch (e) {
                await showErrorDialog(context, "Error: ${e.toString()}");
              }
              ;
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
                final userid = await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                devtools.log(userid.toString());
                Navigator.of(context).pushNamed(verifyEmailRoute);
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  await showErrorDialog(context, "Weak-Password");
                } else {
                  await showErrorDialog(context, "Error: ${e.code}");
                }
              } catch (e) {
                await showErrorDialog(context, "Error: ${e.toString()}");
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
