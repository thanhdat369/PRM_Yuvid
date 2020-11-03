import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prm_yuvid/blocs/login/login_bloc.dart';
import 'package:prm_yuvid/screens/login_signup/sign_up.dart';
import 'package:prm_yuvid/screens/user/main_user_screen/user_home.dart';
import 'package:prm_yuvid/themes/colors.dart';

import 'components/rounded_input.dart';
import 'components/rounded_password.dart';
import 'components/brand_label.dart';
import 'components/rounded_button.dart';
import 'components/screen_with_background.dart';

class LoginPageParent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  TextEditingController userController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  LoginBloc _loginBloc;

  @override
  Widget build(BuildContext context) {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
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
                  press: login,
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
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                        return SignUpScreen();
                      }));
                    },
                  ),
                ],
              ),
            ),
            BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccessState) {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return UserHome(id: state.id);
                  }));
                }
              },
              child:
                  BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                if (state is LoginInitial) {
                  return SizedBox.shrink();
                } else if (state is LoginLoadingState) {
                  return buildLoading();
                } else if (state is LoginSuccessState) {
                  return Container();
                } else if (state is LoginFailedState) {
                  return buildFailure(state.message);
                } else {
                  return SizedBox.shrink();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildFailure(String mess) {
    return Text(mess, style: TextStyle(color: Colors.red));
  }

  void login() {
    if (passwordController.text.isEmpty || userController.text.isEmpty) {
    } else {
      _loginBloc.add(LoginButtonPressEvent(
          username: userController.text, password: passwordController.text));
    }
  }
}
