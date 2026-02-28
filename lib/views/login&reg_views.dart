import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learningdart/services/auth/auth_exceptions.dart';
import 'package:learningdart/services/auth/bloc/auth_bloc.dart';
import 'package:learningdart/services/auth/bloc/auth_event.dart';
import 'package:learningdart/services/auth/bloc/auth_state.dart';
import 'package:learningdart/utilities/dialog/error_dialog.dart';
import 'package:learningdart/utilities/dialog/loading_dialog.dart';

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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          final exception = state.exception;
          if (exception is UserNotFoundAuthException) {
            await showErrorDialog(context, 'User not found');
          } else if (exception is WrongPasswordAuthException) {
            await showErrorDialog(context, 'Wrong password');
          } else if (exception is InvalidCredentialAuthException) {
            await showErrorDialog(context, 'Invalid login credentials');
          } else if (exception is InvalidEmailAuthException) {
            await showErrorDialog(context, 'Invalid email');
          } else if (exception is GenericAuthException) {
            await showErrorDialog(
              context,
              'Unprecedented Authentication error',
            );
          }
        }
      },
      child: Scaffold(
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
                hintText:
                    'Enter your password which I will not encrypt confirm',
                hintStyle: TextStyle(
                  color: const Color.fromARGB(255, 173, 171, 163),
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                context.read<AuthBloc>().add(AuthEventLogin(email, password));
              },
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(const AuthEventShouldRegister());
              },
              child: const Text('Go to Registration'),
            ),
          ],
        ),
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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateRegistering) {
          if (state.exception is WeakPasswordAuthException) {
            await showErrorDialog(context, 'Weak Password');
          } else if (state.exception is EmailAlreadyInUseAuthException) {
            await showErrorDialog(context, 'Email Already In Use');
          } else if (state.exception is InvalidEmailAuthException) {
            await showErrorDialog(context, 'Invalid Credential brotherman');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Unprecedented Registering Error');
          }
        }
      },
      child: Scaffold(
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
                hintText:
                    'Enter your password which I will not encrypt confirm',
                hintStyle: TextStyle(
                  color: const Color.fromARGB(255, 173, 171, 163),
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                context.read<AuthBloc>().add(
                  AuthEventRegister(email, password),
                );
              },
              child: const Text('Register'),
            ),
            TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(const AuthEventLogOut());
              },
              child: const Text('Go to Login'),
            ),
          ],
        ),
      ),
    );
  }
}
