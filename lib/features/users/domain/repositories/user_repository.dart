import 'package:dartz/dartz.dart';
import 'package:crud/core/error/failures.dart';
import 'package:crud/features/users/domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, void>> createUser(User user);
  Future<Either<Failure, void>> updateUser(User user);
  Future<Either<Failure, User>> getUser(String id);
  Future<Either<Failure, List<User>>> getAllUsers();
  Future<Either<Failure, void>> deleteUser(String id);
}
