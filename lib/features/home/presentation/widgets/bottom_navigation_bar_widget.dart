import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:store_me/core/di/depedency_injection.dart';

import '../../../../core/constant/constant.dart';
import '../bloc/home_bloc.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return BottomNavigationBar(
            selectedItemColor: Colors.black,
            currentIndex: state.indexBottomNavigation ?? 0,
            onTap: (value) {
              locator<HomeBloc>().add(HomeChangeBottomNavigationEvent(
                  context: context, index: value));
              context.push(Constant().listBottomNavigation[value].route);
            },
            items: Constant()
                .listBottomNavigation
                .map(
                  (e) => BottomNavigationBarItem(
                    icon: e.icon,
                    label: e.label,
                  ),
                )
                .toList());
      },
    );
  }
}
