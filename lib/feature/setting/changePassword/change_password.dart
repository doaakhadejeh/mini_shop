import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimi_shope/core/theme/theme_extention.dart';
import 'package:mimi_shope/feature/auth/logic/auth_cubit.dart';
import 'package:mimi_shope/feature/auth/logic/auth_state.dart';
import 'package:mimi_shope/feature/setting/changePassword/widget/field_change_password.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final cubit = context.read<AuthCubit>();

    void changePassword() {
      if (!cubit.changePasswordFormKey.currentState!.validate()) return;

      context.read<AuthCubit>().changePassword(
        newPassword: cubit.changePasswordController.text.trim(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Password',
          style: TextStyle(color: colors.mainText, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }

          if (state is AuthInitial) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Password changed successfully')),
            );

            Navigator.pop(context);
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              FieldChangePassword(colors: colors,),

              const SizedBox(height: 35),

              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  final isLoading = state is AuthLoading;

                  return SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : changePassword,
                      child: isLoading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text(
                              'Change Password',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
