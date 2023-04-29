import 'package:sinlist_app/core/http/network_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:sinlist_app/pages/widgets/custom_style.dart';

class Toaster {
  static ok(
      {@required BuildContext context,
      @required String message,
      SnackBarAction snackBarAction}) {
    final scaffoldState = ScaffoldMessenger.of(context);
    scaffoldState.showSnackBar(SnackBar(
      content: Text(message, style: CustomStyle.text16_ff1b5e20_700()),
      action: snackBarAction,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 2),
      backgroundColor: Colors.green[200],
    ));
  }

  static error(
      {@required BuildContext context,
      @required NetworkExceptions error,
      SnackBarAction snackBarAction}) {
    var message = NetworkExceptions.getErrorMessage(error);
    final scaffoldState = ScaffoldMessenger.of(context);
    scaffoldState.showSnackBar(SnackBar(
      content: Text(message, style: CustomStyle.text16_ffb40700_700()),
      action: snackBarAction,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red[200],
    ));
  }

  static unSuccesfull(
      {@required BuildContext context,
      @required String message,
      SnackBarAction snackBarAction,
      Duration duration}) {
    final scaffoldState = ScaffoldMessenger.of(context);
    scaffoldState.showSnackBar(SnackBar(
      content: Text(message, style: CustomStyle.text16_ffb40700_700()),
      action: snackBarAction,
      behavior: SnackBarBehavior.floating,
      duration: duration ?? Duration(seconds: 2),
      backgroundColor: Colors.red[200],
    ));
  }
}
