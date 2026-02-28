import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learningdart/constants/routes.dart';
import 'package:learningdart/services/auth/auth_service.dart';
import 'package:learningdart/services/auth/bloc/auth_bloc.dart';
import 'package:learningdart/services/auth/bloc/auth_event.dart';

class EmailVerificationView extends StatefulWidget {
  const EmailVerificationView({super.key});

  @override
  State<EmailVerificationView> createState() => _EmailVerificationViewState();
}

class _EmailVerificationViewState extends State<EmailVerificationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 19, 19),
      appBar: AppBar(
        title: const Text('Verify Email'),
        backgroundColor: Colors.amberAccent,
      ),
      body: Column(
        children: [
          Text(
            'Check your email address to verify your account',
            style: TextStyle(color: const Color.fromARGB(255, 236, 216, 216)),
          ),
          TextButton(
            onPressed: () {
              context.read<AuthBloc>().add(AuthEventSendEmailVerification());
            },
            child: const Text("Resend Verification Email"),
          ),
          TextButton(
            onPressed: () async {
              context.read<AuthBloc>().add(AuthEventLogOut());
            },
            child: const Text("Restart"),
          ),
        ],
      ),
    );
  }
}
