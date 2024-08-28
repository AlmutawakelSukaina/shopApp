import '/main_app.dart';

import 'libs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PreferencesHelper.init();
  ServiceLocator().init();
  await ProductDatabase.instance.database;

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppColors.orange,
    statusBarBrightness: Brightness.dark,
  ));

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(
      const MainApp(),
    );
  });
}
