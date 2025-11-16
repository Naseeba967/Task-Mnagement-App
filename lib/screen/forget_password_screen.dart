import 'package:developer_hub_authentication_app/services/firebase_auth.dart';
import 'package:developer_hub_authentication_app/utils/constant.dart';
import 'package:developer_hub_authentication_app/widgets/custom_button.dart';
import 'package:developer_hub_authentication_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _authService = FirebaseAuthService();
  bool _isLoading = false;
  Future<void> _handleResetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      String? errorMessage = await _authService.resetPassword(
        _emailController.text,
      );
      _isLoading = false;
      if (errorMessage == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Reset Passsword Sccessfuuly ')));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage)));
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),

          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  'Forgot password',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heading,
                ),
                SizedBox(height: 8),
                Text(
                  'Enter your Emai to reset you password',
                  style: AppTextStyles.subtitle,
                ),
                SizedBox(height: 40),
                CustomTextField(
                  controller: _emailController,
                  icon: Icons.email,
                  hintText: 'Enter your Email',
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 32),
                CustomButton(
                  text: 'Reset Password',
                  onPressed: _handleResetPassword,
                  isLoading: _isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
