import 'package:alamri_adm/core/widgets/custom_loading_widget.dart';
import 'package:alamri_adm/features/honey_type/presentation/bloc/honey_type_bloc.dart';
import 'package:alamri_adm/core/widgets/custom_error_widget.dart';
import 'package:alamri_adm/features/item_feature/presentation/bloc/items_bloc.dart';
import 'package:alamri_adm/features/offer_feature/presentation/widgets/add_offer_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddOfferBlocBuilderWidget extends StatelessWidget {
  const AddOfferBlocBuilderWidget({
    super.key,
  });

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
              BlocProvider.of<ItemsBloc>(context).add(InitEvent());
            },
          );
        } else if (state is HoneyTypeLoaded) {
          return AddOfferFormWidget(types: state.honeyType);
        } else {
          return const CustomLoadingWidget();
        }
      },
    );
  }
}
