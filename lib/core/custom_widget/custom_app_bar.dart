import '/main_app.dart';

import '../../../libs.dart';

AppBar customAppBar({VoidCallback? backFun,String?title,
  List<Widget>?actions,bool?hasBack,}) {
  return AppBar(
    surfaceTintColor: AppColors.backgroundColor,
    backgroundColor: AppColors.backgroundColor,
    iconTheme: IconThemeData(
        color: AppColors.orange,
        size:   30),
    centerTitle: true,
    title: CustomTextApp(
      text: title,
      size: 25,
    ),
    leading: hasBack!=false?IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        if (backFun != null) {
          backFun();
        } else {
          AppRouter.navigatorKey.currentContext!.pop();
        }
      },
    ):const Nothing(),
    actions: actions,
  );
}
