import 'package:crud/core/error/failures.dart';
import 'package:crud/core/network/network_info.dart';
import 'package:crud/features/users/domain/entities/user.dart';
import 'package:crud/features/users/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:crud/core/transaction/transaction_queue.dart';
import 'package:crud/features/users/data/models/user_model.dart';

class CreateUser {
  final UserRepository repository;
  final NetworkInfo networkInfo;
  final TransactionQueue transactionQueue;

  CreateUser(this.repository, this.networkInfo, this.transactionQueue);

  Future<Either<Failure, void>> call(User user) async {
    if (await networkInfo.isConnected) {
      final result = await repository.createUser(user);
      if (result.isRight()) {
        await transactionQueue.clearTransactions();
      }
      return result;
    } else {
      final userModel = UserModel(
        id: user.id,
        name: user.name,
        surname: user.surname,
        age: user.age,
        cellphone: user.cellphone,
        email: user.email,
        password: user.password,
      );
      await transactionQueue.addTransaction({
        'type': 'create',
        'user': userModel.toJson(),
      });
      return const Right(null);
    }
  }
}
