import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  expandedHeight: size.height / 1.3, // Tetap 600px
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Hero(
                      tag: state.valuePhotoDetail!.id,
                      child: ImageCacheService.getNetworkImage(
                        state.valuePhotoDetail?.src.portrait ?? '',
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
                      state.valuePhotoDetail!.photographer,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Color(int.parse(
                              '0xff${state.valuePhotoDetail?.avgColor.substring(1)}'))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      state.valuePhotoDetail!.alt,
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(int.parse(
                              '0xff${state.valuePhotoDetail?.avgColor.substring(1)}'))),
                    ),
                  ),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(
                              color: Color(int.parse(
                                  '0xff${state.valuePhotoDetail?.avgColor.substring(1)}')))),
                      onPressed: () async {
                        await launchUrl(Uri.parse(state.valuePhotoDetail!.url));
                      },
                      child: Text(
                        'Profile Photographer',
                        style: TextStyle(
                            color: Color(int.parse(
                                '0xff${state.valuePhotoDetail?.avgColor.substring(1)}'))),
                      ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
