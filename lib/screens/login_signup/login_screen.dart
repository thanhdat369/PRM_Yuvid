import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prm_yuvid/screens/login_signup/sign_up.dart';
import 'package:prm_yuvid/themes/colors.dart';

import 'components/rounded_input.dart';
import 'components/rounded_password.dart';
import 'components/brand_label.dart';
import 'components/rounded_button.dart';
import 'components/screen_with_background.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
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
            // FormTitle(title: "Login"),
            Column(
              children: [
                RoundedInputField(
                  hintText: "Username",
                  textEditingController: userController,
                ),
                RoundedPasswordField(
                  ishaveVisibleButton: true,
                  hintText: "Password",
                  textEditingController: passwordController,
                ),
                RoundedButton(
                  text: "Login",
                  // press: _login,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account ?  "),
                  InkWell(
                    child: Text("Register",
                        style: TextStyle(
                            color: MainColors.kMain,
                            fontFamily: "Product Sans",
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline)),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
