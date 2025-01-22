import 'package:fpdart/fpdart.dart';

import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _authRemoteDataSource;
  const AuthRepositoryImpl(this._authRemoteDataSource);

  @override
  Future<Either<Exception, void>> login({
    required String email,
    required String password,
  }) async {
    return await _authRemoteDataSource.login(email: email, password: password);
  }

  @override
  Future<Either<Exception, void>> loginAsGuest() async {
    return await _authRemoteDataSource.loginAsGuest();
  }

  @override
  Future<Either<Exception, void>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    return await _authRemoteDataSource.register(name: name, email: email, password: password);
  }

  @override
  Future<Either<Exception, void>> logout() async {
    return await _authRemoteDataSource.logout();
  }

  @override
  Future<Either<Exception, void>> resetPassword({required String email}) async {
    return await _authRemoteDataSource.resetPassword(email: email);
  }
}
