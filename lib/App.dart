import 'package:flutter/material.dart';
import 'package:prm_yuvid/screens/login_signup/login_screen.dart';
import 'package:prm_yuvid/screens/login_signup/sign_up.dart';
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
      initialRoute: '/login',
      onGenerateRoute: onGenerateRoute,
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

  Route onGenerateRoute(RouteSettings routeSettings) {
    if (routeSettings.name == '/login') {
      return MaterialPageRoute(builder: (_) => LoginScreen());
    }

    if (routeSettings.name == '/sign_up') {
      return MaterialPageRoute(builder: (_) => SignUpScreen());
    }
    return MaterialPageRoute(builder: (_) => Home());
  }
}
