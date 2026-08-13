import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:riders_keeper/core/design_system/templates/md_widget_preview/md_widget_preview.dart';
import 'package:riders_keeper/features/auth/presentation/templates/forgot_password/forgot_password_template.dart';

@Preview(name: 'Forgot Password', group: 'Authentication', size: Size(390, 844))
Widget forgotPasswordTemplatePreview() {
  return MDWidgetPreview(
    child: ForgotPasswordTemplate(
      formKey: GlobalKey<FormState>(),
      emailController: TextEditingController(),
      isLoading: false,
      emailValidator: (_) => null,
      onSubmit: () {},
      onBackToLogin: () {},
    ),
  );
}
