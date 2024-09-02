import 'package:alamri_adm/config/routes/app_routes.dart';
import 'package:alamri_adm/core/utils/functions.dart';
import 'package:alamri_adm/core/widgets/custom_error_widget.dart';
import 'package:alamri_adm/core/widgets/success_process_widget.dart';
import 'package:alamri_adm/item_feature/domain/entities/item.dart';
import 'package:alamri_adm/item_feature/presentation/bloc/items_bloc.dart';
import 'package:alamri_adm/item_feature/presentation/widgets/add_item_bloc_builder.dart';
import 'package:alamri_adm/item_feature/presentation/widgets/update_item_bloc_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddItemScreen extends StatelessWidget {
  const AddItemScreen({super.key, this.item});
  final Item? item;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ItemsBloc, ItemsState>(
        builder: (context, state) {
          if (state is ItemsErrorState) {
            return CustomErrorWidget(
                ontap: () {
                  BlocProvider.of<ItemsBloc>(context).add(InitEvent());
                },
                title: 'error in loading',
                content: 'you have error ${state.message}');
          } else if (state is ItemsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ItmesLoadedState) {
            return SuccessProcess(
              title: getTranslation("success_process", context),
              content: item != null
                  ? getTranslation("update_item_is_success", context)
                  : getTranslation("adding_item_is_success", context),
              onTap: () => Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.inisialRoute,
                arguments: 1,
                (route) => false,
              ),
            );
          } else {
            return item != null
                ? UpdateItemBlocBuilder(item: item!)
                : const AddItemBlocBuilder();
          }
        },
      ),
    );
  }
}
