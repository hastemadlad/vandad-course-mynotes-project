import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learningdart/firebase_options.dart';
import 'login&reg_views.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomePage(),
      routes: { '/Login/': (context) => const LoginView(),
                '/Register/': (context) => const RegisterView(),

      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 19, 19),
      appBar: AppBar(
        title: const Text('Home'), 
        backgroundColor: Colors.amberAccent,
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              // final user = FirebaseAuth.instance.currentUser;
              // if (user?.emailVerified ?? false) {
              //   print("Email is verified aymaan"); 
              // }else{print("verify your email first aymaan");
              //   return const EmailVerificationView();}
              // return const Text("Aymaan done", style: TextStyle(color: Color.fromARGB(255, 225, 230, 230)),);
              return const LoginView();

            default:
              return const Text('Loading...');
          }
        },
      ),
    );
  }
}


class EmailVerificationView extends StatefulWidget {
  const EmailVerificationView({super.key});

  @override
  State<EmailVerificationView> createState() => _EmailVerificationViewState();
}

class _EmailVerificationViewState extends State<EmailVerificationView> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [Text('Please verify your email address to continue.'),
    TextButton(onPressed: () async{
      final user = FirebaseAuth.instance.currentUser;
      await user?.sendEmailVerification();
    }, child: const Text("Resend Verification Email")),],);
  }
}