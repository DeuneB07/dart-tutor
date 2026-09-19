// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Dart Tutor';

  @override
  String get homeSubtitle => 'Learn Dart from scratch to advanced';

  @override
  String get topicsTitle => 'Topics';

  @override
  String get lessonsLabel => 'lessons';

  @override
  String get lessonLabel => 'lesson';

  @override
  String get difficultyBeginner => 'Beginner';

  @override
  String get difficultyIntermediate => 'Intermediate';

  @override
  String get difficultyAdvanced => 'Advanced';

  @override
  String topicProgress(int done, int total) {
    return '$done of $total lessons';
  }

  @override
  String get noteLabel => 'Note';

  @override
  String get backToTopics => 'Back to topics';

  @override
  String get nextLesson => 'Next lesson';

  @override
  String get previousLesson => 'Previous lesson';

  @override
  String lessonOf(int current, int total) {
    return 'Lesson $current of $total';
  }

  @override
  String get searchHint => 'Search topics...';

  @override
  String get noResults => 'No topics found';

  @override
  String get allLevels => 'All levels';

  @override
  String get filterBy => 'Filter';

  @override
  String get markDone => 'Mark as done';

  @override
  String get markUndone => 'Mark as not done';

  @override
  String get lessonDone => 'Lesson completed';

  @override
  String progressLabel(int done, int total) {
    return '$done/$total lessons completed';
  }

  @override
  String get takeQuiz => 'Take quiz';

  @override
  String get quizTitle => 'Quiz';

  @override
  String quizResult(int score) {
    return '$score% correct';
  }

  @override
  String quizBestScore(int score) {
    return 'Best: $score%';
  }

  @override
  String get quizCorrect => 'Correct!';

  @override
  String get quizIncorrect => 'Incorrect';

  @override
  String get quizFinish => 'Finish quiz';

  @override
  String get quizRetry => 'Retry';

  @override
  String quizQuestionOf(int current, int total) {
    return 'Question $current of $total';
  }

  @override
  String get quizExplanation => 'Explanation';

  @override
  String get flashcardsTitle => 'Flashcards';

  @override
  String get flashcardTap => 'Tap to flip';

  @override
  String flashcardOf(int current, int total) {
    return '$current / $total';
  }

  @override
  String get flashcardKnow => 'I know it';

  @override
  String get flashcardReview => 'Review again';

  @override
  String get flashcardDone => 'Session completed!';

  @override
  String get flashcardRestart => 'Start over';

  @override
  String get noQuiz => 'No quiz available for this topic';

  @override
  String get noFlashcards => 'No flashcards available for this topic';

  @override
  String get codeCopy => 'Copy';

  @override
  String get codeCopied => 'Copied';

  @override
  String get lightMode => 'Light mode';

  @override
  String get darkMode => 'Dark mode';

  @override
  String get flashcardFrontLabel => 'Concept';

  @override
  String get flashcardBackLabel => 'Explanation';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsThemeSystem => 'System default';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageSystem => 'System';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsLanguageSpanish => 'Español';

  @override
  String get settingsPalette => 'Color palette';

  @override
  String get settingsData => 'Data';

  @override
  String get settingsResetProgress => 'Reset progress';

  @override
  String get settingsResetProgressSubtitle =>
      'Delete all completed lessons and quiz scores';

  @override
  String get settingsResetConfirmTitle => 'Reset progress?';

  @override
  String get settingsResetConfirmBody =>
      'This will permanently delete all your completed lessons and quiz scores. This action cannot be undone.';

  @override
  String get settingsResetConfirm => 'Reset';

  @override
  String get settingsResetDone => 'Progress reset';

  @override
  String get cancel => 'Cancel';
}
