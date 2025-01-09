import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_tutuor/core/utils/constants.dart';
import 'package:growmind_tutuor/core/utils/validator.dart';
import 'package:growmind_tutuor/features/auth/presentation/bloc/kyc_bloc/kyc_bloc.dart';
import 'package:growmind_tutuor/features/auth/presentation/bloc/kyc_bloc/kyc_event.dart';
import 'package:growmind_tutuor/features/auth/presentation/pages/login_page.dart';
import 'package:growmind_tutuor/features/auth/presentation/widgets/text_fields.dart';
import 'package:pdfx/pdfx.dart';

class KycVerificationPage extends StatefulWidget {
  KycVerificationPage({super.key});

  @override
  State<KycVerificationPage> createState() => _KycVerificationPageState();
}

class _KycVerificationPageState extends State<KycVerificationPage> {
  String? filepath;
  late PdfController? pdfController;

  Future<void> pickAndDisplayPdf() async {
    try {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

      if (result != null && result.files.single.path != null) {
        final String pickedFilePath = result.files.single.path!;
        print('This is the path $pickedFilePath');
        if (await File(pickedFilePath).exists()) {
          setState(() {
            filepath = pickedFilePath;
            pdfController?.dispose();
            pdfController =
                PdfController(document: PdfDocument.openFile(filepath!));
          });
        } else {
          debugPrint('Files does not exists  $pickedFilePath');
        }
      }
    } catch (e) {
      debugPrint('Error picking and displaying the file $e');
    }
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController professionController = TextEditingController();
  @override
  void initState() {
    super.initState();
    pdfController =
        PdfController(document: PdfDocument.openAsset('assets/sample.pdf'));
  }

  @override
  void dispose() {
    pdfController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textColor,
      appBar: AppBar(
        title: const Text(
          'Tutor Verification',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: textColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                kheight2,
                Center(
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset('assets/logo/kyc.png'),
                  ),
                ),
                kheight2,
                const Text(
                  'Enter your name',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                CustomTextField(
                    controller: nameController,
                    validator: validateName,
                    hintText: 'Name'),
                kheight1,
                const Text(
                  'Please enter your email ',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                CustomTextField(
                    controller: emailController,
                    validator: validateEmail,
                    hintText: 'Email'),
                kheight1,
                const Text(
                  'Please enter your profession',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                CustomTextField(
                    controller: professionController,
                    validator: validateName,
                    hintText: 'Profession'),
                kheight1,
                const Text(
                  'Attach document',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const Text(
                  '1.please ensure to provide your valid document related to your work experience \n 2.minimum 1 year of experience',
                  style: TextStyle(fontSize: 12, color: mainColor),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Material(
                      child: Container(
                        height: 240,
                        width: 400,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: mainColor),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        pickAndDisplayPdf();
                      },
                      child: Container(
                          height: 235,
                          width: 390,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              color: Color.fromARGB(255, 231, 228, 228)),
                          child: filepath != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: PdfView(controller: pdfController!),
                                )
                              : const Center(
                                  child: Icon(
                                    Icons.attach_file,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                )),
                    )
                  ],
                ),
                kheight,
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                        minimumSize: const Size(350, 50)),
                    onPressed: () {
                      if (filepath != null &&
                          nameController.text.isNotEmpty &&
                          professionController.text.isNotEmpty &&
                          emailController.text.isNotEmpty) {
                        context.read<TutorKycBloc>().add(SubmitKycEvent(
                            name: nameController.text,
                            email: emailController.text,
                            pdfUrl: filepath!,
                            profession: professionController.text));
                       
                        loginUser(context);
                        
                      
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                'please fill the fields to attach the document')));
                      }
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: textColor),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loginUser(BuildContext context) async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Error',
          message: 'Please enter an email address!',
          contentType: ContentType.failure,
        ),
      ));
      return;
    }

    // Query the 'tutors' collection to find a matching email
    final kycCollection = FirebaseFirestore.instance.collection('tutors');
    final querySnapshot =
        await kycCollection.where('email', isEqualTo: email).limit(1).get();

    if (querySnapshot.docs.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Email Not Found',
          message: 'The entered email is not registered!',
          contentType: ContentType.warning,
        ),
      ));
      return;
    }
      Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                                 ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                    title: 'kyc request sended',
                                    message:
                                        'Approval takes 1-3 business days ',
                                    contentType: ContentType.success)));
  }
}
