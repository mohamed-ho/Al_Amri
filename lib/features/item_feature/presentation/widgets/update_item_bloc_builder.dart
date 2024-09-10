import 'package:alamri_adm/core/widgets/custom_loading_widget.dart';
import 'package:alamri_adm/features/honey_type/presentation/bloc/honey_type_bloc.dart';
import 'package:alamri_adm/core/widgets/custom_error_widget.dart';
import 'package:alamri_adm/features/item_feature/domain/entities/item.dart';
import 'package:alamri_adm/features/item_feature/presentation/bloc/items_bloc.dart';
import 'package:alamri_adm/features/item_feature/presentation/widgets/update_item_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateItemBlocBuilder extends StatelessWidget {
  const UpdateItemBlocBuilder({
    super.key,
    required this.item,
  });
  final Item item;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
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
            return UpdateItemFormWidget(types: state.honeyType, item: item);
          } else {
            return const CustomLoadingWidget();
          }
        });
  }
}
