import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

import '../models/user_model.dart';

abstract class AuthRemoteDatasource {
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

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final FirebaseAuth client = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Future<Either<Exception, void>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userModel = UserModel(
        email: email,
        name: name,
        profilePicture: '',
      );

      await client
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) async => await db.collection('users').doc(user.user?.uid).set(userModel.toJSON()));

      return Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(Exception(e.message));
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, void>> login({
    required String email,
    required String password,
  }) async {
    try {
      await client.signInWithEmailAndPassword(email: email, password: password);

      return Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(Exception(e.message));
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, void>> loginAsGuest() async {
    try {
      await client.signInAnonymously();

      return Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(Exception(e.message));
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, void>> logout() async {
    try {
      await client.signOut();

      return Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(Exception(e.message));
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, void>> resetPassword({required String email}) async {
    try {
      await client.sendPasswordResetEmail(email: email);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(Exception(e.message));
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
