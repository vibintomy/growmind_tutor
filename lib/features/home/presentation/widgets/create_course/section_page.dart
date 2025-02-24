import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:growmind_tutuor/core/utils/constants.dart';
import 'package:growmind_tutuor/core/utils/validator.dart';
import 'package:growmind_tutuor/features/home/presentation/widgets/create_course/price_page.dart';
import 'package:video_player/video_player.dart';

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
  final List<Map<String, String>> sections = [];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final List<VideoPlayerController?> videoController = [];
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  @override
  void dispose() {
    for (var controller in videoController) {
      controller?.dispose();
    }
    super.dispose();
  }

  void addSection() {
    if (nameController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty) {
      setState(() {
        sections.add({
          'sectionName': nameController.text,
          'sectionDescription': descriptionController.text,
          'videoPath': '', // Placeholder for the attached video path
        });
        videoController.add(null);
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
    isLoading.value = true;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null && result.files.isNotEmpty) {
      final videoPath = result.files.single.path ?? '';
      final controller = VideoPlayerController.file(File(videoPath))
        ..initialize().then((_) {
          setState(() {
            sections[index]['vedioPath'] = videoPath;
            isLoading.value = false;
          });
        });
      videoController[index] = controller;
      setState(() {
        sections[index]['videoPath'] = result.files.single.path ?? '';
      });
    } else {
      isLoading.value = false;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No video selected')),
      );
    }
  }

  void removeSection(int index) {
    setState(() {
      sections.removeAt(index);
      videoController[index]?.dispose();
      videoController.removeAt(index);
    });
  }

  void removeVedio(int index) {
    setState(() {
      sections[index]['videoPath'] = '';
      videoController[index]?.dispose();
      videoController[index] = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          backgroundColor: mainColor,
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: textColor),
          title: const Text(
            'Section Details',
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
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Text(
                  'STEP -2',
                  style: TextStyle(
                      color: mainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                SizedBox(
                  height: 100,
                  width: 150,
                  child: Image.asset('assets/logo/chapter (1).png'),
                ),
                kheight,
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: sections.length,
                  itemBuilder: (context, index) {
                    final section = sections[index];
                    final controller = videoController[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: textColor,
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(0, 3),
                                  spreadRadius: 0,
                                  blurRadius: 3,
                                  color: mainColor)
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Section ${index + 1}: ${section['sectionName']}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                    onPressed: () => removeSection(index),
                                    icon: const Icon(Icons.delete),
                                  )
                                ],
                              ),
                              kheight,
                              Text(
                                  'Description: ${section['sectionDescription']}'),
                              kheight,
                              if (controller != null &&
                                  controller.value.isInitialized)
                                AspectRatio(
                                  aspectRatio: controller.value.aspectRatio,
                                  child: SizedBox(
                                      height: 200,
                                      width: 300,
                                      child: VideoPlayer(controller)),
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
                                      onPressed: () => removeVedio(index),
                                      child: const Text(
                                        'Remove Video',
                                        style: TextStyle(color: textColor),
                                      ),
                                    ),
                                ],
                              ),
                              kheight,
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
                      color: textColor,
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 3),
                          color: greyColor,
                          spreadRadius: 1,
                          blurRadius: 3,
                        )
                      ]),
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
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 249, 179, 27)))),
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
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 249, 179, 27)))),
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
