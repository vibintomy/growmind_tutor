
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
                : []);

  @override
  Widget build(BuildContext context) {
    context.read<UpdateSectionBloc>();
    return Scaffold(
      backgroundColor: textColor,
      appBar: AppBar(
        // iconTheme: const IconThemeData(color: textColor),
        backgroundColor: mainColor,
        title: const Text(
          'Update Course',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold,color: textColor,
              ),
        ),
        iconTheme: IconThemeData(color: textColor),
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
                      decoration:const BoxDecoration(
                          boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 3),
                      color: greyColor,
                      spreadRadius: 0,
                      blurRadius: 3,
                    )
                  ],
                      ),
                      child: Image.network(course.imageUrl,fit: BoxFit.fill,),
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
              // ElevatedButton(
              //     onPressed: () {
              //       context
              //           .read<CreateCourseBloc>()
              //           .add(DeleteCourseEvent(courseId: course.id));

              //     },
              //     child: const Text('Delete the course')),
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
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16,color: textColor),
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
                              suffixIcon: Padding(padding: EdgeInsets.only(right: 10,top: 15),child: Text('🖋️'),),
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
                                  fontWeight: FontWeight.w700, fontSize: 16,color: textColor),
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
                             suffixIcon: Padding(padding: EdgeInsets.only(right: 10,top: 15),child: Text('🖋️'),),
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
             const Center(child: Text('Sections',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),)),
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
                child: ValueListenableBuilder(
                  valueListenable: sectionVideoController,
                  builder: (context, videoController, _) {
                    return SingleChildScrollView(
                      child: Column(
                          children:
                              List.generate(course.sections.length, (index) {
                        return ExpansionTile(
                          title: Text(sectionNameController.value[index].text,style:const TextStyle(fontWeight: FontWeight.w600),),
                          children: [
                            Card(
                            child: SizedBox(
                              height: 370,
                              width: MediaQuery.of(context).size.width,
                               child: Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Column(
                                  children: [
                               const     Text('Section Name',style: TextStyle(color: mainColor),),
                                    TextFormField(
                                      
                                      decoration:const InputDecoration(
                                        suffixIcon: Padding(padding: EdgeInsets.only(right: 10,top: 15),child: Text('🖋️'),),
                                    fillColor: textColor,
                                    filled: true,
                                        border: InputBorder.none
                                      ),
                                      controller: sectionNameController.value[index],
                                    ),
                                 const      Text('Section Description',style: TextStyle(color: mainColor),),
                                      TextFormField(
                                        decoration:const InputDecoration(
                                            suffixIcon: Padding(padding: EdgeInsets.only(right: 10,top: 15),child: Text('🖋️'),),
                                          fillColor: textColor,
                                          filled: true,
                                          border: InputBorder.none
                                        ),
                                      controller: sectionDescriptionController.value[index],
                                    ),
                                                               const    Text('Vedio'),
                                    SizedBox(
                                      height: 150,
                                      width: 300,
                                      child:VideoPlayerWidget(videoUrl: videoController[index].text) ,
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
                                                              type: FileType.video);
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
                                                child:const Text('🖋️',style: TextStyle(fontSize: 15),)),
                                                
                                            ElevatedButton(
                                                onPressed: () {
                                                  context
                                                      .read<CreateCourseBloc>()
                                                      .add(DeleteSectionEvent(
                                                          courseId: course.id,
                                                          sectionId: course
                                                              .sections[index].id));
                                                },
                                                 child:const Text('🗑️')),
                                          ],
                                        )
                                  ],
                                 ),
                               ),
                            ),
                          ),
                          ],
                        );
                      })),
                    );
                  },
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
                                    "id": course.sections[index].id,
                                    "sectionName":
                                        sectionNameController.value[index].text,
                                    "sectionDescription":
                                        sectionDescriptionController
                                            .value[index].text,
                                    "videoUrl": sectionVideoController
                                        .value[index].text,
                                  }),
                        ));
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BottomNavigation()),
                        (Route<dynamic> route) => false);
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

 // child: ExpansionTile(
                            //   tilePadding:
                            //       const EdgeInsets.symmetric(horizontal: 10),
                            //   collapsedBackgroundColor: textColor,
                            //   backgroundColor: greyColor,
                            //   title: Text(course.sections[index].sectionName),
                            //   leading:
                            //       const Icon(Icons.book, color: Colors.blue),
                            //   trailing: const Icon(Icons.arrow_drop_down,
                            //       color: Colors.black),
                            //   children: [
                            //     Column(
                            //       children: [
                            //         TextFormField(
                            //           controller: sectionDescriptionController
                            //               .value[index],
                            //           decoration: const InputDecoration(
                            //               labelText: "Section Description"),
                            //         ),
                            //         const SizedBox(height: 10),
                            //         const Text('Section Video'),
                            //         const SizedBox(height: 10),
                            //         Container(
                            //           height: 200,
                            //           width: MediaQuery.of(context).size.width,
                            //           decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(10),
                            //             boxShadow: const [
                            //               BoxShadow(
                            //                 color: greyColor,
                            //                 blurRadius: 5,
                            //               )
                            //             ],
                            //           ),
                            //           child: VideoPlayerWidget(
                            //               videoUrl:
                            //                   videoController[index].text),
                            //         ),
                            //         Row(
                            //           mainAxisAlignment:
                            //               MainAxisAlignment.spaceEvenly,
                            //           children: [
                            //             ElevatedButton(
                            //                 onPressed: () async {
                            //                   FilePickerResult? result =
                            //                       await FilePicker.platform
                            //                           .pickFiles(
                            //                               type: FileType.video);
                            //                   if (result != null &&
                            //                       result.files.single.path !=
                            //                           null) {
                            //                     String pickedVedioPath =
                            //                         result.files.single.path!;
                            //                     sectionVideoController
                            //                         .value[index]
                            //                         .text = pickedVedioPath;
                            //                     context
                            //                         .read<UpdateSectionBloc>()
                            //                         .add(UpdateVideoEvent(
                            //                             sectionIndex: index,
                            //                             videoPath:
                            //                                 pickedVedioPath));
                            //                   }
                            //                 },
                            //                 child: const Text('Update Vedio')),
                            //             ElevatedButton(
                            //                 onPressed: () {
                            //                   context
                            //                       .read<CreateCourseBloc>()
                            //                       .add(DeleteSectionEvent(
                            //                           courseId: course.id,
                            //                           sectionId: course
                            //                               .sections[index].id));
                            //                 },
                            //                 child: const Text('Delete Section'))
                            //           ],
                            //         )
                            //       ],
                            //     )
                            //   ],
                            // ),