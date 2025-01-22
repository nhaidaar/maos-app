import 'package:fpdart/fpdart.dart';

abstract class AuthRepository {
  Future<Either<Exception, void>> login({
    required String email,
    required String password,
  });

  Future<Either<Exception, void>> loginAsGuest();

  Future<Either<Exception, void>> register({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Exception, void>> logout();

  Future<Either<Exception, void>> resetPassword({required String email});
}
