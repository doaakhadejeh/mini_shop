import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimi_shope/core/theme/theme_extention.dart';
import 'package:mimi_shope/core/widget/custom_text_form_field.dart';
import 'package:mimi_shope/feature/auth/logic/auth_cubit.dart';
import 'package:mimi_shope/feature/setting/changePassword/widget/top_change_password.dart';

class FieldChangePassword extends StatefulWidget {
  final AppColors? colors;
  const FieldChangePassword({super.key, this.colors});

  @override
  State<FieldChangePassword> createState() => _FieldChangePasswordState();
}

class _FieldChangePasswordState extends State<FieldChangePassword> {
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return Form(
      key: cubit.changePasswordFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          Center(child: TopChangePassword(colors: widget.colors!)),

          const SizedBox(height: 30),

          Text(
            'Create a new password',
            style: TextStyle(
              color: widget.colors!.mainText,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Choose a strong password that you haven’t used before.',
            style: TextStyle(color: widget.colors!.subText, fontSize: 14),
          ),

          const SizedBox(height: 30),

          Text(
            'New Password',
            style: TextStyle(
              color: widget.colors!.mainText,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          CustomTextFormField(
            controller: cubit.changePasswordController,
            hinttext: 'new Password',
            obscureText: obscureNewPassword,
            prefixicon: const Icon(Icons.lock, color: Colors.black),
            suffix: IconButton(
              icon: Icon(
                obscureNewPassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  obscureNewPassword = !obscureNewPassword;
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

          const SizedBox(height: 20),

          Text(
            'Confirm Password',
            style: TextStyle(
              color: widget.colors!.mainText,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          CustomTextFormField(
            controller: cubit.confirmChangePasswordController,
            hinttext: 'confirm new Password',
            obscureText: obscureConfirmPassword,
            prefixicon: const Icon(Icons.lock, color: Colors.black),
            suffix: IconButton(
              icon: Icon(
                obscureConfirmPassword
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  obscureConfirmPassword = !obscureConfirmPassword;
                });
              },
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }

              if (value != cubit.changePasswordController.text) {
                return 'Passwords do not match';
              }

              return null;
            },
          ),
        ],
      ),
    );
  }
}
