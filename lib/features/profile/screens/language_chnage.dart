import 'package:crop_advisory/core/providers/language_provider.dart';
import 'package:crop_advisory/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguageChangeScreen extends ConsumerWidget {
  const LanguageChangeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final currentLocale = ref.watch(localeNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.language)),
      body: ListView(
        children: [
          _buildLanguageTile(
            context,
            ref,
            title: 'English',
            locale: const Locale('en'),
            isSelected: currentLocale.languageCode == 'en',
          ),
          _buildLanguageTile(
            context,
            ref,
            title: 'हिंदी',
            locale: const Locale('hi'),
            isSelected: currentLocale.languageCode == 'hi',
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageTile(
    BuildContext context,
    WidgetRef ref, {
    required String title,
    required Locale locale,
    required bool isSelected,
  }) {
    return ListTile(
      title: Text(title),
      trailing: isSelected
          ? const Icon(Icons.check, color: Colors.green)
          : null,
      onTap: () {
        ref.read(localeNotifierProvider.notifier).setLocale(locale);
        Navigator.of(context).pop();
      },
    );
  }
}
