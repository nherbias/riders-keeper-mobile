import 'package:flutter/material.dart';
import 'package:riders_keeper/core/constants/theme/app_colors.dart';

class MDHomeBottomNavigation extends StatelessWidget {
  const MDHomeBottomNavigation({
    required this.currentIndex,
    required this.onDestinationSelected,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        iconTheme: WidgetStateProperty.all(
          const IconThemeData(color: AppColors.primary),
        ),
      ),
      child: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: onDestinationSelected,
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.border,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined, color: AppColors.primary),
            selectedIcon: Icon(Icons.home, color: AppColors.primary),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.two_wheeler_outlined, color: AppColors.primary),
            selectedIcon: Icon(Icons.two_wheeler, color: AppColors.primary),
            label: 'Garage',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined, color: AppColors.primary),
            selectedIcon: Icon(Icons.calendar_month, color: AppColors.primary),
            label: 'Calendar',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline, color: AppColors.primary),
            selectedIcon: Icon(Icons.person, color: AppColors.primary),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
