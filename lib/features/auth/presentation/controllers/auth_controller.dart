import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../../core/utils/snackbar.dart';
import '../../domain/usecases/auth_usecase.dart';
import '../../../../core/utils/exception.dart';

class AuthController extends GetxController {
  final AuthUsecase _authUsecase;
  final FirebaseAuth _authInstance = FirebaseAuth.instance;
  AuthController(this._authUsecase);

  static AuthController instance = Get.find<AuthController>();
  late Rx<User?> _user;
  User? get user => _user.value;

  Rx<bool> authLoading = false.obs;
  Rx<bool> guestAuthLoading = false.obs;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(_authInstance.currentUser);
    _user.bindStream(_authInstance.authStateChanges());
    ever(_user, handleAuthStateChanges);
  }

  void handleAuthStateChanges(User? user) {
    if (user != null) {
      Get.offAllNamed('/home');
    } else {
      Get.offAllNamed('/login');
    }
  }

  void switchLoading() {
    authLoading.value = !authLoading.value;
    authLoading.refresh();
  }

  void switchGuestAuthLoading() {
    guestAuthLoading.value = !guestAuthLoading.value;
    guestAuthLoading.refresh();
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    switchLoading();

    final session = await _authUsecase.login(
      email: email,
      password: password,
    );
    session.fold(
      (l) => showSnackbar(message: getExceptionMessage(l), isError: true),
      (r) => null,
    );

    switchLoading();
  }

  Future<void> loginAsGuest() async {
    switchGuestAuthLoading();

    final session = await _authUsecase.loginAsGuest();
    session.fold(
      (l) => showSnackbar(message: getExceptionMessage(l), isError: true),
      (r) => null,
    );

    switchGuestAuthLoading();
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    switchLoading();

    final session = await _authUsecase.register(
      name: name,
      email: email,
      password: password,
    );
    session.fold(
      (l) => showSnackbar(message: getExceptionMessage(l), isError: true),
      (r) => null,
    );

    switchLoading();
  }

  Future<void> resetPassword({required String email}) async {
    switchLoading();

    final session = await _authUsecase.resetPassword(email: email);
    session.fold(
      (l) => showSnackbar(message: getExceptionMessage(l), isError: true),
      (r) => null,
    );

    switchLoading();
  }

  Future<void> logout() async {
    switchLoading();

    final session = await _authUsecase.logout();
    session.fold(
      (l) => showSnackbar(message: getExceptionMessage(l), isError: true),
      (r) => null,
    );

    switchLoading();
  }
}
