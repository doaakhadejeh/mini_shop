import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimi_shope/core/widget/custom_text_form_field.dart';
import 'package:mimi_shope/feature/auth/logic/auth_cubit.dart';
import 'package:mimi_shope/feature/auth/ui/widget/button_login_page.dart';

class FieldLoginPage extends StatefulWidget {
  const FieldLoginPage({super.key});

  @override
  State<FieldLoginPage> createState() => _FieldLoginPageState();
}

class _FieldLoginPageState extends State<FieldLoginPage> {
  @override
  Widget build(BuildContext context) {
    final phone = context.read<AuthCubit>().phoneController;
    return Form(
      key: context.read<AuthCubit>().phoneFormKey,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: .start,
            children: [
              Container(
                height: 47.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.brown),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: CountryCodePicker(
                  onChanged: (country) {
                    setState(() {
                      context.read<AuthCubit>().selectedCountryCode =
                          country.dialCode ?? '+963';
                    });
                  },
                  initialSelection: 'SY',
                  favorite: const ['+963', 'SY'],
                  showCountryOnly: false,
                  showOnlyCountryWhenClosed: false,
                  alignLeft: false,
                  padding: EdgeInsets.zero,
                  textStyle: TextStyle(fontSize: 14.sp, color: Colors.black),
                ),
              ),

              SizedBox(width: 8.w),

              Expanded(
                child: CustomTextFormField(
                  controller: phone,
                  typekeybord: .number,
                  hinttext: 'phone number',
                  prefixicon: const Icon(Icons.phone, color: Colors.black),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "phone number must not be empty";
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 100.h),
          Center(
            child: ButtonLoginPage(
              phone: phone,
              countryCode: context.read<AuthCubit>().selectedCountryCode,
            ),
          ),
        ],
      ),
    );
  }
}
