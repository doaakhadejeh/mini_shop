import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mimi_shope/core/helper/shared_pref.dart';
import 'package:mimi_shope/core/routing/const_rout.dart';
import 'package:mimi_shope/feature/auth/logic/auth_cubit.dart';
import 'package:mimi_shope/feature/auth/logic/auth_state.dart';

class AuthListener extends StatelessWidget {
  const AuthListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) async {
        goToHome() => context.go(ConstRouter.home);
        if (state is AuthLoading) {
          showDialog(
            context: context,
            builder: (_) => SimpleDialog(
              backgroundColor: Colors.grey.shade50,
              title: Padding(
                padding: EdgeInsets.all(10.sp),
                child: Row(
                  mainAxisAlignment: .center,
                  children: [CircularProgressIndicator(color: Colors.amber)],
                ),
              ),
            ),
          );
        } else if (state is PhoneNumberVerificationSent) {
          context.pop();
          context.push(ConstRouter.otp);
        } else if (state is AuthError) {
          showDialog(
            context: context,
            builder: (_) => SimpleDialog(
              title: Text(state.message),
              children: [const Icon(Icons.error, color: Colors.red)],
            ),
          );
        } else if (state is Authenticated) {
          context.pop();
          await SharedPrefHelper.setSecuredString(
            "userId",
            state.user.uid.toString(),
          );
          goToHome();
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
