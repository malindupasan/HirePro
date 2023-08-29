import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/providers/customer_provider.dart';
import 'package:hire_pro/screens/addAddressScreen.dart';
import 'package:hire_pro/screens/biddingScreen.dart';
import 'package:hire_pro/screens/categories/categoryScreen.dart';
import 'package:hire_pro/screens/editProfile/changePassword.dart';
import 'package:hire_pro/screens/editProfile/emailcodereqScreen.dart';
import 'package:hire_pro/screens/emailCodeVerifyScreen.dart';
import 'package:hire_pro/screens/job_request/confirmationScreen.dart';
import 'package:hire_pro/screens/editProfile/editProfileScreen.dart';
import 'package:hire_pro/screens/jobCompletedScreen.dart';
import 'package:hire_pro/screens/job_request/stepper.dart';
import 'package:hire_pro/screens/login/loginScreen.dart';
import 'package:hire_pro/screens/myTasks.dart';
import 'package:hire_pro/screens/ongoingScreen.dart';
import 'package:hire_pro/screens/otpEnterScreen.dart';
import 'package:hire_pro/screens/signupScreen.dart';
import 'package:hire_pro/screens/pro_profile_screen/proProfileScreen.dart';
import 'package:hire_pro/screens/registerSuccess.dart';
import 'package:provider/provider.dart';
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
    return ChangeNotifierProvider(
      create: (context) => CustomerProvider(),
      child: MaterialApp(
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
          // '/profile': (context) => MyHomePage(),
          '/edit_profile': (context) => EditProfileScreen(),
          '/job_request': (context) => JobRequestScreen(),
          '/confirm_job_request': (context) => ConfirmationScreen(),
          '/biddings': (context) => BiddingPage(),
          '/pro_profile': (context) => proProfileScreen(),
          '/emailcoderequest': (context) => EmailcodereqScreen(),
          '/emailcodeverify': (context) => EmailCodeVerifyScreen(),
          '/change_password': (context) => ChangePassword(),
          '/add_address': (context) => AddAddressScreen(),
          '/otp': (context) => OtpScreen(),
          '/otp_enter': (context) => OtpEnterScreen(),
          '/register_success': (context) => RegisterSuccess(),
          '/my_tasks':(context) => MyTasks(),
          '/rate':(context) =>JobCompletedScreen(),
        },
      ),
    );
  }
}
