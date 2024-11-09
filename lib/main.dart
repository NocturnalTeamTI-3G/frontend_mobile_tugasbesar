import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/auth/providers/auth_provider.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/check/providers/camera_provider.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/news/providers/news_list_provider.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/news/providers/news_provider.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/product/providers/product_provider.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/setting/providers/setting_provider.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/routes/router.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => SettingProvider()),
        ChangeNotifierProvider(create: (_) => NewsProvider()),
        ChangeNotifierProvider(create: (_) => CameraProvider()),
        ChangeNotifierProvider(create: (_) => NewsListProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouters.splash,
      getPages: AppPages.pages,
    );
  }
}
