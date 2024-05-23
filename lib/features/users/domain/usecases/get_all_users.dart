import 'package:dartz/dartz.dart';
import 'package:crud/core/error/failures.dart';
import 'package:crud/core/usecases/usecase.dart';
import 'package:crud/features/users/domain/entities/user.dart';
import 'package:crud/features/users/domain/repositories/user_repository.dart';

class GetAllUsers implements UseCase<List<User>, NoParams> {
  final UserRepository repository;

  GetAllUsers(this.repository);

  @override
  Future<Either<Failure, List<User>>> call(NoParams params) async {
    return await repository.getAllUsers();
  }
}
