import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy Policy"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Privacy Policy",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Last updated: March 19, 2025\n\n"
                "This Privacy Policy describes Our policies and procedures on the collection, use and "
                "disclosure of Your information when You use the Service and tells You about Your privacy rights "
                "and how the law protects You.\n\n"
                "We use Your Personal data to provide and improve the Service. By using the Service, You agree to the "
                "collection and use of information in accordance with this Privacy Policy.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                "1. Interpretation and Definitions",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "For the purposes of this Privacy Policy:\n"
                "- \"Account\" means a unique account created for You to access our Service.\n"
                "- \"Application\" refers to growmind.\n"
                "- \"Company\" refers to growmind.\n"
                "- \"Country\" refers to Kerala, India.\n"
                "- \"Personal Data\" is any information that relates to an identified or identifiable individual.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                "2. Collecting and Using Your Personal Data",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "We may collect the following Personal Data:\n"
                "- Email address\n"
                "- First name and last name\n"
                "- Phone number\n"
                "- Usage Data\n\n"
                "Usage Data is collected automatically and may include:\n"
                "- Your Device's IP address\n"
                "- Browser type and version\n"
                "- Pages of our Service that You visit\n"
                "- Time spent on pages and unique device identifiers.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                "3. Use of Your Personal Data",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "The Company may use Personal Data for the following purposes:\n"
                "- To provide and maintain our Service.\n"
                "- To manage Your Account.\n"
                "- To contact You regarding updates or security notifications.\n"
                "- To provide news and special offers unless You opt out.\n"
                "- To manage Your requests and customer support.\n",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                "4. Security of Your Personal Data",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "The security of Your Personal Data is important to Us, but no method of "
                "transmission over the Internet is 100% secure. While We strive to use "
                "commercially acceptable means to protect Your Personal Data, We cannot guarantee absolute security.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                "5. Contact Us",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "If you have any questions about this Privacy Policy, You can contact us:\n"
                "By phone number: 123456789",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
