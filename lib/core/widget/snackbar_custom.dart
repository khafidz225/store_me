import 'package:flutter/material.dart';

class SnackbarCustom {
  BuildContext context;
  SnackbarCustom({required this.context});
  success({required String title, required String desc}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.green[500],
        content: Stack(
          children: [
            Positioned(
              bottom: 0,
              right: 0,
              child: Icon(
                Icons.check_circle_outline_outlined,
                size: 45,
                color: Colors.green[200],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  desc,
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  warning({required String title, required String desc}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.amber[700],
        content: Stack(
          children: [
            Positioned(
              bottom: 0,
              right: 0,
              child: Icon(
                Icons.warning_amber_rounded,
                size: 45,
                color: Colors.amber[200],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  desc,
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  error({required String title, required String desc}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red[500],
        content: Stack(
          children: [
            Positioned(
              bottom: 0,
              right: 0,
              child: Icon(
                Icons.error_outline_rounded,
                size: 45,
                color: Colors.red[200],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  desc,
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
