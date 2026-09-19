import 'package:dart_tutor/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../models/topic.dart';
import '../theme/app_theme.dart';

class DifficultyBadge extends StatelessWidget {
  final DifficultyLevel difficulty;
  final bool small;

  const DifficultyBadge({super.key, required this.difficulty, this.small = false});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final color = AppTheme.difficultyColor(difficulty, context);
    final label = switch (difficulty) {
      DifficultyLevel.beginner => l10n.difficultyBeginner,
      DifficultyLevel.intermediate => l10n.difficultyIntermediate,
      DifficultyLevel.advanced => l10n.difficultyAdvanced,
    };

    return Container(
      padding: EdgeInsets.symmetric(horizontal: small ? 8 : 10, vertical: small ? 2 : 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: small ? 10 : 12, fontWeight: FontWeight.w600, letterSpacing: 0.3),
      ),
    );
  }
}
