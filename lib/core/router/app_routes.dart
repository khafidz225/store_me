part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const HOME = _Paths.HOME;
  static const HOME_DETAIL = _Paths.HOME_DETAIL;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const HOME_DETAIL = '/home/detail';
}
