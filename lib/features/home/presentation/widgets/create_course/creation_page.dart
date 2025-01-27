import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_tutuor/core/utils/constants.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/fetch_category_bloc/bloc/fetch_category_bloc.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/fetch_category_bloc/bloc/fetch_category_event.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/fetch_category_bloc/bloc/fetch_category_state.dart';
import 'package:growmind_tutuor/features/home/presentation/widgets/create_course/section_page.dart';

class CreationPage extends StatelessWidget {
  final TextEditingController courseNameController = TextEditingController();
  final TextEditingController courseDescriptionController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  String? selectedCategoryId;
  String? selectedCategoryName;
  String? selectedSubCategory;

  @override
  Widget build(BuildContext context) {
    final fetchBloc = context.read<FetchCategoryBloc>();
    fetchBloc.add(GetCategoryEvent()); // Trigger fetching categories

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: mainColor,
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: textColor),
          title: const Text(
            'Create Course',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: textColor),
          ),
          centerTitle: true,
        ),
      ),
      backgroundColor: textColor,
      body: BlocListener<FetchCategoryBloc, FetchCategoryState>(
        listener: (context, state) {
          if (state is FetchCategoryError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const Text(
                    'STEP -1',
                    style: TextStyle(
                        color: mainColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset('assets/logo/product.png'),
                  ),
                  kheight1,
                  Container(
                    width: 400,
                    height: 350,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: textColor,
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 1,
                            blurRadius: 5,
                            color: greyColor,
                            offset: Offset(0, 3),
                          )
                        ]),
                    child: Column(
                      children: [
                        const Text(
                          'Course Name',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        kheight,
                        Container(
                          height: 50,
                          width: 330,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: textColor,
                              boxShadow: [
                                BoxShadow(
                                    color: mainColor,
                                    spreadRadius: 0,
                                    blurRadius: 3,
                                    offset: Offset(0, 3))
                              ]),
                          child: TextFormField(
                            controller: courseNameController,
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
                        const Text(
                          'Description',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 200,
                          width: 330,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: textColor,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 3),
                                  color: mainColor,
                                  spreadRadius: 0,
                                  blurRadius: 3,
                                )
                              ]),
                          child: TextFormField(
                            controller: courseDescriptionController,
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
                  kheight1,
                  const Text(
                    'Select your course type',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  kheight,
                  BlocBuilder<FetchCategoryBloc, FetchCategoryState>(
                      builder: (context, state) {
                    if (state is FetchCategoryLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is FetchCategoryLoaded) {
                      return Container(
                        height: 50,
                        width: 250,
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 3),
                                color: greyColor,
                                spreadRadius: 0,
                                blurRadius: 3)
                          ],
                          color: Color.fromARGB(255, 239, 239, 239),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: DropdownButton<String>(
                            value: selectedCategoryId,
                            hint: const Text('Select a Category'),
                            items: state.categories
                                .map((category) => DropdownMenuItem(
                                      value: category.id,
                                      child: Text(category.name),
                                    ))
                                .toList(),
                            onChanged: (String? id) {
                              selectedCategoryId = id;
                              selectedCategoryName = state.categories
                                  .firstWhere((cat) => cat.id == id)
                                  .name;
                              context
                                  .read<FetchCategoryBloc>()
                                  .add(GetSubCategoryEvent(categoryId: id!));
                            },
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  }),
             
                  BlocBuilder<FetchCategoryBloc, FetchCategoryState>(
                      builder: (context, state) {
                    if (state is FetchSubCategoryLoaded) {
                      return Container(
                        height: 50,
                        width: 250,
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 3),
                                color: greyColor,
                                spreadRadius: 0,
                                blurRadius: 3)
                          ],
                          color: Color.fromARGB(255, 239, 239, 239),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: DropdownButton<String>(
                            value: selectedSubCategory,
                            hint: Text(
                                selectedSubCategory ?? 'Select a SubCategory'),
                            items: state.subcategories
                                .map((subcategory) => DropdownMenuItem(
                                      value: subcategory.name,
                                      child: Text(subcategory.name),
                                    ))
                                .toList(),
                            onChanged: (String? value) {
                              context
                                  .read<FetchCategoryBloc>()
                                  .add(UpdateSelectedSubCategoryEvent(value!));
                              selectedSubCategory = value;
                            },
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  }),
                  kheight,
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: mainColor),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SectionPage(
                                courseName: courseNameController.text,
                                description: courseDescriptionController.text,
                                category: selectedCategoryName ?? '',
                                subCategory: selectedSubCategory ?? '',
                              ),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
