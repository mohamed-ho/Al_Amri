import 'package:alamri_adm/config/routes/app_routes.dart';
import 'package:alamri_adm/core/utils/app_colors.dart';
import 'package:alamri_adm/core/utils/functions.dart';
import 'package:alamri_adm/core/widgets/custom_error_widget.dart';
import 'package:alamri_adm/core/widgets/success_process_widget.dart';
import 'package:alamri_adm/features/offer_feature/domain/entities/offer.dart';
import 'package:alamri_adm/features/offer_feature/presentation/bloc/offer_bloc.dart';
import 'package:alamri_adm/features/offer_feature/presentation/widgets/add_offer_bloc_builder_widget.dart';
import 'package:alamri_adm/features/offer_feature/presentation/widgets/update_offer_bloc_builder_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddOfferScreen extends StatelessWidget {
  const AddOfferScreen({super.key, this.offer});
  final Offer? offer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.logoBackgroundColor,
        body: offer != null
            ? UpdateOfferBlocBuilderWidget(offer: offer!)
            : const AddOfferBlocBuilderWidget());
  }
}
