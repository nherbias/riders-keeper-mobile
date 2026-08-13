import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:riders_keeper/core/design_system/templates/md_widget_preview/md_widget_preview.dart';
import 'package:riders_keeper/features/auth/presentation/templates/signup/signup_template.dart';

@Preview(name: 'Sign Up', group: 'Authentication', size: Size(390, 844))
Widget signUpTemplatePreview() {
  return MDWidgetPreview(
    alignment: Alignment.topCenter,
    child: SignUpTemplate(
      formKey: GlobalKey<FormState>(),
      fullNameController: TextEditingController(),
      emailController: TextEditingController(),
      passwordController: TextEditingController(),
      confirmPasswordController: TextEditingController(),
      obscurePassword: true,
      obscureConfirmPassword: true,
      isLoading: false,
      fullNameValidator: (_) => null,
      emailValidator: (_) => null,
      passwordValidator: (_) => null,
      confirmPasswordValidator: (_) => null,
      onPasswordVisibilityChanged: () {},
      onConfirmPasswordVisibilityChanged: () {},
      onSignUp: () {},
      onBackToLogin: () {},
    ),
  );
}
