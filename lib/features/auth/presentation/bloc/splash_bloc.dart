import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_tutuor/features/auth/data/datasource/auth_local_datasource.dart';
import 'package:growmind_tutuor/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashState {
  final double opacity;
  final bool isCentered;
  final double animationProgress; 
  final bool isAnimationComplete;
  
  SplashState({
    required this.opacity, 
    required this.isCentered, 
    this.animationProgress = 0.0,
    this.isAnimationComplete = false
  });

  SplashState copyWith({
    double? opacity,
    bool? isCentered,
    double? animationProgress,
    bool? isAnimationComplete,
  }) {
    return SplashState(
      opacity: opacity ?? this.opacity,
      isCentered: isCentered ?? this.isCentered,
      animationProgress: animationProgress ?? this.animationProgress,
      isAnimationComplete: isAnimationComplete ?? this.isAnimationComplete,
    );
  }
}

class SplashCubit extends Cubit<SplashState> {
  final AuthLocalDataSourceImpl authLocalDataSource;
  
  SplashCubit(this.authLocalDataSource)
      : super(SplashState(opacity: 0.0, isCentered: false));
  
  void startAnimation() {

    emit(SplashState(opacity: 0.0, isCentered: false, animationProgress: 0.0));
    

    Future.delayed(const Duration(milliseconds: 300), () {
      emit(state.copyWith(
        opacity: 0.8, 
        animationProgress: 0.3
      ));
    });

   
    Future.delayed(const Duration(milliseconds: 600), () {
      emit(state.copyWith(
        opacity: 1.0,
        animationProgress: 0.5
      ));
    });
    
   
    Future.delayed(const Duration(milliseconds: 1000), () {
      emit(state.copyWith(animationProgress: 0.7));
    });

    Future.delayed(const Duration(seconds: 2), () {
      emit(state.copyWith(
        isCentered: true,
        animationProgress: 0.9
      ));
    });
    
 
    Future.delayed(const Duration(seconds: 2, milliseconds: 500), () {
      emit(state.copyWith(
        animationProgress: 1.0,
        isAnimationComplete: true
      ));
    });
    
    Future.delayed(const Duration(seconds: 3, milliseconds: 500), checkFirstLaunch);
  }

  Future<void> checkFirstLaunch() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      bool? isFirstLaunch = prefs.getBool('isFirstLaunch');
      if (navigatorKey.currentContext?.mounted ?? false) {
        if (isFirstLaunch == null || isFirstLaunch) {      
          navigatorKey.currentState?.pushReplacementNamed('/welcomePage');
          prefs.setBool('isFirstLaunch', false);
        } else {         
          checkLogin();
        }
      }
    } catch (e) {    
      if (navigatorKey.currentContext?.mounted ?? false) {
        navigatorKey.currentState?.pushReplacementNamed('/login');
      }
    }
  }

  Future<void> checkLogin() async {
    try {
      final user = await authLocalDataSource.getcacheUser();
      
      if (navigatorKey.currentContext?.mounted ?? false) {
        if (user != null) {
       
          navigatorKey.currentState?.pushReplacementNamed('/bottomnavigation');
        } else {

          navigatorKey.currentState?.pushReplacementNamed('/login');
        }
      }
    } catch (e) {
  
      if (navigatorKey.currentContext?.mounted ?? false) {
        navigatorKey.currentState?.pushReplacementNamed('/login');
      }
    }
  }
}