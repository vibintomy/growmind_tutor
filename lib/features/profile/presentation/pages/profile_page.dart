import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_tutuor/core/utils/constants.dart';
import 'package:growmind_tutuor/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:growmind_tutuor/features/profile/presentation/bloc/profile_event.dart';
import 'package:growmind_tutuor/features/profile/presentation/bloc/profile_state.dart';
import 'package:growmind_tutuor/features/profile/presentation/pages/update_page.dart';
import 'package:growmind_tutuor/features/profile/presentation/widgets/alert_box.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final profileBloc = context.read<ProfileBloc>();
    profileBloc.add(LoadProfileEvent(user!.uid ?? ''));
    if (user == null) {
      print('No user currently logged in');
    }
   
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(27),
        child: AppBar(backgroundColor: mainColor,title:  const Text(
              'Profile',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: textColor),
            ) ,
            centerTitle: true,
            automaticallyImplyLeading: false,
            ),
      ),
          
      backgroundColor: textColor,
       
      body: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProfileLoaded) {
          final profile = state.profile;

          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 340,
                    width: MediaQuery.of(context).size.width,
                    decoration:const BoxDecoration(
                      boxShadow: [BoxShadow(
                        offset: Offset(0, 3),
                        blurRadius: 3,
                        color: greyColor,
                        spreadRadius: 0
                      )],
                      color: mainColor,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30))
                    ),
                    child: Column(
                      children: [
                      
                        Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 250,
                          width: 130,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: textColor),
                        ),
                        Container(
                          height: 120,
                          width: 120,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey),
                             child: ClipOval(child:profile.imageUrl!=null && profile.imageUrl!.isNotEmpty ?Image.network(profile.imageUrl!,fit:BoxFit.cover)
                             :Image.asset('assets/logo/user.png'))
                        ),
                        
                      ],
                      
                    ),
                   
                  ),
            
                     Text(
                    profile.displayName,
                    style: const TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  kheight,
                  Text(
                    profile.email,
                    style: const TextStyle(color: textColor, fontSize: 15,fontWeight: FontWeight.w700),
                  ),
                 
                      ],
                    ),
                  ),
                  kheight1,
        const    Padding(
              padding: EdgeInsets.all(8.0),
              child:    Divider(color: greyColor,height: 2,),
            ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                           
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdatePage(
                                       
                                        )));
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.person,color: Colors.blueAccent,),
                              kwidth,
                              Text(
                                'Edit Profile',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Icon(Icons.arrow_right,color: mainColor,)
                            ],
                          ),
                        ),
                        kheight2,
                        const Row(
                          children: [
                            Icon(Icons.wallet,color: Color.fromARGB(255, 235, 211, 0),),
                            kwidth,
                            Text(
                              'My course',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Icon(Icons.arrow_right,color: mainColor,)
                          ],
                        ),
                        kheight2,
                        const Row(
                          children: [
                            Icon(Icons.notifications,color: greyColor,),
                            kwidth,
                            Text(
                              'Notifications',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Icon(Icons.arrow_right,color: mainColor,)
                          ],
                        ),
                        kheight2,
                        const Row(
                          children: [
                            Icon(Icons.security,color: Colors.green,),
                            kwidth,
                            Text(
                              'Terms & conditions',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Icon(Icons.arrow_right,color: mainColor,)
                          ],
                        ),
                        kheight2,
                        const Row(
                          children: [
                            Icon(Icons.help_center,color: Colors.purple,),
                            kwidth,
                            Text(
                              'Help Center',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Icon(Icons.arrow_right,color: mainColor,)
                          ],
                        ),
                        kheight2,
                        alertBox(context),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        } else if (state is ProfileError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const Center(
            child: Text('something went wrong. please check later'),
          );
        }
      }),
    );
  }
}
