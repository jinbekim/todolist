import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todolist/application/auth/auth_controller.dart';
import 'package:todolist/application/auth/sign_in_form/sign_in_form_controller.dart';
import 'package:todolist/application/notes/actor/note_actor_controller.dart';
import 'package:todolist/application/notes/form/note_form_controller.dart';
import 'package:todolist/application/notes/watcher/note_watcher_controller.dart';
import 'package:todolist/infrastructure/auth/firebase_auth_facade.dart';
import 'package:todolist/infrastructure/notes/note_repository.dart';

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
  Get.put<FirebaseFirestore>(FirebaseFirestore.instance);
  Get.put<NoteRepository>(
    NoteRepository(Get.find<FirebaseFirestore>()),
  );
  Get.put<NoteWatcherController>(
    NoteWatcherController(Get.find<NoteRepository>()),
  );
  Get.put<NoteActorController>(
    NoteActorController(Get.find<NoteRepository>()),
  );
  Get.put<NoteFormController>(
    NoteFormController(Get.find<NoteRepository>()),
  );
}
