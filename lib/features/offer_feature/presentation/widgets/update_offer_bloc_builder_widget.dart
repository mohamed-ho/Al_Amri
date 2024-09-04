import 'package:alamri_adm/features/honey_type/presentation/bloc/honey_type_bloc.dart';
import 'package:alamri_adm/core/widgets/custom_error_widget.dart';
import 'package:alamri_adm/features/offer_feature/domain/entities/offer.dart';
import 'package:alamri_adm/features/offer_feature/presentation/widgets/update_offer_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateOfferBlocBuilderWidget extends StatelessWidget {
  const UpdateOfferBlocBuilderWidget({
    super.key,
    required this.offer,
  });
  final Offer offer;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HoneyTypeBloc, HoneyTypeState>(
      bloc: BlocProvider.of<HoneyTypeBloc>(context)..add(GetHoneyTypeEvent()),
      builder: (context, state) {
        if (state is HoneyTypeError) {
          return CustomErrorWidget(
            title: 'error in loading',
            content: 'you have error ${state.message}',
            ontap: () {
              BlocProvider.of<HoneyTypeBloc>(context).add(GetHoneyTypeEvent());
            },
          );
        } else if (state is HoneyTypeLoaded) {
          return UpdateOfferFormWidget(
            types: state.honeyType,
            offer: offer,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
