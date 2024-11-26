import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/depedency_injection.dart';
import '../../../../core/service/image_cache_service.dart';
import '../bloc/home_bloc.dart';

class HomeDetailPage extends StatelessWidget {
  const HomeDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final scrollController = ScrollController();

    scrollController.addListener(() {
      context
          .read<HomeBloc>()
          .add(HomeDetailScrollPositionChanged(scrollController.offset));
    });

    return Scaffold(
      bottomSheet: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
              width: 1,
              color: Colors.grey.shade200,
            ))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$ ${state.valueProductDetail?.price}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        locator<HomeBloc>().add(HomeAddCartEvent(
                            context: context,
                            value: state.valueProductDetail!));
                      },
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            ),
          );
        },
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (scrollController.offset > 100 && scrollController.hasClients) {
            scrollController.jumpTo(100);
          }
        },
        builder: (context, state) {
          return NestedScrollView(
            controller: scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: size.height / 2, // Tetap 600px
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Hero(
                      tag: state.valueProductDetail!.id,
                      child: ImageCacheService.getNetworkImage(
                        imageUrl: state.valueProductDetail?.image ?? '',
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              width: size.width,
              color: Colors.grey.shade100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      state.valueProductDetail?.title ?? '',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          state.valueProductDetail != null
                              ? state.valueProductDetail?.rating.rate
                                      .toString() ??
                                  '5'
                              : '5',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w800),
                        ),
                        Text(
                          '(${state.valueProductDetail?.rating.count ?? 0})',
                          style: const TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      state.valueProductDetail?.description ?? '',
                      style: const TextStyle(color: Colors.grey),
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
}
