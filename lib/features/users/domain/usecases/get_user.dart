import 'package:dartz/dartz.dart';
import 'package:crud/core/error/failures.dart';
import 'package:crud/core/usecases/usecase.dart';
import 'package:crud/features/users/domain/entities/user.dart';
import 'package:crud/features/users/domain/repositories/user_repository.dart';

class GetUser implements UseCase<User, String> {
  final UserRepository repository;

  GetUser(this.repository);

  @override
  Future<Either<Failure, User>> call(String id) async {
    return await repository.getUser(id);
  }
}
