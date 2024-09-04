import 'package:alamri_adm/al_amri_enjection.dart';
import 'package:alamri_adm/features/auth/data/datasources/admin_remote_data_source.dart';
import 'package:alamri_adm/features/auth/data/repositories/admin_repository_impl.dart';
import 'package:alamri_adm/features/auth/domain/repositories/admin_repository.dart';
import 'package:alamri_adm/features/auth/domain/usecases/add_user_usercase.dart';
import 'package:alamri_adm/features/auth/domain/usecases/login_usecase.dart';
import 'package:alamri_adm/features/auth/domain/usecases/logout_usecase.dart';
import 'package:alamri_adm/features/auth/presentation/bloc/auth_bloc.dart';

class AuthInjection {
  void init() {
    ls.registerFactory(() => AuthBloc(
        addUserUsercase: ls(), loginUsecase: ls(), logoutUsecase: ls()));

    ls.registerLazySingleton(() => AddUserUsercase(adminRepository: ls()));
    ls.registerLazySingleton(() => LoginUsecase(adminRepository: ls()));
    ls.registerLazySingleton(() => LogoutUsecase(adminRepository: ls()));

    ls.registerLazySingleton<AdminRepository>(
        () => AdminRepositoryImpl(adminRemoteDataSource: ls()));

    ls.registerLazySingleton<AdminRemoteDataSource>(
        () => AdminRemoteDataSourceImpl(dioConsumer: ls()));
  }
}
