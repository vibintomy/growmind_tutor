import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:growmind_tutuor/core/utils/constants.dart';
import 'package:growmind_tutuor/features/chat/chat_page.dart';
import 'package:growmind_tutuor/features/home/presentation/pages/home_page.dart';
import 'package:growmind_tutuor/features/profile/presentation/pages/profile_page.dart';

// ignore: must_be_immutable
class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;
  final ValueNotifier<bool> bottomNavBarVisible = ValueNotifier(true);

  final List<Widget> listOfPages = [
    const HomePage(),
    const ChatPage(),
    const ProfilePage()
  ];
  List<IconData> listOfIcons = [Icons.home_rounded, Icons.chat, Icons.person];

  void setPage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.direction == ScrollDirection.reverse) {
            bottomNavBarVisible.value = true;
          } else if (notification.direction == ScrollDirection.forward) {          
              bottomNavBarVisible.value = true;           
          }

          return true;
        },
        child: IndexedStack(
          index: currentIndex,
          children: listOfPages,
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: bottomNavBarVisible,
        builder: (context, isVisible, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: isVisible ? kBottomNavigationBarHeight + 15 : 0,
            child: isVisible ? child : const SizedBox.shrink(),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 0),
                  spreadRadius: 2,
                  blurRadius: 5,
                )
              ],
              color: textColor,
              borderRadius: BorderRadius.circular(35),
            ),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: GNav(
                  haptic: true,
                  color: Colors.black,
                  activeColor: textColor,
                  gap: 1,
                  onTabChange: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  textStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  tabBackgroundColor: mainColor,
                  selectedIndex: currentIndex,
                  tabs: const [
                    GButton(
                      icon: Icons.home,
                      text: 'Home',
                    ),
                    GButton(
                      icon: Icons.chat,
                      text: 'Chat',
                    ),
                    GButton(
                      icon: Icons.person,
                      text: 'profile',
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
