import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';


//LOGINVIEW FOR THEM LOGINS 

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
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(
                children: [
                  TextField(
                    style: TextStyle(color: const Color.fromARGB(255, 236, 216, 216)),
                    controller: _email,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Enter your email babygirl', hintStyle: TextStyle(color: const Color.fromARGB(255, 173, 171, 163))
                    ),
                  ),
                  TextField(
                    controller: _password,
                    style: TextStyle(color:  const Color.fromARGB(255, 236, 216, 216)),
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText:
                          'Enter your password which I will not encrypt confirm', hintStyle: TextStyle(color: const Color.fromARGB(255, 173, 171, 163))
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final email = _email.text;
                      final password = _password.text;
                      try{
                        final userid = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                        print(userid);} on FirebaseAuthException catch (e) {if(e.code == 'invalid-credential')
                                                                            {print("Aymaan found invalid credential");}else{
                                                                              print("something else happened aymaan");
                                                                              print(e.code);
                                                                            }} 
                      
                      
                    },
                    child: const Text('Login'),
                  ),
                ],
              );
            default:
              return const Text('Loading...');
          }
        },
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
    return Scaffold( backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Registration'),
        backgroundColor: Colors.amberAccent,
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(
                children: [
                  TextField(
                    controller: _email,
                    style: TextStyle(color:  const Color.fromARGB(255, 236, 216, 216)),
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Enter your email babygirl',hintStyle: TextStyle(color: const Color.fromARGB(255, 173, 171, 163))
                    ),
                  ),
                  TextField(
                    controller: _password,
                    obscureText: true,
                    style: TextStyle(color:  const Color.fromARGB(255, 236, 216, 216)),
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText:
                          'Enter your password which I will not encrypt confirm',hintStyle: TextStyle(color: const Color.fromARGB(255, 173, 171, 163))
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final email = _email.text;
                      final password = _password.text;
                      try{final userid = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          print(userid);}
                      on FirebaseAuthException catch(e){if(e.code == 'weak-password'){print("weak password my nigga");}else{print(e.code);}} ///try catch
                      
                    },
                    child: const Text('Register'),
                  ),
                ],
              );
            default:
              return const Text('Loading...');
          }
        },
      ),
    );
  }
}
