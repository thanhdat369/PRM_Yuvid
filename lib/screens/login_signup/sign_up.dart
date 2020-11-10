import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prm_yuvid/blocs/signup/signup_bloc.dart';
import 'package:prm_yuvid/models/accountDTO.dart';
import 'package:prm_yuvid/screens/login_signup/login_screen.dart';
import 'package:prm_yuvid/themes/colors.dart';
import 'components/brand_label.dart';
import 'components/rounded_button.dart';
import 'components/rounded_input.dart';
import 'components/rounded_password.dart';
import 'components/screen_with_background.dart';

// class SignUpScreen extends StatefulWidget {
//   SignUpScreen({Key key}) : super(key: key);

//   @override
//   SignUpScreenState createState() => SignUpScreenState();
// }

class SignUpPageParent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupBloc(),
      child: SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatelessWidget {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController fullnameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController bioController = new TextEditingController();
  SignupBloc _signupBloc;


  // int group_value = 1;
  // bool isCheck = true;
  @override
  Widget build(BuildContext context) {
    _signupBloc = BlocProvider.of<SignupBloc>(context);
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
                  hintText: "Enter UserName",
                  textEditingController: usernameController,
                ),
                RoundedInputField(
                  hintText: "Enter Fullname",
                  icon: Icons.person_add_alt_1,
                  textEditingController: fullnameController,
                ),
                RoundedPasswordField(
                  hintText: "Enter Password",
                  ishaveVisibleButton: false,
                  textEditingController: passwordController,
                ),
                RoundedInputField(
                  hintText: "Enter Email",
                  textEditingController: emailController,
                  icon: Icons.email,
                ),
                RoundedInputField(
                  hintText: "Enter bio",
                  icon: Icons.person_pin_rounded,
                  textEditingController: bioController,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //     Checkbox(
                //         value: isCheck,
                //         checkColor: MainColors.kMain, // color of tick Mark
                //         activeColor: MainColors.kLight,
                //         onChanged: (bool value) {
                //           setState(() {
                //             isCheck = value;
                //           });
                //         }),
                //     Text("Agree to the Terms of Service & Privacy Policy",
                //         style: TextStyle(fontSize: 13)),
                //   ],
                // ),
                RoundedButton(
                  text: "REGISTER",
                  press: signup,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: TextStyle(height: 2, fontSize: 15),
                ),
                GestureDetector(
                  child: Text("Login",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: MainColors.kMain,
                          fontSize: 18,
                          height: 2,
                          decoration: TextDecoration.underline)),
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) {
                      return LoginPageParent();
                    }));
                  },
                ),
              ],
            ),
            
            BlocListener<SignupBloc, SignupState>(
              listener: (context, state) {
                if (state is SignupSuccessState) {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return LoginPageParent();
                  }));
                }
              },
              child:
                  BlocBuilder<SignupBloc, SignupState>(builder: (context, state) {
                if (state is SignupInitial) {
                  return SizedBox.shrink();
                } else if (state is SignupLoadingState) {
                  return buildLoading();
                } else if (state is SignupSuccessState) {
                  return Container();
                } else if (state is SignupFailedState) {
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

  void signup() {



    if (passwordController.text.isEmpty || usernameController.text.isEmpty) {
    } else {

      String _username = usernameController.text;
      String _fullname = fullnameController.text;
      String _password = passwordController.text;
      String _email = emailController.text;
      String _bio = bioController.text;
      

      AccountSignUpDTO _dto = AccountSignUpDTO(username: _username,
                                              name: _fullname,
                                              password: _password,
                                              email: _email,
                                              bio: _bio);

      _signupBloc.add(SignupButtonPressEvent(dto: _dto));
    }
  }
}
