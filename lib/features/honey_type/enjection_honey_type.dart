import 'package:alamri_adm/features/honey_type/data/data_source/honey_type_remote_data_source.dart';
import 'package:alamri_adm/features/honey_type/data/repository/honey_type_repository_impl.dart';
import 'package:alamri_adm/features/honey_type/domain/repository/honey_type_repository.dart';
import 'package:alamri_adm/features/honey_type/domain/usecase/add_honey_type_usecase.dart';
import 'package:alamri_adm/features/honey_type/domain/usecase/delete_honey_type_usecase.dart';
import 'package:alamri_adm/features/honey_type/domain/usecase/get_list_of_honey_type_usecase.dart';
import 'package:alamri_adm/features/honey_type/domain/usecase/get_one_honey_type_use_case.dart';
import 'package:alamri_adm/features/honey_type/domain/usecase/get_type_usecase.dart';
import 'package:alamri_adm/features/honey_type/domain/usecase/update_honey_type_usecase.dart';
import 'package:alamri_adm/features/honey_type/presentation/bloc/honey_type_bloc.dart';
import 'package:alamri_adm/al_amri_enjection.dart';
import 'package:alamri_adm/core/apis/dio_consumer.dart';
import 'package:dio/dio.dart';

class EnjectionHoneyType {
  void init() {
    ls.registerFactory(() => HoneyTypeBloc(
        getOneHoneyTypeUseCase: ls(),
        getTypeUsecase: ls(),
        updateHoneyTypeUsecase: ls(),
        addHoneyTypeUsecase: ls(),
        deleteHoneyTypeUsecase: ls(),
        getListOfHoneyTypeUsecase: ls()));

    ls.registerLazySingleton(
        () => GetOneHoneyTypeUseCase(honeyTypeRepository: ls()));
    ls.registerLazySingleton(() => GetTypeUsecase(honeyTypeRepository: ls()));
    ls.registerLazySingleton(
        () => UpdateHoneyTypeUsecase(honeyTypeRepository: ls()));
    ls.registerLazySingleton(
        () => AddHoneyTypeUsecase(honeyTypeRepository: ls()));
    ls.registerLazySingleton(
        () => DeleteHoneyTypeUsecase(honeyTypeRepository: ls()));
    ls.registerLazySingleton(
        () => GetListOfHoneyTypeUsecase(honeyTypeRepository: ls()));

    ls.registerLazySingleton<HoneyTypeRepository>(
        () => HoneyTypeRepositoryImpl(honeyTypeRemoteDataSource: ls()));

    ls.registerLazySingleton<HoneyTypeRemoteDataSource>(
        () => HoneyTypeRemoteDataSourceImpl(dioConsumer: ls()));

    ls.registerLazySingleton(() => DioConsumer(client: ls()));
    ls.registerLazySingleton(() => Dio());
    
  }
}
