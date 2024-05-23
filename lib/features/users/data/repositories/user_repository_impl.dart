import 'package:crud/core/error/exceptions.dart';
import 'package:crud/core/error/failures.dart';
import 'package:crud/features/users/data/datasources/user_remote_data_source.dart';
import 'package:crud/features/users/data/models/user_model.dart';
import 'package:crud/features/users/domain/entities/user.dart';
import 'package:crud/features/users/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> createUser(User user) async {
    try {
      final userModel = UserModel(
        id: user.id,
        name: user.name,
        surname: user.surname,
        age: user.age,
        cellphone: user.cellphone,
        email: user.email,
        password: user.password,
      );
      print('Sending request to create user: ${user.name}');
      await remoteDataSource.createUser(userModel);
      return const Right(null);
    } on ServerException {
      print('ServerException while creating user');
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateUser(User user) async {
    try {
      final userModel = UserModel(
        id: user.id,
        name: user.name,
        surname: user.surname,
        age: user.age,
        cellphone: user.cellphone,
        email: user.email,
        password: user.password,
      );
      print('Sending request to update user: ${user.name}');
      await remoteDataSource.updateUser(userModel);
      return const Right(null);
    } on ServerException {
      print('ServerException while updating user');
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getUser(String id) async {
    try {
      print('Sending request to get user with id: $id');
      final userModel = await remoteDataSource.getUser(id);
      return Right(userModel);
    } on ServerException {
      print('ServerException while getting user with id: $id');
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<User>>> getAllUsers() async {
    try {
      print('Sending request to get all users');
      final userModels = await remoteDataSource.getAllUsers();
      return Right(userModels);
    } on ServerException {
      print('ServerException while getting all users');
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser(String id) async {
    try {
      print('Sending request to delete user with id: $id');
      await remoteDataSource.deleteUser(id);
      return const Right(null);
    } on ServerException {
      print('ServerException while deleting user with id: $id');
      return Left(ServerFailure());
    }
  }
}
