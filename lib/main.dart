import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/providers/news_provider.dart';
import 'package:frontend_mobile_tugasbesar/utils/router.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsProvider()),
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
