import 'package:flutter/material.dart';
import 'package:growmind_tutuor/core/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';
  

class HelpCenter extends StatelessWidget {
  const HelpCenter({super.key});

  void _callSupport() async {
    final Uri phoneUri = Uri(scheme: "tel", path: "+1234567890");
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw "Could not launch $phoneUri";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textColor,
      appBar: AppBar(
        title: const Text(
          'Help & Support',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: textColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 400,
              width: 400,
              child: Image.asset('assets/logo/faq.png'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Need Assistance?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            kheight,
            const Text(
              'If you need any help, feel free to contact us.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            kheight,
            const Text(
              '⏰ 24/7 Support: Our team is available 24/7 to assist you with any queries.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            kheight,
            const Text(
              '📞 Call Assistance: Reach us anytime for immediate support.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            kheight1,
            ElevatedButton.icon(
              onPressed: _callSupport,
              icon: const Icon(Icons.phone, color: Colors.blueAccent),
              label: const Text('Call Support'),
              style: ElevatedButton.styleFrom(
                backgroundColor: mainColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
