import 'package:bariq/core/theme/app_sizes.dart';
import 'package:bariq/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class AuthScreenShell extends StatelessWidget {
  const AuthScreenShell({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _AuthScrollableBody(child: child)),
    );
  }
}

class _AuthScrollableBody extends StatelessWidget {
  const _AuthScrollableBody({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.pageHorizontal,
        vertical: AppSpacing.pageVertical,
      ),
      child: Center(child: child),
    );
  }
}

class AuthConstrainedContent extends StatelessWidget {
  const AuthConstrainedContent({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: AppSizes.authContentMaxWidth),
      child: child,
    );
  }
}
