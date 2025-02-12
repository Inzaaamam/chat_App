import 'package:reactive_forms/reactive_forms.dart';

class LoginForm {
  static final loginForm = FormGroup({
    'email': FormControl<String>(validators: [Validators.required, Validators.email]),
    'password': FormControl<String>(validators: [Validators.required])
  });
}
