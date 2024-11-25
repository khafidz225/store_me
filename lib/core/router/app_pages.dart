import 'package:store_me/features/home/presentation/pages/home_detail_page.dart';
import 'package:store_me/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/bloc/home_bloc.dart';
import '../di/depedency_injection.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static List<RouteBase> routes = [
    GoRoute(
      path: _Paths.HOME,
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: MultiBlocProvider(providers: [
          BlocProvider.value(
              value: locator<HomeBloc>()
                ..add(HomeGetPhotosEvent(context: context, isRender: false))),
        ], child: const HomePage()),
      ),
    ),
    GoRoute(
      path: _Paths.HOME_DETAIL,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: MultiBlocProvider(providers: [
          BlocProvider.value(value: locator<HomeBloc>()),
        ], child: const HomeDetailPage()),
        transitionDuration: const Duration(milliseconds: 600),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0); // Mulai dari bawah
          const end = Offset.zero; // Berakhir di posisi normal
          const curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    ),
  ];
}
