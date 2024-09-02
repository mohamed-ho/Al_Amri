import 'package:alamri_adm/admain_feature/data/data_source/honey_type_remote_data_source.dart';
import 'package:alamri_adm/admain_feature/data/repository/honey_type_repository_impl.dart';
import 'package:alamri_adm/admain_feature/domain/usecase/add_honey_type_usecase.dart';
import 'package:alamri_adm/admain_feature/domain/usecase/delete_honey_type_usecase.dart';
import 'package:alamri_adm/admain_feature/domain/usecase/get_list_of_honey_type_usecase.dart';
import 'package:alamri_adm/admain_feature/domain/usecase/get_one_honey_type_use_case.dart';
import 'package:alamri_adm/admain_feature/domain/usecase/get_type_usecase.dart';
import 'package:alamri_adm/admain_feature/domain/usecase/update_honey_type_usecase.dart';
import 'package:alamri_adm/admain_feature/presentation/bloc/honey_type_bloc.dart';
import 'package:alamri_adm/core/apis/dio_consumer.dart';
import 'package:alamri_adm/core/utils/app_colors.dart';
import 'package:alamri_adm/offer_feature/domain/entities/offer.dart';
import 'package:alamri_adm/offer_feature/presentation/widgets/offer_loaded_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OfferWidget extends StatelessWidget {
  const OfferWidget({super.key, required this.offer});
  final Offer offer;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HoneyTypeBloc(
        addHoneyTypeUsecase: AddHoneyTypeUsecase(
            honeyTypeRepository: HoneyTypeRepositoryImpl(
                honeyTypeRemoteDataSource: HoneyTypeRemoteDataSourceImpl(
                    dioConsumer: DioConsumer(client: Dio())))),
        getTypeUsecase: GetTypeUsecase(
            honeyTypeRepository: HoneyTypeRepositoryImpl(
                honeyTypeRemoteDataSource: HoneyTypeRemoteDataSourceImpl(
                    dioConsumer: DioConsumer(client: Dio())))),
        deleteHoneyTypeUsecase: DeleteHoneyTypeUsecase(
            honeyTypeRepository: HoneyTypeRepositoryImpl(
                honeyTypeRemoteDataSource: HoneyTypeRemoteDataSourceImpl(
                    dioConsumer: DioConsumer(client: Dio())))),
        updateHoneyTypeUsecase: UpdateHoneyTypeUsecase(
            honeyTypeRepository: HoneyTypeRepositoryImpl(
                honeyTypeRemoteDataSource: HoneyTypeRemoteDataSourceImpl(
                    dioConsumer: DioConsumer(client: Dio())))),
        getOneHoneyTypeUseCase: GetOneHoneyTypeUseCase(
            honeyTypeRepository: HoneyTypeRepositoryImpl(
                honeyTypeRemoteDataSource: HoneyTypeRemoteDataSourceImpl(
                    dioConsumer: DioConsumer(client: Dio())))),
        getListOfHoneyTypeUsecase: GetListOfHoneyTypeUsecase(
            honeyTypeRepository: HoneyTypeRepositoryImpl(
                honeyTypeRemoteDataSource: HoneyTypeRemoteDataSourceImpl(
                    dioConsumer: DioConsumer(client: Dio())))),
      )..add(GetListOfHoneyTypeEvent(ids: offer.typesId)),
      child: BlocBuilder<HoneyTypeBloc, HoneyTypeState>(
        builder: (context, state) {
          if (state is HoneyTypeError) {
            return Center(
              child: Text('you Have error ${state.message}'),
            );
          } else if (state is GetListOfHoneyTypeState) {
            return OfferLoadedWidget(offer: offer, types: state.types);
          } else {
            return Container(
              height: 130.h,
              padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 5.w),
              margin: EdgeInsets.symmetric(vertical: 10.w, horizontal: 5.w),
              decoration: BoxDecoration(
                  color: AppColors.backgroundItemsColor,
                  borderRadius: BorderRadius.circular(10.w),
                  boxShadow: [BoxShadow(blurRadius: 5.w, color: Colors.grey)]),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
