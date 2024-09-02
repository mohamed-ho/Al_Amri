import 'package:alamri_adm/al_amri_enjection.dart';
import 'package:alamri_adm/features/orders/data/datasources/order_remote_data_source.dart';
import 'package:alamri_adm/features/orders/data/repositories/order_repository_impl.dart';
import 'package:alamri_adm/features/orders/domain/repositories/order_repository.dart';
import 'package:alamri_adm/features/orders/domain/usecases/delete_order_usecase.dart';
import 'package:alamri_adm/features/orders/domain/usecases/get_list_of_item_order_usecase.dart';
import 'package:alamri_adm/features/orders/domain/usecases/get_orders_usecase.dart';
import 'package:alamri_adm/features/orders/presentation/bloc/orders_bloc.dart';

class OrderInjection {
  void init() {
    ls.registerFactory(() => OrdersBloc(
        deleteOrderUsecase: ls(),
        getOrdersUsecase: ls(),
        getListOfItemOrderUsecase: ls()));
    ls.registerLazySingleton(() => DeleteOrderUsecase(orderRepository: ls()));
    ls.registerLazySingleton(() => GetOrdersUsecase(orderRepository: ls()));
    ls.registerLazySingleton(
        () => GetListOfItemOrderUsecase(orderRepository: ls()));
    ls.registerLazySingleton<OrderRepository>(
        () => OrderRepositoryImpl(orderRemoteDataSource: ls()));
    ls.registerLazySingleton<OrderRemoteDataSource>(
        () => OrderRemoteDataSourceImpl(dioConsumer: ls()));
  }
}
