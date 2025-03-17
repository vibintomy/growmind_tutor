import 'package:flutter/material.dart';
import 'package:growmind_tutuor/core/utils/constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final IconData? suffixIcon;
  final IconData? prefixIcon;

  final Function()? onSuffixTap;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  const CustomTextField(
      {super.key,
      this.controller,
      required this.hintText,
      this.suffixIcon,
      this.prefixIcon,
      this.onSuffixTap,
      this.keyboardType = TextInputType.text,
      this.validator});

  @override
  Widget build(BuildContext context) {
    bool obscureText = false;
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
        borderSide: BorderSide(color: mainColor),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon != null
            ? GestureDetector(
                onTap: () {
                  obscureText=true;
                  (context as Element).markNeedsBuild();
                },
                child:
                    // ignore: dead_code
                    Icon(obscureText ? Icons.visibility_off : Icons.visibility),
              )
            : null,
      ),
    );
  }
}
