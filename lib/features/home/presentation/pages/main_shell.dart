import 'package:bariq/core/config/app_router.dart';
import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Main shell providing persistent bottom navigation across home tabs.
///
/// The bottom bar matches the Figma design with four destinations:
/// الرئيسية · سياراتي · الحجز · حسابي.
class MainShell extends StatelessWidget {
  const MainShell({required this.child, super.key});

  final Widget child;

  static const _navItems = [
    _NavItem(
      label: AppStrings.navHome,
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
      route: AppRoutes.home,
    ),
    _NavItem(
      label: AppStrings.navVehicles,
      icon: Icons.directions_car_outlined,
      activeIcon: Icons.directions_car_rounded,
      route: AppRoutes.vehicles,
    ),
    _NavItem(
      label: AppStrings.navBooking,
      icon: Icons.calendar_today_outlined,
      activeIcon: Icons.calendar_today_rounded,
      route: AppRoutes.services,
    ),
    _NavItem(
      label: AppStrings.navAccount,
      icon: Icons.person_outline_rounded,
      activeIcon: Icons.person_rounded,
      route: AppRoutes.home, // placeholder until profile settings page
    ),
  ];

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith('/vehicles') || location.startsWith('/addresses')) {
      return 1;
    }
    if (location.startsWith('/services')) return 2;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final index = _currentIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.aquaSurface,
        onDestinationSelected: (i) {
          if (i == index) return;
          context.go(_navItems[i].route);
        },
        destinations: [
          for (final item in _navItems)
            NavigationDestination(
              icon: Icon(item.icon),
              selectedIcon: Icon(item.activeIcon, color: AppColors.aqua),
              label: item.label,
            ),
        ],
      ),
    );
  }
}

class _NavItem {
  const _NavItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.route,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
  final String route;
}
