// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase/widgets/custom_button.dart';
import 'package:firebase/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatefulWidget {
  final VoidCallback showLoginPage;
  Register({
    super.key,
    required this.showLoginPage,
  });

  @override
  State<Register> createState() => _LoginState();
}

class _LoginState extends State<Register> {
  @override
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmedPasswordController = TextEditingController();

//* sign in to check if
  Future signUp() async {
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    }
  }

  bool passwordConfirmed() {
    if (passwordController.text.trim() !=
        confirmedPasswordController.text.trim()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Passwords do not match!")));
      return false;
    }
    return true;
  }

//* to release memory
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmedPasswordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Gap(100),
              //* logo for the app

              Center(
                child: Icon(
                  Icons.android,
                  size: 100,
                ),
              ),
              Gap(10),
              //* name of App
              Text(
                "Hello There!",
                style: GoogleFonts.bebasNeue(
                  fontSize: 50,
                ),
              ),
              //* message for user
              Text(
                "Register Below , With Your Details",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.normal,
                ),
              ),
              Gap(40),
              //* email text field

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: CustomTextFormField(
                  controller: emailController,
                  prefixIcon: Icon(Icons.email),
                  suffixIcon: Icon(Icons.clear),
                  labelText: "Email",
                ),
              ),
              Gap(10),
              //* password text field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: CustomTextFormField(
                  controller: passwordController,
                  prefixIcon: Icon(Icons.password),
                  suffixIcon: Icon(Icons.remove_red_eye),
                  labelText: "Password",
                ),
              ),
              Gap(10),
              //* password text field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: CustomTextFormField(
                  controller: confirmedPasswordController,
                  prefixIcon: Icon(Icons.password),
                  suffixIcon: Icon(Icons.remove_red_eye),
                  labelText: "Confirm Password",
                ),
              ),
              Gap(15),
              //* sign in button
              CustomButton(
                text: "Sign Up",
                onTap: signUp,
              ),
              Gap(19),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not A Member ? ",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[800],
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.showLoginPage,
                    child: Text(
                      "Register Now",
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              )
            ],

            //* not a memeber register Now
          ),
        ),
      ),
    );
  }
}
