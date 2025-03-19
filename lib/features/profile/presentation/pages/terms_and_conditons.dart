import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms & Conditions',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Welcome to GrowMind! By using our platform, you agree to the following terms and conditions.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                "1. **User Accounts**: You must provide accurate information when creating an account. You are responsible for all activities under your account.",
              ),
              SizedBox(height: 10),
              Text(
                "2. **Course Content**: Courses on GrowMind are provided for educational purposes only. Unauthorized copying or distribution is prohibited.",
              ),
              SizedBox(height: 10),
              Text(
                "3. **Payments & Refunds**: Payments are processed securely. Refunds are subject to our refund policy.",
              ),
              SizedBox(height: 10),
              Text(
                "4. **Privacy Policy**: Your personal data is protected in accordance with our privacy policy.",
              ),
              SizedBox(height: 10),
              Text(
                "5. **Termination**: Violation of these terms may result in account suspension or termination.",
              ),
              SizedBox(height: 10),
              Text(
                "6. **Changes to Terms**: GrowMind reserves the right to update these terms at any time.",
              ),
              SizedBox(height: 20),
              Text(
                "By using GrowMind, you agree to abide by these terms. For any queries, contact support@growmind.com.",
              ),
              SizedBox(height: 20),
              Text(
                "App developed by : \nVibin Tomy \nFlutter Developer",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
