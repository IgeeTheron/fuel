// ignore_for_file: unintended_html_in_doc_comment

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuel/core/constants/enums/authentication_status.dart';
import 'package:fuel/data/models/user_management/user_model.dart';
import 'package:fuel/data/repositories/user_management_repository.dart';
import 'package:general_utilities/general_utilities.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

/// The `AuthenticationBloc` class is responsible for managing the authentication
/// state and handling authentication events in a Dart application.
class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserManagementRepository _userManagementRepository;
  StreamSubscription<UserModel>? _userSubscription;

  /// The `AuthenticationBloc` constructor is initializing the `AuthenticationBloc`
  /// class with the required dependencies and initial state.
  AuthenticationBloc({
    required UserManagementRepository userManagementRepository,
  })  : _userManagementRepository = userManagementRepository,
        super(
          userManagementRepository.currentUser.isNotEmpty
              ? AuthenticationState.authenticated(
                  userManagementRepository.currentUser,
                )
              : const AuthenticationState.unauthenticated(),
        ) {
    on<_AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    _userSubscription = userManagementRepository.user.listen((user) => add(_AppUserChanged(user)));
  }

  /// The function `_onUserChanged` updates the authentication state based on the
  /// user information provided in the event.
  ///
  /// Args:
  ///   event (_AppUserChanged): The event parameter is of type _AppUserChanged,
  /// which represents an event that occurs when the user changes in the app.
  ///   emit (Emitter<AuthenticationState>): The `emit` parameter is an `Emitter`
  /// object that is used to emit a new state in the authentication process. It is
  /// responsible for notifying the listeners about the changes in the
  /// authentication state.
  Future<void> _onUserChanged(
    _AppUserChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    PrintColor.green(event.user);
    emit(
      event.user.isNotEmpty ? AuthenticationState.authenticated(event.user) : const AuthenticationState.unauthenticated(),
    );
  }

  /// The function logs out the user from the app by calling the logOut() method
  /// from the authentication repository.
  ///
  /// Args:
  ///   event (AppLogoutRequested): AppLogoutRequested event - an event object that
  /// represents a logout request from the app.
  ///   emit (Emitter<AuthenticationState>): The `emit` parameter is an instance of
  /// the `Emitter` class, which is used to emit new values for the
  /// `AuthenticationState`. In this context, it is used to notify the application
  /// that a logout has been requested.
  void _onLogoutRequested(
    AppLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    try {
      PrintColor.green("_onLogoutRequested");
      unawaited(_userManagementRepository.logOutUser(userLogout: true));
    } catch (e) {
      PrintColor.red(e);
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
