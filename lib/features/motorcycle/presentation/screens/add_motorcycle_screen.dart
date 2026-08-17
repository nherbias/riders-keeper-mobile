import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riders_keeper/config/router/app_router.dart';
import 'package:riders_keeper/config/router/app_routes.dart';
import 'package:riders_keeper/core/constants/theme/app_colors.dart';
import 'package:riders_keeper/core/design_system/atoms/md_button/md_button.dart';
import 'package:riders_keeper/core/design_system/atoms/md_text/md_text.dart';
import 'package:riders_keeper/core/enum/text_variant.dart';
import 'package:riders_keeper/core/types/motorcycle_draft.dart';
import 'package:riders_keeper/features/motorcycle/presentation/templates/add_motorcycle/add_motorcycle_template.dart';

class AddMotorcycleScreen extends ConsumerStatefulWidget {
  const AddMotorcycleScreen({this.initialDraft, super.key});

  final MotorcycleDraft? initialDraft;

  @override
  ConsumerState<AddMotorcycleScreen> createState() =>
      _AddMotorcycleScreenState();
}

class _AddMotorcycleScreenState extends ConsumerState<AddMotorcycleScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _brandController;
  late final TextEditingController _modelController;
  late final TextEditingController _yearController;
  late final TextEditingController _plateNumberController;
  late final TextEditingController _odometerController;
  late final TextEditingController _nicknameController;

  final bool _isLoading = false;
  late final bool _hasSelectedPhoto;
  bool _isDirty = false;

  @override
  void initState() {
    super.initState();
    final draft = widget.initialDraft;
    _brandController = TextEditingController(text: draft?.brand ?? '');
    _modelController = TextEditingController(text: draft?.model ?? '');
    _yearController = TextEditingController(text: draft?.year ?? '');
    _plateNumberController = TextEditingController(
      text: draft?.plateNumber ?? '',
    );
    _odometerController = TextEditingController(
      text: draft == null ? '' : draft.odometerKm.toString(),
    );
    _nicknameController = TextEditingController(text: draft?.nickname ?? '');
    _hasSelectedPhoto = draft?.hasPhoto ?? false;
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
          Row(
            children: [
              Expanded(
                child: MDButton(
                  label: 'Keep Editing',
                  variant: MDButtonVariant.outlined,
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                  labelFontSize: 12,
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: MDButton(
                  label: 'Discard',
                  onPressed: () => Navigator.of(dialogContext).pop(true),
                  labelFontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );

    if (shouldDiscard == true && mounted) {
      ref.read(appRouterProvider).go(AppRoutes.garage);
    }
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final draft = MotorcycleDraft(
      brand: _brandController.text.trim(),
      model: _modelController.text.trim(),
      year: _yearController.text.trim(),
      plateNumber: _plateNumberController.text.trim(),
      odometerKm: int.parse(_odometerController.text.trim()),
      nickname: _nicknameController.text.trim(),
      hasPhoto: _hasSelectedPhoto,
    );
    _isDirty = false;
    ref.read(appRouterProvider).go(AppRoutes.reviewMotorcycle, extra: draft);
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
