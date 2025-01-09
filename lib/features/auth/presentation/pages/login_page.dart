import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_tutuor/core/utils/constants.dart';
import 'package:growmind_tutuor/core/utils/validator.dart';
import 'package:growmind_tutuor/features/auth/data/datasource/auth_local_datasource.dart';
import 'package:growmind_tutuor/features/auth/data/models/user_model.dart';
import 'package:growmind_tutuor/features/auth/presentation/bloc/login_bloc/auth_bloc.dart';
import 'package:growmind_tutuor/features/auth/presentation/bloc/login_bloc/auth_event.dart';
import 'package:growmind_tutuor/features/auth/presentation/bloc/login_bloc/auth_state.dart';
import 'package:growmind_tutuor/features/auth/presentation/pages/forgot_password.dart';
import 'package:growmind_tutuor/features/auth/presentation/pages/signup_page.dart';
import 'package:growmind_tutuor/features/auth/presentation/widgets/googlebutton.dart';
import 'package:growmind_tutuor/features/auth/presentation/widgets/kyc.dart';
import 'package:growmind_tutuor/features/bottom_navigation/presentation/pages/bottom_navigation.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final formkey = GlobalKey<FormState>();
  static bool isObscure = true;
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: textColor,
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            } else if (state is Authenticated) {
              Navigator.pushReplacementNamed(context, '/home');
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Kyc(),
                        kheight1,
                        SizedBox(
                          height: 150,
                          child: Image.asset('assets/logo/logo1.png'),
                        ),
                        kheight1,
                        const Text(
                          'Getting Started.!',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        kheight,
                        TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                                hintText: 'E-mail',
                                prefixIcon: Icon(Icons.mail),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)))),
                            keyboardType: TextInputType.emailAddress,
                            validator: validateEmail),
                        kheight,
                        TextFormField(
                            obscureText: isObscure,
                            controller: passwordController,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      isObscure = !isObscure;
                                      (context as Element).markNeedsBuild();
                                    },
                                    child: const Icon(Icons.remove_red_eye)),
                                hintText: 'password'),
                            validator: validatePassword),
                        kheight,
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ForgotPassword()));
                          },
                          child: const Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Forgot password ?',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: mainColor),
                            ),
                          ),
                        ),
                        kheight1,
                        Center(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: mainColor,
                                minimumSize: const Size(350, 50),
                              ),
                              onPressed: () {
                                if (formkey.currentState!.validate()) {
                                  loginUser(context);
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Sign in',
                                    style: TextStyle(
                                      color: textColor,
                                    ),
                                  ),
                                  kwidth,
                                  Container(
                                    height: 27,
                                    width: 27,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: textColor),
                                    child: const Icon(
                                      Icons.arrow_forward,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              )),
                        ),
                        kheight,
                        const Center(
                            child: Text(
                          'Or continue with',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        )),
                        kheight1,
                        const Googlebutton(),
                        kheight,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Dont't have an Account?",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            kwidth,
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignupPage()));
                              },
                              child: const Text(
                                "SIGN UP",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFC82C55)),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ));
  }

  void loginUser(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Fill the tables')));
    }
    final FirebaseFirestore firestore;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      final user = userCredential.user;

      if (user == null || user.emailVerified == false) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.redAccent,
            content:
                Text('Email is not verified. Please enter a valid email')));
        return;
      }

      final kycCollection = FirebaseFirestore.instance.collection('kyc');
      final querySnapshot =
          await kycCollection.where('vemail', isEqualTo: email).limit(1).get();
      if (querySnapshot.docs.isEmpty) {
         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              elevation: 0,
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              content: AwesomeSnackbarContent(
                                  title: 'email not registered ',
                                  message:
                                      'email is not registered for kyc!',
                                  contentType: ContentType.warning)));
                           return;
                      }

                      final kycData = querySnapshot.docs.first.data();
                   if (kycData['status'] != 'Accepted') {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              elevation: 0,
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              content: AwesomeSnackbarContent(
                                  title: 'Profile not verified ',
                                  message:
                                      'Your profile is not verified by our team',
                                  contentType: ContentType.warning)));
        return;
      }
       if (kycData['status'] == 'pending') {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              elevation: 0,
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              content: AwesomeSnackbarContent(
                                  title: 'Profile not verified ',
                                  message:
                                      'Your profile is not verified by our team',
                                  contentType: ContentType.help)));
        return;
      }

      final userId = user.uid;
      final userDoc = await FirebaseFirestore.instance
          .collection('tutors')
          .doc(userId)
          .get();
      if (!userDoc.exists) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Profile is not verified. please contact support')));
        return;
      }
      final AuthLocalDataSource authLocalDataSource = AuthLocalDataSourceImpl();
      final userModel = UserModel(
          id: userId,
          email: user.email ?? '',
          displayName: user.displayName ?? '',
          phone: user.phoneNumber ?? '');
      await authLocalDataSource.cacheUser(userModel);
      // ignore: use_build_context_synchronously
      BlocProvider.of<AuthBloc>(context).add(LoginRequested(email, password));
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement((context),
          MaterialPageRoute(builder: (context) => const BottomNavigation()));
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found with this mail';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password entered';
      } else {
        errorMessage = 'Check the inputs';
      }
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent, content: Text(errorMessage)));
    }
  }
}
