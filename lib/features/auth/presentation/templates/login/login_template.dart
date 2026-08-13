import 'package:flutter/material.dart';
import 'package:riders_keeper/core/constants/theme/app_colors.dart';
import 'package:riders_keeper/core/design_system/atoms/md_button/md_button.dart';
import 'package:riders_keeper/core/design_system/atoms/md_google_icon/md_google_icon.dart';
import 'package:riders_keeper/core/design_system/atoms/md_input_box/md_input_box.dart';
import 'package:riders_keeper/core/design_system/atoms/md_text/md_text.dart';
import 'package:riders_keeper/core/design_system/templates/md_scaffold/md_scaffold.dart';
import 'package:riders_keeper/core/enum/text_variant.dart';

class LoginTemplate extends StatelessWidget {
  const LoginTemplate({
    required this.formKey,
    required this.identityController,
    required this.passwordController,
    required this.rememberMe,
    required this.obscurePassword,
    required this.isLoading,
    required this.identityValidator,
    required this.passwordValidator,
    required this.onRememberMeChanged,
    required this.onPasswordVisibilityChanged,
    required this.onLogin,
    required this.onContinueWithGoogle,
    required this.onForgotPassword,
    required this.onCreateAccount,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController identityController;
  final TextEditingController passwordController;
  final bool rememberMe;
  final bool obscurePassword;
  final bool isLoading;
  final FormFieldValidator<String> identityValidator;
  final FormFieldValidator<String> passwordValidator;
  final ValueChanged<bool> onRememberMeChanged;
  final VoidCallback onPasswordVisibilityChanged;
  final VoidCallback onLogin;
  final VoidCallback onContinueWithGoogle;
  final VoidCallback onForgotPassword;
  final VoidCallback onCreateAccount;

  @override
  Widget build(BuildContext context) {
    return MDScaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
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
                  padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
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
                          label: 'EMAIL OR USERNAME',
                          controller: identityController,
                          hintText: 'Enter your email or username',
                          prefixIcon: Icons.badge_outlined,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.none,
                          validator: identityValidator,
                          autofillHints: const [
                            AutofillHints.username,
                            AutofillHints.email,
                          ],
                        ),
                        const SizedBox(height: 24),
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
                          textInputAction: TextInputAction.done,
                          textCapitalization: TextCapitalization.none,
                          validator: passwordValidator,
                          onSubmitted: (_) => onLogin(),
                          autofillHints: const [AutofillHints.password],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Checkbox(
                              value: rememberMe,
                              activeColor: AppColors.primary,
                              checkColor: AppColors.surface,
                              fillColor: WidgetStateProperty.resolveWith(
                                (states) =>
                                    states.contains(WidgetState.disabled)
                                    ? AppColors.mutedText
                                    : states.contains(WidgetState.selected)
                                    ? AppColors.primary
                                    : AppColors.surface,
                              ),
                              side: const BorderSide(color: AppColors.border),
                              onChanged: isLoading
                                  ? null
                                  : (value) =>
                                        onRememberMeChanged(value ?? false),
                            ),
                            Expanded(
                              child: const MDText(
                                'Remember me',
                                variant: MDTextVariant.bodySmall,
                              ),
                            ),
                            TextButton(
                              onPressed: isLoading ? null : onForgotPassword,
                              style: TextButton.styleFrom(
                                foregroundColor: AppColors.link,
                                disabledForegroundColor: AppColors.mutedText,
                                overlayColor: AppColors.linkPressed,
                              ),
                              child: const MDText(
                                'Forgot Password?',
                                variant: MDTextVariant.bodySmall,
                                color: AppColors.link,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        MDButton(
                          label: 'Login',
                          icon: Icons.login,
                          isLoading: isLoading,
                          onPressed: onLogin,
                        ),
                        const SizedBox(height: 28),
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(color: AppColors.border),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                              ),
                              child: const MDText(
                                'OR',
                                variant: MDTextVariant.bodySmall,
                                letterSpacing: 4,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Expanded(
                              child: Divider(color: AppColors.border),
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),
                        MDButton(
                          label: 'Continue with Google',
                          iconWidget: const MDGoogleIcon(),
                          variant: MDButtonVariant.outlined,
                          enabled: !isLoading,
                          onPressed: onContinueWithGoogle,
                          labelFontSize: 12,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const MDText(
                              "Don't have an account?",
                              variant: MDTextVariant.bodySmall,
                            ),
                            TextButton(
                              onPressed: isLoading ? null : onCreateAccount,
                              style: TextButton.styleFrom(
                                foregroundColor: AppColors.link,
                                disabledForegroundColor: AppColors.mutedText,
                                overlayColor: AppColors.linkPressed,
                              ),
                              child: const MDText(
                                'Sign Up',
                                variant: MDTextVariant.bodySmall,
                                color: AppColors.link,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
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
