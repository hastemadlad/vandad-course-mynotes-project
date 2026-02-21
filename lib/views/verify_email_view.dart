import 'package:flutter/material.dart';
import 'package:learningdart/constants/routes.dart';
import 'package:learningdart/services/auth/auth_service.dart';

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
            onPressed: () async {
              await AuthService.firebase().sendEmailVerification();
            },
            child: const Text("Resend Verification Email"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(registerRoute, (route) => false);
              await AuthService.firebase().logout();
            },
            child: const Text("Restart"),
          ),
        ],
      ),
    );
  }
}
