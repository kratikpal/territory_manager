import 'package:flutter/material.dart';

class CommonElevatedButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final double? height;
  final double? width;
  final double? borderRadius;
  final Color? backgroundColor;
  final bool isLoading;

  const CommonElevatedButton(
      {super.key,
      required this.text,
      this.onPressed,
      this.borderRadius,
      this.backgroundColor,
      this.height,
      this.width,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height ?? kToolbarHeight - 25,
        width: width ?? 200,
        child: ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius ?? 6)),
                backgroundColor: backgroundColor ?? const Color(0xff1E1E1E),
                side: const BorderSide(color: Colors.transparent)),
            child: Center(
                child: isLoading
                    ? const CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black))
                    : Text(text,
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Anek')))));
  }
}
