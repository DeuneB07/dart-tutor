import 'dart:math' as math;

import 'package:dart_tutor/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../models/topic.dart';

class FlashcardScreen extends StatefulWidget {
  final Topic topic;

  const FlashcardScreen({super.key, required this.topic});

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  bool _showingFront = true;
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;
  final Set<int> _known = {};

  List<Flashcard> get _cards => widget.topic.flashcards;

  bool get _done => _currentIndex >= _cards.length;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _flipAnimation = Tween<double>(
      begin: 0,
      end: math.pi,
    ).animate(CurvedAnimation(parent: _flipController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  void _flip() {
    if (_flipController.isAnimating) return;
    if (_showingFront) {
      _flipController.forward();
    } else {
      _flipController.reverse();
    }
    setState(() => _showingFront = !_showingFront);
  }

  void _action(bool know) {
    if (know) _known.add(_currentIndex);
    if (_showingFront == false) {
      _flipController.reverse();
      setState(() => _showingFront = true);
    }
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) setState(() => _currentIndex++);
    });
  }

  void _restart() {
    setState(() {
      _currentIndex = 0;
      _showingFront = true;
      _known.clear();
    });
    _flipController.reset();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text('${l10n.flashcardsTitle} — ${widget.topic.title}'),
        actions: [
          if (!_done)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(
                child: Text(
                  l10n.flashcardOf(_currentIndex + 1, _cards.length),
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ),
        ],
      ),
      body: _done ? _buildDone(context, l10n) : _buildCard(context, l10n),
    );
  }

  Widget _buildCard(BuildContext context, AppLocalizations l10n) {
    final colorScheme = Theme.of(context).colorScheme;
    final card = _cards[_currentIndex];

    return Column(
      children: [
        // Progress
        LinearProgressIndicator(
          value: _currentIndex / _cards.length,
          minHeight: 4,
          backgroundColor: colorScheme.surfaceContainerHighest,
        ),
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: GestureDetector(
                onTap: _flip,
                child: AnimatedBuilder(
                  animation: _flipAnimation,
                  builder: (context, child) {
                    final angle = _flipAnimation.value;
                    final isFrontVisible = angle < math.pi / 2;

                    return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(angle),
                      child: isFrontVisible
                          ? _CardFace(
                              card: card,
                              isFront: true,
                              colorScheme: colorScheme,
                              tapHint: l10n.flashcardTap,
                              label: l10n.flashcardFrontLabel,
                            )
                          : Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()..rotateY(math.pi),
                              child: _CardFace(
                                card: card,
                                isFront: false,
                                colorScheme: colorScheme,
                                tapHint: l10n.flashcardTap,
                                label: l10n.flashcardBackLabel,
                              ),
                            ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        // Action buttons
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _action(false),
                    icon: const Icon(Icons.refresh_rounded, size: 18),
                    label: Text(l10n.flashcardReview),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: colorScheme.error,
                      side: BorderSide(color: colorScheme.error.withValues(alpha: 0.5)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => _action(true),
                    icon: const Icon(Icons.check_rounded, size: 18),
                    label: Text(l10n.flashcardKnow),
                    style: FilledButton.styleFrom(backgroundColor: const Color(0xFF4CAF50)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDone(BuildContext context, AppLocalizations l10n) {
    final colorScheme = Theme.of(context).colorScheme;
    final knownCount = _known.length;
    final total = _cards.length;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('🎓', style: TextStyle(fontSize: 72)),
            const SizedBox(height: 16),
            Text(
              l10n.flashcardDone,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(
              '$knownCount / $total',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 8),
            // Known vs review bar
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: total > 0 ? knownCount / total : 0,
                minHeight: 10,
                backgroundColor: colorScheme.errorContainer,
                color: const Color(0xFF4CAF50),
              ),
            ),
            const SizedBox(height: 40),
            FilledButton.icon(
              onPressed: _restart,
              icon: const Icon(Icons.refresh_rounded),
              label: Text(l10n.flashcardRestart),
            ),
            const SizedBox(height: 12),
            OutlinedButton(onPressed: () => Navigator.of(context).pop(), child: Text(l10n.backToTopics)),
          ],
        ),
      ),
    );
  }
}

class _CardFace extends StatelessWidget {
  final Flashcard card;
  final bool isFront;
  final ColorScheme colorScheme;
  final String tapHint;
  final String label;

  const _CardFace({
    required this.card,
    required this.isFront,
    required this.colorScheme,
    required this.tapHint,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 260),
      decoration: BoxDecoration(
        color: isFront ? colorScheme.primaryContainer : colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 16, offset: const Offset(0, 4))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Label
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: (isFront ? colorScheme.primary : colorScheme.secondary).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: isFront ? colorScheme.primary : colorScheme.secondary,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Content
            Text(
              isFront ? card.front : card.back,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: isFront ? FontWeight.w700 : FontWeight.w500,
                height: 1.5,
                color: isFront ? colorScheme.onPrimaryContainer : colorScheme.onSecondaryContainer,
              ),
              textAlign: TextAlign.center,
            ),
            // Code snippet on back
            if (!isFront && card.code != null) ...[
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: const Color(0xFF1E1E2E), borderRadius: BorderRadius.circular(10)),
                child: SelectableText(
                  card.code!.trim(),
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 12, color: Color(0xFFCDD6F4), height: 1.6),
                ),
              ),
            ],
            const SizedBox(height: 16),
            // Tap hint
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.touch_app_rounded,
                  size: 14,
                  color: (isFront ? colorScheme.onPrimaryContainer : colorScheme.onSecondaryContainer).withValues(
                    alpha: 0.4,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  tapHint,
                  style: TextStyle(
                    fontSize: 11,
                    color: (isFront ? colorScheme.onPrimaryContainer : colorScheme.onSecondaryContainer).withValues(
                      alpha: 0.4,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
