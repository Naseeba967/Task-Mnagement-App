import 'package:developer_hub_authentication_app/utils/constant.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.icon,
    required this.hintText,
    this.isPassword = false,

    this.keyboardType = TextInputType.text,
    this.validator,
  });

  final TextEditingController controller;
  final IconData icon;
  final String hintText;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightGray,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: AppColors.lightGray,
          hintStyle: TextStyle(color: AppColors.textGray),
          prefixIcon: Icon(icon, color: AppColors.textGray),
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
