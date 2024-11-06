import 'package:frontend_mobile_tugasbesar/app/modules/check/pages/check_page.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/check/pages/display_picture_screen.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/history/pages/history_detail_page.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/login/create_new_pw_page.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/login/forgot_password_page.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/login/intro_page.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/login/login_page.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/login/otp_verif_page.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/login/register_page.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/main_page.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/news/pages/news_detail_page.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/news/pages/news_list_page.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/splash.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class AppRouters {
  static const splash = '/splash';

  // Login dan Registrasi
  static const intro = '/intro';
  static const login = '/login';
  static const registrasi = '/registrasi';
  static const forgotPassword = '/forgotPassword';
  static const otp = '/otp';
  static const newPassword = '/newPassword';

  // Main page
  static const main = '/';

  // History
  static const historyDetail = '/historyDetail';

  // Camera
  static const camera = '/camera';
  static const cameraResult = '/cameraResult';

  // News
  static const newsDetail = '/newsDetail';
  static const newsList = '/newsList';
}

class AppPages {
  static final pages = [
    GetPage(
      name: AppRouters.splash,
      page: () => Splash(),
    ),
    GetPage(
      name: AppRouters.intro,
      page: () => IntroPage(),
    ),
    GetPage(
      name: AppRouters.login,
      page: () => LoginPage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRouters.registrasi,
      page: () => RegisterPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRouters.forgotPassword,
      page: () => ForgotPasswordPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRouters.otp,
      page: () => OtpVerifPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRouters.newPassword,
      page: () => CreateNewPasswordPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRouters.main,
      page: () => MainPage(),
    ),
    GetPage(
      name: AppRouters.historyDetail,
      page: () => HistoryDetailPage(),
    ),
    GetPage(
      name: AppRouters.camera,
      page: () => CheckPage(),
    ),
    GetPage(
      name: AppRouters.cameraResult,
      page: () => DisplayPictureScreen(),
    ),
    GetPage(
      name: AppRouters.newsDetail,
      page: () => NewsDetailPage(),
    ),
    GetPage(
      name: AppRouters.newsList,
      page: () => NewsListPage(),
    ),
  ];
}
