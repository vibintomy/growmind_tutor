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
                    child: Container(
                      height: 150,
                      width: 150,
                      child: Image.asset('assets/logo/customer.png'),
                    ),
                  ),
                  kheight1,
                  const Text(
                      ''' 1. To ensure compliance with regulatory standards and maintain the security of user accounts,email verification is mandatory
                     
                       2. Users must provide a valid and active email address for identification purposes Users are required to complete  the verification process within a specified timeframe, failing which access to certain services may be restricted.  
                     
                       3. All personal information collected during the verification process will be handled in accordance with data protection   laws and will not be shared with third parties without user consent'''),
                  kheight2,
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                     KycVerificationPage()));
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
}
