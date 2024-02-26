import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_calculator/components/auth_service.dart';
import 'package:new_calculator/main.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailAddress = TextEditingController();

  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
              controller: emailAddress,
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
              controller: password,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                logUserIn();
              },
              child: const Text('Login'),
            ),
            const SizedBox(
              height: 40,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.green,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'or continue with',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                AuthService authService =
                    AuthService(); // Instantiate AuthService
                await authService
                    .signInWithGoogle(); // Call signInWithGoogle method
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('lib/images/logo.jpeg', width: 50, height: 50),
                  const SizedBox(width: 10),
                  const Text('Sign in with Google'),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('no account?',
                    style: TextStyle(color: Colors.green)),
                const SizedBox(width: 4.0),
                GestureDetector(
                  onTap: widget.onTap,
                  child: const Text(
                    'Register here',
                    style: TextStyle(
                        color: Colors.amber, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void wrongEmailMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Incorrect email'),
          );
        });
  }

  //Message pop up
  void wrongPassword() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Incorrect password'),
          );
        });
  }

  void logUserIn() async {
    // Show a loading indicator while processing login
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
      barrierDismissible: false, // Prevent user from dismissing dialog
    );

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress.text,
        password: password.text,
      );
      // Navigate to MyHomePage upon successful login
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    } on FirebaseAuthException catch (e) {
      // Hide loading indicator
      Navigator.pop(context);

      if (e.code == 'user-not-found') {
        // Show error message for incorrect email
        wrongEmailMessage();
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        // Show error message for incorrect password
        wrongPassword();
        print('Wrong password provided for that user.');
      } else {
        // Show generic error message for other errors
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text('Error'),
            content: Text('An error occurred. Please try again later.'),
          ),
        );
        print('Error: ${e.message}');
      }
    }
  }
}
