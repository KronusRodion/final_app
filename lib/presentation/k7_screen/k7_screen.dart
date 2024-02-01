import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kronuss23_s_application1/core/app_export.dart';
import 'package:kronuss23_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:kronuss23_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:kronuss23_s_application1/widgets/custom_elevated_button.dart';
import 'package:kronuss23_s_application1/widgets/custom_text_form_field.dart';
import 'package:firebase_core/firebase_core.dart';

String phone_number1 = '';

class PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'[^\d]+'), '');
    final digitsOnlyChar = digitsOnly.split('');
    var newString = <String>[];
    final specialSymbolCount = newValue.selection
        .textBefore(newValue.text)
        .replaceAll(RegExp(r'[\d]+'), '')
        .length;
    var cursorPosition = newValue.selection.start - specialSymbolCount;

    var finalCursorpPosition = cursorPosition;

    if (oldValue.selection.textInside(oldValue.text) == ' ') {
      digitsOnlyChar.removeAt(cursorPosition - 1);
      finalCursorpPosition -= 2;
    }

    for (int i = 0; i < digitsOnlyChar.length; i++) {
      if (i == 3 || i == 6 || i == 8) {
        newString.add(' ');
        newString.add(digitsOnlyChar[i]);
        if (i <= cursorPosition) finalCursorpPosition += 1;
      } else {
        newString.add(digitsOnlyChar[i]);
      }
    }

    if (digitsOnlyChar.length > 10) {
      digitsOnlyChar.removeAt(10);
    }
    final resultString = newString.join('');
    String phone_number = resultString.replaceAll(' ', '');
    phone_number1 = ('+7$phone_number');
    return TextEditingValue(
      selection: TextSelection.collapsed(offset: finalCursorpPosition),
      text: resultString,
    );
  }
}

class K7Screen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return K7ScreenState();
  }
}

class K7ScreenState extends State<K7Screen> {
  K7ScreenState({Key? key}) : super();

  TextEditingController plusSevenController = TextEditingController();

  void auth() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '$phone_number1',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        Navigator.of(context).pushNamed('/k9_screen');
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 2.v),
                child: Column(children: [
                  AnotherStepper(
                      stepperDirection: Axis.horizontal,
                      activeIndex: 0,
                      barThickness: 1,
                      inverted: true,
                      stepperList: [
                        StepperData(),
                        StepperData(),
                        StepperData()
                      ]),
                  SizedBox(height: 27.v),
                  Text("Регистрация", style: theme.textTheme.displaySmall),
                  SizedBox(height: 21.v),
                  SizedBox(
                      width: 181.h,
                      child: Text("Введите номер телефона для регистрации",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium!
                              .copyWith(height: 1.33))),
                  SizedBox(height: 42.v),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Номер телефона",
                          style: theme.textTheme.labelLarge)),
                  SizedBox(height: 5.v),
                  CustomTextFormField(
                      
                      textInputType: TextInputType.phone,
                      inputFormatters: [
                        PhoneInputFormatter(),
                        LengthLimitingTextInputFormatter(13),
                      ],
                      controller: plusSevenController,
                      prefix: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        child: Text('+7'),
                      ),
                      textInputAction: TextInputAction.done),
                  Spacer(flex: 33),
                  CustomElevatedButton(
                      text: "Отправить смс-код",
                      margin: EdgeInsets.symmetric(horizontal: 29.h),
                      onPressed: () async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '$phone_number1',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        Navigator.of(context).pushNamed('/k9_screen');
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }),
                  SizedBox(height: 8.v),
                  SizedBox(
                      width: 228.h,
                      child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text:
                                    "Нажимая на данную кнопку, вы даете согласие на обработку ",
                                style: CustomTextStyles.bodySmallffa7a7a7),
                            TextSpan(
                                text: "персональных данных",
                                style: CustomTextStyles.bodySmallffffb700)
                          ]),
                          textAlign: TextAlign.center)),
                  Spacer(flex: 66)
                ]))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 374.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgVector,
            margin: EdgeInsets.fromLTRB(18.h, 10.v, 341.h, 11.v)));
  }

  /// Navigates to the k11Screen when the action is triggered.
  onTaptf(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.k11Screen);
  }
}
