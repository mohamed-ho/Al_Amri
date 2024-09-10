import 'package:alamri_adm/al_amri_enjection.dart';
import 'package:alamri_adm/config/routes/app_routes.dart';
import 'package:alamri_adm/core/utils/functions.dart';
import 'package:alamri_adm/core/widgets/custom_loading_widget.dart';
import 'package:alamri_adm/features/item_feature/presentation/bloc/items_bloc.dart';
import 'package:alamri_adm/features/item_feature/presentation/widgets/item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemPanelWidget extends StatelessWidget {
  const ItemPanelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text(getTranslation("add_type", context)),
        onPressed: () => Navigator.pushNamed(
          context,
          Routes.addItemScreen,
        ),
      ),
      body: BlocProvider(
        create: (context) => ls<ItemsBloc>()..add(GetItemsEvent()),
        child: BlocBuilder<ItemsBloc, ItemsState>(
          builder: (context, state) {
            if (state is ErrorWidget) {
              return const Text('you have Error');
            } else if (state is ItemsGetedState) {
              return Center(
                  child: state.items.isNotEmpty
                      ? ListView.builder(
                          itemCount: state.items.length,
                          itemBuilder: (context, index) {
                            return ItemWidget(item: state.items[index]!);
                          })
                      : Center(
                          child: Text(getTranslation("item_is_empty", context)),
                        ));
            } else {
              return const CustomLoadingWidget();
            }
          },
        ),
      ),
    );
  }
}
