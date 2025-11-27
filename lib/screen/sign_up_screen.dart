import 'package:developer_hub_authentication_app/screen/home_screen.dart';
import 'package:developer_hub_authentication_app/services/firebase_auth.dart';
import 'package:developer_hub_authentication_app/utils/constant.dart';
import 'package:developer_hub_authentication_app/widgets/custom_button.dart';
import 'package:developer_hub_authentication_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namecontroller = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final authservice = FirebaseAuthService();
  bool isLoading = false;

  @override
  void dispose() {
    _namecontroller.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> signUphandle() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      String? errorMessage = await authservice.signUp(
        _namecontroller.text,
        _emailController.text,
        _passwordController.text,
      );
      setState(() {
        isLoading = false;
      });
      if (errorMessage == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
      } else {
        print(errorMessage);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage, style: TextStyle(color: Colors.red)),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
       final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      backgroundColor: Colors.grey.withValues(alpha: 0.1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 60),
                Text(
                  'Create Account',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heading,
                ),
                Text(
                  'Let\'s get you started',
                  style: AppTextStyles.subtitle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: _namecontroller,
                  icon: Icons.person,
                  hintText: 'Name',
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter your Email';
                    }
                    if (!value.contains('@')) {
                      return 'Please Enter valid Email';
                    }
                    return null;
                  },
                  controller: _emailController,
                  icon: Icons.email,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter your password';
                    }
                    return null;
                  },

                  controller: _passwordController,
                  icon: Icons.lock,
                  hintText: 'Password',
                  keyboardType: TextInputType.visiblePassword,
                ),
                SizedBox(height: 10),
                CustomButton(
                  text: 'Sign Up',
                  onPressed: signUphandle,
                  isLoading: isLoading,
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account? '),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
