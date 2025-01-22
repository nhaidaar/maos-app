import 'package:fpdart/fpdart.dart';

import '../repositories/auth_repository.dart';

class AuthUsecase {
  final AuthRepository _authRepository;
  const AuthUsecase(this._authRepository);

  Future<Either<Exception, void>> login({
    required String email,
    required String password,
  }) {
    return _authRepository.login(email: email, password: password);
  }

  Future<Either<Exception, void>> loginAsGuest() {
    return _authRepository.loginAsGuest();
  }

  Future<Either<Exception, void>> register({
    required String name,
    required String email,
    required String password,
  }) {
    return _authRepository.register(name: name, email: email, password: password);
  }

  Future<Either<Exception, void>> logout() {
    return _authRepository.logout();
  }

  Future<Either<Exception, void>> resetPassword({required String email}) {
    return _authRepository.resetPassword(email: email);
  }
}
