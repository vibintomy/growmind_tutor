import 'package:flutter/material.dart';
import 'package:growmind_tutuor/core/utils/constants.dart';
import 'package:growmind_tutuor/features/auth/data/datasource/auth_local_datasource.dart';
import 'package:growmind_tutuor/features/auth/presentation/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

GestureDetector alertBox(BuildContext context) {
  return GestureDetector(
    onTap: () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Center(child: Text('Log out')),
              content: const Text('Are you sure! want to Log Out ?'),
              actions: [
                TextButton(
                    onPressed: () {
                      logout();
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) => LoginPage()),(Route<dynamic>route)=>false);
                    },
                    child: const Text(
                      'Yes',
                      style: TextStyle(color: mainColor),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('NO'))
              ],
            );
          });
    },
    child: const Row(
      children: [
        Icon(Icons.logout,color: Colors.red,),
        kwidth,
        Text(
          'Log Out',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Icon(Icons.arrow_right),
      ],
    ),
  );
}

Future<void> logout() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(AuthLocalDataSourceImpl.cachedUserKey);
  print('user logged out');
}
