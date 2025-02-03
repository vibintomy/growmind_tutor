import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_tutuor/core/utils/constants.dart';
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

  UpdateCourse({super.key, required this.course})
      : selectedSubCatController =
            TextEditingController(text: course.subCategory),
        courseDiscriptionConrtoller =
            TextEditingController(text: course.courseDescription),
        courseNameconroller = TextEditingController(text: course.courseName),
        sectionDescriptionController =
            ValueNotifier<List<TextEditingController>>(course.sections
                .map((section) =>
                    TextEditingController(text: section.sectionName))
                .toList()),
        sectionNameController = ValueNotifier<List<TextEditingController>>(
            course.sections
                .map((section) =>
                    TextEditingController(text: section.sectionDescription))
                .toList()),
        sectionVideoController = ValueNotifier<List<TextEditingController>>(
            course.sections
                .map((section) => TextEditingController(text: section.videoUrl))
                .toList());

  @override
  Widget build(BuildContext context) {
    context.read<UpdateSectionBloc>();
    return Scaffold(
      backgroundColor: textColor,
      appBar: AppBar(
        backgroundColor: textColor,
        title: const Text(
          'Update Course',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
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
                  children: [
                    SizedBox(
                      height: 180,
                      width: 180,
                      child: Image.network(course.imageUrl),
                    ),
                    Column(
                      children: [
                        kheight1,
                        Text(course.subCategory,style:const TextStyle(color: textColor1,fontWeight: FontWeight.bold,fontSize: 15),),
                        kheight1,
                       
                        Text(course.courseName,style:const TextStyle(fontSize: 17,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),),
                        kheight1,
                      ],
                    ),
                  ],
                ),
              ),
              // ElevatedButton(
              //     onPressed: () {
              //       context
              //           .read<CreateCourseBloc>()
              //           .add(DeleteCourseEvent(courseId: course.id));
                  
              //     },
              //     child: const Text('Delete the course')),
              kheight,
            const  Align(
                alignment: Alignment.center,
                child: Text('Course Name',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),)),
              kheight,
              SizedBox(
                height: 300,
                width: 350,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          height: 50,
                        width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: textColor,
                              boxShadow: [
                                BoxShadow(
                                    color: greyColor,
                                    spreadRadius: 0,
                                    blurRadius: 3,
                                    offset: Offset(0, 3))
                              ]),
                          child: TextFormField(
                            controller: courseNameconroller,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter the course name';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Course Name',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10),
                            ),
                          ),
                        ),
                        kheight,
                           
            const  Align(
                alignment: Alignment.center,
                child: Text('Course Description',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),)),
            
                      Container(
                          height: 200,
                        width: MediaQuery.of(context).size.width,   decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: textColor,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 3),
                                  color: greyColor,
                                  spreadRadius: 0,
                                  blurRadius: 3,
                                )
                              ]),
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
              
              const Divider(height: 2, color: greyColor),
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
          
                      sectionNameController.notifyListeners();
                      sectionDescriptionController.notifyListeners();
                      sectionVideoController.notifyListeners();
                    }
                  }
                },
                child: SizedBox(
                  height: 150,
                  child: ValueListenableBuilder(
                    valueListenable: sectionVideoController,
                    builder: (context, videoController, _) {
                      return ListView.builder(
                        itemCount: course.sections.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(vertical: 5.0),
                            child: ExpansionTile(
                              tilePadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              collapsedBackgroundColor: textColor,
                              backgroundColor: greyColor,
                              title: Text(course.sections[index].sectionName),
                              leading:
                                  const Icon(Icons.book, color: Colors.blue),
                              trailing: const Icon(Icons.arrow_drop_down,
                                  color: Colors.black),
                              children: [
                                Column(
                                  children: [
                                    TextFormField(
                                      controller: sectionDescriptionController
                                          .value[index],
                                      decoration: const InputDecoration(
                                          labelText: "Section Description"),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text('Section Video'),
                                    const SizedBox(height: 10),
                                    Container(
                                      height: 200,
                                      width:
                                          MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: greyColor,
                                            blurRadius: 5,
                                          )
                                        ],
                                      ),
                                      child: VideoPlayerWidget(
                                          videoUrl:
                                              videoController[index].text),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () async {
                                              FilePickerResult? result =
                                                  await FilePicker.platform
                                                      .pickFiles(
                                                          type:
                                                              FileType.video);
                                              if (result != null &&
                                                  result.files.single.path !=
                                                      null) {
                                                String pickedVedioPath =
                                                    result.files.single.path!;
                                                sectionVideoController
                                                    .value[index]
                                                    .text = pickedVedioPath;
                                                context
                                                    .read<UpdateSectionBloc>()
                                                    .add(UpdateVideoEvent(
                                                        sectionIndex: index,
                                                        videoPath:
                                                            pickedVedioPath));
                                              }
                                            },
                                            child:
                                                const Text('Update Vedio')),
                                        ElevatedButton(
                                            onPressed: () {
                                              context
                                                  .read<CreateCourseBloc>()
                                                  .add(DeleteSectionEvent(
                                                      courseId: course.id,
                                                      sectionId: course
                                                          .sections[index]
                                                          .id));
                                            },
                                            child:
                                                const Text('Delete Section'))
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: textColor,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    side: const BorderSide(color: mainColor, width: 2),
                  ),
                  onPressed: () {
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
                                    "id": course.sections[index]
                                        .id, // Ensure `id` is a String, if not convert it using `.toString()`
                                    "sectionName":
                                        sectionNameController.value[index].text,
                                    "sectionDescription":
                                        sectionDescriptionController
                                            .value[index].text,
                                    "videoUrl": sectionVideoController
                                        .value[index].text,
                                  }),
                        ));
                  },
                  child: const Text('Save Details',
                      style: TextStyle(color: mainColor)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
