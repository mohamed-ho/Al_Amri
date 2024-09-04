import 'package:alamri_adm/features/honey_type/presentation/bloc/honey_type_bloc.dart';
import 'package:alamri_adm/al_amri_enjection.dart';
import 'package:alamri_adm/core/widgets/custom_error_widget.dart';
import 'package:alamri_adm/features/item_feature/presentation/bloc/items_bloc.dart';
import 'package:alamri_adm/features/item_feature/presentation/widgets/add_item_fram.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddItemBlocBuilder extends StatelessWidget {
  const AddItemBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ls<HoneyTypeBloc>()..add(GetHoneyTypeEvent()),
      child: BlocBuilder<HoneyTypeBloc, HoneyTypeState>(
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
            return AddItemFram(types: state.honeyType);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
