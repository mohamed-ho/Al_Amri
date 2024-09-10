import 'package:alamri_adm/al_amri_enjection.dart';
import 'package:alamri_adm/core/utils/app_colors.dart';
import 'package:alamri_adm/core/widgets/custom_error_widget.dart';
import 'package:alamri_adm/core/widgets/custom_loading_widget.dart';
import 'package:alamri_adm/features/offer_feature/domain/entities/offer.dart';
import 'package:alamri_adm/features/orders/domain/entities/order.dart';
import 'package:alamri_adm/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:alamri_adm/features/orders/presentation/widgets/order_item_details_widget.dart';
import 'package:alamri_adm/features/offer_feature/presentation/bloc/offer_bloc.dart';
import 'package:alamri_adm/features/orders/presentation/widgets/order_offers_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetailsOnPhone extends StatelessWidget {
  const OrderDetailsOnPhone({super.key, required this.orders});
  final Orders orders;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.logoBackgroundColor,
        body: Row(
          children: [
            ScreenUtil().screenWidth > 1200
                ? Expanded(
                    flex: 1,
                    child: Container(
                      decoration:
                          BoxDecoration(color: AppColors.logoBackgroundColor),
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: .20.sw,
                        height: 20.sw,
                      ),
                    ),
                  )
                : const SizedBox(),
            Expanded(
              flex: 2,
              child: ListView(
                children: [
                  orders.itemsId != null
                      ? Column(
                          children: [
                            Text(
                              'العناصر ',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black.withOpacity(.5)),
                            ),
                            SizedBox(
                              height: orders.offersId != null ? .4.sh : .9.sh,
                              child: BlocProvider(
                                create: (context) => ls<OrdersBloc>()
                                  ..add(GetItemOrderEvent(
                                      itemsId: orders.itemsId!)),
                                child: BlocBuilder<OrdersBloc, OrdersState>(
                                  builder: (context, state) {
                                    if (state is OrderErrorState) {
                                      return Center(
                                        child: CustomErrorWidget(
                                          content: 'حدث خطا حاول مره اخرا',
                                          title: 'خطا',
                                          ontap: () async {
                                            BlocProvider.of<OrdersBloc>(context)
                                                .add(GetItemOrderEvent(
                                                    itemsId: orders.itemsId!));
                                          },
                                        ),
                                      );
                                    } else if (state is OrdersLoadingState) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (state
                                        is OrderGetedItemsOrderState) {
                                      return ListView.builder(
                                          itemCount: state.itemOrder.length,
                                          itemBuilder: (context, index) {
                                            return OrderItemDetailsWidget(
                                              quanity: orders
                                                  .itemsQuantities![index],
                                              itemOrder: state.itemOrder[index],
                                            );
                                          });
                                    } else {
                                      BlocProvider.of<OrdersBloc>(context).add(
                                          GetItemOrderEvent(
                                              itemsId: orders.itemsId!));
                                      return const CustomLoadingWidget();
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                  orders.offersId != null
                      ? Column(
                          children: [
                            Text(
                              'العروض ',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black.withOpacity(.5)),
                            ),
                            SizedBox(
                              height: orders.offersId != null ? .38.sh : .9.sh,
                              child: BlocProvider(
                                create: (context) => ls<OfferBloc>()
                                  ..add(GetListOfOffersEvent(
                                      offerId: orders.offersId!)),
                                child: BlocBuilder<OfferBloc, OfferState>(
                                  builder: (context, state) {
                                    if (state is OfferErrorState) {
                                      return Center(
                                        child: CustomErrorWidget(
                                          content: 'حدث خطا حاول مره اخرا',
                                          title: 'خطا',
                                          ontap: () async {
                                            BlocProvider.of<OrdersBloc>(context)
                                                .add(GetItemOrderEvent(
                                                    itemsId: orders.itemsId!));
                                          },
                                        ),
                                      );
                                    } else if (state is OfferLoadingState) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (state is OfferGetDataState) {
                                      return OrderOffersDetailsWidget(
                                          offers: state.offers, order: orders);
                                    } else {
                                      BlocProvider.of<OrdersBloc>(context).add(
                                          GetItemOrderEvent(
                                              itemsId: orders.itemsId!));
                                      return const CustomLoadingWidget();
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                  Column(
                    children: [
                      Text(
                        'السعر الاجمالى',
                        style: TextStyle(
                            fontSize: 18, color: Colors.black.withOpacity(.5)),
                      ),
                      const Divider(),
                      Text(
                        '${orders.totalPrice}',
                        style: const TextStyle(
                            fontSize: 22,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ),
            ScreenUtil().screenWidth > 1200
                ? Expanded(
                    flex: 1,
                    child: Container(
                      decoration:
                          BoxDecoration(color: AppColors.logoBackgroundColor),
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: .20.sw,
                        height: 20.sw,
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ));
  }
}
