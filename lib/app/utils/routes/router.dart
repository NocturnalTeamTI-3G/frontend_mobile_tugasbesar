import 'package:frontend_mobile_tugasbesar/app/modules/check/pages/check_page.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/check/pages/display_picture_screen.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/history/pages/history_detail_page.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/auth/pages/create_new_pw_page.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/auth/pages/forgot_password_page.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/auth/pages/intro_page.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/auth/pages/login_page.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/auth/pages/otp_verif_page.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/auth/pages/register_page.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/main_page.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/news/pages/news_detail_page.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/news/pages/news_list_page.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/product/pages/product_detail_page.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/product/pages/product_list_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class AppRouters {
  // Login dan Registrasi
  static const intro = '/intro';
  static const login = '/login';
  static const registrasi = '/registrasi';
  static const forgotPassword = '/forgotPassword';
  static const otp = '/otp';
  static const newPassword = '/newPassword';

  // Main page
  static const main = '/home';

  // History
  static const historyDetail = '/historyDetail';

  // Camera
  static const camera = '/camera';
  static const cameraResult = '/cameraResult';

  // News
  static const newsDetail = '/newsDetail';
  static const newsList = '/newsList';

  // product
  static const productDetail = '/productDetail';
  static const productList = '/productList';
}

class AppPages {
  static final pages = [
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
    GetPage(
      name: AppRouters.productDetail,
      page: () => ProductDetailPage(),
    ),
    GetPage(
      name: AppRouters.productList,
      page: () => ProductListPage(),
    ),
  ];
}
