import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_calculator/main.dart';
import 'package:new_calculator/screens/login_or_register.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while checking authentication state
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData) {
              // If authenticated, navigate to MyHomePage
              return MyHomePage();
            } else {
              // If not authenticated, show the login page
              return const LoginOrRegisterPage();
            }
          }
        },
      ),
    );
  }
}
