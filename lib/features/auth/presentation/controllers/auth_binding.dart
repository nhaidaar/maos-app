import 'package:get/get.dart';

import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/auth_usecase.dart';
import 'auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthRemoteDatasourceImpl());
    Get.put(AuthRepositoryImpl(Get.find<AuthRemoteDatasourceImpl>()));
    Get.put(AuthUsecase(Get.find<AuthRepositoryImpl>()));
    Get.put(AuthController(Get.find<AuthUsecase>()), permanent: true);

    Get.find<AuthController>();
  }
}
