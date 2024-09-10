import 'package:alamri_adm/al_amri_enjection.dart';
import 'package:alamri_adm/core/widgets/custom_error_widget.dart';
import 'package:alamri_adm/core/widgets/custom_loading_widget.dart';
import 'package:alamri_adm/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:alamri_adm/features/orders/presentation/widgets/order_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ls<OrdersBloc>()..add(GetOrdersEvent()),
        child: BlocBuilder<OrdersBloc, OrdersState>(
          builder: (context, state) {
            if (state is OrderErrorState) {
              return Center(
                child: CustomErrorWidget(
                  title: 'خطأ',
                  content: "حدث خطا من فضلك حاول مره اخره",
                  ontap: () async {
                    BlocProvider.of<OrdersBloc>(context).add(GetOrdersEvent());
                  },
                ),
              );
            } else if (state is OrdersLoadingState) {
              return const CustomLoadingWidget();
            } else if (state is OrderGetedState) {
              if (state.orders.isEmpty) {
                return const Center(
                  child: Text('لا يوجد طلابات'),
                );
              }
              return ListView.builder(
                  itemCount: state.orders.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OrderWidget(
                        order: state.orders[index],
                      ),
                    );
                  });
            } else {
              BlocProvider.of<OrdersBloc>(context).add(GetOrdersEvent());
              return const CustomLoadingWidget();
            }
          },
        ),
      ),
    );
  }
}
