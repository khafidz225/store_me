import 'package:flutter/material.dart';

import '../widget/snackbar_custom.dart';
import 'failure.dart';

class TrigerError {
  void trigerSnackbarError(
      {required BuildContext context,
      required Failure error,
      required String title}) {
    if (error is ConnectionFailure &&
        error.message.split(' ').first.toLowerCase() != 'no') {
      debugPrint('CONNECTION FAILURE TITLE: $title');
      SnackbarCustom(context: context).error(title: title, desc: error.message);
    } else if (error is ServerFailure &&
        error.message.split(' ').first.toLowerCase() != 'no') {
      debugPrint('SERVER FAILURE TITLE: $title');
      SnackbarCustom(context: context).error(title: title, desc: error.message);
    } else if (error is GeneralFailure &&
        error.message.split(' ').first.toLowerCase() != 'no') {
      debugPrint('GENERAL FAILURE TITLE: $title');
      SnackbarCustom(context: context).error(title: title, desc: error.message);
    }
  }

  void trigerSnackbarWarning(
      {required BuildContext context,
      required Failure error,
      required String title}) {
    if (error is ConnectionFailure) {
      debugPrint('CONNECTION FAILURE TITLE: $title');
      SnackbarCustom(context: context)
          .warning(title: title, desc: error.message);
    } else if (error is ServerFailure) {
      debugPrint('SERVER FAILURE TITLE: $title');
      SnackbarCustom(context: context)
          .warning(title: title, desc: error.message);
    } else if (error is GeneralFailure) {
      debugPrint('GENERAL FAILURE TITLE: $title');
      SnackbarCustom(context: context)
          .warning(title: title, desc: error.message);
    } else {
      debugPrint('ERROR FAILURE TITLE: $title');
      SnackbarCustom(context: context)
          .warning(title: title, desc: error.toString());
    }
  }
}
