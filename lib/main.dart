import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:growmind_tutuor/core/utils/service_locator.dart';
import 'package:growmind_tutuor/core/utils/constants.dart';
import 'package:growmind_tutuor/features/auth/domain/usecases/kyc_usecases.dart';
import 'package:growmind_tutuor/features/auth/presentation/bloc/kyc_bloc/kyc_bloc.dart';
import 'package:growmind_tutuor/features/auth/presentation/bloc/login_bloc/auth_bloc.dart';
import 'package:growmind_tutuor/features/auth/presentation/bloc/signup_bloc/signup_bloc.dart';
import 'package:growmind_tutuor/features/auth/presentation/pages/kyc_verification_page.dart';
import 'package:growmind_tutuor/features/auth/presentation/pages/login_page.dart';
import 'package:growmind_tutuor/features/auth/presentation/pages/splash_screen.dart';
import 'package:growmind_tutuor/features/bottom_navigation/presentation/pages/bottom_navigation.dart';
import 'package:growmind_tutuor/features/chat/domain/domain/usecases/get_TutorConversation.dart';
import 'package:growmind_tutuor/features/chat/domain/domain/usecases/get_message_students.dart';
import 'package:growmind_tutuor/features/chat/domain/domain/usecases/get_send_message.dart';
import 'package:growmind_tutuor/features/chat/domain/domain/usecases/get_student_info.dart';
import 'package:growmind_tutuor/features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:growmind_tutuor/features/chat/presentation/bloc/conversation_bloc/conversation_bloc.dart';
import 'package:growmind_tutuor/features/home/domain/usecases/fetch_category_usecases.dart';
import 'package:growmind_tutuor/features/home/domain/usecases/fetch_course_usecases.dart';
import 'package:growmind_tutuor/features/home/domain/usecases/get_saled_course_usecase.dart';
import 'package:growmind_tutuor/features/home/domain/usecases/upload_course_usecases.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/create_course_bloc/create_course_bloc.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/fetch_category_bloc/bloc/fetch_category_bloc.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/fetch_course_bloc/fetch_course_bloc.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/sales_course_bloc/sales_course_bloc.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/update_section_course_bloc/bloc/update_section_bloc.dart';
import 'package:growmind_tutuor/features/profile/domain/usecases/get_profile.dart';
import 'package:growmind_tutuor/features/profile/domain/usecases/update_profile_usecases.dart';
import 'package:growmind_tutuor/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:growmind_tutuor/features/profile/presentation/bloc/profile_update_bloc/bloc/profile_update_bloc.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

 
  await Firebase.initializeApp();
  setup();
  runApp(const MyApp());  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(372, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    AuthBloc(firebasepath: FirebaseAuth.instance),
              ),
              BlocProvider(
                  create: (context) => SignupBloc(
                      auth: FirebaseAuth.instance,
                      firestore: FirebaseFirestore.instance)),
              BlocProvider(
                create: (context) => TutorKycBloc(
                    submitKycUseCase: getIt<SubmitKycUseCase>(),
                    uploadPDFUseCase: getIt<UploadPDFUseCase>()),
                child: const  KycVerificationPage(),
              ),
              // BlocProvider(create: (context)=> ProfileBloc(getIt<GetProfile>(), getIt<ProfileRepo>()),child: HomePage(),),
                 BlocProvider(create: (context)=> ProfileBloc(getIt<GetProfile>(),)),
               BlocProvider(create: (context)=> CreateCourseBloc(getIt<UploadCourseUsecases>())),
               BlocProvider(create: (context)=> FetchCategoryBloc(getIt<FetchCategories>(), getIt<FetchSubCategories>())),
               BlocProvider(create: (context)=>ProfileUpdateBloc(getIt<UpdateProfileUsecases>())),
              BlocProvider(create: (context)=> FetchCourseBloc(getIt<FetchCourseUsecases>())),
              BlocProvider(create: (context)=> UpdateSectionBloc([])),
              BlocProvider(create: (context)=> ChatBloc(getMessageWithStudents: getIt<GetMessageStudents>(), sendMessage:getIt<GetSendMessage>() )),
              BlocProvider(create: (context)=> ConversationBloc(getTutorConversations: getIt<GetTutorconversation>(), getStudentProfile: getIt<GetStudentProfile>())),
              BlocProvider(create: (context)=> SalesCourseBloc(getIt<GetSaledCourseUsecase>()))
            ],
            child: MaterialApp(
              theme: ThemeData(
                  iconTheme: IconThemeData(size: 28.w, color: Colors.black)),
              color: textColor,
              debugShowCheckedModeBanner: false,
              initialRoute: '/splashscreen',
              routes: {
                '/splashscreen': (context) => const SplashScreen(),
                '/bottomnavigation': (context) => const BottomNavigation(),
                '/login': (context) => LoginPage(),
              },
            ));
      },
    );
  }
}
