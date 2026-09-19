import 'package:dart_tutor/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../models/topic.dart';
import '../services/progress_service.dart';
import '../widgets/code_block.dart';

class LessonScreen extends StatefulWidget {
  final Topic topic;
  final int initialIndex;

  const LessonScreen({super.key, required this.topic, required this.initialIndex});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  late int _currentIndex;
  late PageController _pageController;
  Set<int> _doneLessons = {};

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final done = await ProgressService.completedLessons(widget.topic.id, widget.topic.lessons.length);
    if (mounted) setState(() => _doneLessons = done);
  }

  Future<void> _toggleDone() async {
    final isDone = _doneLessons.contains(_currentIndex);
    if (isDone) {
      await ProgressService.markLessonUndone(widget.topic.id, _currentIndex);
    } else {
      await ProgressService.markLessonDone(widget.topic.id, _currentIndex);
    }
    await _loadProgress();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Lesson get _current => widget.topic.lessons[_currentIndex];

  bool get _isFirst => _currentIndex == 0;

  bool get _isLast => _currentIndex == widget.topic.lessons.length - 1;

  void _goTo(int index) {
    setState(() => _currentIndex = index);
    _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final total = widget.topic.lessons.length;

    final isDone = _doneLessons.contains(_currentIndex);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.topic.title, style: const TextStyle(fontWeight: FontWeight.w700)),
        actions: [
          IconButton(
            tooltip: isDone ? l10n.markUndone : l10n.markDone,
            icon: Icon(
              isDone ? Icons.check_circle_rounded : Icons.check_circle_outline_rounded,
              color: isDone ? const Color(0xFF4CAF50) : null,
            ),
            onPressed: _toggleDone,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(28),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Row(
              children: [
                Text(
                  l10n.lessonOf(_currentIndex + 1, total),
                  style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: (_currentIndex + 1) / total,
                      minHeight: 4,
                      backgroundColor: colorScheme.surfaceContainerHighest,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: total,
        onPageChanged: (i) => setState(() => _currentIndex = i),
        itemBuilder: (context, index) {
          final lesson = widget.topic.lessons[index];
          return _LessonPage(lesson: lesson);
        },
      ),
      bottomNavigationBar: _NavBar(
        l10n: l10n,
        isFirst: _isFirst,
        isLast: _isLast,
        onPrev: _isFirst ? null : () => _goTo(_currentIndex - 1),
        onNext: _isLast ? null : () => _goTo(_currentIndex + 1),
        currentIndex: _currentIndex,
        total: total,
        onJump: _goTo,
      ),
    );
  }
}

class _LessonPage extends StatelessWidget {
  final Lesson lesson;

  const _LessonPage({required this.lesson});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        Text(lesson.title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 16),
        ...lesson.sections.map((s) => _SectionWidget(section: s)),
      ],
    );
  }
}

class _SectionWidget extends StatelessWidget {
  final LessonSection section;

  const _SectionWidget({required this.section});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (section.heading != null) ...[
          const SizedBox(height: 8),
          Text(
            section.heading!,
            style: Theme.of(context).textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w700, color: colorScheme.primary),
          ),
          const SizedBox(height: 6),
        ],
        if (section.text != null) ...[
          Text(section.text!, style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.6)),
          const SizedBox(height: 8),
        ],
        if (section.code != null) CodeBlock(code: section.code!),
        if (section.note != null) ...[const SizedBox(height: 8), _NoteBox(text: section.note!, label: l10n.noteLabel)],
        const SizedBox(height: 12),
      ],
    );
  }
}

class _NoteBox extends StatelessWidget {
  final String text;
  final String label;

  const _NoteBox({required this.text, required this.label});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.tertiaryContainer.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: colorScheme.tertiary.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb_outline_rounded, size: 18, color: colorScheme.tertiary),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(height: 1.5, color: colorScheme.onTertiaryContainer),
                children: [
                  TextSpan(
                    text: '$label: ',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextSpan(text: text),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavBar extends StatelessWidget {
  final AppLocalizations l10n;
  final bool isFirst;
  final bool isLast;
  final VoidCallback? onPrev;
  final VoidCallback? onNext;
  final int currentIndex;
  final int total;
  final void Function(int) onJump;

  const _NavBar({
    required this.l10n,
    required this.isFirst,
    required this.isLast,
    required this.onPrev,
    required this.onNext,
    required this.currentIndex,
    required this.total,
    required this.onJump,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          border: Border(top: BorderSide(color: colorScheme.outlineVariant)),
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onPrev,
                icon: const Icon(Icons.arrow_back_rounded, size: 18),
                label: Text(l10n.previousLesson),
              ),
            ),
            const SizedBox(width: 12),
            // Dot indicators
            if (total <= 8)
              Row(
                children: List.generate(total, (i) {
                  return GestureDetector(
                    onTap: () => onJump(i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: i == currentIndex ? 16 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: i == currentIndex ? colorScheme.primary : colorScheme.outlineVariant,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  );
                }),
              ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton.icon(
                onPressed: onNext,
                icon: Text(l10n.nextLesson),
                label: const Icon(Icons.arrow_forward_rounded, size: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
