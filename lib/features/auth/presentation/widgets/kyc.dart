
import 'package:flutter/material.dart';
import 'package:growmind_tutuor/features/auth/presentation/pages/kyc_validation.dart';

class Kyc extends StatelessWidget {
  const Kyc({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => KycValidation()));
      },
      child: Align(
        alignment: Alignment.centerRight,
        child: Material(
          elevation: 5,
          shadowColor: Colors.grey,
          child: Container(
              height: 40,
              width: 140,
              decoration: const BoxDecoration(
                  border: Border.fromBorderSide(BorderSide(
                    color:
                        Color.fromARGB(255, 241, 239, 239),
                  )),
                  shape: BoxShape.rectangle),
              child: const Row(
                children: [
                  Icon(Icons.person),
                  Text(
                    'Verify kyc',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.verified,
                    color: Colors.green,
                  )
                ],
              )),
        ),
      ),
    );
  }
}
