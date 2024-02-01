import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kronuss23_s_application1/core/app_export.dart';
import 'package:kronuss23_s_application1/presentation/k7_screen/k7_screen.dart';
import 'package:kronuss23_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:kronuss23_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:kronuss23_s_application1/widgets/custom_pin_code_text_field.dart';

class K9Screen extends StatefulWidget {
  String verificationid;

  K9Screen({super.key, required this.verificationid});

  @override
  State<StatefulWidget> createState() {
    return K9ScreenState();
  }
}



class K9ScreenState extends State<K9Screen> {
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 51.h, vertical: 2.v),
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
                  Text("Подтверждение", style: theme.textTheme.displaySmall),
                  SizedBox(height: 20.v),
                  Container(
                      width: 261.h,
                      margin: EdgeInsets.only(left: 5.h, right: 6.h),
                      child: Text(
                          "Введите код, который мы отправили в SMS на +7$phone_number1",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium!
                              .copyWith(height: 1.33))),
                  SizedBox(height: 23.v),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.h),
                      child: CustomPinCodeTextField(
                          
                          controller: otpController,
                          // key: GlobalKey(),
                          context: context,
                          onCompleted: (value) async {
                            try {
                              PhoneAuthCredential credential =
                                  await PhoneAuthProvider.credential(
                                verificationId: widget.verificationid,
                                smsCode: otpController.text.toString(),
                              );
                              FirebaseAuth.instance
                                  .signInWithCredential(credential)
                                  .then((value) {
                                Navigator.of(context).pushNamed('/k12_screen');
                              });
                            } catch (ex) {
                              print(ex.toString());
                            }
                          })),
                  SizedBox(height: 43.v),
                  GestureDetector(
                      onTap: () {
                        onTapTxtWidget(context);
                      },
                      child: Text("Отправить код еще раз",
                          style: CustomTextStyles.bodyMediumAmber600)),
                  SizedBox(height: 5.v)
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
  onTapTxtWidget(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.k11Screen);
  }
}
