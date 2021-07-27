import 'package:daikita/src/ui/utils/progress_dialog.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static ProgressDialog pr;
  static Future showLoading(
      BuildContext context,String message) async {

    pr = new ProgressDialog(context);
    pr = new ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    pr.style(
      message: message,
      borderRadius: 10.0,
      backgroundColor: Colors.black45,
      progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w600)
    );
    return pr.show();
  }
  static Future dismiss(
      BuildContext context) async {

    pr = new ProgressDialog(context);
    pr = new ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: true, showLogs: false);
    return pr.hide();
  }
}