import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/application/auth/sign_in_form/sign_in_form_controller.dart';

class SignInForm extends StatelessWidget {
  SignInForm({super.key});

  final SignInFormController _c = Get.find<SignInFormController>();

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            '📝',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 130),
          ),
          const SizedBox(height: 8),
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.email),
              labelText: 'Email',
            ),
            autocorrect: false,
            onChanged: (value) => _c.emailChanged(value),
            validator: (_) => _c.state.value.emailAddress.value.fold(
              (f) => f.maybeMap(
                invalidEmail: (_) => 'Invalid Email',
                orElse: () => null,
              ),
              (_) => null,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.lock),
              labelText: 'Password',
            ),
            autocorrect: false,
            obscureText: true,
            onChanged: (value) => _c.passwordChanged(value),
            validator: (_) => _c.state.value.password.value.fold(
              (f) => f.maybeMap(
                shortPassword: (_) => 'Short Password',
                orElse: () => null,
              ),
              (_) => null,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => _c.signInWithEmailAndPasswordPressed(),
                  child: const Text('SIGN IN'),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () => _c.registerWithEmailAndPasswordPressed(),
                  child: const Text('REGISTER'),
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () => _c.signInWithGooglePressed(),
            child: const Text(
              'SIGN IN WITH GOOGLE',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Obx(
            () {
              return _c.state.value.isSubmitting
                  ? Column(
                      children: const [
                        SizedBox(height: 8),
                        LinearProgressIndicator(),
                      ],
                    )
                  : Container();
            },
          )
        ],
      ),
    );
//       },
//     );
  }
}
