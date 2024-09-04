import 'package:alamri_adm/al_amri_enjection.dart';
import 'package:alamri_adm/core/widgets/custom_error_widget.dart';
import 'package:alamri_adm/features/orders/domain/entities/item_order.dart';
import 'package:alamri_adm/features/orders/domain/entities/order.dart';
import 'package:alamri_adm/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:alamri_adm/features/orders/presentation/widgets/order_item_details_widget.dart';
import 'package:alamri_adm/features/offer_feature/domain/entities/offer.dart';
import 'package:alamri_adm/features/offer_feature/presentation/bloc/offer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetailsOnPhone extends StatelessWidget {
  const OrderDetailsOnPhone({super.key, required this.orders});
  final Orders orders;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          orders.itemsId != null
              ? Column(
                  children: [
                    Text(
                      'العناصر ',
                      style: TextStyle(
                          fontSize: 18, color: Colors.black.withOpacity(.5)),
                    ),
                    SizedBox(
                      height: orders.offersId != null ? .4.sh : 1.sh,
                      child: BlocProvider(
                        create: (context) => ls<OrdersBloc>()
                          ..add(GetItemOrderEvent(itemsId: orders.itemsId!)),
                        child: BlocBuilder<OrdersBloc, OrdersState>(
                          builder: (context, state) {
                            if (state is OrderErrorState) {
                              return Center(
                                child: CustomErrorWidget(
                                  content: 'حدث خطا حاول مره اخرا',
                                  title: 'خطا',
                                  ontap: () async {
                                    BlocProvider.of<OrdersBloc>(context).add(
                                        GetItemOrderEvent(
                                            itemsId: orders.itemsId!));
                                  },
                                ),
                              );
                            } else if (state is OrdersLoadingState) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is OrderGetedItemsOrderState) {
                              return ListView.builder(
                                  itemCount: state.itemOrder.length,
                                  itemBuilder: (context, index) {
                                    return OrderItemDetailsWidget(
                                      quanity: orders.itemsQuantities![index],
                                      itemOrder: state.itemOrder[index],
                                    );
                                  });
                            } else {
                              BlocProvider.of<OrdersBloc>(context).add(
                                  GetItemOrderEvent(itemsId: orders.itemsId!));
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
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
                          fontSize: 18, color: Colors.black.withOpacity(.5)),
                    ),
                    SizedBox(
                      height: orders.offersId != null ? .38.sh : 1.sh,
                      child: BlocProvider(
                        create: (context) => ls<OfferBloc>()
                          ..add(
                              GetListOfOffersEvent(offerId: orders.offersId!)),
                        child: BlocBuilder<OfferBloc, OfferState>(
                          builder: (context, state) {
                            if (state is OfferErrorState) {
                              return Center(
                                child: CustomErrorWidget(
                                  content: 'حدث خطا حاول مره اخرا',
                                  title: 'خطا',
                                  ontap: () async {
                                    BlocProvider.of<OrdersBloc>(context).add(
                                        GetItemOrderEvent(
                                            itemsId: orders.itemsId!));
                                  },
                                ),
                              );
                            } else if (state is OfferLoadingState) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is OfferGetDataState) {
                              return ListView.builder(
                                  itemCount: state.offers.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: .008.sh,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 5.w,
                                                  color: Colors.grey
                                                      .withOpacity(.5),
                                                  spreadRadius: 5.w)
                                            ]),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: .01.sh,
                                              horizontal: .05.sw),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    state.offers[index]!.title,
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    'سعر العرض : ${state.offers[index]!.price}',
                                                    style: const TextStyle(
                                                        fontSize: 16),
                                                  ),
                                                  Text(
                                                    'عدد طلب العرض : ${orders.offersQuantities![index]}',
                                                    style: const TextStyle(
                                                        fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                height: .2.sw,
                                                width: .2.sw,
                                                decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                          blurRadius: 3.w,
                                                          spreadRadius: 3.w)
                                                    ]),
                                                child: Image.asset(
                                                    'assets/icons/gallery.png'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            } else {
                              BlocProvider.of<OrdersBloc>(context).add(
                                  GetItemOrderEvent(itemsId: orders.itemsId!));
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
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
    );
  }
}
