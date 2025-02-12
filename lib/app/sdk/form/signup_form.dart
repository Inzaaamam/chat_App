import 'package:reactive_forms/reactive_forms.dart';

class SignUpForm {
  static final registerForm = FormGroup({
    'email': FormControl<String>(validators: [Validators.required, Validators.email]),
    'password': FormControl<String>(validators: [Validators.required]),
    'confirm_password': FormControl<String>(
      validators: [],
    ),
  }, validators: [
    Validators.mustMatch('password', 'confirm_password', markAsDirty: false),
    Validators.required
  ]);
}
