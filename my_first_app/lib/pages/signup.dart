import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:my_first_app/pages/login.dart';
import 'package:my_first_app/pages/home.dart';
import 'package:my_first_app/widget/widget_support.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // ✅ Controllers HERE - OUTSIDE build() method
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Firebase instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  // Sign Up Function
  Future<void> signUp() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    // Validation
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please fill all fields')));
      return;
    }

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password must be at least 6 characters')),
      );
      return;
    }

    try {
      // Create user in Firebase Auth
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Get user ID
      String uid = userCredential.user!.uid;

      // Save user data to Realtime Database
      await _database.child('users').child(uid).set({
        'name': name,
        'email': email,
        'createdAt': DateTime.now().toString(),
      });

      // Show success message
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Account created successfully!')));

      // Navigate to home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists for this email.';
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
    // ❌ DON'T PUT CONTROLLERS HERE!
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFff5c30), Color(0xFFe74b1a)],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 3,
              ),
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Text(""),
            ),
            Container(
              margin: EdgeInsets.only(top: 50.0, left: 20, right: 20),
              child: Column(
                children: [
                  Center(
                    child: Image.asset(
                      "images/logo.png",
                      width: MediaQuery.of(context).size.width / 1.5,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 50),
                  Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 30.0),
                          Text(
                            "Sign Up",
                            style: AppWidget.HeadlineTextFieldStyle(),
                          ),
                          SizedBox(height: 25.0),
                          TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              hintText: 'Name',
                              hintStyle: AppWidget.semiBoldTextFieldStyle(),
                              prefixIcon: Icon(Icons.person_outlined),
                            ),
                          ),
                          SizedBox(height: 25.0),
                          TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: AppWidget.semiBoldTextFieldStyle(),
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                          ),
                          SizedBox(height: 25.0),
                          TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: AppWidget.semiBoldTextFieldStyle(),
                              prefixIcon: Icon(Icons.password_outlined),
                            ),
                          ),
                          SizedBox(height: 80.0),
                          GestureDetector(
                            onTap: signUp,
                            child: Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Color(0xffff5722),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    "Sign Up",
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
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LogIn()),
                      );
                    },
                    child: Text(
                      "Already have an account? Log in",
                      style: AppWidget.semiBoldTextFieldStyle(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
