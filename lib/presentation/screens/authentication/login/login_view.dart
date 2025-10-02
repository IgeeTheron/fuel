import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel/core/constants/enums/validations/password_validation_error.dart';
import 'package:fuel/core/input_formaters/prevent_spaces_formatter.dart';
import 'package:fuel/logic/cubit/authentication/login/login_cubit.dart';
import 'package:fuel/presentation/widgets/inputs/password_input_field.dart';
import 'package:fuel/presentation/widgets/toggle/custom_check_box.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

@immutable
class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: themeData.colorScheme.surfaceContainerLowest,
      body: Form(
        key: _formKey,
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: [
                    BlocBuilder<LoginCubit, LoginState>(
                      buildWhen: (previous, current) => previous.username != current.username,
                      builder: (context, state) {
                        return TextFormField(
                          onChanged: (username) => context.read<LoginCubit>().onUsernameChanged(username),
                          validator: (_) => state.username.displayError,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                          inputFormatters: PreventSpacesFormatter.format(),
                          style: themeData.textTheme.bodyLarge,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.mail),
                            hintText: "Username",
                          ),
                        );
                      },
                    ),
                    BlocBuilder<LoginCubit, LoginState>(
                      buildWhen: (previous, current) => previous.password != current.password,
                      builder: (context, state) {
                        return PasswordInputField(
                          onChanged: (password) => context.read<LoginCubit>().onPasswordChanged(password),
                          validator: (_) => state.password.displayError?.message,
                          textInputAction: TextInputAction.done,
                          inputFormatters: PreventSpacesFormatter.format(),
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BlocBuilder<LoginCubit, LoginState>(
                          buildWhen: (previous, current) => previous.rememberMe != current.rememberMe,
                          builder: (context, state) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: CustomCheckBox(
                                onTap: () => context.read<LoginCubit>().onRememberMeChanged(),
                                value: state.rememberMe,
                                text: Text(
                                  "Remember Me",
                                  style: themeData.textTheme.bodyMedium?.copyWith(fontSize: 15.sp, height: 1.5, letterSpacing: 0.2),
                                ),
                              ),
                            );
                          },
                        ),
                        InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            // TODO: Create forgot password screen
                            // context.read<AuthenticationWrapperCubit>().goToForgotPass();
                          },
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                "Forgot Password",
                                style: themeData.textTheme.bodyMedium?.copyWith(
                                  fontSize: 15.sp,
                                  height: 1.5,
                                  letterSpacing: 0.2,
                                  decoration: TextDecoration.underline,
                                  decorationThickness: 2,
                                  decorationStyle: TextDecorationStyle.solid,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            FocusManager.instance.primaryFocus?.unfocus();
                            context.read<LoginCubit>().onLoginWithEmailAndPassword();
                          }
                        },
                        child: const Text("Log In"),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
