import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hirepro/constants.dart';
import 'package:hirepro/providers/address_provider.dart';
import 'package:hirepro/providers/category_provider.dart';
import 'package:hirepro/providers/customer_provider.dart';
import 'package:hirepro/providers/file_upload_provider.dart';
import 'package:hirepro/providers/location_provider.dart';
import 'package:hirepro/providers/task_provider.dart';
import 'package:hirepro/screens/addAddressScreen.dart';
import 'package:hirepro/screens/biddingScreen.dart';
import 'package:hirepro/screens/categoryScreen.dart';
import 'package:hirepro/screens/editProfile/changePassword.dart';
import 'package:hirepro/screens/editProfile/emailcodereqScreen.dart';
import 'package:hirepro/screens/emailCodeVerifyScreen.dart';
import 'package:hirepro/screens/job_request/TaskAddScreen.dart';
import 'package:hirepro/screens/job_request/confirmationScreen.dart';
import 'package:hirepro/screens/editProfile/editProfileScreen.dart';
import 'package:hirepro/screens/jobCompletedScreen.dart';
import 'package:hirepro/screens/job_request/searchingPros.dart';
import 'package:hirepro/screens/job_request/setLocationScreen.dart';
import 'package:hirepro/screens/loginScreen.dart';
import 'package:hirepro/screens/myTasks.dart';
import 'package:hirepro/screens/ongoingScreen.dart';
import 'package:hirepro/screens/otpEnterScreen.dart';
import 'package:hirepro/screens/signupScreen.dart';
import 'package:hirepro/screens/pro_profile_screen/proProfileScreen.dart';
import 'package:hirepro/screens/registerSuccess.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CustomerProvider()),
        ChangeNotifierProvider(create: (context) => AddressProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => TaskProvider()),
        ChangeNotifierProvider(create: (context) => FileUploadProvider()),
        ChangeNotifierProvider(create: (context) => LocationProvider())
      ],
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
          '/job_request': (context) => TaskAddScreen(),
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
          '/my_tasks': (context) => MyTasks(),
          '/rate': (context) => JobCompletedScreen(),
          '/set_location': (context) => SetLocationScreen(),
          '/searching_pros': (context) => SearchingPros(),
        },
      ),
    );
  }
}
