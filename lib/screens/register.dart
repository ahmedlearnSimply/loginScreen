// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
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
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

//* sign Up to check if
  Future signUp() async {
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    }
    getUserData(
      firstNameController.text.trim(),
      lastNameController.text.trim(),
      emailController.text.trim(),
      int.parse(ageController.text.trim()),
    );
  }

  Future getUserData(
    String firstName,
    String lastName,
    String email,
    int age,
  ) async {
    await FirebaseFirestore.instance.collection('user').add({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'age': age
    });
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
              Gap(40),
              //* logo for the app

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
              //* Firstname text field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: CustomTextFormField(
                  controller: firstNameController,
                  prefixIcon: Icon(Icons.person),
                  suffixIcon: Icon(Icons.clear),
                  labelText: "First Name",
                ),
              ),
              Gap(10),
              //* LastName text field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: CustomTextFormField(
                  controller: lastNameController,
                  prefixIcon: Icon(Icons.person_4),
                  suffixIcon: Icon(Icons.clear),
                  labelText: "Last Name",
                ),
              ),
              Gap(10),
              //* age Text Field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: CustomTextFormField(
                  controller: ageController,
                  prefixIcon: Icon(Icons.apps_outage_sharp),
                  suffixIcon: Icon(Icons.clear),
                  labelText: "Age",
                ),
              ),
              Gap(10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: CustomTextFormField(
                  controller: emailController,
                  prefixIcon: Icon(Icons.email),
                  suffixIcon: Icon(Icons.clear),
                  labelText: "email",
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
                    "You \'ve an account ? ",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[800],
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.showLoginPage,
                    child: Text(
                      "Login Now",
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
