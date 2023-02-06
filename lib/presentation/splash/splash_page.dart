import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/application/auth/auth_controller.dart';

// class SplashPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // return BlocListener<AuthBloc, AuthState>(
//     //   listener: (context, state) {
//     //     if (state is Authenticated) {
//     //       print('Authenticated');
//     //     } else if (state is Unauthenticated) {
//     //       Get.toNamed('/sign-in');
//     //     }
//     //     if (state is Initial) {
//     //       print('Initial');
//     //     }
//     //   },
//     // child:
//     return const Scaffold(
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//       // ),
//     );
//   }
// }

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Get.find<AuthController>().authCheckRequested();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
