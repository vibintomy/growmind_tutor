import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:growmind_tutuor/core/utils/constants.dart';
import 'package:growmind_tutuor/features/auth/presentation/widgets/text_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});

  final TextEditingController emailController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  void sendVerificationCode(BuildContext context, String email) async {
    try {
      final emailTrimmed = email.trim();
      if (emailTrimmed.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(      
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
                title: 'Error ',
                message: 'please Enter an email address',
                contentType: ContentType.failure)));
      }
      final querySnapShot = await FirebaseFirestore.instance
          .collection('tutors')
          .where('email', isEqualTo: emailTrimmed)
          .get();

      if (querySnapShot.docs.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
                title: 'Error ',
                message: 'No linked email founded',
                contentType: ContentType.failure)));
        return;
      }
      await auth.sendPasswordResetEmail(email: emailTrimmed);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
              title: 'Success ',
              message: 'Verication code has been sent',
              contentType: ContentType.success)));
      await Future.delayed(const  Duration(seconds: 1));
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred';
      if (e.code == 'invalid-email') {
        errorMessage = 'The email address is not valid.';
      } else if (e.code == 'user-not-found') {
        errorMessage = 'No user found with this email address.';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.red,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An unexpected error occurred: $e'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: textColor,
        automaticallyImplyLeading: true,
      ),
      backgroundColor: textColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.lock,
                      size: 100,
                    )),
                kheight2,
                const Text(
                  'FORGET',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                kheight,
                const Text(
                  'PASSWORD',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                kheight,
                const Text(
                  "Provide your account's email  for which you want",
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
                const Text(
                  " to reset your password",
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
                kheight2,
                CustomTextField(
                  controller: emailController,
                  hintText: 'E-mail',
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter valid mail';
                    }
                    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }

                    return null;
                  },
                ),
                kheight2,
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                        minimumSize: const Size(350, 50)),
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        sendVerificationCode(
                            context, emailController.text.trim());
                      }
                    },
                    child: const Text(
                      'Send OTP',
                      style: TextStyle(color: textColor),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
