import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sell_streams/domain/repositories/user_repository.dart';

import 'user.dart';

class UserBloc extends Bloc<UserEvent, UserState> {

  final UserRepository _userRepository;
  UserBloc(UserRepository repository)
      : assert (repository != null),
      _userRepository = repository,
      super(UserStateInitial());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if(event is GetUserProfileDetails){
      yield* _mapGetUserProfileDetailsToState(event);
    }
    if(event is UpdateUserProfileDetails){
      yield* _mapEditUserProfileDetailsToState(event);
    }
  }

  Stream<UserState> _mapGetUserProfileDetailsToState(GetUserProfileDetails event) async* {
    yield UserStateLoading();
    try {
      final user = await _userRepository.getCurrentUser();
      if(user != null){
        yield UserStateSuccess(user: user);
      }else {
        yield UserStateFailure(errorMessage: 'Unable to Fetch Profile Details');
      }
    } catch (err){
      print(err);
      yield UserStateFailure(errorMessage: 'Error Completing Your Request, Try Again!');
    }
  }

  Stream<UserState> _mapEditUserProfileDetailsToState(UpdateUserProfileDetails event) async* {
    yield UserStateLoading();
    try {
      final editedUser = await _userRepository.editCurrentUser(event.body);
      if(editedUser != null){
        yield UserStateSuccess(user: editedUser);
      } else {
        yield UserStateFailure(errorMessage: 'Could Not Update Your Profile Details at the moment!');
      }
    } catch(err){
      print(err);
      yield UserStateFailure(errorMessage: 'Could Not Update Your Profile Details at the moment!');
    }
  }
}