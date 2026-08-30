import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimi_shope/core/widget/custom_text_form_field.dart';
import 'package:mimi_shope/feature/auth/logic/auth_cubit.dart';

class FieldLoginEmail extends StatefulWidget {
  const FieldLoginEmail({super.key});

  @override
  State<FieldLoginEmail> createState() => _FieldLoginEmailState();
}

class _FieldLoginEmailState extends State<FieldLoginEmail> {
  bool isPasswordObscure = true;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return Form(
      key: cubit.loginFormKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: cubit.emailController,
            hinttext: 'Email Address',
            prefixicon: const Icon(Icons.email, color: Colors.black),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Email must not be empty";
              }

              return null;
            },
          ),
          SizedBox(height: 16.h),

          // Password Field
          CustomTextFormField(
            controller: cubit.passwordController,
            hinttext: 'Password',
            obscureText: isPasswordObscure,
            prefixicon: const Icon(Icons.lock, color: Colors.black),
            suffix: IconButton(
              icon: Icon(
                isPasswordObscure ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  isPasswordObscure = !isPasswordObscure;
                });
              },
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Password must not be empty";
              }
              if (value.length < 6) {
                return "Password must be at least 6 characters";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
