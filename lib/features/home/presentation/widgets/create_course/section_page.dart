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
  final List<Map<String, dynamic>> sections = [];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final List<VideoPlayerController?> videoController = [];
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  
  // Add upload progress tracking
  final List<double> uploadProgress = [];
  final List<bool> isUploading = [];

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
        uploadProgress.add(0.0);
        isUploading.add(false);
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
    // Reset progress and set uploading state
    setState(() {
      uploadProgress[index] = 0.0;
      isUploading[index] = true;
    });
    
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null && result.files.isNotEmpty) {
      final videoPath = result.files.single.path ?? '';
      final videoFile = File(videoPath);
      
      // Simulate upload process with progress updates
      // In a real app, this would be an actual upload to a server
      simulateVideoUpload(videoFile, index).then((_) {
        // Initialize video player after upload completes
        final controller = VideoPlayerController.file(videoFile)
          ..initialize().then((_) {
            setState(() {
              sections[index]['videoPath'] = videoPath;
              isUploading[index] = false;
            });
          });
        
        videoController[index] = controller;
        setState(() {
          sections[index]['videoPath'] = videoPath;
        });
      });
    } else {
      setState(() {
        isUploading[index] = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No video selected')),
      );
    }
  }
  
  // Method to simulate video upload with progress
  Future<void> simulateVideoUpload(File videoFile, int index) async {
    final fileSize = await videoFile.length();
    int uploadedBytes = 0;
    
    // Calculate how many steps we'll need for a smooth animation
    final stepSize = fileSize ~/ 100;
    final stepDelay = Duration(milliseconds: 50);
    
    while (uploadedBytes < fileSize) {
      await Future.delayed(stepDelay);
      uploadedBytes += stepSize;
      if (uploadedBytes > fileSize) uploadedBytes = fileSize;
      
      final progress = uploadedBytes / fileSize;
      setState(() {
        uploadProgress[index] = progress;
        
        // Also update sections map to include progress for persistence
        sections[index]['uploadProgress'] = progress;
      });
    }
    
    // Simulate some processing time after upload completes
    await Future.delayed(const Duration(seconds: 1));
  }

  void removeSection(int index) {
    setState(() {
      sections.removeAt(index);
      videoController[index]?.dispose();
      videoController.removeAt(index);
      uploadProgress.removeAt(index);
      isUploading.removeAt(index);
    });
  }

  void removeVedio(int index) {
    setState(() {
      sections[index]['videoPath'] = '';
      videoController[index]?.dispose();
      videoController[index] = null;
      uploadProgress[index] = 0.0;
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
                    final progress = uploadProgress[index];
                    final uploading = isUploading[index];
                    
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
                              // Video upload progress indicator
                              if (uploading)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.cloud_upload,
                                          color: Colors.blue,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'Uploading video... ${(progress * 100).toInt()}%',
                                          style: const TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    LinearProgressIndicator(
                                      value: progress,
                                      backgroundColor: Colors.grey[300],
                                      valueColor: const AlwaysStoppedAnimation<Color>(
                                        Colors.blue,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                ),
                              Row(
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                    ),
                                    onPressed: uploading ? null : () => pickVideo(index),
                                    child: Text(
                                      section['videoPath']!.isEmpty 
                                          ? 'Attach Video' 
                                          : 'Replace Video',
                                      style: const TextStyle(color: textColor),
                                    ),
                                  ),
                                  kwidth,
                                  if (section['videoPath']!.isNotEmpty)
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                      ),
                                      onPressed: uploading ? null : () => removeVedio(index),
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
                      // Check if any uploads are still in progress
                      if (isUploading.contains(true)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Please wait for all uploads to complete')),
                        );
                        return;
                      }
                      
                      if (sections.isEmpty ||
                          sections.any((s) => s['videoPath']!.isEmpty)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Please attach a video for all sections')),
                        );
                        return;
                      }

                    // Replace the Navigator.push code with this:
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) {
      // Convert sections to List<Map<String, String>> by removing non-string values
      final List<Map<String, String>> formattedSections = sections.map((section) {
        return {
          'sectionName': section['sectionName'] as String,
          'sectionDescription': section['sectionDescription'] as String,
          'videoPath': section['videoPath'] as String,
        };
      }).toList();
      
      return PricePage(
        courseName: widget.courseName,
        description: widget.description,
        category: widget.category,
        subCategory: widget.subCategory,
        sections: formattedSections,
      );
    },
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