import 'package:dart_tutor/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../models/topic.dart';
import 'difficulty_badge.dart';

class TopicCard extends StatelessWidget {
  final Topic topic;
  final VoidCallback onTap;
  final int completedLessons;

  const TopicCard({super.key, required this.topic, required this.onTap, this.completedLessons = 0});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final totalLessons = topic.lessons.length;
    final lessonWord = totalLessons == 1 ? l10n.lessonLabel : l10n.lessonsLabel;

    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Icon
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(color: colorScheme.primaryContainer, borderRadius: BorderRadius.circular(12)),
                child: Center(child: Text(topic.icon, style: const TextStyle(fontSize: 26))),
              ),
              const SizedBox(width: 14),
              // Text content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      topic.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      topic.subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        DifficultyBadge(difficulty: topic.difficulty, small: true),
                        const SizedBox(width: 8),
                        Text(
                          '$totalLessons $lessonWord',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                    if (completedLessons > 0) ...[
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: LinearProgressIndicator(
                          value: completedLessons / totalLessons,
                          minHeight: 4,
                          backgroundColor: colorScheme.surfaceContainerHighest,
                          color: completedLessons == totalLessons ? const Color(0xFF4CAF50) : colorScheme.primary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.chevron_right_rounded, color: colorScheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}
