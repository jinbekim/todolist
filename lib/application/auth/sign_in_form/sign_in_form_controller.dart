import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:todolist/application/auth/sign_in_form/sign_in_form_state.dart';
import 'package:todolist/domain/auth/auth_failure.dart';
import 'package:todolist/domain/auth/i_auth_facade.dart';
import 'package:todolist/domain/auth/value_objects.dart';

class SignInFormController extends GetxController {
  final state = SignInFormState.initial().obs;
  final IAuthFacade _authFacade;

  SignInFormController(this._authFacade);

  @override
  void onInit() {
    super.onInit();
    ever(
      state,
      (_) => state.value.authFailureOrSuccessOption.fold(
        () {},
        (either) => either.fold(
          (failure) {
            Get.snackbar(
              "alert",
              failure.map(
                cancelledByUser: (_) => 'Cancelled',
                serverError: (_) => 'Server Error',
                emailAlreadyInUse: (_) => 'Email already in use',
                invalidEmailAndPasswordCombination: (_) =>
                    'Invalid email and password combination',
              ),
            );
          },
          (_) {},
        ),
      ),
    );
  }

  void emailChanged(String emailAddressStr) {
    state.value = state.value.copyWith(
      emailAddress: EmailAddress(emailAddressStr),
      authFailureOrSuccessOption: none(),
    );
  }

  void passwordChanged(String passwordStr) {
    state.value = state.value.copyWith(
      password: Password(passwordStr),
      authFailureOrSuccessOption: none(),
    );
  }

  Future<void> registerWithEmailAndPasswordPressed() async {
    Either<AuthFailure, Unit>? failureOrSuccess;

    final isEmailValid = state.value.emailAddress.isValid();
    final isPasswordValid = state.value.password.isValid();

    if (isEmailValid && isPasswordValid) {
      state.value = state.value.copyWith(
        isSubmitting: true,
        authFailureOrSuccessOption: none(),
      );

      failureOrSuccess = await _authFacade.registerWithEmailAndPassword(
        emailAddress: state.value.emailAddress,
        password: state.value.password,
      );
    }

    state.value = state.value.copyWith(
      showErrorMessages: true,
      isSubmitting: false,
      authFailureOrSuccessOption: optionOf(failureOrSuccess),
    );
  }

  Future<void> signInWithEmailAndPasswordPressed() async {
    Either<AuthFailure, Unit>? failureOrSuccess;

    final isEmailValid = state.value.emailAddress.isValid();
    final isPasswordValid = state.value.password.isValid();

    if (isEmailValid && isPasswordValid) {
      state.value = state.value.copyWith(
        isSubmitting: true,
        authFailureOrSuccessOption: none(),
      );

      failureOrSuccess = await _authFacade.signInWithEmailAndPassword(
        emailAddress: state.value.emailAddress,
        password: state.value.password,
      );
    }

    state.value = state.value.copyWith(
      showErrorMessages: true,
      isSubmitting: false,
      authFailureOrSuccessOption: optionOf(failureOrSuccess),
    );
  }

  Future<void> signInWithGooglePressed() async {
    state.value = state.value.copyWith(
      isSubmitting: true,
      authFailureOrSuccessOption: none(),
    );

    final failureOrSuccess = await _authFacade.signInWithGoogle();

    state.value = state.value.copyWith(
      isSubmitting: false,
      authFailureOrSuccessOption: optionOf(failureOrSuccess),
    );
  }
}
