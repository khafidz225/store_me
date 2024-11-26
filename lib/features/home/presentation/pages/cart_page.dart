import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_me/core/enum/condition_state_enum.dart';
import 'package:store_me/features/home/domain/entities/home_count_product_cart.dart';
import 'package:store_me/features/home/presentation/widgets/bottom_navigation_bar_widget.dart';

import '../../../../core/di/depedency_injection.dart';
import '../../../../core/service/image_cache_service.dart';
import '../../../../core/widget/dashed_line_widget.dart';
import '../bloc/home_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      bottomSheet: _bottomSheetWidget(),
      bottomNavigationBar: const BottomNavigationBarWidget(),
      appBar: PreferredSize(
        preferredSize: Size(size.width, 50),
        child: const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Center(
              child: Text(
                'Cart',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
            )),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 150),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  cardDeliveryWidget(state),
                  const SizedBox(
                    height: 20,
                  ),
                  state.valueCart == null || state.valueCart!.items.isEmpty
                      ? const Expanded(
                          child: Center(
                          child:
                              Text('You haven\'t added a product to your cart'),
                        ))
                      : Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: state.valueCart!.items
                                  .map(
                                    (e) => cardProduct(e, context),
                                  )
                                  .toList(),
                            ),
                          ),
                        )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  BlocBuilder<HomeBloc, HomeState> _bottomSheetWidget() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Container(
          height: 150,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: const BoxDecoration(
              border: Border(
                  top: BorderSide(
            width: 1,
            color: Colors.white,
          ))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              listTileHorizontal(
                  label: 'Sub Total',
                  price: '${state.valueCart?.subtotal ?? 0}'),
              listTileHorizontal(
                  label: 'Delivery Fee',
                  price: '${state.valueCart?.deliveryFee ?? 0}'),
              const DashedLine(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '\$${state.valueCart?.total ?? 0}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  state.valueCart == null || state.valueCart!.items.isEmpty
                      ? Container(
                          width: 130,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                            child: Text(
                              'Checkout',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      : SizedBox(
                          width: 130,
                          height: 50,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onPressed: () {
                                locator<HomeBloc>().add(
                                    HomeCheckoutCartEvent(context: context));
                              },
                              child: state.conditionStateEnum ==
                                      ConditionStateEnum.loadingButton
                                  ? const Center(
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : const Text(
                                      'Checkout',
                                      style: TextStyle(color: Colors.white),
                                    )),
                        )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Container cardProduct(HomeProductItemEntities e, BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ImageCacheService.getNetworkImage(
              imageUrl: e.product.image, width: 100, height: 100),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    e.product.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        const Text(
                          '\$',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Text('${e.product.price}')
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: 70,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    locator<HomeBloc>().add(HomeUpdateCartEvent(
                        context: context,
                        value: e.product,
                        count: e.count - 1));
                  },
                  child: const Icon(
                    Icons.remove,
                    size: 14,
                  ),
                ),
                Text('${e.count}'),
                InkWell(
                  onTap: () {
                    locator<HomeBloc>().add(HomeUpdateCartEvent(
                        context: context,
                        value: e.product,
                        count: e.count + 1));
                  },
                  child: const Icon(
                    Icons.add,
                    size: 14,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Row listTileHorizontal({required String label, required String price}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style:
              TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w600),
        ),
        Text(
          '\$$price',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Container cardDeliveryWidget(HomeState state) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[100],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.place,
            color: Colors.grey[700],
          ),
          const SizedBox(
            width: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Delivering to',
                style: TextStyle(fontSize: 12, color: Colors.grey[700]),
              ),
              FittedBox(
                child: Text(
                  '${state.valueMyProfile?.address.street} ${state.valueMyProfile?.address.city} ${state.valueMyProfile?.address.zipcode}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
