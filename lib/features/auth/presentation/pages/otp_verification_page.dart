import 'package:flutter/material.dart';
import 'package:growmind_tutuor/core/utils/constants.dart';
import 'package:growmind_tutuor/features/auth/presentation/pages/new_credentials_page.dart';

import 'package:pinput/pinput.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final formkey = GlobalKey<FormState>();
  final borderColor = Colors.grey[800]!;
  final pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final defaultTheme = PinTheme(
        height: 75,
        width: 50,
        textStyle: const TextStyle(fontSize: 22, color: Colors.black),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderColor)));

    return Scaffold(
      backgroundColor: textColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Form(
          key: formkey,
          child: Column(
          
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            const  Text('CO',style: TextStyle(fontSize: 100,fontWeight: FontWeight.bold),),
              const  Text('DE',style: TextStyle(fontSize: 100,fontWeight: FontWeight.bold),),
              kheight,
               const  Text('VERIFICATION',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
               kheight,
                const  Text('Enter the one time password',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.grey),),
              Directionality(
                  textDirection: TextDirection.ltr,
                  child: Center(
                    child: Pinput(
                      length: 4,
                      controller: pinController,
                      defaultPinTheme: defaultTheme,
                      hapticFeedbackType: HapticFeedbackType.lightImpact,
                      onCompleted: (pin) {
                        debugPrint('on completed $pin');
                      },
                      onChanged: (pin) {
                        debugPrint('completed $pin');
                      },
                      cursor: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin:const EdgeInsets.only(bottom: 9),
                            width: 75,
                            height: 10,
                    
                    
                          )
                        ],
                      ),
                      focusedPinTheme: defaultTheme.copyWith(
                        decoration: defaultTheme.decoration!.copyWith(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black)
                        )
                      ),
                      submittedPinTheme: defaultTheme.copyWith(
                        decoration: defaultTheme.decoration!.copyWith(
                          color:const Color.fromRGBO(243, 246, 249, 0),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.redAccent)
                        )
                      ),
                      errorPinTheme: defaultTheme.copyBorderWith(border: Border.all(color: Colors.redAccent)),
                    ),
                  )),
                  kheight2,
                   ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                        minimumSize: const Size(350, 50)),
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  NewCredentialsPage()));
                      }
                    },
                    child: const Text(
                      'VERIFY CODE',
                      style: TextStyle(color: textColor),
                    ))
            ],
          ),
          ),
        ),
      )
    );
  }
}
