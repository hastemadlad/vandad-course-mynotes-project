import 'package:flutter/material.dart';
import 'package:learningdart/views/notes/create_update_note_view.dart';
import 'package:learningdart/views/notes/notes_view.dart';
import 'package:learningdart/services/auth/auth_service.dart';
import 'package:learningdart/views/verify_email_view.dart';
import 'views/login&reg_views.dart';
import 'package:learningdart/constants/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomePage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        notesRoute: (context) => const NotesView(),
        verifyEmailRoute: (context) => const EmailVerificationView(),
        createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return const NotesView();
              } else {
                return const EmailVerificationView(); //Email Verification View does not have a scaffold Yet
              }
            } else {
              return const LoginView();
            }
          // return const Text('Done');

          default:
            return const Text('Loading...');
        }
      },
    );
  }
}
