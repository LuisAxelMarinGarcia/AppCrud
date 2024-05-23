import 'package:crud/core/error/failures.dart';
import 'package:crud/core/network/network_info.dart';
import 'package:crud/features/users/domain/entities/user.dart';
import 'package:crud/features/users/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:crud/core/transaction/transaction_queue.dart';

class UpdateUser {
  final UserRepository repository;
  final NetworkInfo networkInfo;
  final TransactionQueue transactionQueue;

  UpdateUser(this.repository, this.networkInfo, this.transactionQueue);

  Future<Either<Failure, void>> call(User user) async {
    if (await networkInfo.isConnected) {
      final result = await repository.updateUser(user);
      if (result.isRight()) {
        await transactionQueue.clearTransactions();
      }
      return result;
    } else {
      await transactionQueue.addTransaction({
        'type': 'update',
        'user': user.toJson(),
      });
      return const Right(null);
    }
  }
}
