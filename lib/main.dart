import 'package:flutter/material.dart';
import 'package:hire_pro/screens/categoryScreen.dart';
import 'package:hire_pro/screens/createJobRequestScreen.dart';
import 'package:hire_pro/screens/editProfileScreen.dart';
import 'package:hire_pro/screens/homeScreen.dart';
import 'package:hire_pro/screens/jobCompletedScreen.dart';
import 'package:hire_pro/screens/jobRequestScreen.dart';
import 'package:hire_pro/screens/ongoingScreen.dart';
import 'package:hire_pro/screens/otpEnterScreen.dart';
import 'package:hire_pro/screens/registerSuccess.dart';
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
          brightness: Brightness.light,
          primaryColor: Colors.white,
          primaryColorDark: Color.fromARGB(1, 245, 245, 245),
          fontFamily: 'Roboto',
          textTheme: const TextTheme(
            displayLarge: TextStyle(fontSize: 72),
            titleLarge: TextStyle(fontSize: 36),
            bodyMedium: TextStyle(fontSize: 14),
          ),
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Color(0xFFD4842B))),
      initialRoute: '/',
      routes: {
        '/': (context) => MyNavigationWidget(),
        '/home': (context) => HomeScreen(),
        '/category': (context) => CategoryScreen(),
        '/ongoing': (context) => JobCompletedScreen(),
        '/profile': (context) => UserProfile(),
        '/edit_profile': (context) => EditProfile(),
        '/job_request': (context) => JobRequestScreen(),
      },
    );
  }
}
