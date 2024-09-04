part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class AuthLoginEvent extends AuthEvent {
  final Admin admin;
  const AuthLoginEvent({required this.admin});
  @override
  List<Object> get props => [admin];
}

final class AuthAddUserEvent extends AuthEvent {
  final Admin admin;
  const AuthAddUserEvent({required this.admin});
  @override
  List<Object> get props => [admin];
}

final class AuthLogoutEvent extends AuthEvent {}
