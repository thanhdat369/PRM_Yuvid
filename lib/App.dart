import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prm_yuvid/blocs/auth/auth_bloc.dart';
import 'package:prm_yuvid/screens/login_signup/login_screen.dart';
import 'package:prm_yuvid/screens/login_signup/splash_screen.dart';
import 'package:prm_yuvid/screens/user/main_user_screen/user_home.dart';
import 'package:prm_yuvid/themes/colors.dart';

class App extends StatelessWidget {
  // render
  @override
  Widget build(BuildContext context) {
    var materialApp = MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          unselectedWidgetColor: Colors.white,
          textTheme: TextTheme(
            bodyText1: TextStyle(),
            bodyText2: TextStyle(),
          ).apply(
            bodyColor: MainColors.kLight,
            displayColor: Colors.blue,
            fontFamily: "Product Sans",
          ),
          primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (context) => AuthBloc()..add(AppStartedEvent()),
        // child: AuthenScreen(),
        child: UserHome(),
      ),
    );

    //Dimniss auto focus
    var myApp = GestureDetector(
      child: materialApp,
      onTap: () {
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      },
    );

    return myApp;
  }
}

class AuthenScreen extends StatelessWidget {
  const AuthenScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is AuthInitial) {
        return SplashScreen();
      } else if (state is AuthenticatedState) {
        return UserHome();
      } else if (state is UnAuthenticatedState) {
        return LoginPageParent();
      }
    });
  }
}
