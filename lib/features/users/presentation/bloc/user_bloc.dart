import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:crud/features/users/domain/usecases/create_user.dart';
import 'package:crud/features/users/domain/usecases/update_user.dart';
import 'package:crud/features/users/domain/usecases/get_user.dart';
import 'package:crud/features/users/domain/usecases/get_all_users.dart';
import 'package:crud/features/users/domain/usecases/delete_user.dart';
import 'package:crud/features/users/domain/entities/user.dart';
import 'package:crud/core/error/failures.dart';

import '../../../../core/usecases/usecase.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final CreateUser createUser;
  final UpdateUser updateUser;
  final GetUser getUser;
  final GetAllUsers getAllUsers;
  final DeleteUser deleteUser;

  UserBloc({
    required this.createUser,
    required this.updateUser,
    required this.getUser,
    required this.getAllUsers,
    required this.deleteUser,
  }) : super(UserInitial()) {
    on<CreateUserEvent>(_onCreateUserEvent);
    on<UpdateUserEvent>(_onUpdateUserEvent);
    on<GetUserEvent>(_onGetUserEvent);
    on<GetAllUsersEvent>(_onGetAllUsersEvent);
    on<DeleteUserEvent>(_onDeleteUserEvent);
  }

  Future<void> _onCreateUserEvent(CreateUserEvent event, Emitter<UserState> emit) async {
    print('CreateUserEvent started');
    emit(UserLoading());
    final failureOrSuccess = await createUser(event.user);
    emit(failureOrSuccess.fold(
          (failure) {
        print('CreateUserEvent failed: $failure');
        return UserError(message: _mapFailureToMessage(failure));
      },
          (_) {
        print('CreateUserEvent succeeded');
        return UserCreated();
      },
    ));
  }

  Future<void> _onUpdateUserEvent(UpdateUserEvent event, Emitter<UserState> emit) async {
    print('UpdateUserEvent started');
    emit(UserLoading());
    final failureOrSuccess = await updateUser(event.user);
    emit(failureOrSuccess.fold(
          (failure) {
        print('UpdateUserEvent failed: $failure');
        return UserError(message: _mapFailureToMessage(failure));
      },
          (_) {
        print('UpdateUserEvent succeeded');
        return UserUpdated();
      },
    ));
  }

  Future<void> _onGetUserEvent(GetUserEvent event, Emitter<UserState> emit) async {
    print('GetUserEvent started');
    emit(UserLoading());
    final failureOrUser = await getUser(event.id);
    emit(failureOrUser.fold(
          (failure) {
        print('GetUserEvent failed: $failure');
        return UserError(message: _mapFailureToMessage(failure));
      },
          (user) {
        print('GetUserEvent succeeded');
        return UserLoaded(user: user);
      },
    ));
  }

  Future<void> _onGetAllUsersEvent(GetAllUsersEvent event, Emitter<UserState> emit) async {
    print('GetAllUsersEvent started');
    emit(UserLoading());
    final failureOrUsers = await getAllUsers(NoParams());
    emit(failureOrUsers.fold(
          (failure) {
        print('GetAllUsersEvent failed: $failure');
        return UserError(message: _mapFailureToMessage(failure));
      },
          (users) {
        print('GetAllUsersEvent succeeded');
        return UsersLoaded(users: users);
      },
    ));
  }

  Future<void> _onDeleteUserEvent(DeleteUserEvent event, Emitter<UserState> emit) async {
    print('DeleteUserEvent started');
    emit(UserLoading());
    final failureOrSuccess = await deleteUser(event.id);
    emit(failureOrSuccess.fold(
          (failure) {
        print('DeleteUserEvent failed: $failure');
        return UserError(message: _mapFailureToMessage(failure));
      },
          (_) {
        print('DeleteUserEvent succeeded');
        return UserDeleted();
      },
    ));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      case CacheFailure:
        return 'Cache Failure';
      default:
        return 'Unexpected Error';
    }
  }
}
