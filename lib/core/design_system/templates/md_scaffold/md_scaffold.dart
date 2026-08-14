import 'package:flutter/material.dart';
import 'package:riders_keeper/core/constants/theme/app_colors.dart';
import 'package:riders_keeper/core/design_system/atoms/md_text/md_text.dart';
import 'package:riders_keeper/core/enum/text_variant.dart';

class MDScaffold extends StatelessWidget {
  const MDScaffold({
    required this.body,
    this.appBar,
    this.appBarTitle,
    this.appBarLeading,
    this.appBarActions,
    this.bottomNavigationBar,
    this.drawer,
    this.endDrawer,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.resizeToAvoidBottomInset = true,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.useSafeArea = true,
    this.safeAreaMinimum = EdgeInsets.zero,
    super.key,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final String? appBarTitle;
  final Widget? appBarLeading;
  final List<Widget>? appBarActions;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final Widget? endDrawer;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool resizeToAvoidBottomInset;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final bool useSafeArea;
  final EdgeInsets safeAreaMinimum;

  @override
  Widget build(BuildContext context) {
    final resolvedAppBar =
        appBar ??
        (appBarTitle == null
            ? null
            : AppBar(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.surface,
                leading: appBarLeading,
                title: MDText(
                  appBarTitle!,
                  variant: MDTextVariant.title,
                  color: AppColors.surface,
                  fontWeight: FontWeight.w800,
                ),
                actions: appBarActions,
              ));
    final content = useSafeArea
        ? SafeArea(minimum: safeAreaMinimum, child: body)
        : body;

    return Scaffold(
      appBar: resolvedAppBar,
      backgroundColor: AppColors.background,
      bottomNavigationBar: bottomNavigationBar,
      drawer: drawer,
      endDrawer: endDrawer,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      body: content,
    );
  }
}
