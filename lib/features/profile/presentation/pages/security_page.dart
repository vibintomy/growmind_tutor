import 'package:flutter/material.dart';
import 'package:growmind_tutuor/core/utils/constants.dart';


class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: textColor,
        title: const Text(
          'Security',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      backgroundColor: textColor,
      body: Column(
        children: [
          kheight2,
          Center(
            child: SizedBox(
              height: 200,
              width: 200,
              child: Image.asset('assets/logo/lock.png'),
            ),
          ),
          kheight2,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Security Guidelines',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                kheight,
                const Text(
                  '1. **User Authentication:** All users must authenticate using secure methods such as Firebase Authentication.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                kheight,
                const Text(
                  '2. **Data Protection:** Your personal data is securely stored in Firebase Firestore with strict access controls.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                kheight,
                const Text(
                  '3. **Cloudinary Security:** Uploaded media is protected using signed URLs and restricted access policies.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                kheight2,
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor
                    ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Ok'I Understand",
                        style: TextStyle(color: textColor, fontSize: 25),
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
