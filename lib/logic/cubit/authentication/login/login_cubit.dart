import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:fuel/core/di/injection.dart';
import 'package:fuel/core/exceptions/exceptions.dart';
import 'package:fuel/core/formz/password_login.dart';
import 'package:fuel/core/formz/username.dart';
import 'package:fuel/data/repositories/user_management_repository.dart';
import 'package:fuel/logic/cubit/loading/loading_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final UserManagementRepository _userManagementRepository;
  final LoadingCubit _loadingCubit;

  LoginCubit({
    required UserManagementRepository userManagementRepository,
    required LoadingCubit loadingCubit,
  })  : _userManagementRepository = userManagementRepository,
        _loadingCubit = loadingCubit,
        super(LoginState.initial());

  void onUsernameChanged(String value) {
    final Username username = Username.dirty(value);

    emit(
      state.copyWith(
        status: FormzSubmissionStatus.initial,
        username: username,
        userMessage: '',
      ),
    );
  }

  void onPasswordChanged(String value) {
    final PasswordLogin password = PasswordLogin.dirty(value);

    emit(
      state.copyWith(
        status: FormzSubmissionStatus.initial,
        password: password,
        userMessage: '',
      ),
    );
  }

  void onRememberMeChanged() {
    emit(
      state.copyWith(
        status: FormzSubmissionStatus.initial,
        rememberMe: !state.rememberMe,
        userMessage: '',
      ),
    );
  }

  Future<void> onLoginWithEmailAndPassword() async {
    try {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress, userMessage: ''));

      await _userManagementRepository.loginUser(
        username: state.username.value.trim(),
        password: state.password.value.trim(),
        rememberMe: state.rememberMe,
      );

      _loadingCubit.stop();
    } on AppException catch (e) {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.failure,
          userMessage: e.message,
        ),
      );
    } catch (e, st) {
      // TODO: Add error logging
      // await FirebaseCrashlytics.instance.recordError(e, st);
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.failure,
          userMessage: "Failed to login, Please try again later",
        ),
      );
    }
  }
}
