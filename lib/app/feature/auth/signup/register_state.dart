import 'package:equatable/equatable.dart';

import '../../../sdk/enum/loading_status.dart';

class RegisterState extends Equatable {
  const RegisterState(
      {this.isVisible = true, this.status = Status.initial, this.errorMessage});
  final bool isVisible;
  final Status status;
  final String? errorMessage;
  RegisterState copyWith({bool? isVisible, Status? status, String? errorMessage}) {
    return RegisterState(
        isVisible: isVisible ?? this.isVisible,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [isVisible, status, errorMessage];
}
