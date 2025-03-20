// profile_menu_item.dart
import 'package:flutter/material.dart';
import 'package:growmind_tutuor/core/utils/constants.dart';

class ProfileMenuItem extends StatelessWidget {
  final Icon icon;
  final String title;
  final VoidCallback onTap;

  const ProfileMenuItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          icon,
          kwidth,
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          const Icon(Icons.arrow_right)
        ],
      ),
    );
  }
}