import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riders_keeper/config/router/app_router.dart';
import 'package:riders_keeper/config/router/app_routes.dart';
import 'package:riders_keeper/core/constants/theme/app_colors.dart';
import 'package:riders_keeper/core/design_system/atoms/md_button/md_button.dart';
import 'package:riders_keeper/core/design_system/atoms/md_text/md_text.dart';
import 'package:riders_keeper/core/enum/text_variant.dart';
import 'package:riders_keeper/features/motorcycle/presentation/templates/add_motorcycle/add_motorcycle_template.dart';

class AddMotorcycleScreen extends ConsumerStatefulWidget {
  const AddMotorcycleScreen({super.key});

  @override
  ConsumerState<AddMotorcycleScreen> createState() =>
      _AddMotorcycleScreenState();
}

class _AddMotorcycleScreenState extends ConsumerState<AddMotorcycleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _yearController = TextEditingController();
  final _plateNumberController = TextEditingController();
  final _odometerController = TextEditingController();
  final _nicknameController = TextEditingController();

  bool _isLoading = false;
  final bool _hasSelectedPhoto = false;
  bool _isDirty = false;

  @override
  void initState() {
    super.initState();
    for (final controller in [
      _brandController,
      _modelController,
      _yearController,
      _plateNumberController,
      _odometerController,
      _nicknameController,
    ]) {
      controller.addListener(_markDirty);
    }
    _brandController.addListener(() => _limitLength(_brandController, 40));
    _modelController.addListener(() => _limitLength(_modelController, 40));
    _yearController.addListener(
      () => _formatDigits(_yearController, maxLength: 4),
    );
    _plateNumberController.addListener(_formatPlateNumber);
    _odometerController.addListener(
      () => _formatDigits(_odometerController, maxLength: 9),
    );
    _nicknameController.addListener(
      () => _limitLength(_nicknameController, 40),
    );
  }

  @override
  void dispose() {
    _brandController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    _plateNumberController.dispose();
    _odometerController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  String? _validateRequired(String? value, String field) {
    if ((value?.trim().isEmpty ?? true)) return 'Enter the $field';
    return null;
  }

  String? _validateYear(String? value) {
    final requiredError = _validateRequired(value, 'year');
    if (requiredError != null) return requiredError;

    final year = int.tryParse(value!.trim());
    final currentYear = DateTime.now().year + 1;
    if (year == null || year < 1885 || year > currentYear) {
      return 'Enter a valid year';
    }
    return null;
  }

  String? _validateOdometer(String? value) {
    final requiredError = _validateRequired(value, 'current odometer');
    if (requiredError != null) return requiredError;

    final odometer = int.tryParse(value!.trim());
    if (odometer == null || odometer < 0) {
      return 'Enter a valid odometer reading';
    }
    return null;
  }

  void _markDirty() {
    if (!_isDirty) setState(() => _isDirty = true);
  }

  void _limitLength(TextEditingController controller, int maxLength) {
    final value = controller.text;
    if (value.length <= maxLength) return;
    _replaceControllerText(controller, value.substring(0, maxLength));
  }

  void _formatDigits(
    TextEditingController controller, {
    required int maxLength,
  }) {
    final formatted = controller.text.replaceAll(RegExp(r'\D'), '');
    final limited = formatted.length > maxLength
        ? formatted.substring(0, maxLength)
        : formatted;
    if (limited != controller.text) _replaceControllerText(controller, limited);
  }

  void _formatPlateNumber() {
    final formatted = _plateNumberController.text.toUpperCase().replaceAll(
      RegExp(r'[^A-Z0-9 -]'),
      '',
    );
    final limited = formatted.length > 15
        ? formatted.substring(0, 15)
        : formatted;
    if (limited != _plateNumberController.text) {
      _replaceControllerText(_plateNumberController, limited);
    }
  }

  void _replaceControllerText(TextEditingController controller, String text) {
    controller.value = controller.value.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
      composing: TextRange.empty,
    );
  }

  void _selectPhoto() {
    // TODO: Open the platform image picker and store the selected file.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Photo selection will be available soon.')),
    );
  }

  Future<void> _goBack() async {
    if (!_isDirty) {
      ref.read(appRouterProvider).go(AppRoutes.garage);
      return;
    }

    final shouldDiscard = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const MDText(
          'Discard changes?',
          variant: MDTextVariant.title,
          fontWeight: FontWeight.w800,
        ),
        content: const MDText(
          'Your motorcycle details have not been saved.',
          variant: MDTextVariant.bodyMedium,
          color: AppColors.textSecondary,
        ),
        actions: [
          MDButton(
            label: 'KEEP EDITING',
            width: 140,
            variant: MDButtonVariant.outlined,
            onPressed: () => Navigator.of(dialogContext).pop(false),
          ),
          MDButton(
            label: 'DISCARD',
            width: 110,
            onPressed: () => Navigator.of(dialogContext).pop(true),
          ),
        ],
      ),
    );

    if (shouldDiscard == true && mounted) {
      ref.read(appRouterProvider).go(AppRoutes.garage);
    }
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isLoading = true);
    try {
      // TODO: Save the motorcycle through the motorcycle repository.
      await Future<void>.delayed(const Duration(milliseconds: 350));
      if (!mounted) return;
      _isDirty = false;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Motorcycle added to your garage.')),
      );
      ref.read(appRouterProvider).go(AppRoutes.garage);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AddMotorcycleTemplate(
      formKey: _formKey,
      brandController: _brandController,
      modelController: _modelController,
      yearController: _yearController,
      plateNumberController: _plateNumberController,
      odometerController: _odometerController,
      nicknameController: _nicknameController,
      isLoading: _isLoading,
      hasSelectedPhoto: _hasSelectedPhoto,
      brandValidator: (value) => _validateRequired(value, 'brand or make'),
      modelValidator: (value) => _validateRequired(value, 'model'),
      yearValidator: _validateYear,
      plateNumberValidator: (value) => _validateRequired(value, 'plate number'),
      odometerValidator: _validateOdometer,
      onSelectPhoto: _selectPhoto,
      onBack: _goBack,
      onSubmit: _submit,
    );
  }
}
