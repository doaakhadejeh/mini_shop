import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mimi_shope/core/routing/const_rout.dart';
import 'package:mimi_shope/core/widget/custom_button.dart';

class ButtonLoginPage extends StatelessWidget {
  final TextEditingController phone;
  final String countryCode;
  const ButtonLoginPage({
    super.key,
    required this.phone,
    required this.countryCode,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      isRectangleBorder: true,
      radiusRectangleBorder: 10.sp,
      onPressed: () {
        // if (context.read<AuthCubit>().formKey.currentState!.validate()) {
        //   context.read<AuthCubit>().sendOtp(
        //     "$countryCode${phone.text.replaceFirst(RegExp(r'^0'), '')}",
        //   );
        // }
        context.push(ConstRouter.otp);
      },
      child: Text(
        "Login",
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
      ),
    );
  }
}
