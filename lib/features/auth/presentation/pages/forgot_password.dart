import 'package:flutter/material.dart';
import 'package:growmind_tutuor/core/utils/constants.dart';
import 'package:growmind_tutuor/features/auth/presentation/widgets/text_fields.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});

  final TextEditingController emailController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: textColor,
        automaticallyImplyLeading: true,
      ),
      backgroundColor: textColor,
      body: Form(
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
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            const Text(
              " to reset your password",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
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
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Center(child: Text('Enter OTP')),
                            content: Row(
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                  }
                },
                child: const Text(
                  'Next',
                  style: TextStyle(color: textColor),
                ))
          ],
        ),
      ),
    );
  }
}
