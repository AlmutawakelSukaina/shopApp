


import '../../../libs.dart';

extension BuildContextExtension on BuildContext {
  Future pushName(String routeName) {
    return Navigator.of(this).pushNamed(routeName);
  }

  void pushReplacementName(String routeName) {
    Navigator.of(this).pushReplacementNamed(routeName);
  }

  Future pushPage(Widget page) {
    return Navigator.of(this).push(MaterialPageRoute(builder: (_) => page));
  }

  void pop([result]) {
    Navigator.of(this).pop(result);
  }

  void showAppDialog({
    required String title,
    Function? onTapSuccess,
    Widget? widget,
    bool? showCancel,
    String? message,
    Function? cancelButton,
    String?successTitle,String?cancelButtonTitle,
   }) {
    showDialog(
        context: this,
        builder: (BuildContext context) {
          return CustomGeneralAlertDialog(
            title: title,
            showCancel: showCancel ?? false,
            specificBody: widget ??
                CustomTextApp(
                  text: message,
                  size: 20,
                ),
            successButton:successTitle?? "OK",
            cancelOnTap: cancelButton,
            cancelButton:cancelButtonTitle,
            successOnTap: onTapSuccess,
          );
        });
  }


}
