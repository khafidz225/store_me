import 'package:store_me/core/di/depedency_injection.dart';
import 'package:store_me/core/enum/condition_state_enum.dart';

import 'package:store_me/core/service/image_cache_service.dart';
import 'package:store_me/features/home/presentation/bloc/home_bloc.dart';
import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        locator<HomeBloc>().add(HomeLoadMoreEvent(context: context));
      }
    });
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return NestedScrollView(
            controller: scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 150.0,
                  floating: false,
                  pinned: true,
                  backgroundColor: Colors.blue,
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      collapseMode: CollapseMode.parallax,
                      title: const Text("Galery",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          )),
                      background: Image.network(
                        "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                        fit: BoxFit.cover,
                      )),
                ),
              ];
            },
            body: RefreshIndicator(
              onRefresh: () async {
                locator<HomeBloc>()
                    .add(HomeGetPhotosEvent(context: context, isRender: true));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 150,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: state.valueListPhoto?.photos.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            locator<HomeBloc>().add(HomeGetPhotoDetailEvent(
                                context: context,
                                valuePhotoDetail:
                                    state.valueListPhoto!.photos[index]));
                          },
                          child: state.conditionStateEnum ==
                                  ConditionStateEnum.loading
                              ? CardLoading(
                                  height: 200,
                                  borderRadius: BorderRadius.circular(16),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(16.0),
                                  child: Hero(
                                    tag: state.valueListPhoto!.photos[index].id,
                                    child: ImageCacheService.getNetworkImage(
                                        state.valueListPhoto!.photos[index].src
                                            .portrait),
                                  )),
                        );
                      },
                    ),
                    if (state.conditionStateEnum ==
                        ConditionStateEnum.loadingMore)
                      Positioned(
                        bottom: 16,
                        left: size.width / 2 - 30,
                        child: const CircularProgressIndicator(),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
