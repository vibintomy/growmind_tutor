import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_tutuor/features/bottom_navigation/presentation/pages/bottom_navigation.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/create_course_bloc/create_course_bloc.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/create_course_bloc/create_course_event.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:growmind_tutuor/core/utils/constants.dart';

class PricePage extends StatefulWidget {
  final String courseName;
  final String description;
  final String category;
  final String subCategory;
  final List<Map<String, String>> sections;

  const PricePage({
    Key? key,
    required this.courseName,
    required this.description,
    required this.category,
    required this.subCategory,
    required this.sections,
  }) : super(key: key);

  @override
  State<PricePage> createState() => _PricePageState();
}

class _PricePageState extends State<PricePage> {
  bool isPaid = false;
  bool isFree = false;
  final TextEditingController priceController = TextEditingController();
  File? selectedImage;

  final ImagePicker _picker = ImagePicker();

  void toggleCheckbox(bool isPaidSelected) {
    setState(() {
      if (isPaidSelected) {
        isPaid = true;
        isFree = false;
      } else {
        isPaid = false;
        isFree = true;
        priceController.clear();
      }
    });
  }

  Future<void> pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  void saveDetails() {
    if (isPaid) {
      final price = double.tryParse(priceController.text);
      if (price == null || priceController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a valid price')),
        );
        return;
      }
    }

    if (selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a thumbnail image')),
      );
      return;
    }

    if (widget.sections.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Section data is Empty')),
      );
      return;
    }

    context.read<CreateCourseBloc>().add(
          UploadCourseEvent(
            courseName: widget.courseName,
            courseDiscription: widget.description,
            category: widget.category,
            subCategory: widget.subCategory,
            sections: widget.sections,
            coursePrice: isPaid ? priceController.text : '0',
            imagePath: selectedImage!.path,
          ),
        );

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      elevation: 0,
        content: AwesomeSnackbarContent(
            title: 'Sucess',
            message: "Course Sucessfully Added",
            contentType: ContentType.success)));
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const BottomNavigation()),
        (Route<dynamic> state) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          backgroundColor: mainColor,
          automaticallyImplyLeading: true,
          iconTheme:const IconThemeData(color: textColor),
          title: const Text(
            'Course Price',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: textColor),
          ),
          centerTitle: true,
        ),
      ),
      backgroundColor: textColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
                   const  Text('STEP -3',style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 25),),
                   SizedBox(height: 80,width: 150,child: Image.asset('assets/logo/tag.png'),),
              kheight,
              Container(
                width: 400,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    boxShadow: [BoxShadow(
                      offset: Offset(0, 3),

                      color: greyColor,
                      spreadRadius: 0,
                      blurRadius: 3
                    )],
                    color: textColor),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        'Course Price',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      kheight,
                      CheckboxListTile(
                        title: const Text('Paid'),
                        value: isPaid,
                        onChanged: (value) => toggleCheckbox(true),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      CheckboxListTile(
                        title: const Text('Free'),
                        value: isFree,
                        onChanged: (value) => toggleCheckbox(false),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      kheight,
                      if (isPaid)
                        Container(
                          height: 50,
                          width: 330,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: textColor,
                             boxShadow: [BoxShadow(
                            color: mainColor,
                           spreadRadius: 0,
                           blurRadius: 3,
                            offset: Offset(0, 3)
                          )]
                          ),
                          child: TextFormField(
                            controller: priceController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Enter Price',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10),
                            ),
                          ),
                        ),
                      kheight,
                      const Text(
                        'Thumbnail Image',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: pickImage,
                        child: Container(
                          height: 200,
                          width: 330,
                          decoration: BoxDecoration(
                             boxShadow:const [BoxShadow(
                            color: mainColor,
                           spreadRadius: 0,
                           blurRadius: 3,
                            offset: Offset(0, 3)
                          )],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            color: textColor,
                            image: selectedImage != null
                                ? DecorationImage(
                                    image: FileImage(selectedImage!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: selectedImage == null
                              ? const Icon(Icons.image,
                                  size: 50, color: greyColor)
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              kheight1,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                      ),
                      onPressed: saveDetails,
                      child: const Text(
                        'Save Details',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
