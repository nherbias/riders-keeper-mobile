import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:riders_keeper/core/design_system/templates/md_widget_preview/md_widget_preview.dart';
import 'package:riders_keeper/features/auth/presentation/templates/login/login_template.dart';

@Preview(name: 'Login', group: 'Authentication', size: Size(390, 780))
Widget loginTemplatePreview() {
  return MDWidgetPreview(
    child: LoginTemplate(
      formKey: GlobalKey<FormState>(),
      identityController: TextEditingController(),
      passwordController: TextEditingController(),
      rememberMe: false,
      obscurePassword: true,
      isLoading: false,
      identityValidator: (_) => null,
      passwordValidator: (_) => null,
      onRememberMeChanged: (_) {},
      onPasswordVisibilityChanged: () {},
      onLogin: () {},
      onContinueWithGoogle: () {},
      onForgotPassword: () {},
      onCreateAccount: () {},
    ),
  );
}
