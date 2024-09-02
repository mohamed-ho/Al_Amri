import 'package:alamri_adm/admain_feature/domain/entities/type.dart';
import 'package:alamri_adm/admain_feature/domain/usecase/add_honey_type_usecase.dart';
import 'package:alamri_adm/admain_feature/domain/usecase/delete_honey_type_usecase.dart';
import 'package:alamri_adm/admain_feature/domain/usecase/get_list_of_honey_type_usecase.dart';
import 'package:alamri_adm/admain_feature/domain/usecase/get_one_honey_type_use_case.dart';
import 'package:alamri_adm/admain_feature/domain/usecase/get_type_usecase.dart';
import 'package:alamri_adm/admain_feature/domain/usecase/update_honey_type_usecase.dart';
import 'package:alamri_adm/core/usecase/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'honey_type_event.dart';
part 'honey_type_state.dart';

class HoneyTypeBloc extends Bloc<HoneyTypeEvent, HoneyTypeState> {
  final GetTypeUsecase getTypeUsecase;
  final AddHoneyTypeUsecase addHoneyTypeUsecase;
  final DeleteHoneyTypeUsecase deleteHoneyTypeUsecase;
  final UpdateHoneyTypeUsecase updateHoneyTypeUsecase;
  final GetOneHoneyTypeUseCase getOneHoneyTypeUseCase;
  final GetListOfHoneyTypeUsecase getListOfHoneyTypeUsecase;
  HoneyTypeBloc(
      {required this.getOneHoneyTypeUseCase,
      required this.getTypeUsecase,
      required this.updateHoneyTypeUsecase,
      required this.addHoneyTypeUsecase,
      required this.deleteHoneyTypeUsecase,
      required this.getListOfHoneyTypeUsecase})
      : super(HoneyTypeInitial()) {
    on<GetHoneyTypeEvent>((event, emit) async {
      final result = await getTypeUsecase(NoParams());
      result.fold((l) => emit(HoneyTypeError(message: l.message)),
          (r) => emit(HoneyTypeLoaded(honeyType: r)));
    });

    on<AddHoneyTypeEvent>(
      (event, emit) async {
        emit(HoneyTypeLoading());
        final result = await addHoneyTypeUsecase(event.honeyType);
        result.fold((l) => emit(HoneyTypeError(message: l.message)),
            (r) => emit(HoneyTypeAddedState(state: r)));
      },
    );

    on<DeleteHoneyTypeEven>(
      (event, emit) async {
        final result = await deleteHoneyTypeUsecase(event.honeyId);
        result.fold((l) => emit(HoneyTypeError(message: l.message)),
            (r) => emit(HoneyDeletedState()));
      },
    );

    on<UpdateHoneyTypeEvent>(
      (event, emit) async {
        final result = await updateHoneyTypeUsecase(event.honeyType);
        result.fold((l) => emit(HoneyTypeError(message: l.message)),
            (r) => emit(HoneyTypeAddedState(state: r)));
      },
    );

    on<GetOneHoneyTypeEvent>(
      (event, emit) async {
        final result = await getOneHoneyTypeUseCase(event.typeId);
        result.fold((l) => emit(HoneyTypeError(message: l.message)),
            (r) => emit(GetOneHoneyTypeState(honeyType: r)));
      },
    );

    on<GetListOfHoneyTypeEvent>((event, emit) async {
      final result = await getListOfHoneyTypeUsecase(event.ids);
      result.fold((l) => emit(HoneyTypeError(message: l.message)),
          (r) => emit(GetListOfHoneyTypeState(types: r)));
    });
  }
}
