import 'package:dart_tutor/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../models/topic.dart';
import '../services/progress_service.dart';
import '../widgets/code_block.dart';

class QuizScreen extends StatefulWidget {
  final Topic topic;

  const QuizScreen({super.key, required this.topic});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  int? _selectedOption;
  bool _answered = false;
  int _correctCount = 0;
  bool _finished = false;

  List<QuizQuestion> get _questions => widget.topic.quiz;

  QuizQuestion get _current => _questions[_currentIndex];

  void _selectOption(int index) {
    if (_answered) return;
    setState(() {
      _selectedOption = index;
      _answered = true;
      if (index == _current.correctIndex) _correctCount++;
    });
  }

  void _next() {
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedOption = null;
        _answered = false;
      });
    } else {
      _finish();
    }
  }

  Future<void> _finish() async {
    final score = (_correctCount * 100 / _questions.length).round();
    await ProgressService.saveQuizScore(widget.topic.id, score);
    setState(() => _finished = true);
  }

  void _retry() {
    setState(() {
      _currentIndex = 0;
      _selectedOption = null;
      _answered = false;
      _correctCount = 0;
      _finished = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text('${l10n.quizTitle} — ${widget.topic.title}')),
      body: _finished ? _buildResults(context, l10n) : _buildQuestion(context, l10n),
    );
  }

  Widget _buildQuestion(BuildContext context, AppLocalizations l10n) {
    final colorScheme = Theme.of(context).colorScheme;
    final total = _questions.length;

    return Column(
      children: [
        // Progress bar
        LinearProgressIndicator(
          value: (_currentIndex + (_answered ? 1 : 0)) / total,
          minHeight: 4,
          backgroundColor: colorScheme.surfaceContainerHighest,
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                l10n.quizQuestionOf(_currentIndex + 1, total),
                style: Theme.of(context).textTheme.labelMedium?.copyWith(color: colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: 12),
              Text(
                _current.question,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700, height: 1.4),
              ),
              if (_current.code != null) ...[const SizedBox(height: 16), CodeBlock(code: _current.code!)],
              const SizedBox(height: 24),
              ...List.generate(_current.options.length, (i) {
                return _OptionTile(
                  text: _current.options[i],
                  index: i,
                  selected: _selectedOption == i,
                  answered: _answered,
                  isCorrect: i == _current.correctIndex,
                  onTap: () => _selectOption(i),
                );
              }),
              if (_answered && _current.explanation != null) ...[
                const SizedBox(height: 16),
                _ExplanationBox(
                  isCorrect: _selectedOption == _current.correctIndex,
                  explanation: _current.explanation!,
                  l10n: l10n,
                ),
              ],
              const SizedBox(height: 80),
            ],
          ),
        ),
        if (_answered) _NextButton(isLast: _currentIndex == total - 1, onNext: _next, l10n: l10n),
      ],
    );
  }

  Widget _buildResults(BuildContext context, AppLocalizations l10n) {
    final colorScheme = Theme.of(context).colorScheme;
    final score = (_correctCount * 100 / _questions.length).round();
    final perfect = score == 100;
    final good = score >= 70;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              perfect
                  ? '🏆'
                  : good
                  ? '🎉'
                  : '📚',
              style: const TextStyle(fontSize: 72),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.quizResult(score),
              style: Theme.of(context).textTheme.displaySmall
                  ?.copyWith(fontWeight: FontWeight.w800, color: _scoreColor(score, colorScheme)),
            ),
            const SizedBox(height: 8),
            Text(
              '$_correctCount / ${_questions.length}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 40),
            FilledButton.icon(onPressed: _retry, icon: const Icon(Icons.refresh_rounded), label: Text(l10n.quizRetry)),
            const SizedBox(height: 12),
            OutlinedButton(onPressed: () => Navigator.of(context).pop(), child: Text(l10n.backToTopics)),
          ],
        ),
      ),
    );
  }

  Color _scoreColor(int score, ColorScheme colorScheme) {
    if (score == 100) return const Color(0xFF4CAF50);
    if (score >= 70) return colorScheme.primary;
    return colorScheme.error;
  }
}

class _OptionTile extends StatelessWidget {
  final String text;
  final int index;
  final bool selected;
  final bool answered;
  final bool isCorrect;
  final VoidCallback onTap;

  const _OptionTile({
    required this.text,
    required this.index,
    required this.selected,
    required this.answered,
    required this.isCorrect,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    Color? bgColor;
    Color? borderColor;
    Widget? trailingIcon;

    if (answered) {
      if (isCorrect) {
        bgColor = const Color(0xFF4CAF50).withValues(alpha: 0.12);
        borderColor = const Color(0xFF4CAF50);
        trailingIcon = const Icon(Icons.check_circle_rounded, color: Color(0xFF4CAF50));
      } else if (selected) {
        bgColor = colorScheme.errorContainer.withValues(alpha: 0.5);
        borderColor = colorScheme.error;
        trailingIcon = Icon(Icons.cancel_rounded, color: colorScheme.error);
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: bgColor ?? colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: borderColor ?? colorScheme.outlineVariant,
            width: answered && (isCorrect || selected) ? 1.5 : 1,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: answered ? null : onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: colorScheme.primaryContainer),
                  child: Center(
                    child: Text(
                      String.fromCharCode(65 + index), // A, B, C, D
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(child: Text(text, style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.4))),
                if (trailingIcon != null) ...[const SizedBox(width: 8), trailingIcon],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ExplanationBox extends StatelessWidget {
  final bool isCorrect;
  final String explanation;
  final AppLocalizations l10n;

  const _ExplanationBox({required this.isCorrect, required this.explanation, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final color = isCorrect ? const Color(0xFF4CAF50) : colorScheme.error;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(isCorrect ? Icons.check_circle_outline_rounded : Icons.info_outline_rounded, color: color, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isCorrect ? l10n.quizCorrect : l10n.quizIncorrect,
                  style: TextStyle(fontWeight: FontWeight.w700, color: color, fontSize: 13),
                ),
                const SizedBox(height: 4),
                Text(explanation, style: Theme.of(context).textTheme.bodySmall?.copyWith(height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NextButton extends StatelessWidget {
  final bool isLast;
  final VoidCallback onNext;
  final AppLocalizations l10n;

  const _NextButton({required this.isLast, required this.onNext, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          border: Border(top: BorderSide(color: colorScheme.outlineVariant)),
        ),
        child: SizedBox(
          width: double.infinity,
          child: FilledButton(onPressed: onNext, child: Text(isLast ? l10n.quizFinish : l10n.nextLesson)),
        ),
      ),
    );
  }
}
