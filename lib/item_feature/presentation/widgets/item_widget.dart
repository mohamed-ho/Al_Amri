import 'dart:convert';
import 'package:alamri_adm/admain_feature/presentation/bloc/honey_type_bloc.dart';
import 'package:alamri_adm/core/utils/app_colors.dart';
import 'package:alamri_adm/item_feature/domain/entities/item.dart';
import 'package:alamri_adm/item_feature/presentation/widgets/item_loaded_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemWidget extends StatelessWidget {
  ItemWidget({super.key, required this.item});
  final Item item;
  final String _basicAuth =
      'Basic ${base64Encode(utf8.encode('mohamed:mohamed110'))}';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HoneyTypeBloc, HoneyTypeState>(
      bloc: BlocProvider.of(context)
        ..add(GetOneHoneyTypeEvent(typeId: item.typeId)),
      builder: (context, state) {
        if (state is HoneyTypeError) {
          return Center(
            child: Text('you Have error ${state.message}'),
          );
        } else if (state is GetOneHoneyTypeState) {
          print(state.honeyType.name);
          return ItemLoadedWidget(
            item: item,
            type: state.honeyType,
          );
        } else {
          return Container(
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
    );
  }
}
