import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_me/core/enum/key_local_storage_enum.dart';
import '../../../../application_info.dart';
import '../../../../core/di/depedency_injection.dart';
import '../../../../core/router/app_pages.dart';
import '../../../home/presentation/bloc/home_bloc.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  bool visible = false;

  @override
  void initState() {
    Future.delayed(
        const Duration(seconds: 1),
        () => {
              setState(() {
                visible = true;
              })
            });
    Future.delayed(const Duration(milliseconds: 3500), () => {checkingAuth()});
    super.initState();
  }

  void checkingAuth() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (!mounted) {
        return; // Pastikan widget masih mounted sebelum menggunakan context
      }
      if (prefs.getString(KeyLocalStorageEnum.token.name) == null) {
        if (mounted) context.go(Routes.LOGIN);
      } else {
        if (mounted) {
          locator<HomeBloc>()
              .add(HomeInitEvent(context: context, isRender: true));
          context.go(Routes.HOME);
        }
      }
    } catch (e) {
      if (mounted) context.go(Routes.LOGIN);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Center(
                child: SizedBox(
                  width: 150,
                  child: AnimatedOpacity(
                    opacity: visible ? 1 : 0,
                    duration: const Duration(seconds: 3),
                    child: Image.asset(
                      'assets/icon/logo_icon.png',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: AnimatedOpacity(
                    opacity: visible ? 1 : 0,
                    duration: const Duration(seconds: 3),
                    child: const Center(
                        child: Text('Version ${ApplicationInfo.version}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff445297),
                            )))))
          ],
        ),
      ),
    ));
  }
}
