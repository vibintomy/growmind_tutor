import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:growmind_tutuor/core/utils/constants.dart';
import 'package:growmind_tutuor/features/home/presentation/widgets/create_course/section_page.dart';

class CreationPage extends StatefulWidget {
  const CreationPage({Key? key}) : super(key: key);

  @override
  State<CreationPage> createState() => _CreationPageState();
}

class _CreationPageState extends State<CreationPage> {
  String? selectedCategory;
  String? selectedCategoryId;
  List<Map<String, String>> categories = [];
  bool isLoadingCategories = true;

  String? selectedSubcategory;
  List<String> subcategories = [];
  bool isLoadingSubcategories = false;

  final TextEditingController courseNameController = TextEditingController();
  final TextEditingController courseDescriptionController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('category').get();
      List<Map<String, String>> fetchedCategories = snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'name': doc['category'].toString(),
        };
      }).toList();

      setState(() {
        categories = fetchedCategories;
        isLoadingCategories = false;
      });
    } catch (e) {
      print('Error fetching categories: $e');
      setState(() {
        isLoadingCategories = false;
      });
    }
  }

  Future<void> fetchSubcategories(String categoryId) async {
    setState(() {
      isLoadingSubcategories = true;
      subcategories = [];
      selectedSubcategory = null;
    });

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('category')
          .doc(categoryId)
          .collection('subcategory')
          .get();

      List<String> fetchedSubcategories = snapshot.docs
          .map((doc) => doc['name'].toString())
          .toList();

      setState(() {
        subcategories = fetchedSubcategories;
        isLoadingSubcategories = false;
      });
    } catch (e) {
      print('Error fetching subcategories: $e');
      setState(() {
        isLoadingSubcategories = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
        backgroundColor: textColor,
        automaticallyImplyLeading: true,

        title:const Text('Create Course',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      backgroundColor: textColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                kheight1,
                Container(
                  width: 400,
                  height: 400,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Color.fromARGB(255, 254, 201, 183),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Course Name',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: 50,
                        width: 330,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: textColor,
                        ),
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
                        height: 250,
                        width: 330,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: textColor,
                        ),
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
                isLoadingCategories
                    ? const CircularProgressIndicator()
                    : DropdownButton<String>(
                        value: selectedCategory,
                        hint: const Text('Select a Category'),
                        items: categories.map((category) {
                          return DropdownMenuItem<String>(
                            value: category['id'],
                            child: Text(category['name'] ?? 'Unknown'),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCategory = newValue;
                            selectedCategoryId = newValue;
                          });
                          fetchSubcategories(newValue!);
                        },
                      ),
                kheight1,
                isLoadingSubcategories
                    ? const CircularProgressIndicator()
                    : DropdownButton<String>(
                        value: selectedSubcategory,
                        hint: const Text('Select a Subcategory'),
                        items: subcategories.map((String subcategory) {
                          return DropdownMenuItem<String>(
                            value: subcategory,
                            child: Text(subcategory),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedSubcategory = newValue;
                          });
                        },
                      ),
                kheight2,
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: mainColor),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SectionPage(
                              courseName: courseNameController.text,
                              description: courseDescriptionController.text,
                              category: selectedCategory ?? '',
                              subCategory: selectedSubcategory ?? '',
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
    );
  }
}
