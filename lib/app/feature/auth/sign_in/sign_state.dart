import 'package:equatable/equatable.dart';

import '../../../sdk/enum/loading_status.dart';

class SignState extends Equatable {
  const SignState({this.status = Status.initial, this.errorMessage});
  final Status status;
  final String? errorMessage;
  SignState copyWith({Status? status, String? errorMessage}) {
    return SignState(
        status: status ?? this.status, errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [status];
}
