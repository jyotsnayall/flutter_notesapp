import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:notesapp/screens/home_screen.dart';
import 'package:notesapp/services/auth.dart';
import 'package:notesapp/stores/notes_store.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login To App"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignInButton(
              Buttons.Google,
              onPressed: () async {
                await signInWithGoogle().then((value) {
                  print("login value: ${store.isLoggedin}");
                  store.isLoggedin = true;
                  print("login value: ${store.isLoggedin}");
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
