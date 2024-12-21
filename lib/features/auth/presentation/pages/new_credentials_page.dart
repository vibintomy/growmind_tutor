import 'package:flutter/material.dart';
import 'package:growmind_tutuor/core/utils/constants.dart';
import 'package:growmind_tutuor/features/auth/presentation/widgets/text_fields.dart';

class NewCredentialsPage extends StatelessWidget {
  NewCredentialsPage({super.key});

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repasswordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.key,
                        size: 100,
                      )),
                  kheight2,
                  const Text(
                    'NEW',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  kheight,
                  const Text(
                    'CREDENTIALS',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  kheight,
                  const Text(
                    "Your identity has been verified",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Set new password",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  kheight2,
                  CustomTextField(
                    controller: passwordController,
                    prefixIcon: Icons.lock,
                    hintText: 'password',
                    suffixIcon: Icons.remove_red_eye,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter the password';
                      }

                      if (value.length <= 3 || value.length >= 15) {
                        return 'please enter a valid password';
                      }
                      return null;
                    },
                  ),
                  kheight1,
                  CustomTextField(
                    controller: repasswordController,
                    prefixIcon: Icons.lock,
                    hintText: 'Re-confirm password',
                    suffixIcon: Icons.remove_red_eye,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter the password';
                      }

                      if (value.length <= 3 || value.length >= 15) {
                        return 'please enter a valid password';
                      }
                      if (passwordController.text !=
                          repasswordController.text) {
                        return 'enter the valid password';
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
                          Navigator.pushReplacementNamed(context, '/login');
                        }
                      },
                      child: const Text(
                        'Update',
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
