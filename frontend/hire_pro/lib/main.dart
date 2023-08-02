import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/screens/biddingScreen.dart';
import 'package:hire_pro/screens/categoryScreen.dart';
import 'package:hire_pro/screens/emailCodeVerifyScreen.dart';
import 'package:hire_pro/screens/job_request/confirmationScreen.dart';
import 'package:hire_pro/screens/editProfile/editProfileScreen.dart';
import 'package:hire_pro/screens/homeScreen.dart';
import 'package:hire_pro/screens/jobCompletedScreen.dart';
import 'package:hire_pro/screens/job_request/stepper.dart';
import 'package:hire_pro/screens/pro_profile_screen/proProfileScreen.dart';
import 'package:hire_pro/screens/userProfile.dart';
import 'package:hire_pro/widgets/MyNavigationWidget.dart';

void main() {
  runApp(const HirePro());
}

class HirePro extends StatelessWidget {
  const HirePro({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: kSecondaryYellow, primary: kMainYellow),
        // primaryColorDark: Colors.black, // Update this line
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 72),
          titleLarge: TextStyle(fontSize: 36),
          bodyMedium: TextStyle(fontSize: 14),
        ),
        // colorScheme:
        //     ColorScheme.fromSwatch().copyWith(secondary: Color(0xFFD4842B)),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyNavigationWidget(),
        '/home': (context) => HomeScreen(),
        '/category': (context) => CategoryScreen(),
        '/ongoing': (context) => JobCompletedScreen(),
        '/profile': (context) => UserProfile(),
        '/edit_profile': (context) => EditProfile(),
        '/job_request': (context) => JobRequestScreen(),
        '/confirm_job_request': (context) => ConfirmationScreen(),
        '/biddings': (context) => BiddingPage(),
        '/pro_profile': (context) => proProfileScreen(),
        '/emailcodeverify': (context) => EmailCodeVerifyScreen(),
      },
    );
  }
}
