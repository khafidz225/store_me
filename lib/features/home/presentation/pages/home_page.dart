import 'dart:math';

import 'package:store_me/core/di/depedency_injection.dart';
import 'package:store_me/core/enum/condition_state_enum.dart';

import 'package:store_me/core/service/image_cache_service.dart';

import 'package:store_me/features/home/presentation/bloc/home_bloc.dart';
import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widget/textformfield_custom.dart';
import '../widgets/bottom_navigation_bar_widget.dart';
import '../widgets/skl_product_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(size.width, 80),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: TextFormFieldCustom(
            controller: searchController,
            label: 'Search',
            isTopLabel: false,
            isRequired: false,
            fillColor: Colors.grey.shade200,
            filled: true,
            keyboardType: TextInputType.name,
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(20)),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: size.width,
                  height: 30,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        state.conditionStateEnum == ConditionStateEnum.loading
                            ? 5
                            : state.valueListCategory?.length ?? 0,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 5,
                      );
                    },
                    itemBuilder: (context, index) {
                      bool isActiveColor = state.valueListCategory?[index] ==
                          state.activeCategory;
                      return state.conditionStateEnum ==
                              ConditionStateEnum.loading
                          ? CardLoading(
                              height: 30,
                              width: 35 + (Random().nextDouble() * (150 - 35)),
                              borderRadius: BorderRadius.circular(10),
                            )
                          : InkWell(
                              onTap: () {
                                locator<HomeBloc>().add(HomeChangeCategoryEvent(
                                    context: context,
                                    activeCategory:
                                        state.valueListCategory?[index] ??
                                            'all'));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: isActiveColor
                                        ? null
                                        : Border.all(
                                            color: Colors.grey.shade200,
                                          ),
                                    color: isActiveColor
                                        ? Colors.black
                                        : Colors.white),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Text(
                                      state.valueListCategory?[index] ?? '',
                                      style: TextStyle(
                                          color: isActiveColor
                                              ? Colors.white
                                              : Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                            );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: state.conditionStateEnum ==
                                ConditionStateEnum.loading ||
                            state.conditionStateEnum ==
                                ConditionStateEnum.loadingCard
                        ? 4
                        : state.valueListProduct?.length,
                    itemBuilder: (context, index) {
                      final valueProduct = state.valueListProduct?[index];
                      return state.conditionStateEnum ==
                                  ConditionStateEnum.loading ||
                              state.conditionStateEnum ==
                                  ConditionStateEnum.loadingCard
                          ? const SklProductCard()
                          : InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {
                                locator<HomeBloc>().add(HomeProductDetailEvent(
                                    context: context,
                                    productDetail:
                                        state.valueListProduct![index]));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  state.conditionStateEnum ==
                                              ConditionStateEnum.loading &&
                                          state.valueListProduct?[index] == null
                                      ? CardLoading(
                                          height: 150,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        )
                                      : SizedBox(
                                          height: 150,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                              child: Hero(
                                                tag: state
                                                        .valueListProduct?[
                                                            index]
                                                        .id ??
                                                    0,
                                                child: ImageCacheService
                                                    .getNetworkImage(
                                                        imageUrl: state
                                                                .valueListProduct?[
                                                                    index]
                                                                .image ??
                                                            '',
                                                        width: 200,
                                                        height: 200),
                                              )),
                                        ),
                                  Text(
                                    valueProduct?.title ?? '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    children: [
                                      const Padding(
                                          padding: EdgeInsets.only(right: 2),
                                          child: Text(
                                            '\$',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          )),
                                      Text(
                                          valueProduct?.price.toString() ?? ''),
                                    ],
                                  )
                                ],
                              ));
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
