import 'package:alamri_adm/features/auth/domain/entities/admin.dart';
import 'package:alamri_adm/features/auth/domain/usecases/add_user_usercase.dart';
import 'package:alamri_adm/features/auth/domain/usecases/login_usecase.dart';
import 'package:alamri_adm/features/auth/domain/usecases/logout_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;
  final LogoutUsecase logoutUsecase;
  final AddUserUsercase addUserUsercase;
  AuthBloc(
      {required this.addUserUsercase,
      required this.loginUsecase,
      required this.logoutUsecase})
      : super(AuthInitial()) {
    on<AuthLoginEvent>((event, emit) async {
      emit(AuthLoadingState());
      final result = await loginUsecase(event.admin);
      result.fold((l) => emit(AuthErrorState(message: l.message)), (r) {
        if (r) {
          emit(AuthCorrectAccountState());
        } else {
          emit(AuthUnCorrectAccountState());
        }
      });
    });

    on<AuthAddUserEvent>(
      (event, emit) async {
        emit(AuthLoadingState());
        final result = await addUserUsercase(event.admin);
        result.fold((l) => emit(AuthErrorState(message: l.message)), (r) {
          emit(AuthLoadedState());
        });
      },
    );
  }
}
