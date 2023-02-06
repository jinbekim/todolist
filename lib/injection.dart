import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todolist/application/auth/auth_controller.dart';
import 'package:todolist/application/auth/sign_in_form/sign_in_form_controller.dart';
import 'package:todolist/infrastructure/auth/firebase_auth_facade.dart';

void configureInjection(String env) {
  Get.put<FirebaseAuth>(FirebaseAuth.instance);
  Get.put<GoogleSignIn>(GoogleSignIn());
  Get.put<FirebaseAuthFacade>(
    FirebaseAuthFacade(Get.find<FirebaseAuth>(), Get.find<GoogleSignIn>()),
  );
  Get.put<SignInFormController>(
    SignInFormController(Get.find<FirebaseAuthFacade>()),
  );
  Get.put<AuthController>(
    AuthController(Get.find<FirebaseAuthFacade>()),
  );
}
