import 'package:alamri_adm/al_amri_enjection.dart';
import 'package:alamri_adm/item_feature/data/data_source/item_remote_data_source.dart';
import 'package:alamri_adm/item_feature/data/repository/items_repository_impl.dart';
import 'package:alamri_adm/item_feature/domain/repository/items_repository.dart';
import 'package:alamri_adm/item_feature/domain/usecases/add_item_usecase.dart';
import 'package:alamri_adm/item_feature/domain/usecases/delete_item_usecase.dart';
import 'package:alamri_adm/item_feature/domain/usecases/get_item_usecase.dart';
import 'package:alamri_adm/item_feature/domain/usecases/update_item_usecase.dart';
import 'package:alamri_adm/item_feature/presentation/bloc/items_bloc.dart';

class ItemsInjection {
  void init() {
    ls.registerFactory(() => ItemsBloc(
        getItemUsecase: ls(),
        addItemUsecase: ls(),
        updateItemUsecase: ls(),
        deleteItemUsecase: ls()));

    ls.registerLazySingleton(() => GetItemUsecase(itemsRepository: ls()));
    ls.registerLazySingleton(() => AddItemUsecase(itemsRepository: ls()));
    ls.registerLazySingleton(() => UpdateItemUsecase(itemsRepository: ls()));
    ls.registerLazySingleton(() => DeleteItemUsecase(itemsRepository: ls()));

    ls.registerLazySingleton<ItemsRepository>(
        () => ItemsRepositoryImpl(itemRemoteDataSource: ls()));

    ls.registerLazySingleton<ItemRemoteDataSource>(
        () => ItemRemoteDataSourceImpl(dioConsumer: ls()));
  }
}
