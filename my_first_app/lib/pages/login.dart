import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_first_app/pages/signup.dart';
import 'package:my_first_app/pages/home.dart';
import 'package:my_first_app/widget/widget_support.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  // Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Firebase instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Login Function
  Future<void> login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please fill all fields')));
      return;
    }

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Login successful!')));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'user-not-found') {
        message = 'No user found with this email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password.';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email format.';
      } else {
        message = 'Error: ${e.message}';
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ✅ background gradient
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2.2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFff5c30), Color(0xFFe74b1a)],
              ),
            ),
          ),

          // ✅ white bottom container
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height / 1.7,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
            ),
          ),

          // ✅ main content with flexible layout
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // ✅ key change
                children: [
                  Column(
                    children: [
                      SizedBox(height: 20),
                      Center(
                        child: Image.asset(
                          "images/logo.png",
                          width: MediaQuery.of(context).size.width / 1.5,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 20),

                      // ✅ Login box
                      Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(20),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 25.0,
                          ),
                          child: Column(
                            mainAxisSize:
                                MainAxisSize.min, // ✅ prevents overflow
                            children: [
                              Text(
                                "Login",
                                style: AppWidget.HeadlineTextFieldStyle(),
                              ),
                              SizedBox(height: 20.0),
                              TextField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  hintStyle: AppWidget.semiBoldTextFieldStyle(),
                                  prefixIcon: Icon(Icons.email_outlined),
                                ),
                              ),
                              SizedBox(height: 20.0),
                              TextField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: AppWidget.semiBoldTextFieldStyle(),
                                  prefixIcon: Icon(Icons.password_outlined),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "Forgot password?",
                                  style: AppWidget.semiBoldTextFieldStyle(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // ✅ bottom section
                  Column(
                    children: [
                      GestureDetector(
                        onTap: login,
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            width: 200,
                            decoration: BoxDecoration(
                              color: Color(0xffff5722),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                "LOGIN",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontFamily: 'poppins1',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUp()),
                          );
                        },
                        child: Text(
                          "Don't have an account? Sign up",
                          style: AppWidget.semiBoldTextFieldStyle(),
                        ),
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
