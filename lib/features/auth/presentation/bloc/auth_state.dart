part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthUnCorrectAccountState extends AuthState {}

final class AuthCorrectAccountState extends AuthState {}

final class AuthErrorState extends AuthState {
  final String message;

  const AuthErrorState({required this.message});
}

final class AuthLoadedState extends AuthState {}
