


import '../../../libs.dart';
import '../../../main_app.dart';

class SignInProvider extends BasedHttpRequests with ChangeNotifier {
  bool loading = false;

  void setLoading(bool register) {
    loading = register;
    notifyListeners();
  }

  Future<void> signInWithUserAndPassword(
      String userName, String password) async {

    sl<SignInProvider>().setLoading(true);
    try {
      NetworkServiceResponse response = await postData(
        url: AppUrl.loginUrl,
        parameter: {"username": userName, "password": password},
      );
      sl<SignInProvider>().setLoading(false);
      if (response.status == EnumStatus.complete) {
        PreferencesHelper().setBool(SharedPreferenceConst.isUserLoggedIn, true);
        PreferencesHelper().setString(SharedPreferenceConst.prefToken, response.data["token"]);
        AppRouter.navigatorKey.currentContext!.pop();
      }else
        {
          AppRouter.navigatorKey.currentContext!
              .showAppDialog(message: response.data.toString(), title: "Error");
        }
     } catch (e, s) {
      sl<SignInProvider>().setLoading(false);

      globalPrint("error inside $e $s");
      setLoading(false);
      AppRouter.navigatorKey.currentContext!
          .showAppDialog(message: e.toString(), title: "Error");
    }
  }
}
