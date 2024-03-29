import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kronuss23_s_application1/core/app_export.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomPinCodeTextField extends StatelessWidget {
  CustomPinCodeTextField({
    Key? key,
    required this.context,
    // required this.onChanged,
    this.alignment,
    this.controller,
    this.textStyle,
    this.hintStyle,
    this.validator,
    required this.onCompleted
  }) : super(
          key: key,
        );

  final Alignment? alignment;

  final BuildContext context;

  final TextEditingController? controller;

  final TextStyle? textStyle;

  final TextStyle? hintStyle;

  // Function(String) onChanged;

  final FormFieldValidator<String>? validator;

  Function(String) onCompleted;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: pinCodeTextFieldWidget,
          )
        : pinCodeTextFieldWidget;
  }

  Widget get pinCodeTextFieldWidget => PinCodeTextField(
        appContext: context,
        controller: controller,
        length: 6,
        keyboardType: TextInputType.number,
        textStyle: textStyle ?? theme.textTheme.headlineMedium,
        hintStyle: hintStyle ?? theme.textTheme.headlineMedium,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        enableActiveFill: true,
        pinTheme: PinTheme(
          fieldHeight: 2.h,
          fieldWidth: 40.h,
          shape: PinCodeFieldShape.underline,
          inactiveFillColor: appTheme.gray500,
          activeFillColor: appTheme.gray500,
          inactiveColor: Colors.transparent,
          activeColor: Colors.transparent,
          selectedColor: Colors.transparent,
        ),
        // onChanged: (value) => onChanged(value),
        onCompleted: (value) => onCompleted(value),
        validator: validator,
      );
}
