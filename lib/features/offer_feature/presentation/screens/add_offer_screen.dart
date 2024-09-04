import 'package:alamri_adm/config/routes/app_routes.dart';
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
      body: BlocBuilder<OfferBloc, OfferState>(
        builder: (context, state) {
          if (state is OfferErrorState) {
            return CustomErrorWidget(
                ontap: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.inisialRoute,
                    arguments: 2,
                    (route) => false,
                  );
                },
                title: 'error in loading',
                content: 'you have error ${state.message}');
          } else if (state is OfferLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is OfferLoadedState) {
            return SuccessProcess(
              title: getTranslation("success_process", context),
              content: offer != null
                  ? getTranslation("update_item_is_success", context)
                  : getTranslation("adding_item_is_success", context),
              onTap: () => Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.inisialRoute,
                (route) => false,
              ),
            );
          } else {
            return offer != null
                ? UpdateOfferBlocBuilderWidget(offer: offer!)
                : const AddOfferBlocBuilderWidget();
          }
        },
      ),
    );
  }
}
