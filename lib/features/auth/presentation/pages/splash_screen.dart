import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_tutuor/core/utils/constants.dart';
import 'package:growmind_tutuor/features/auth/presentation/bloc/splash_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger animation when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SplashCubit>().startAnimation();
    });

    return BlocBuilder<SplashCubit, SplashState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: textColor,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  kheight2,
                  // Top row with animated elements
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Left top image with animations
                      TweenAnimationBuilder<Offset>(
                        tween: Tween<Offset>(
                          begin: const Offset(-1.0, 0.0),
                          end: state.animationProgress >= 0.3 ? Offset.zero : const Offset(-1.0, 0.0),
                        ),
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeOutCubic,
                        builder: (context, offset, child) {
                          return FractionalTranslation(
                            translation: offset,
                            child: AnimatedOpacity(
                              opacity: state.opacity,
                              duration: const Duration(milliseconds: 500),
                              child: AnimatedAlign(
                                duration: const Duration(seconds: 1),
                                curve: Curves.easeInOut,
                                alignment: state.isCentered
                                    ? Alignment.center
                                    : Alignment.topLeft,
                                child: SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: Image.asset('assets/logo/Paint3.png'),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      // Right top image with animations
                      TweenAnimationBuilder<Offset>(
                        tween: Tween<Offset>(
                          begin: const Offset(1.0, 0.0),
                          end: state.animationProgress >= 0.3 ? Offset.zero : const Offset(1.0, 0.0),
                        ),
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeOutCubic,
                        builder: (context, offset, child) {
                          return FractionalTranslation(
                            translation: offset,
                            child: AnimatedOpacity(
                              opacity: state.opacity,
                              duration: const Duration(milliseconds: 500),
                              child: AnimatedAlign(
                                duration: const Duration(seconds: 1),
                                curve: Curves.easeInOut,
                                alignment: state.isCentered
                                    ? Alignment.center
                                    : Alignment.topRight,
                                child: SizedBox(
                                  height: 200,
                                  width: 100,
                                  child: Image.asset('assets/logo/paper-plane.png'),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  kheight,
                  // Center logo with animation
                  TweenAnimationBuilder<double>(
                    tween: Tween<double>(
                      begin: 0.5,
                      end: state.animationProgress >= 0.5 ? 1.0 : 0.5,
                    ),
                    duration: const Duration(milliseconds: 1200),
                    curve: Curves.elasticOut,
                    builder: (context, scale, child) {
                      return Transform.scale(
                        scale: scale,
                        child: AnimatedOpacity(
                          opacity: state.animationProgress >= 0.5 ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 300),
                          child: Center(
                            child: SizedBox(
                              height: 150,
                              width: 150,
                              child: Image.asset('assets/logo/Group 4.png'),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  // Text with fade animation
                  AnimatedOpacity(
                    opacity: state.animationProgress >= 0.7 ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 800),
                    child: const Text(
                      'Start Learning',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, 
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  kheight2,
                  // Bottom row with animated elements
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Left bottom image with animations
                      TweenAnimationBuilder<Offset>(
                        tween: Tween<Offset>(
                          begin: const Offset(-1.0, 1.0),
                          end: state.animationProgress >= 0.4 ? Offset.zero : const Offset(-1.0, 1.0),
                        ),
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeOutCubic,
                        builder: (context, offset, child) {
                          return FractionalTranslation(
                            translation: offset,
                            child: AnimatedOpacity(
                              opacity: state.opacity,
                              duration: const Duration(milliseconds: 500),
                              child: AnimatedAlign(
                                duration: const Duration(seconds: 1),
                                curve: Curves.easeInOut,
                                alignment: state.isCentered
                                    ? Alignment.center
                                    : Alignment.bottomLeft,
                                child: SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: Image.asset('assets/logo/Group 46.png'),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      // Right bottom image with animations
                      TweenAnimationBuilder<Offset>(
                        tween: Tween<Offset>(
                          begin: const Offset(1.0, 1.0),
                          end: state.animationProgress >= 0.4 ? Offset.zero : const Offset(1.0, 1.0),
                        ),
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeOutCubic,
                        builder: (context, offset, child) {
                          return FractionalTranslation(
                            translation: offset,
                            child: AnimatedOpacity(
                              opacity: state.opacity,
                              duration: const Duration(milliseconds: 500),
                              child: AnimatedAlign(
                                duration: const Duration(seconds: 1),
                                curve: Curves.easeInOut,
                                alignment: state.isCentered
                                    ? Alignment.center
                                    : Alignment.bottomRight,
                                child: SizedBox(
                                  height: 200,
                                  width: 100,
                                  child: Image.asset('assets/logo/Books.png'),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}