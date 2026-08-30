import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimi_shope/core/widget/custom_text_form_field.dart';
import 'package:mimi_shope/feature/auth/logic/auth_cubit.dart';

class FieldRegister extends StatefulWidget {
  const FieldRegister({super.key});

  @override
  State<FieldRegister> createState() => _FieldRegisterState();
}

class _FieldRegisterState extends State<FieldRegister> {
  bool isPasswordObscure = true;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return Form(
      key: cubit.registerFormKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: cubit.nameController,
            hinttext: 'Full Name',
            prefixicon: const Icon(Icons.person, color: Colors.black),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Name must not be empty";
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),

          // Email Field
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

          // Phone Field
          CustomTextFormField(
            controller: cubit.phoneController,
            hinttext: 'Phone Number',
            prefixicon: const Icon(Icons.phone, color: Colors.black),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Phone number must not be empty";
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
