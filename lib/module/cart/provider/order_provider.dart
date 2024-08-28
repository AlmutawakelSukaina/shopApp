import 'dart:io';

import 'package:intl/intl.dart';

import '../../../libs.dart';
import '../../../main_app.dart';

class OrderProvider extends BasedHttpRequests {
  Future<void> postOrder(List<Product> product) async {
    sl<SignInProvider>().setLoading(true);
    try {
      NetworkServiceResponse response =
          await postData(url: AppUrl.postOrder, parameter: {
        "userId": 3,
        "date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
        "products": product.map((e) => e.toJson()).toList()
      });
      sl<SignInProvider>().setLoading(false);
      if (response.status == EnumStatus.complete) {
        AppRouter.navigatorKey.currentContext!
            .showAppDialog(message:"Operation successfully done" ,title: "Success",
         onTapSuccess: (){
           AppRouter.navigatorKey.currentContext!.pushReplacementName(AppRoutes.product);
         }
        );
      } else {
        AppRouter.navigatorKey.currentContext!
            .showAppDialog(message: response.data.toString(), title: "Error");
      }
    } on SocketException {
      sl<SignInProvider>().setLoading(false);
      AppRouter.navigatorKey.currentContext!.showAppDialog(
          message: "Check Your internet connection", title: "No internet");
    } catch (e, s) {
      sl<SignInProvider>().setLoading(false);
      AppRouter.navigatorKey.currentContext!
          .showAppDialog(message: e.toString(), title: "Error");
    }
  }
}
