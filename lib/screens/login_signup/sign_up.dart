import 'package:flutter/material.dart';
import 'package:prm_yuvid/themes/colors.dart';
import 'components/brand_label.dart';
import 'components/rounded_button.dart';
import 'components/rounded_input.dart';
import 'components/rounded_password.dart';
import 'components/screen_with_background.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  int group_value = 1;
  bool isCheck = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MainColors.kDark,
      body: ScreenWithBackground(
        pathBackground: "asset/images/background/background.jpg",
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BrandLabel(),
            Column(
              children: [
                RoundedInputField(
                  hintText: "Enter Full Name",
                ),
                RoundedInputField(
                  hintText: "Enter Email",
                  icon: Icons.email,
                ),
                RoundedPasswordField(
                  hintText: "Password",
                  ishaveVisibleButton: false,
                ),
                RoundedPasswordField(
                  hintText: "Confirm Password",
                  ishaveVisibleButton: false,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Checkbox(
                        value: isCheck,
                        checkColor: MainColors.kMain, // color of tick Mark
                        activeColor: MainColors.kLight,
                        onChanged: (bool value) {
                          setState(() {
                            isCheck = value;
                          });
                        }),
                    Text("Agree to the Terms of Service & Privacy Policy",
                        style: TextStyle(fontSize: 13)),
                  ],
                ),
                RoundedButton(
                  text: "REGISTER",
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: TextStyle(height: 2, fontSize: 18),
                ),
                GestureDetector(
                  child: Text("Login",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: MainColors.kMain,
                          fontSize: 20,
                          height: 2,
                          decoration: TextDecoration.underline)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
