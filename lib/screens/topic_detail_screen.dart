import 'package:dart_tutor/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../models/topic.dart';
import '../services/progress_service.dart';
import '../widgets/difficulty_badge.dart';
import 'flashcard_screen.dart';
import 'lesson_screen.dart';
import 'quiz_screen.dart';

class TopicDetailScreen extends StatefulWidget {
  final Topic topic;

  const TopicDetailScreen({super.key, required this.topic});

  @override
  State<TopicDetailScreen> createState() => _TopicDetailScreenState();
}

class _TopicDetailScreenState extends State<TopicDetailScreen> {
  int _completedCount = 0;
  int? _bestScore;
  Set<int> _doneLessons = {};

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final total = widget.topic.lessons.length;
    final done = await ProgressService.completedLessons(widget.topic.id, total);
    final score = await ProgressService.bestQuizScore(widget.topic.id);
    if (mounted) {
      setState(() {
        _doneLessons = done;
        _completedCount = done.length;
        _bestScore = score;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final topic = widget.topic;
    final total = topic.lessons.length;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text(topic.title, style: const TextStyle(fontWeight: FontWeight.w800)),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(topic.icon, style: const TextStyle(fontSize: 36)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          topic.subtitle,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      DifficultyBadge(difficulty: topic.difficulty),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '${topic.lessons.length} ${topic.lessons.length == 1 ? l10n.lessonLabel : l10n.lessonsLabel}',
                          style: TextStyle(
                            color: colorScheme.onSecondaryContainer,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // ── Progreso ──────────────────────
                  _ProgressBar(completed: _completedCount, total: total, l10n: l10n),
                  const SizedBox(height: 16),
                  // ── Botones Quiz y Flashcards ─────
                  Row(
                    children: [
                      if (topic.quiz.isNotEmpty)
                        Expanded(
                          child: _ActionButton(
                            icon: Icons.quiz_rounded,
                            label: l10n.takeQuiz,
                            badge: _bestScore != null ? l10n.quizBestScore(_bestScore!) : null,
                            onTap: () =>
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (_) => QuizScreen(topic: topic)))
                                    .then((_) => _loadProgress()),
                          ),
                        ),
                      if (topic.quiz.isNotEmpty && topic.flashcards.isNotEmpty) const SizedBox(width: 10),
                      if (topic.flashcards.isNotEmpty)
                        Expanded(
                          child: _ActionButton(
                            icon: Icons.style_rounded,
                            label: l10n.flashcardsTitle,
                            badge: '${topic.flashcards.length}',
                            onTap: () =>
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (_) => FlashcardScreen(topic: topic))),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    l10n.topicsTitle,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            sliver: SliverList.separated(
              itemCount: total,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final lesson = topic.lessons[index];
                return _LessonTile(
                  lesson: lesson,
                  index: index,
                  total: total,
                  isDone: _doneLessons.contains(index),
                  onTap: () => Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                          builder: (_) => LessonScreen(topic: topic, initialIndex: index),
                        ),
                      )
                      .then((_) => _loadProgress()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final int completed;
  final int total;
  final AppLocalizations l10n;

  const _ProgressBar({required this.completed, required this.total, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final pct = total > 0 ? completed / total : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.progressLabel(completed, total),
              style: Theme.of(context).textTheme.labelMedium?.copyWith(color: colorScheme.onSurfaceVariant),
            ),
            Text(
              '${(pct * 100).round()}%',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: pct == 1.0 ? const Color(0xFF4CAF50) : colorScheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: pct,
            minHeight: 6,
            backgroundColor: colorScheme.surfaceContainerHighest,
            color: pct == 1.0 ? const Color(0xFF4CAF50) : colorScheme.primary,
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? badge;
  final VoidCallback onTap;

  const _ActionButton({required this.icon, required this.label, this.badge, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Icon(icon, color: colorScheme.primary, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              if (badge != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    badge!,
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: colorScheme.onPrimaryContainer),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LessonTile extends StatelessWidget {
  final Lesson lesson;
  final int index;
  final int total;
  final bool isDone;
  final VoidCallback onTap;

  const _LessonTile({
    required this.lesson,
    required this.index,
    required this.total,
    required this.isDone,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: isDone ? const Color(0xFF4CAF50).withValues(alpha: 0.15) : colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: isDone
                      ? const Icon(Icons.check_rounded, size: 18, color: Color(0xFF4CAF50))
                      : Text(
                          '${index + 1}',
                          style: TextStyle(fontWeight: FontWeight.w700, color: colorScheme.onPrimaryContainer),
                        ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  lesson.title,
                  style: Theme.of(context).textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w500, color: isDone ? colorScheme.onSurfaceVariant : null),
                ),
              ),
              Icon(Icons.play_circle_outline_rounded, color: colorScheme.primary),
            ],
          ),
        ),
      ),
    );
  }
}
