import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_tutuor/core/utils/constants.dart';
import 'package:growmind_tutuor/features/bottom_navigation/presentation/pages/bottom_navigation.dart';
import 'package:growmind_tutuor/features/home/domain/entities/fetch_course_model.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/create_course_bloc/create_course_bloc.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/create_course_bloc/create_course_event.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/create_course_bloc/create_course_state.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/update_section_course_bloc/bloc/update_section_bloc.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/update_section_course_bloc/bloc/update_section_event.dart';
import 'package:growmind_tutuor/features/home/presentation/widgets/video_player_widget.dart';

class UpdateCourse extends StatelessWidget {
  final CourseEntity course;
  final TextEditingController selectedSubCatController;
  final TextEditingController courseDiscriptionConrtoller;
  final TextEditingController courseNameconroller;
  final ValueNotifier<List<TextEditingController>> sectionDescriptionController;
  final ValueNotifier<List<TextEditingController>> sectionNameController;
  final ValueNotifier<List<TextEditingController>> sectionVideoController;
  
  // Add ValueNotifiers for upload progress tracking
  final ValueNotifier<List<double>> uploadProgress;
  final ValueNotifier<List<bool>> isUploading;
  // Add ValueNotifier for video preview files
  final ValueNotifier<List<File?>> videoPreviewFiles;

  UpdateCourse({super.key, required this.course})
      : selectedSubCatController =
            TextEditingController(text: course.subCategory ?? ''),
        courseDiscriptionConrtoller =
            TextEditingController(text: course.courseDescription ?? ''),
        courseNameconroller = TextEditingController(text: course.courseName ?? ''),
        sectionDescriptionController = ValueNotifier<List<TextEditingController>>(
            course.sections.isNotEmpty
                ? course.sections.map((section) => 
                      TextEditingController(text: section.sectionDescription ?? '')
                  ).toList()
                : []),
        sectionNameController = ValueNotifier<List<TextEditingController>>(
            course.sections.isNotEmpty
                ? course.sections.map((section) => 
                      TextEditingController(text: section.sectionName ?? '')
                  ).toList()
                : []),
        sectionVideoController = ValueNotifier<List<TextEditingController>>(
            course.sections.isNotEmpty
                ? course.sections.map((section) => 
                      TextEditingController(text: section.videoUrl ?? '')
                  ).toList()
                : []),
        uploadProgress = ValueNotifier<List<double>>(
            course.sections.isNotEmpty
                ? List.generate(course.sections.length, (_) => 0.0)
                : []),
        isUploading = ValueNotifier<List<bool>>(
            course.sections.isNotEmpty
                ? List.generate(course.sections.length, (_) => false)
                : []),
        videoPreviewFiles = ValueNotifier<List<File?>>(
            course.sections.isNotEmpty
                ? List.generate(course.sections.length, (_) => null)
                : []);
  Future<void> simulateVideoUpload(File videoFile, int index, BuildContext context) async {
    final fileSize = await videoFile.length();
    int uploadedBytes = 0;
    videoPreviewFiles.value[index] = videoFile;
    videoPreviewFiles.notifyListeners();
    
 
    final stepSize = fileSize ~/ 100;
    final stepDelay = Duration(milliseconds: 50);
    
    while (uploadedBytes < fileSize) {
      await Future.delayed(stepDelay);
      uploadedBytes += stepSize;
      if (uploadedBytes > fileSize) uploadedBytes = fileSize;
      
      final progress = uploadedBytes / fileSize;
      uploadProgress.value[index] = progress;
      uploadProgress.notifyListeners();
    }
    
   
    await Future.delayed(const Duration(seconds: 1));

    sectionVideoController.value[index].text = videoFile.path;
    sectionVideoController.notifyListeners();
    

    context.read<UpdateSectionBloc>().add(UpdateVideoEvent(
        sectionIndex: index,
        videoPath: videoFile.path
    ));
    

    isUploading.value[index] = false;
    isUploading.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    context.read<UpdateSectionBloc>();
    return Scaffold(
      backgroundColor: textColor,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text(
          'Update Course',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: textColor,
              ),
        ),
        iconTheme: const IconThemeData(color: textColor),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              kheight1,
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 3),
                      color: greyColor,
                      spreadRadius: 0,
                      blurRadius: 3,
                    )
                  ],
                  color: textColor,
                ),
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 3),
                            color: greyColor,
                            spreadRadius: 0,
                            blurRadius: 3,
                          )
                        ],
                      ),
                      child: Image.network(course.imageUrl, fit: BoxFit.fill),
                    ),
                    Column(
                      children: [
                        kheight1,
                        Text(
                          course.subCategory,
                          style: const TextStyle(
                              color: greyColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 17),
                        ),
                        kheight1,
                        Text(
                          course.courseName,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              overflow: TextOverflow.ellipsis),
                        ),
                        kheight1,
                      ],
                    ),
                  ],
                ),
              ),          
              kheight,
            
              kheight,
              Container(
                height: 325,
                width: 350,
                decoration: const BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 3),
                          color: greyColor,
                          spreadRadius: 0,
                          blurRadius: 3)
                    ]),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Course Name',
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: textColor),
                          )),
                       
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: textColor,
                            ),
                          child: TextFormField(
                            controller: courseNameconroller,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter the course name';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              suffixIcon: Padding(padding: EdgeInsets.only(right: 10, top: 15), child: Text('🖋️')),
                              hintText: 'Course Name',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10),
                            ),
                          ),
                        ),
                        kheight,
                        const Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Course Description',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 16, color: textColor),
                            )),
                        Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: textColor,
                            ),
                          child: TextFormField(
                            controller: courseDiscriptionConrtoller,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please provide a brief description';
                              }
                              return null;
                            },
                            maxLines: 10,
                            decoration: const InputDecoration(
                             suffixIcon: Padding(padding: EdgeInsets.only(right: 10, top: 15), child: Text('🖋️')),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10),
                            ),
                            keyboardType: TextInputType.multiline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              kheight1,

              kheight1,
              const Center(child: Text('Sections', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17))),
              BlocListener<CreateCourseBloc, CreateCourseState>(
                listener: (context, state) {
                  if (state is DeleteSectionSucess) {
                    int index = course.sections
                        .indexWhere((s) => s.id == state.sectionId);
                    if (index != -1) {
                      course.sections.removeAt(index);
                      sectionNameController.value.removeAt(index);
                      sectionDescriptionController.value.removeAt(index);
                      sectionVideoController.value.removeAt(index);
                      uploadProgress.value.removeAt(index);
                      isUploading.value.removeAt(index);
                      videoPreviewFiles.value.removeAt(index);

                      sectionNameController.notifyListeners();
                      sectionDescriptionController.notifyListeners();
                      sectionVideoController.notifyListeners();
                      uploadProgress.notifyListeners();
                      isUploading.notifyListeners();
                      videoPreviewFiles.notifyListeners();
                    }
                  }
                },
                child: ValueListenableBuilder(
                  valueListenable: sectionVideoController,
                  builder: (context, videoController, _) {
                    return ValueListenableBuilder(
                      valueListenable: uploadProgress,
                      builder: (context, progressValues, _) {
                        return ValueListenableBuilder(
                          valueListenable: isUploading,
                          builder: (context, uploadingValues, _) {
                            return ValueListenableBuilder(
                              valueListenable: videoPreviewFiles,
                              builder: (context, previewFiles, _) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: course.sections.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                                      elevation: 4,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: ExpansionTile(
                                        title: Text(
                                          sectionNameController.value[index].text,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // Section Name Field
                                                const Text(
                                                  'Section Name', 
                                                  style: TextStyle(
                                                    color: mainColor,
                                                    fontWeight: FontWeight.w500,
                                                  )
                                                ),
                                                const SizedBox(height: 8),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: textColor,
                                                    borderRadius: BorderRadius.circular(10),
                                                    border: Border.all(color: Colors.grey.shade300),
                                                  ),
                                                  child: TextFormField(
                                                    decoration: const InputDecoration(
                                                      suffixIcon: Padding(
                                                        padding: EdgeInsets.only(right: 10, top: 15),
                                                        child: Text('🖋️'),
                                                      ),
                                                      border: InputBorder.none,
                                                      contentPadding: EdgeInsets.all(12),
                                                    ),
                                                    controller: sectionNameController.value[index],
                                                  ),
                                                ),
                                                
                                                const SizedBox(height: 16),
                                                
                                                // Section Description Field
                                                const Text(
                                                  'Section Description', 
                                                  style: TextStyle(
                                                    color: mainColor,
                                                    fontWeight: FontWeight.w500,
                                                  )
                                                ),
                                                const SizedBox(height: 8),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: textColor,
                                                    borderRadius: BorderRadius.circular(10),
                                                    border: Border.all(color: Colors.grey.shade300),
                                                  ),
                                                  child: TextFormField(
                                                    maxLines: 3,
                                                    decoration: const InputDecoration(
                                                      suffixIcon: Padding(
                                                        padding: EdgeInsets.only(right: 10, top: 15),
                                                        child: Text('🖋️'),
                                                      ),
                                                      border: InputBorder.none,
                                                      contentPadding: EdgeInsets.all(12),
                                                    ),
                                                    controller: sectionDescriptionController.value[index],
                                                  ),
                                                ),
                                                
                                                const SizedBox(height: 20),
                                                
                                                // Video Section
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    const Text(
                                                      'Video',
                                                      style: TextStyle(
                                                        color: mainColor,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    
                                                    // Video upload button
                                                    ElevatedButton.icon(
                                                      onPressed: uploadingValues[index] 
                                                          ? null 
                                                          : () async {
                                                              FilePickerResult? result = await FilePicker.platform.pickFiles(
                                                                type: FileType.video
                                                              );
                                                              
                                                              if (result != null && result.files.single.path != null) {
                                                                String pickedVideoPath = result.files.single.path!;
                                                                File videoFile = File(pickedVideoPath);
                                                                
                                                                // Set uploading state to true
                                                                isUploading.value[index] = true;
                                                                isUploading.notifyListeners();
                                                                
                                                                // Reset progress
                                                                uploadProgress.value[index] = 0.0;
                                                                uploadProgress.notifyListeners();
                                                                
                                                                // Start simulated upload
                                                                simulateVideoUpload(videoFile, index, context);
                                                              }
                                                            },
                                                      icon: const Icon(Icons.upload_file, size: 16),
                                                      label: const Text('Upload New'),
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: mainColor,
                                                        foregroundColor: textColor,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                
                                                const SizedBox(height: 12),
                                                
                                                // Upload progress indicator
                                                if (uploadingValues[index])
                                                  Container(
                                                    padding: const EdgeInsets.all(12),
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue.withOpacity(0.1),
                                                      borderRadius: BorderRadius.circular(8),
                                                      border: Border.all(color: Colors.blue.shade200),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Icon(
                                                              Icons.cloud_upload,
                                                              color: Colors.blue,
                                                              size: 18,
                                                            ),
                                                            const SizedBox(width: 8),
                                                            Text(
                                                              'Uploading video... ${(progressValues[index] * 100).toInt()}%',
                                                              style: const TextStyle(
                                                                color: Colors.blue,
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(height: 8),
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.circular(4),
                                                          child: LinearProgressIndicator(
                                                            value: progressValues[index],
                                                            backgroundColor: Colors.grey[300],
                                                            valueColor: const AlwaysStoppedAnimation<Color>(
                                                              Colors.blue,
                                                            ),
                                                            minHeight: 6,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                
                                                const SizedBox(height: 16),
                                                
                                                // Video player
                                                Container(
                                                  height: 180,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[900],
                                                    borderRadius: BorderRadius.circular(12),
                                                    border: Border.all(color: Colors.grey.shade800),
                                                  ),
                                                  clipBehavior: Clip.antiAlias,
                                                  child: previewFiles[index] != null
                                                      ? _buildNewVideoPreview(previewFiles[index]!)
                                                      : VideoPlayerWidget(videoUrl: videoController[index].text),
                                                ),
                                                
                                                const SizedBox(height: 16),
                                                
                                            
                                                Align(
                                                  alignment: Alignment.centerRight,
                                                  child: ElevatedButton.icon(
                                                    onPressed: uploadingValues[index]
                                                        ? null
                                                        : () {
                                                            context.read<CreateCourseBloc>().add(
                                                              DeleteSectionEvent(
                                                                courseId: course.id,
                                                                sectionId: course.sections[index].id
                                                              )
                                                            );
                                                          },
                                                    icon: const Icon(Icons.delete_outline, size: 18),
                                                    label: const Text('Remove Section'),
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: Colors.red[700],
                                                      foregroundColor: Colors.white,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(8),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Save button
              Align(
                alignment: Alignment.center,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    foregroundColor: textColor,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 2,
                  ),
                  onPressed: () {
                    // Check if any uploads are still in progress
                    bool anyUploadsInProgress = isUploading.value.contains(true);
                    if (anyUploadsInProgress) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please wait for all uploads to complete'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      return;
                    }
                    
                    context.read<CreateCourseBloc>().add(UpdateCourseEvent(
                      courseId: course.id,
                      courseName: courseNameconroller.text,
                      courseDescription: courseDiscriptionConrtoller.text,
                      category: course.category,
                      subCategory: selectedSubCatController.text,
                      coursePrice: course.coursePrice,
                      sections: List.generate(
                        course.sections.length,
                        (index) => {
                          "id": course.sections[index].id,
                          "sectionName": sectionNameController.value[index].text,
                          "sectionDescription": sectionDescriptionController.value[index].text,
                          "videoUrl": sectionVideoController.value[index].text,
                        }
                      ),
                    ));
                    
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const BottomNavigation()),
                      (Route<dynamic> route) => false
                    );
                  },
                  icon: const Icon(Icons.save),
                  label: const Text(
                    'Save Course Details',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
  

  Widget _buildNewVideoPreview(File videoFile) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Video thumbnail/placeholder
        Center(
          child: Icon(
            Icons.play_circle_filled,
            size: 60,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
        
        
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black.withOpacity(0.7), Colors.transparent],
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.video_file_outlined,
                  color: Colors.white70,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    videoFile.path.split('/').last,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Text(
                  'New Video',
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}