import 'package:dart_tutor/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../services/progress_service.dart';
import '../theme/app_palette.dart';

class SettingsScreen extends StatelessWidget {
  final ThemeMode themeMode;
  final Locale? locale;
  final AppPalette palette;
  final ValueChanged<ThemeMode> onSetThemeMode;
  final ValueChanged<Locale?> onSetLocale;
  final ValueChanged<AppPalette> onSetPalette;

  const SettingsScreen({
    super.key,
    required this.themeMode,
    required this.locale,
    required this.palette,
    required this.onSetThemeMode,
    required this.onSetLocale,
    required this.onSetPalette,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        children: [
          // ── Theme ──────────────────────────────────────────
          _SectionHeader(label: l10n.settingsTheme, colorScheme: colorScheme),
          RadioListTile<ThemeMode>(
            value: ThemeMode.system,
            groupValue: themeMode,
            onChanged: (v) {
              if (v != null) onSetThemeMode(v);
            },
            title: Text(l10n.settingsThemeSystem),
            secondary: const Icon(Icons.brightness_auto_rounded),
          ),
          RadioListTile<ThemeMode>(
            value: ThemeMode.light,
            groupValue: themeMode,
            onChanged: (v) {
              if (v != null) onSetThemeMode(v);
            },
            title: Text(l10n.settingsThemeLight),
            secondary: const Icon(Icons.light_mode_rounded),
          ),
          RadioListTile<ThemeMode>(
            value: ThemeMode.dark,
            groupValue: themeMode,
            onChanged: (v) {
              if (v != null) onSetThemeMode(v);
            },
            title: Text(l10n.settingsThemeDark),
            secondary: const Icon(Icons.dark_mode_rounded),
          ),

          const Divider(height: 32),

          // ── Language ───────────────────────────────────────
          _SectionHeader(label: l10n.settingsLanguage, colorScheme: colorScheme),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SegmentedButton<Locale?>(
              segments: [
                ButtonSegment(value: null, label: Text(l10n.settingsLanguageSystem)),
                ButtonSegment(value: const Locale('en'), label: Text(l10n.settingsLanguageEnglish)),
                ButtonSegment(value: const Locale('es'), label: Text(l10n.settingsLanguageSpanish)),
              ],
              selected: {locale},
              onSelectionChanged: (s) => onSetLocale(s.first),
            ),
          ),

          const Divider(height: 32),

          // ── Palette ────────────────────────────────────────
          _SectionHeader(label: l10n.settingsPalette, colorScheme: colorScheme),
          const SizedBox(height: 8),
          _PaletteGrid(palettes: kPalettes, selected: palette, onChanged: onSetPalette),
          const SizedBox(height: 24),

          const Divider(height: 32),

          // ── Reset progress ─────────────────────────────────
          _SectionHeader(label: l10n.settingsData, colorScheme: colorScheme),
          ListTile(
            leading: Icon(Icons.delete_sweep_rounded, color: colorScheme.error),
            title: Text(l10n.settingsResetProgress, style: TextStyle(color: colorScheme.error)),
            subtitle: Text(l10n.settingsResetProgressSubtitle),
            onTap: () => _confirmReset(context, l10n),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Future<void> _confirmReset(BuildContext context, AppLocalizations l10n) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.settingsResetConfirmTitle),
        content: Text(l10n.settingsResetConfirmBody),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l10n.cancel)),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Theme.of(ctx).colorScheme.error),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.settingsResetConfirm),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      await ProgressService.resetAll();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.settingsResetDone)));
      }
    }
  }
}

// ── Section header ─────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String label;
  final ColorScheme colorScheme;

  const _SectionHeader({required this.label, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge
            ?.copyWith(color: colorScheme.primary, fontWeight: FontWeight.w700, letterSpacing: 0.5),
      ),
    );
  }
}

// ── Palette grid ───────────────────────────────────────────────

class _PaletteGrid extends StatelessWidget {
  final List<AppPalette> palettes;
  final AppPalette selected;
  final ValueChanged<AppPalette> onChanged;

  const _PaletteGrid({required this.palettes, required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 12,
        runSpacing: 16,
        children: palettes
            .map((p) => _PaletteSwatch(palette: p, isSelected: p.id == selected.id, onTap: () => onChanged(p)))
            .toList(),
      ),
    );
  }
}

class _PaletteSwatch extends StatelessWidget {
  final AppPalette palette;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaletteSwatch({required this.palette, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final appScheme = Theme.of(context).colorScheme;
    final preview = palette.scheme(Brightness.light);

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 88,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: preview.surface,
                border: Border.all(
                  color: isSelected ? appScheme.primary : appScheme.outlineVariant,
                  width: isSelected ? 3 : 1.5,
                ),
                boxShadow: isSelected
                    ? [BoxShadow(color: preview.primary.withValues(alpha: 0.35), blurRadius: 10, spreadRadius: 2)]
                    : null,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Primary — large circle center
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(color: preview.primary, shape: BoxShape.circle),
                    child: isSelected ? Icon(Icons.check_rounded, color: preview.onPrimary, size: 18) : null,
                  ),
                  // Secondary — bottom-right pip
                  Positioned(
                    right: 8,
                    bottom: 8,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: preview.secondary,
                        shape: BoxShape.circle,
                        border: Border.all(color: preview.surface, width: 1.5),
                      ),
                    ),
                  ),
                  // Tertiary — top-right pip
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: preview.tertiary,
                        shape: BoxShape.circle,
                        border: Border.all(color: preview.surface, width: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Text(
              palette.name,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                color: isSelected ? appScheme.primary : appScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
