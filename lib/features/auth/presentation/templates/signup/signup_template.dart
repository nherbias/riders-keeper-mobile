import 'package:flutter/material.dart';
import 'package:riders_keeper/core/constants/theme/app_colors.dart';
import 'package:riders_keeper/core/design_system/atoms/md_button/md_button.dart';
import 'package:riders_keeper/core/design_system/atoms/md_input_box/md_input_box.dart';
import 'package:riders_keeper/core/design_system/atoms/md_text/md_text.dart';
import 'package:riders_keeper/core/design_system/templates/md_scaffold/md_scaffold.dart';
import 'package:riders_keeper/core/enum/text_variant.dart';

class SignUpTemplate extends StatelessWidget {
  const SignUpTemplate({
    required this.formKey,
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.obscurePassword,
    required this.obscureConfirmPassword,
    required this.isLoading,
    required this.fullNameValidator,
    required this.emailValidator,
    required this.passwordValidator,
    required this.confirmPasswordValidator,
    required this.onPasswordVisibilityChanged,
    required this.onConfirmPasswordVisibilityChanged,
    required this.onSignUp,
    required this.onBackToLogin,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final bool isLoading;
  final FormFieldValidator<String> fullNameValidator;
  final FormFieldValidator<String> emailValidator;
  final FormFieldValidator<String> passwordValidator;
  final FormFieldValidator<String> confirmPasswordValidator;
  final VoidCallback onPasswordVisibilityChanged;
  final VoidCallback onConfirmPasswordVisibilityChanged;
  final VoidCallback onSignUp;
  final VoidCallback onBackToLogin;

  @override
  Widget build(BuildContext context) {
    return MDScaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
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
                const SizedBox(height: 26),
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 26),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        MDInputBox(
                          label: 'FULL NAME',
                          controller: fullNameController,
                          hintText: 'John Doe',
                          prefixIcon: Icons.person_outline,
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.next,
                          autofillHints: const [AutofillHints.name],
                          validator: fullNameValidator,
                        ),
                        const SizedBox(height: 18),
                        MDInputBox(
                          label: 'EMAIL ADDRESS',
                          controller: emailController,
                          hintText: 'rider@example.com',
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.none,
                          autofillHints: const [AutofillHints.email],
                          validator: emailValidator,
                        ),
                        const SizedBox(height: 18),
                        MDInputBox(
                          label: 'PASSWORD',
                          controller: passwordController,
                          hintText: 'Enter your password',
                          prefixIcon: Icons.lock_outline,
                          suffixIcon: obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          onSuffixIconPressed: onPasswordVisibilityChanged,
                          obscureText: obscurePassword,
                          textInputAction: TextInputAction.next,
                          autofillHints: const [AutofillHints.newPassword],
                          validator: passwordValidator,
                        ),
                        const SizedBox(height: 18),
                        MDInputBox(
                          label: 'CONFIRM PASSWORD',
                          controller: confirmPasswordController,
                          hintText: 'Confirm your password',
                          prefixIcon: Icons.lock_outline,
                          suffixIcon: obscureConfirmPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          onSuffixIconPressed:
                              onConfirmPasswordVisibilityChanged,
                          obscureText: obscureConfirmPassword,
                          textInputAction: TextInputAction.done,
                          autofillHints: const [AutofillHints.newPassword],
                          validator: confirmPasswordValidator,
                          onSubmitted: (_) => onSignUp(),
                        ),
                        const SizedBox(height: 26),
                        MDButton(
                          label: 'CREATE ACCOUNT',
                          icon: Icons.arrow_forward,
                          isLoading: isLoading,
                          onPressed: onSignUp,
                        ),
                        const SizedBox(height: 22),
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(color: AppColors.border),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 18),
                              child: MDText(
                                'OR',
                                variant: MDTextVariant.bodySmall,
                                color: AppColors.mutedText,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 3,
                              ),
                            ),
                            const Expanded(
                              child: Divider(color: AppColors.border),
                            ),
                          ],
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
                const SizedBox(height: 22),
                const MDText(
                  'By creating an account, you agree to our Terms of Service '
                  'and Privacy Policy.',
                  variant: MDTextVariant.bodySmall,
                  color: AppColors.textSecondary,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
