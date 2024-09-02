import 'package:alamri_adm/al_amri_enjection.dart';
import 'package:alamri_adm/config/routes/app_routes.dart';
import 'package:alamri_adm/core/utils/functions.dart';
import 'package:alamri_adm/core/widgets/custom_error_widget.dart';
import 'package:alamri_adm/offer_feature/presentation/bloc/offer_bloc.dart';
import 'package:alamri_adm/offer_feature/presentation/widgets/offer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OfferPanelWidget extends StatelessWidget {
  const OfferPanelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Text(getTranslation("add_type", context)),
          onPressed: () {
            Navigator.pushNamed(context, Routes.addOfferScreen);
          }),
      body: BlocProvider(
        create: (context) => ls<OfferBloc>()..add(GetOfferEvent()),
        child: BlocBuilder<OfferBloc, OfferState>(
          builder: (context, state) {
            if (state is OfferErrorState) {
              return CustomErrorWidget(
                  ontap: () =>
                      BlocProvider.of<OfferBloc>(context).add(GetOfferEvent()),
                  title: 'you have Error',
                  content: state.message);
            } else if (state is OfferGetDataState) {
              if (state.offers.isEmpty) {
                return const Center(
                  child: Text('لا يوجد عروض'),
                );
              }
              return ListView.builder(
                  itemCount: state.offers.length,
                  itemBuilder: (context, index) {
                    return OfferWidget(
                      offer: state.offers[index]!,
                    );
                  });
            } else if (state is OfferLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else {
              BlocProvider.of<OfferBloc>(context).add(GetOfferEvent());
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
