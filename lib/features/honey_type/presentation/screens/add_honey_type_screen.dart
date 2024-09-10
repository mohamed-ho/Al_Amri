import 'package:alamri_adm/config/routes/app_routes.dart';
import 'package:alamri_adm/core/utils/app_colors.dart';
import 'package:alamri_adm/core/utils/functions.dart';
import 'package:alamri_adm/core/widgets/custom_error_widget.dart';
import 'package:alamri_adm/core/widgets/custom_loading_widget.dart';
import 'package:alamri_adm/core/widgets/success_process_widget.dart';
import 'package:alamri_adm/features/honey_type/domain/entities/type.dart';
import 'package:alamri_adm/features/honey_type/presentation/bloc/honey_type_bloc.dart';
import 'package:alamri_adm/features/honey_type/presentation/widgets/add_honey_type_widget.dart';
import 'package:alamri_adm/features/honey_type/presentation/widgets/update_honey_type_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class AddHoneyTypeScreen extends StatelessWidget {
  AddHoneyTypeScreen({super.key, this.honeyType});
  HoneyType? honeyType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.logoBackgroundColor,
      body: BlocBuilder<HoneyTypeBloc, HoneyTypeState>(
        builder: (context, state) {
          if (state is HoneyTypeError) {
            return CustomErrorWidget(
                ontap: () => Navigator.pushReplacementNamed(
                    context, Routes.addHoneyTypeScreen),
                title: 'you have Error',
                content: 'you have error in the internet connection');
          } else if (state is HoneyTypeAddedState) {
            return SuccessProcess(
              title: getTranslation("adding_successfully_title", context),
              content: getTranslation("adding_successfully_content", context),
              onTap: () => Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.inisialRoute,
                (route) => false,
              ),
            );
          } else if (state is HoneyTypeLoading) {
            return const CustomLoadingWidget();
          } else {
            return honeyType != null
                ? UpdateHoneyTypeWidget(
                    honeyType: honeyType!,
                  )
                : const AddHoneyForm();
          }
        },
      ),
    );
  }
}
