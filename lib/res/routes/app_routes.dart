import 'package:get/get.dart';
import 'package:lessionlab/res/routes/routes.dart';
import 'package:lessionlab/view/auth/login_screen.dart';
import 'package:lessionlab/view/auth/signup/sign_up_screen.dart';
import 'package:lessionlab/view/get_started/get_started.dart';
import 'package:lessionlab/view/home/home_screen.dart';

import '../../view/splash/splash_screen.dart';

class AppRoutes {
  static List<GetPage> routes() {
    return [
      GetPage(name: Routes.splashScreen, page: () => const SplashScreen()),
      GetPage(name: Routes.getStarted, page: () => const GetStarted()),
      GetPage(name: Routes.signUpScreen, page: () =>  SignUpScreen()),
      GetPage(name: Routes.signInScreen, page: () => LoginScreen()),
      GetPage(name: Routes.home, page: () => const HomeScreen()),
      // GetPage(name: Routes.profilePicture, page: () => profile()),
    ];
  }
}
