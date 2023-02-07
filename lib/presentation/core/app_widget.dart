import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/presentation/routes/get_pages.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Todo List',
      initialRoute: '/',
      getPages: Get.getPages(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.green[800],
        ),
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
