import 'package:alamri_adm/core/utils/app_colors.dart';
import 'package:alamri_adm/features/item_feature/domain/entities/item.dart';
import 'package:alamri_adm/features/item_feature/presentation/widgets/add_item_bloc_builder.dart';
import 'package:alamri_adm/features/item_feature/presentation/widgets/update_item_bloc_builder.dart';
import 'package:flutter/material.dart';

class AddItemScreen extends StatelessWidget {
  const AddItemScreen({super.key, this.item});
  final Item? item;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.logoBackgroundColor,
        body: item != null
            ? UpdateItemBlocBuilder(item: item!)
            : const AddItemBlocBuilder());
  }
}
