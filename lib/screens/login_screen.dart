import 'package:firebase_auth/firebase_auth.dart';
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
      appBar: AppBar(title: Text("Login To App"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignInButton(Buttons.Google, onPressed:() async{
              await signInWithGoogle();
              store.isLoggedin = true;
              //  final User? currentUser = await _auth.currentUser;
              //  LocalDataSaver.saveLoginData(true);
              //  LocalDataSaver.saveImg(currentUser!.photoURL.toString());
              //  LocalDataSaver.saveMail(currentUser.email.toString());
              //  LocalDataSaver.saveName(currentUser.displayName.toString());
              //  await FireDB().getAllStoredNotes();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
            })
          ],
        ),
      ),
    );;
  }
}