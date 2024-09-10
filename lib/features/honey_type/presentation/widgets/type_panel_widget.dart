import 'package:alamri_adm/al_amri_enjection.dart';
import 'package:alamri_adm/config/routes/app_routes.dart';

import 'package:alamri_adm/core/utils/functions.dart';
import 'package:alamri_adm/core/widgets/custom_error_widget.dart';
import 'package:alamri_adm/core/widgets/custom_loading_widget.dart';
import 'package:alamri_adm/features/honey_type/presentation/bloc/honey_type_bloc.dart';
import 'package:alamri_adm/features/honey_type/presentation/widgets/type_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TypePanelWidget extends StatefulWidget {
  const TypePanelWidget({super.key});

  @override
  State<TypePanelWidget> createState() => _TypePanelWidgetState();
}

class _TypePanelWidgetState extends State<TypePanelWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text(getTranslation("add_type", context)),
        onPressed: () => Navigator.pushNamed(
          context,
          Routes.addHoneyTypeScreen,
        ),
      ),
      body: BlocProvider(
        create: (context) => ls<HoneyTypeBloc>()..add(GetHoneyTypeEvent()),
        child: BlocBuilder<HoneyTypeBloc, HoneyTypeState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            if (state is HoneyTypeError) {
              return CustomErrorWidget(
                  ontap: () => Navigator.pushReplacementNamed(
                      context, Routes.addHoneyTypeScreen),
                  title: 'you have Error',
                  content: state.message);
            } else if (state is HoneyTypeLoaded) {
              if (state.honeyType.isEmpty) {
                return const Center(
                  child: Text('لا يوجد انوع عسل'),
                );
              }
              return ListView.builder(
                  itemCount: state.honeyType.length,
                  itemBuilder: (context, index) {
                    return TypeWidget(
                      honeyType: state.honeyType[index],
                    );
                  });
            } else if (state is HoneyDeletedState) {
              BlocProvider.of<HoneyTypeBloc>(context).add(GetHoneyTypeEvent());
              return const CustomLoadingWidget();
            } else if (state is HoneyTypeAddedState) {
              BlocProvider.of<HoneyTypeBloc>(context).add(GetHoneyTypeEvent());
              return const CustomLoadingWidget();
            } else {
              return const CustomLoadingWidget();
            }
          },
        ),
      ),
    );
  }
}
