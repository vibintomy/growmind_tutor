import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:growmind_tutuor/core/utils/constants.dart';
import 'package:growmind_tutuor/core/utils/validator.dart';
import 'package:growmind_tutuor/features/home/presentation/widgets/create_course/price_page.dart';

class SectionPage extends StatefulWidget {
  final String courseName;
  final String description;
  final String category;
  final String subCategory;

  const SectionPage({
    Key? key,
    required this.courseName,
    required this.description,
    required this.category,
    required this.subCategory,
  }) : super(key: key);

  @override
  State<SectionPage> createState() => _SectionPageState();
}

class _SectionPageState extends State<SectionPage> {
  final List<Map<String, String>> sections = []; // Holds section data
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void addSection() {
    if (nameController.text.isNotEmpty && descriptionController.text.isNotEmpty) {
      setState(() {
        sections.add({
          'sectionName': nameController.text,
          'sectionDescription': descriptionController.text,
          'videoPath': '', // Placeholder for the attached video path
        });
        nameController.clear();
        descriptionController.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all fields')),
      );
    }
  }

  void pickVideo(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        sections[index]['videoPath'] = result.files.single.path ?? '';
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No video selected')),
      );
    }
  }

  void removeSection(int index) {
    setState(() {
      sections.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
  

    return Scaffold(
         appBar: AppBar(
        backgroundColor: textColor,
        automaticallyImplyLeading: true,

        title:const Text('Section Details',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      backgroundColor: textColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                kheight1,
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: sections.length,
                  itemBuilder: (context, index) {
                    final section = sections[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 251, 213, 201),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Section ${index + 1}: ${section['sectionName']}',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              kheight,
                              Text('Description: ${section['sectionDescription']}'),
                              kheight,
                              Text(
                                'Video: ${section['videoPath']!.isNotEmpty ? section['videoPath'] : 'No video attached'}',
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 116, 114, 114)),
                              ),
                              kheight,
                              Row(
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                    ),
                                    onPressed: () => pickVideo(index),
                                    child: const Text(
                                      'Attach Video',
                                      style: TextStyle(color: textColor),
                                    ),
                                  ),
                                  kwidth,
                                  if (section['videoPath']!.isNotEmpty)
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          section['videoPath'] = ''; // Clear the video path
                                        });
                                      },
                                      child: const Text(
                                        'Remove Video',
                                        style: TextStyle(color: textColor),
                                      ),
                                    ),
                                ],
                              ),
                              kheight,
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red),
                                onPressed: () => removeSection(index),
                                child: const Text(
                                  'Remove Section',
                                  style: TextStyle(color: textColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                kheight1,
                Container(
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color.fromARGB(255, 252, 215, 202),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text(
                          'Add New Section',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        kheight,
                        TextFormField(
                          controller: nameController,
                          validator: validateName,
                          decoration: const InputDecoration(
                              fillColor: textColor,
                              filled: true,
                              hintText: 'Section Name',
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: mainColor))),
                        ),
                        kheight,
                        TextFormField(
                          controller: descriptionController,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            fillColor: textColor,
                            filled: true,
                            hintText: 'Section Description',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        kheight,
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          onPressed: addSection,
                          child: const Text(
                            'Add Section',
                            style: TextStyle(color: textColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                kheight1,
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: mainColor),
                    onPressed: () {
                      if (sections.isEmpty ||
                          sections.any((s) => s['videoPath']!.isEmpty)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Please attach a video for all sections')),
                        );
                        return;
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PricePage(
                            courseName: widget.courseName,
                            description: widget.description,
                            category: widget.category,
                            subCategory: widget.subCategory,
                            sections: sections,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 13,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
