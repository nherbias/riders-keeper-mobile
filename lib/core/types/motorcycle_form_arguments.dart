import 'package:riders_keeper/core/types/motorcycle_draft.dart';
import 'package:riders_keeper/core/types/motorcycle_types.dart';

enum MotorcycleFormMode { create, edit }

class MotorcycleFormArguments {
  const MotorcycleFormArguments({
    required this.mode,
    required this.draft,
    this.originalMotorcycle,
  });

  final MotorcycleFormMode mode;
  final MotorcycleDraft draft;
  final MotorcycleData? originalMotorcycle;
}
