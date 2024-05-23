import 'package:dartz/dartz.dart';
import 'package:crud/core/error/failures.dart';
import 'package:crud/core/usecases/usecase.dart';
import 'package:crud/features/users/domain/repositories/user_repository.dart';

class DeleteUser implements UseCase<void, String> {
  final UserRepository repository;

  DeleteUser(this.repository);

  @override
  Future<Either<Failure, void>> call(String id) async {
    return await repository.deleteUser(id);
  }
}
