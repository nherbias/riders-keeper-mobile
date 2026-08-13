import 'package:flutter/material.dart';
import 'package:riders_keeper/core/constants/theme/app_colors.dart';
import 'package:riders_keeper/core/design_system/atoms/md_button/md_button.dart';
import 'package:riders_keeper/core/design_system/atoms/md_input_box/md_input_box.dart';
import 'package:riders_keeper/core/design_system/atoms/md_text/md_text.dart';
import 'package:riders_keeper/core/design_system/templates/md_scaffold/md_scaffold.dart';
import 'package:riders_keeper/core/enum/text_variant.dart';

class ForgotPasswordTemplate extends StatelessWidget {
  const ForgotPasswordTemplate({
    required this.formKey,
    required this.emailController,
    required this.isLoading,
    required this.emailValidator,
    required this.onSubmit,
    required this.onBackToLogin,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final bool isLoading;
  final FormFieldValidator<String> emailValidator;
  final VoidCallback onSubmit;
  final VoidCallback onBackToLogin;

  @override
  Widget build(BuildContext context) {
    return MDScaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Column(
              children: [
                const Icon(
                  Icons.two_wheeler_outlined,
                  size: 70,
                  color: AppColors.neutral,
                ),
                const SizedBox(height: 16),
                const MDText(
                  'RIDERS KEEPER',
                  variant: MDTextVariant.headline,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 6),
                const MDText(
                  'KEEPING RIDERS ROAD READY',
                  variant: MDTextVariant.bodySmall,
                  textAlign: TextAlign.center,
                  letterSpacing: 2,
                ),
                const SizedBox(height: 32),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(24, 30, 24, 24),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const MDText(
                          'Forgot Password',
                          variant: MDTextVariant.headlineSmall,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(height: 8),
                        const MDText(
                          'Enter your email to receive a reset link.',
                          variant: MDTextVariant.body,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(height: 28),
                        MDInputBox(
                          label: 'EMAIL ADDRESS',
                          controller: emailController,
                          hintText: 'rider@example.com',
                          prefixIcon: Icons.email_outlined,
                          enabled: !isLoading,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          textCapitalization: TextCapitalization.none,
                          validator: emailValidator,
                          onSubmitted: (_) => onSubmit(),
                          autofillHints: const [AutofillHints.email],
                        ),
                        const SizedBox(height: 28),
                        MDButton(
                          label: 'RESET PASSWORD',
                          isLoading: isLoading,
                          onPressed: onSubmit,
                        ),
                        const SizedBox(height: 22),
                        MDButton(
                          label: 'BACK TO LOGIN',
                          icon: Icons.arrow_back,
                          iconAtStart: true,
                          variant: MDButtonVariant.outlined,
                          enabled: !isLoading,
                          onPressed: onBackToLogin,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
