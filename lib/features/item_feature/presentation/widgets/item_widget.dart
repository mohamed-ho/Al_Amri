import 'dart:convert';
import 'package:alamri_adm/core/widgets/custom_loading_widget.dart';
import 'package:alamri_adm/features/honey_type/presentation/bloc/honey_type_bloc.dart';
import 'package:alamri_adm/al_amri_enjection.dart';
import 'package:alamri_adm/core/utils/app_colors.dart';
import 'package:alamri_adm/features/item_feature/domain/entities/item.dart';
import 'package:alamri_adm/features/item_feature/presentation/widgets/item_loaded_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HoneyTypeBloc, HoneyTypeState>(
      bloc: BlocProvider.of<HoneyTypeBloc>(context)
        ..add(GetOneHoneyTypeEvent(typeId: item.typeId)),
      builder: (context, state) {
        if (state is HoneyTypeError) {
          return Center(
            child: Text('you Have error ${state.message}'),
          );
        } else if (state is GetOneHoneyTypeState) {
          return ItemLoadedWidget(
            item: item,
            type: state.honeyType,
          );
        } else {
          return const CustomLoadingWidget();
        }
      },
    );
  }
}
