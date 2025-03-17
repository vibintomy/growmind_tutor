import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_tutuor/core/utils/constants.dart';
import 'package:growmind_tutuor/core/utils/validator.dart';

import 'package:growmind_tutuor/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:growmind_tutuor/features/profile/presentation/bloc/profile_state.dart';
import 'package:growmind_tutuor/features/profile/presentation/bloc/profile_update_bloc/bloc/profile_update_bloc.dart';
import 'package:growmind_tutuor/features/profile/presentation/bloc/profile_update_bloc/bloc/profile_update_event.dart';
import 'package:growmind_tutuor/features/profile/presentation/bloc/profile_update_bloc/bloc/profile_update_state.dart';
import 'package:image_picker/image_picker.dart';

class UpdatePage extends StatelessWidget {
  UpdatePage({super.key});

  final ValueNotifier<File?> selectedImageNotifier = ValueNotifier<File?>(null);
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImageNotifier.value = File(pickedFile.path);
    }
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          iconTheme: const IconThemeData(color: textColor),
          title: const Text(
            'Update Profile',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: textColor),
          ),
          backgroundColor: mainColor,
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
      ),
      body: BlocListener<ProfileUpdateBloc, ProfileUpdateState>(
        listener: (context, state) {
          if (state is ProfileUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile Updated Sucessfully')));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 130,
                        height: 250,
                        decoration: const BoxDecoration(
                          color: mainColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      ValueListenableBuilder(
                          valueListenable: selectedImageNotifier,
                          builder: (context, selectedImage, child) {
                            return Container(
                                width: 120,
                                height: 120,
                                decoration: const BoxDecoration(
                                    color: greyColor, shape: BoxShape.circle),
                                child: ClipOval(
                                  child: selectedImage == null
                                      ? Image.asset('assets/logo/user.png')
                                      : Image.file(
                                          selectedImage,
                                          fit: BoxFit.cover,
                                        ),
                                ));
                          }),
                      Container(
                        height: 120,
                        width: 120,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.transparent),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Align(
                                alignment: Alignment.bottomRight,
                                child: GestureDetector(
                                  onTap: pickImage,
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: mainColor),
                                    child: const Icon(
                                      Icons.edit,
                                      color: textColor,
                                      size: 20,
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                  if (state is ProfileLoaded) {
                    nameController.text = state.profile.displayName;
                    phoneController.text = state.profile.phone;
                    final profile = state.profile;
                    return Column(
                      children: [
                        Text(
                          profile.email,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: mainColor),
                        ),
                        kheight1,
                        const Text(
                          'Name',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 17),
                        ),
                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.edit),
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(255, 215, 0, 1.0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent))),
                        ),
                        kheight1,
                        const Text(
                          'Phone ☎️',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 17),
                        ),
                        TextFormField(
                          controller: phoneController,
                          validator: validatePhone,
                          decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.edit),
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(255, 215, 0, 1.0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent))),
                        ),
                        kheight2,
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: mainColor),
                            onPressed: () {
                              context.read<ProfileUpdateBloc>().add(
                                  UploadImageEvent(
                                      selectedImageNotifier.value!));
                              context
                                  .read<ProfileUpdateBloc>()
                                  .stream
                                  .listen((state) {
                                    if(state is ProfileImageUpdate){
                                     // ignore: use_build_context_synchronously
                                     context.read<ProfileUpdateBloc>().add(
                                  AddDetailsEvent(
                                      id: profile.uid,
                                      name: nameController.text,
                                      number: phoneController.text,
                                      imageUrl: state.imageUrl));
                                    }
                                
                                  });
                             
                            },
                            child: const Text(
                              'Save Details',
                              style: TextStyle(color: textColor),
                            ))
                      ],
                    );
                  }
                  return const Center(
                    child: Text('no values'),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
