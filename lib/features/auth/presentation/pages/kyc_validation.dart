import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:growmind_tutuor/core/utils/constants.dart';
import 'package:growmind_tutuor/core/utils/validator.dart';
import 'package:growmind_tutuor/features/auth/presentation/pages/kyc_verification_page.dart';
import 'package:growmind_tutuor/features/auth/presentation/widgets/text_fields.dart';


class KycValidation extends StatelessWidget {
  KycValidation({super.key});

  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  kheight2,
                  const Text(
                    'KYC e-mail verification',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  kheight2,
                  Center(
                    child: SizedBox(
                      height: 150,
                      width: 150,
                      child: Image.asset('assets/logo/customer.png'),
                    ),
                  ),
                  kheight1,
                  const Text(
                      '1. To ensure compliance with regulatory standards and maintain the security of user accounts,email verification is mandatory'  ),                      
                  kheight,
                const  Text('2. Users must provide a valid and active email address for identification purposes Users are required to complete  the verification process within a specified timeframe, failing which access to certain services may be restricted. '), 
                kheight,
                const    Text('3. All personal information collected during the verification process will be handled in accordance with data protection   laws and will not be shared with third parties without user consent'),
                kheight1,
                  const Text(
                    'Enter your E-mail',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                  ),
                  kheight,
                  CustomTextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'E-mail',
                    validator: validateEmail,
                    prefixIcon: Icons.email,
                  ),
                  kheight1,
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: mainColor,
                          minimumSize: const Size(350, 50)),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          loginUser(context);
                        }
                      },
                      child: const Text(
                        'Confirm mail',
                        style: TextStyle(color: textColor),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void loginUser(BuildContext context) async {
  final email = emailController.text.trim();

  if (email.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Error',
        message: 'Please enter an email address!',
        contentType: ContentType.failure,
      ),
    ));
    return;
  }

  // Query the 'tutors' collection to find a matching email
  final kycCollection = FirebaseFirestore.instance.collection('tutors');
  final querySnapshot =
      await kycCollection.where('email', isEqualTo: email).limit(1).get();

  if (querySnapshot.docs.isEmpty) {
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Email Not Found',
        message: 'The entered email is not registered!',
        contentType: ContentType.warning,
      ),
    ));
    return;
  }

  // Check if the email is already authenticated using Google Sign-In
  final userDoc = querySnapshot.docs.first;
  final bool isGoogleAuthenticated = userDoc.data().containsKey('googleAuthProvider') ? 
      userDoc.get('googleAuthProvider') ?? false : false;

  if (isGoogleAuthenticated) {
    // Navigate to the appropriate page for Google-authenticated users
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const KycVerificationPage(), // Replace with your actual page
      ),
    );
  } 
}
}
