// profile_header.dart
import 'package:flutter/material.dart';
import 'package:growmind_tutuor/core/utils/constants.dart';

class ProfileHeader extends StatelessWidget {
  final String? imageUrl;
  final String displayName;
  final String email;

  const ProfileHeader({
    Key? key,
    required this.imageUrl,
    required this.displayName,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 340,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 3),
            blurRadius: 3,
            color: greyColor,
            spreadRadius: 0,
          )
        ],
        color: mainColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
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
                    shape: BoxShape.circle, 
                    color: textColor,
                  ),
                ),
                Container(
                  height: 120,
                  width: 120,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                  child: ClipOval(
                    child: imageUrl != null && imageUrl!.isNotEmpty
                      ? Image.network(imageUrl!, fit: BoxFit.cover)
                      : Image.asset(
                          'assets/logo/user.png',
                          fit: BoxFit.fill,
                        ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            displayName,
            style: const TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          kheight,
          Text(
            email,
            style: const TextStyle(
              color: textColor,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}