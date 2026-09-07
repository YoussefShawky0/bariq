import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/theme/app_sizes.dart';
import 'package:bariq/core/theme/app_theme.dart';
import 'package:bariq/features/auth/domain/entities/auth_mode.dart';
import 'package:bariq/features/auth/domain/repositories/auth_repository.dart';
import 'package:bariq/features/auth/domain/usecases/request_password_reset.dart';
import 'package:bariq/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:bariq/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:bariq/features/auth/domain/usecases/sign_up_with_email.dart';
import 'package:bariq/features/auth/domain/usecases/update_password.dart';
import 'package:bariq/features/auth/domain/usecases/watch_auth_session.dart';
import 'package:bariq/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bariq/features/auth/presentation/pages/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository repository;
  late AuthBloc bloc;

  setUp(() {
    repository = MockAuthRepository();
    when(repository.watchSession).thenAnswer((_) => const Stream.empty());
    bloc = AuthBloc(
      SignInWithEmail(repository),
      SignUpWithEmail(repository),
      RequestPasswordReset(repository),
      UpdatePassword(repository),
      SignInWithGoogle(repository),
      WatchAuthSession(repository),
    );
  });

  tearDown(() => bloc.close());

  testWidgets('switches to sign up and reports safe validation feedback', (
    tester,
  ) async {
    await _pumpAuthPage(tester, bloc: bloc);

    expect(
      BlocProvider.of<AuthBloc>(tester.element(find.byType(AuthPage))),
      same(bloc),
    );
    expect(find.text(AppStrings.signInTitle), findsOneWidget);
    expect(
      find.widgetWithText(TextButton, AppStrings.createAccount),
      findsOneWidget,
    );
    await tester.runAsync(() async {
      final signUpState = bloc.stream.firstWhere(
        (state) => state == const AuthState.ready(AuthMode.signUp),
      );
      bloc.add(const AuthEvent.modeChanged(AuthMode.signUp));
      await signUpState;
    });
    await tester.pump();

    expect(bloc.state, const AuthState.ready(AuthMode.signUp));
    expect(find.text(AppStrings.signUpTitle), findsOneWidget);
    expect(find.text(AppStrings.confirmPassword), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(TextField, AppStrings.email),
      'invalid-email',
    );
    final submitButton = find.widgetWithText(
      FilledButton,
      AppStrings.createAccount,
    );
    await tester.ensureVisible(submitButton);
    await tester.pumpAndSettle();
    expect(submitButton, findsOneWidget);
    await tester.runAsync(() async {
      final failureState = bloc.stream.firstWhere(
        (state) => state is AuthFailure,
      );
      bloc.add(
        const AuthEvent.credentialsSubmitted(
          email: 'invalid-email',
          password: '',
          passwordConfirmation: '',
        ),
      );
      await failureState;
    });
    await tester.pump();

    expect(find.text('اكتب بريدًا إلكترونيًا صحيحًا.'), findsOneWidget);
    verifyNever(
      () => repository.signUpWithEmail(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    );
  });

  for (final testCase in {
    'small phone': const Size(320, 568),
    'tablet': const Size(800, 1280),
  }.entries) {
    testWidgets('renders without overflow on ${testCase.key}', (tester) async {
      await _pumpAuthPage(tester, bloc: bloc, logicalSize: testCase.value);

      expect(tester.takeException(), isNull);
      expect(find.text(AppStrings.signInTitle), findsOneWidget);
    });
  }
}

Future<void> _pumpAuthPage(
  WidgetTester tester, {
  required AuthBloc bloc,
  Size logicalSize = AppSizes.designSize,
}) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = logicalSize;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    BlocProvider.value(
      value: bloc,
      child: ScreenUtilInit(
        designSize: AppSizes.designSize,
        minTextAdapt: true,
        builder: (_, _) => MaterialApp(
          theme: AppTheme.light,
          home: const Directionality(
            textDirection: TextDirection.rtl,
            child: AuthPage(),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}
