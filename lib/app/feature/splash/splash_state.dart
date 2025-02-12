import 'package:equatable/equatable.dart';

class SplashState extends Equatable {
  const SplashState({this.loaded = false});
  final bool? loaded;
  SplashState copyWith({bool? loaded}) {
    return SplashState(loaded: loaded ?? this.loaded);
  }

  @override
  List<Object?> get props => [loaded];
}
