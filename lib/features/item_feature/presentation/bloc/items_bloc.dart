import 'package:alamri_adm/core/usecase/usecase.dart';
import 'package:alamri_adm/features/item_feature/domain/entities/item.dart';
import 'package:alamri_adm/features/item_feature/domain/usecases/add_item_usecase.dart';
import 'package:alamri_adm/features/item_feature/domain/usecases/delete_item_usecase.dart';
import 'package:alamri_adm/features/item_feature/domain/usecases/get_item_usecase.dart';
import 'package:alamri_adm/features/item_feature/domain/usecases/update_item_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  final GetItemUsecase getItemUsecase;
  final AddItemUsecase addItemUsecase;
  final UpdateItemUsecase updateItemUsecase;
  final DeleteItemUsecase deleteItemUsecase;
  ItemsBloc(
      {required this.getItemUsecase,
      required this.addItemUsecase,
      required this.updateItemUsecase,
      required this.deleteItemUsecase})
      : super(ItemsInitial()) {
    on<InitEvent>((event, emit) {
      return emit(ItemsInitial());
    });

    on<GetItemsEvent>((event, emit) async {
      final result = await getItemUsecase(NoParams());
      result.fold((l) => emit(ItemsErrorState(message: l.message)),
          (r) => emit(ItemsGetedState(items: r)));
    });

    on<AddItemEvent>(
      (event, emit) async {
        emit(ItemsLoadingState());
        final result = await addItemUsecase(event.item);
        result.fold((l) => emit(ItemsErrorState(message: l.message)), (r) {
          if (r['status'] == 'success') {
            return emit(ItmesLoadedState(result: r));
          } else {
            return emit(ItemsErrorState(message: r['status']));
          }
        });
      },
    );

    on<UpdateItemEvent>(
      (event, emit) async {
        emit(ItemsLoadingState());
        final result = await updateItemUsecase(event.item);
        result.fold((l) => emit(ItemsErrorState(message: l.message)),
            (r) => emit(ItmesLoadedState(result: r)));
      },
    );

    on<DeleteItemEvent>(
      (event, emit) async {
        final result = await deleteItemUsecase(event.item);
        emit(ItemsLoadingState());
        result.fold((l) => emit(ItemsErrorState(message: l.message)),
            (r) => emit(ItmesLoadedState(result: r)));
      },
    );
  }
}
