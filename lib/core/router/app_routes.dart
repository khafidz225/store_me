part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const SPLASH_SCREEN = _Paths.SPLASH_SCREEN;
  static const LOGIN = _Paths.LOGIN;
  static const HOME = _Paths.HOME;
  static const HOME_DETAIL = _Paths.HOME_DETAIL;

  static const CART = _Paths.CART;

  static const PROFILE = _Paths.PROFILE;
}

abstract class _Paths {
  _Paths._();

  static const SPLASH_SCREEN = '/splash_screen';
  static const LOGIN = '/login';

  static const HOME = '/home';
  static const HOME_DETAIL = '/home/detail';

  static const CART = '/cart';

  static const PROFILE = '/profile';
}
