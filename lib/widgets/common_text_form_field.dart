import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextFormField extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Color? fillColor;
  final bool? readOnly;
  final int? maxLines;
  final double? height;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final bool obscureText;
  final void Function(String)? onChanged;

  const CommonTextFormField({
    super.key,
    required this.title,
    this.controller,
    this.validator,
    this.fillColor,
    this.readOnly,
    this.maxLines,
    this.height,
    this.keyboardType,
    this.inputFormatters,
    this.maxLength,
    this.onChanged,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(title,
        //     style: const TextStyle(
        //         fontSize: 15,
        //         color: Colors.white,
        //         fontWeight: FontWeight.w400,
        //         fontFamily: 'Anek')),
        TextFormField(
          controller: controller,
          readOnly: readOnly ?? false,
          maxLines: maxLines,
          maxLength: maxLength,
          onChanged: onChanged,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          validator: validator,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: title,
            contentPadding: const EdgeInsets.only(bottom: 10, left: 10),
            filled: true,
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            disabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            fillColor: fillColor ?? Colors.white,
          ),
        )
      ],
    );
  }
}
