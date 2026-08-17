import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riders_keeper/config/router/app_router.dart';
import 'package:riders_keeper/config/router/app_routes.dart';
import 'package:riders_keeper/core/types/motorcycle_draft.dart';
import 'package:riders_keeper/features/motorcycle/presentation/templates/review_motorcycle/review_motorcycle_template.dart';

class ReviewMotorcycleScreen extends ConsumerStatefulWidget {
  const ReviewMotorcycleScreen({required this.draft, super.key});

  final MotorcycleDraft draft;

  @override
  ConsumerState<ReviewMotorcycleScreen> createState() =>
      _ReviewMotorcycleScreenState();
}

class _ReviewMotorcycleScreenState
    extends ConsumerState<ReviewMotorcycleScreen> {
  bool _isLoading = false;

  void _editDetails() {
    ref
        .read(appRouterProvider)
        .go(AppRoutes.addMotorcycle, extra: widget.draft);
  }

  Future<void> _confirm() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);
    try {
      // TODO: Persist the reviewed motorcycle through the repository.
      await Future<void>.delayed(const Duration(milliseconds: 350));
      if (!mounted) return;
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
    return ReviewMotorcycleTemplate(
      draft: widget.draft,
      isLoading: _isLoading,
      onBack: _editDetails,
      onEditDetails: _editDetails,
      onConfirm: _confirm,
    );
  }
}
