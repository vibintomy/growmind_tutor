import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Course details saved successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: textColor,
        automaticallyImplyLeading: true,
        title: const Text(
          'Course Price',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: textColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              kheight1,
              Container(
                width: 400,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Color.fromARGB(255, 254, 201, 183),
                ),
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
