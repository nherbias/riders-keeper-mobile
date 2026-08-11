import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riders_keeper/features/auth/providers/auth_provider.dart';
import 'package:riders_keeper/features/auth/providers/auth_status.dart';

final appNavigationProvider = Provider<ValueNotifier<AuthStatus>>((ref) {
  final notifier = ValueNotifier(ref.read(authProvider));

  ref.listen(authProvider, (_, next) => notifier.value = next);
  ref.onDispose(notifier.dispose);

  return notifier;
});
