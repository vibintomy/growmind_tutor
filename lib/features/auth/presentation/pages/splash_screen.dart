import 'package:flutter/material.dart';
import 'package:growmind_tutuor/features/auth/data/datasource/auth_local_datasource.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthLocalDataSource authLocalDataSource = AuthLocalDataSourceImpl();

  @override
  void initState() {
    checkUser();
    super.initState();
  }

  void checkUser() async {
    try {
      final user = await authLocalDataSource.getcacheUser();
      if (user != null) {
       
        Navigator.pushReplacementNamed(context, '/bottomnavigation',
            arguments: user);
      } else {
        Navigator.pushReplacementNamed(
          context,
          '/login',
        );
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CircularProgressIndicator(),
    );
  }
}
