import 'dart:convert';
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
    return BlocProvider(
      create: (context) =>
          ls<HoneyTypeBloc>()..add(GetOneHoneyTypeEvent(typeId: item.typeId)),
      child: BlocBuilder<HoneyTypeBloc, HoneyTypeState>(
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
            return Container(
              height: 25.sh,
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
