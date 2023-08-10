import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/screens/biddingScreen.dart';
import 'package:hire_pro/screens/categoryScreen.dart';
import 'package:hire_pro/screens/editProfile/changePassword.dart';
import 'package:hire_pro/screens/editProfile/emailcodereqScreen.dart';
import 'package:hire_pro/screens/emailCodeVerifyScreen.dart';
import 'package:hire_pro/screens/job_request/confirmationScreen.dart';
import 'package:hire_pro/screens/editProfile/editProfileScreen.dart';
import 'package:hire_pro/screens/homeScreen.dart';
import 'package:hire_pro/screens/jobCompletedScreen.dart';
import 'package:hire_pro/screens/job_request/stepper.dart';
import 'package:hire_pro/screens/login/loginScreen.dart';
import 'package:hire_pro/screens/ongoingScreen.dart';
import 'package:hire_pro/screens/pro_profile_screen/proProfileScreen.dart';
import 'package:hire_pro/screens/userProfile.dart';
import 'package:hire_pro/screens/userProfilesp.dart';
import 'package:hire_pro/widgets/MyNavigationWidget.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();

  runApp(HirePro(
    token: preferences.getString('token'),
  ));
}

class HirePro extends StatelessWidget {
  final token;
  // const HirePro({super.key, required this.token});
  const HirePro({@required this.token, Key? key}) : super(key: key);
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
        // '/': (context) =>
        //     (token == null || JwtDecoder.isExpired(token) == false)
        //         ? MyNavigationWidget(
        //             token: token,
        //           )
        //         : LoginScreen(),
        '/': (context) => LoginScreen(),
        // '/home': (context) => MyNavigationWidget(
        //       token: token,
        //     ),
        '/category': (context) => CategoryScreen(),
        '/ongoing': (context) => OngoingScreen(),
        '/profile': (context) => UserProfile(),
        '/edit_profile': (context) => EditProfileScreen(),
        '/job_request': (context) => JobRequestScreen(),
        '/confirm_job_request': (context) => ConfirmationScreen(),
        '/biddings': (context) => BiddingPage(),
        '/pro_profile': (context) => proProfileScreen(),
        '/emailcoderequest': (context) => EmailcodereqScreen(),
        '/emailcodeverify': (context) => EmailCodeVerifyScreen(),
        '/change_password': (context) => ChangePassword(),
      },
    );
  }
}
