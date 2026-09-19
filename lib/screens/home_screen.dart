import 'package:dart_tutor/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../data/topics_data.dart';
import '../models/topic.dart';
import '../services/progress_service.dart';
import '../theme/app_palette.dart';
import '../widgets/topic_card.dart';
import 'settings_screen.dart';
import 'topic_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final ThemeMode themeMode;
  final Locale? locale;
  final AppPalette palette;
  final ValueChanged<ThemeMode> onSetThemeMode;
  final ValueChanged<Locale?> onSetLocale;
  final ValueChanged<AppPalette> onSetPalette;

  const HomeScreen({
    super.key,
    required this.themeMode,
    required this.locale,
    required this.palette,
    required this.onSetThemeMode,
    required this.onSetLocale,
    required this.onSetPalette,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _query = '';
  DifficultyLevel? _filterLevel;
  final Map<String, int> _progress = {};

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final Map<String, int> result = {};
    for (final t in kTopics) {
      result[t.id] = await ProgressService.completedCount(t.id, t.lessons.length);
    }
    if (mounted) setState(() => _progress.addAll(result));
  }

  List<Topic> get _filtered {
    return kTopics.where((t) {
      final matchQuery =
          _query.isEmpty ||
          t.title.toLowerCase().contains(_query.toLowerCase()) ||
          t.subtitle.toLowerCase().contains(_query.toLowerCase());
      final matchLevel = _filterLevel == null || t.difficulty == _filterLevel;
      return matchQuery && matchLevel;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            _buildAppBar(context, l10n, colorScheme),
            _buildSearch(context, l10n, colorScheme),
            _buildFilterChips(context, l10n, colorScheme),
            _buildTopicList(context, l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, AppLocalizations l10n, ColorScheme colorScheme) {
    return SliverAppBar.large(
      title: Text(l10n.appTitle, style: const TextStyle(fontWeight: FontWeight.w800, letterSpacing: -0.5)),
      actions: [
        IconButton(
          tooltip: l10n.settingsTitle,
          icon: const Icon(Icons.settings_outlined),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => SettingsScreen(
                themeMode: widget.themeMode,
                locale: widget.locale,
                palette: widget.palette,
                onSetThemeMode: widget.onSetThemeMode,
                onSetLocale: widget.onSetLocale,
                onSetPalette: widget.onSetPalette,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(32),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(l10n.homeSubtitle, style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 14)),
          ),
        ),
      ),
    );
  }

  Widget _buildSearch(BuildContext context, AppLocalizations l10n, ColorScheme colorScheme) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
        child: SearchBar(
          hintText: l10n.searchHint,
          leading: const Icon(Icons.search_rounded),
          padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 16)),
          onChanged: (val) => setState(() => _query = val),
          elevation: WidgetStateProperty.all(0),
          side: WidgetStateProperty.all(BorderSide(color: colorScheme.outlineVariant)),
        ),
      ),
    );
  }

  Widget _buildFilterChips(BuildContext context, AppLocalizations l10n, ColorScheme colorScheme) {
    final filters = <DifficultyLevel?>[
      null,
      DifficultyLevel.beginner,
      DifficultyLevel.intermediate,
      DifficultyLevel.advanced,
    ];
    final labels = [l10n.allLevels, l10n.difficultyBeginner, l10n.difficultyIntermediate, l10n.difficultyAdvanced];

    return SliverToBoxAdapter(
      child: SizedBox(
        height: 44,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: filters.length,
          separatorBuilder: (_, _) => const SizedBox(width: 8),
          itemBuilder: (context, i) {
            final selected = _filterLevel == filters[i];
            return FilterChip(
              label: Text(labels[i]),
              selected: selected,
              onSelected: (_) => setState(() => _filterLevel = filters[i]),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTopicList(BuildContext context, AppLocalizations l10n) {
    final topics = _filtered;

    if (topics.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🔍', style: TextStyle(fontSize: 48)),
              const SizedBox(height: 12),
              Text(l10n.noResults, style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      sliver: SliverList.separated(
        itemCount: topics.length,
        separatorBuilder: (_, _) => const SizedBox(height: 8),
        itemBuilder: (context, i) {
          final topic = topics[i];
          return TopicCard(
            topic: topic,
            completedLessons: _progress[topic.id] ?? 0,
            onTap: () =>
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => TopicDetailScreen(topic: topic)))
                    .then((_) => _loadProgress()),
          );
        },
      ),
    );
  }
}
