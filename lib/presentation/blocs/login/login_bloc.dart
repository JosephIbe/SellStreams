import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:sell_streams/domain/repositories/user_repository.dart';
import 'package:sell_streams/presentation/blocs/authentication/auth.dart';

import 'login.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final AuthenticationBloc _authenticationBloc;
  final UserRepository _userRepository;

  LoginBloc(AuthenticationBloc authenticationBloc, UserRepository repository)
    : assert(authenticationBloc != null),
      assert(repository != null),
      _authenticationBloc = authenticationBloc,
      _userRepository = repository, super(LoginStateInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if(event is LoginWithEmail) {
      yield* _mapLoginWithEmailToState(event);
    }
  }

  Stream<LoginState> _mapLoginWithEmailToState(LoginWithEmail event) async* {
    yield LoginStateLoading();
    try {
      // final user = await _userRepository.loginUser(event.body);
      final response = await _userRepository.loginUser(event.body);
      if(response != null){
        _authenticationBloc.add(UserLoggedIn(user: response));
        yield LoginStateSuccess();
        // yield LoginStateInitial();
      } else {
        yield LoginStateFailure(errorMessage: 'Something very weird just happened');
      }
    // } on SocketException catch (e) {
    //   yield LoginStateFailure(errorMessage: e.message);
    } catch (err){
      print(err);
      yield LoginStateFailure(errorMessage: 'Error Completing Your Request, Try Again!');
    }
  }

}