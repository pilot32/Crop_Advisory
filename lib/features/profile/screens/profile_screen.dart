/// Profile Screen
///
/// User profile with settings and account information

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../auth/providers/simple_auth_provider.dart';
import '../../../l10n/app_localizations.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final authNotifier = ref.read(authProvider.notifier);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Edit profile coming soon')),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.paddingMD),
        children: [
          // Profile Header
          Center(
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.person, size: 50, color: AppColors.primary),
                ),
                const SizedBox(height: AppDimensions.paddingMD),
                Text(user?.email ?? 'Guest User', style: AppTextStyles.h3),
                const SizedBox(height: AppDimensions.paddingSM),
                Text(
                  'Farmer',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimensions.paddingXL),

          // Account Section
          _buildSectionTitle('Account'),
          _buildListTile(
            icon: Icons.person_outline,
            title: 'Personal Information',
            subtitle: 'Manage your personal details',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Feature coming soon')),
              );
            },
          ),
          _buildListTile(
            icon: Icons.agriculture_outlined,
            title: 'Farm Details',
            subtitle: 'Update your farm information',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Feature coming soon')),
              );
            },
          ),
          const SizedBox(height: AppDimensions.paddingMD),

          // Preferences Section
          _buildSectionTitle('Preferences'),
          _buildListTile(
            icon: Icons.language_outlined,
            title: 'Language',
            subtitle: 'Change app language',
            onTap: () {
              Navigator.of(context).pushNamed(Routes.languageSelection);
            },
          ),
          _buildListTile(
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            subtitle: 'Manage notification preferences',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Feature coming soon')),
              );
            },
          ),
          _buildListTile(
            icon: Icons.dark_mode_outlined,
            title: 'Theme',
            subtitle: 'Choose app appearance',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Feature coming soon')),
              );
            },
          ),
          const SizedBox(height: AppDimensions.paddingMD),

          // Support Section
          _buildSectionTitle('Support'),
          _buildListTile(
            icon: Icons.help_outline,
            title: 'Help & Support',
            subtitle: 'Get help with the app',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Feature coming soon')),
              );
            },
          ),
          _buildListTile(
            icon: Icons.info_outline,
            title: 'About',
            subtitle: 'App version ${AppConstants.appVersion}',
            onTap: () {
              _showAboutDialog(context);
            },
          ),
          _buildListTile(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy',
            subtitle: 'Read our privacy policy',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Feature coming soon')),
              );
            },
          ),
          const SizedBox(height: AppDimensions.paddingMD),

          // Logout Button
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppDimensions.paddingMD,
            ),
            child: ElevatedButton.icon(
              onPressed: () => _showLogoutConfirmation(context, authNotifier),
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: AppColors.textLight,
                padding: const EdgeInsets.all(AppDimensions.paddingMD),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: AppDimensions.paddingSM,
        top: AppDimensions.paddingSM,
      ),
      child: Text(title, style: AppTextStyles.h4),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppDimensions.paddingSM),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(AppDimensions.paddingSM),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
          ),
          child: Icon(icon, color: AppColors.primary),
        ),
        title: Text(title, style: AppTextStyles.bodyLarge),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              )
            : null,
        trailing: Icon(Icons.chevron_right, color: AppColors.textSecondary),
        onTap: onTap,
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context, authNotifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await authNotifier.signOut();
              if (context.mounted) {
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil(Routes.login, (route) => false);
              }
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About Crop Advisory'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Version: ${AppConstants.appVersion}',
              style: AppTextStyles.body,
            ),
            const SizedBox(height: AppDimensions.paddingMD),
            Text(
              'A smart farming assistant powered by AI to help farmers make informed decisions.',
              style: AppTextStyles.body,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
