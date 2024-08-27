








import '../../libs.dart';

final sl = GetIt.instance;

class ServiceLocator {
  void init() {

    sl.registerLazySingleton(() => ProductProvider());
    sl.registerLazySingleton(() => CartProvider());

  }
}
