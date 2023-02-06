import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/presentation/sign_in/sign_in_page.dart';
import 'package:todolist/presentation/splash/splash_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Todo List',
      initialRoute: '/sign-in',
      getPages: [
        GetPage(
          name: '/',
          page: () => SplashPage(),
          // binding: BindingsBuilder(() {
          //   Get.put<AuthController>(
          //     AuthController(Get.find<FirebaseAuthFacade>()),
          //   );
          // }),
        ),
        GetPage(name: '/sign-in', page: () => SignInPage()),
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.green[800],
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
