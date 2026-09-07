import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/features/auth/domain/entities/auth_mode.dart';
import 'package:bariq/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bariq/features/auth/presentation/widgets/auth_feedback_content.dart';
import 'package:bariq/features/auth/presentation/widgets/auth_form_content.dart';
import 'package:bariq/features/auth/presentation/widgets/password_recovery_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) => state.when(
        ready: (mode) => _buildForm(context, mode: mode),
        submitting: (mode) => _buildForm(context, mode: mode, isLoading: true),
        emailVerificationRequired: (email) => AuthFeedbackContent(
          title: AppStrings.verifyEmailTitle,
          body: AppStrings.verifyEmailBody,
          email: email,
          onBackToSignIn: () => _changeMode(context, AuthMode.signIn),
        ),
        passwordResetSent: (email) => AuthFeedbackContent(
          title: AppStrings.passwordResetTitle,
          body: AppStrings.passwordResetBody,
          email: email,
          onBackToSignIn: () => _changeMode(context, AuthMode.signIn),
        ),
        passwordRecovery: () => _buildPasswordRecovery(context),
        passwordUpdating: () =>
            _buildPasswordRecovery(context, isLoading: true),
        passwordUpdateFailure: (failure) =>
            _buildPasswordRecovery(context, errorMessage: failure.message),
        oauthPending: (mode) => _buildForm(
          context,
          mode: mode,
          noticeMessage: AppStrings.googleOpened,
        ),
        authenticated: () =>
            _buildForm(context, mode: AuthMode.signIn, isLoading: true),
        failure: (mode, failure) =>
            _buildForm(context, mode: mode, errorMessage: failure.message),
      ),
    );
  }

  Widget _buildPasswordRecovery(
    BuildContext context, {
    bool isLoading = false,
    String? errorMessage,
  }) {
    return PasswordRecoveryContent(
      emailController: _emailController,
      passwordController: _passwordController,
      confirmPasswordController: _confirmPasswordController,
      isLoading: isLoading,
      errorMessage: errorMessage,
      onSubmit: () => context.read<AuthBloc>().add(
        AuthEvent.passwordUpdateSubmitted(
          password: _passwordController.text,
          passwordConfirmation: _confirmPasswordController.text,
        ),
      ),
    );
  }

  Widget _buildForm(
    BuildContext context, {
    required AuthMode mode,
    bool isLoading = false,
    String? errorMessage,
    String? noticeMessage,
  }) {
    return AuthFormContent(
      mode: mode,
      emailController: _emailController,
      passwordController: _passwordController,
      confirmPasswordController: _confirmPasswordController,
      isLoading: isLoading,
      errorMessage: errorMessage,
      noticeMessage: noticeMessage,
      onSubmit: () => _submit(context),
      onGoogle: () =>
          context.read<AuthBloc>().add(const AuthEvent.googleSubmitted()),
      onForgotPassword: () => context.read<AuthBloc>().add(
        AuthEvent.passwordResetRequested(_emailController.text),
      ),
      onToggleMode: () => _changeMode(
        context,
        mode == AuthMode.signIn ? AuthMode.signUp : AuthMode.signIn,
      ),
    );
  }

  void _submit(BuildContext context) {
    context.read<AuthBloc>().add(
      AuthEvent.credentialsSubmitted(
        email: _emailController.text,
        password: _passwordController.text,
        passwordConfirmation: _confirmPasswordController.text,
      ),
    );
  }

  void _changeMode(BuildContext context, AuthMode mode) {
    _passwordController.clear();
    _confirmPasswordController.clear();
    context.read<AuthBloc>().add(AuthEvent.modeChanged(mode));
  }
}
