import 'package:amigo_mobile/service/auth_services.dart';
import 'package:amigo_mobile/screens/signup_screen.dart';

import 'package:flutter/material.dart';

import '../utils/custom_texfield.dart';

import 'admindrawer.dart';


import 'drawer_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isAdmin = false; // Initialize isAdmin as false

  final AuthService authService = AuthService();

  void loginUser() async {
    // Authenticate user
    bool isAuthenticated = await authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      isAdmin: isAdmin,
    );

    if (isAuthenticated) {
      if (isAdmin) {
        // If user is admin, navigate to admin screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminDrawer(title: 'drawer')),
        );
      // Authentication successful, handle navigation or any other actions

    } else {
        // If user is not admin, navigate to normal user screen
        Navigator.pushReplacement(
          context,
            MaterialPageRoute(builder: (context) =>MainDrawer(title: 'drawer')),
        );
      }
      // Authentication failed, handle accordingly
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Image.asset(
                  'assets/logo.png',
                  width: 300,
                  height: 300,
                ),
                SizedBox(height: 5),
                CustomTextField(
                  controller: _emailController,
                  hintText: 'Enter your email',
                  hintTextColor: Colors.grey,
                  textColor: Colors.black,
                ),
                const SizedBox(height: 30),
                CustomTextField(
                  controller: _passwordController,
                  hintText: 'Enter your password',
                  hintTextColor: Colors.grey,
                  textColor: Colors.black,
                ),
                const SizedBox(height: 50),
                CheckboxListTile(
                  title: const Text(' Admin'),
                  value: isAdmin,
                  onChanged: (value) {
                    setState(() {
                      isAdmin = value!;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: loginUser,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    textStyle: MaterialStateProperty.all(
                      const TextStyle(color: Colors.white),
                    ),
                    minimumSize: MaterialStateProperty.all(
                      Size(MediaQuery.of(context).size.width / 2.5, 50),
                    ),
                  ),
                  child: const Text(
                    "Log in",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.black),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
