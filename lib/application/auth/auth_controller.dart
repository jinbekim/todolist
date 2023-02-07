import 'package:get/get.dart';
import 'package:todolist/application/auth/auth_state.dart';
import 'package:todolist/domain/auth/i_auth_facade.dart';

class AuthController extends GetxController {
  final IAuthFacade _authFacade;
  final state = const AuthState.initial().obs;

  AuthController(this._authFacade);

  static AuthController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    ever(state, (value) {
      if (value == const AuthState.authenticated()) {
        Get.offAllNamed('/note');
      } else if (value == const AuthState.unauthenticated()) {
        Get.offAllNamed('/sign-in');
      }
    });
  }

  Future<void> authCheckRequested() async {
    final userOption = await _authFacade.getSignedInUser();
    state.value = userOption.fold(
      () => const AuthState.unauthenticated(),
      (_) => const AuthState.authenticated(),
    );
  }

  Future<void> signOut() async {
    await _authFacade.signOut();
    state.value = const AuthState.unauthenticated();
  }
}
