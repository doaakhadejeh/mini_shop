import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget child;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? width;
  final bool? isRectangleBorder;
  final double? radiusRectangleBorder;
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.foregroundColor,
    this.backgroundColor,
    this.width,
    this.isRectangleBorder,
    this.radiusRectangleBorder,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: foregroundColor ?? Colors.white,
        backgroundColor: backgroundColor ?? Colors.brown.shade600,
        padding: EdgeInsets.symmetric(
          vertical: 5.h,
          horizontal: width ?? 100.w,
        ),
        shape: isRectangleBorder == true
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radiusRectangleBorder!),
              )
            : null,
        side: BorderSide(color: borderColor ?? Colors.brown.shade600),
      ),

      child: child,
    );
  }
}
