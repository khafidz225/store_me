import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_me/core/di/depedency_injection.dart';

import '../bloc/home_bloc.dart';
import '../widgets/bottom_navigation_bar_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(size.width, 50),
        child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox.shrink(),
                const Text(
                  'Profile',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ),
                IconButton(
                    onPressed: () {
                      locator<HomeBloc>()
                          .add(HomeLogoutEvent(context: context));
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.red,
                    ))
              ],
            )),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: const BottomNavigationBarWidget(),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${state.valueMyProfile?.name.firstname} ${state.valueMyProfile?.name.lastname}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                _listTileProfile(
                    icon: Icons.email,
                    value: state.valueMyProfile?.email ?? ''),
                _listTileProfile(
                    icon: Icons.phone,
                    value: state.valueMyProfile?.phone ?? ''),
                _listTileProfile(
                    icon: Icons.place,
                    value:
                        '${state.valueMyProfile?.address.street} ${state.valueMyProfile?.address.city} ${state.valueMyProfile?.address.zipcode}'),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _listTileProfile({required IconData icon, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Icon(
              icon,
              size: 18,
            ),
          ),
          Text(value),
        ],
      ),
    );
  }
}
