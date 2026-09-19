class Topic {
  final String id;
  final String title;
  final String subtitle;
  final String icon;
  final List<Lesson> lessons;
  final DifficultyLevel difficulty;
  final List<QuizQuestion> quiz;
  final List<Flashcard> flashcards;

  const Topic({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.lessons,
    required this.difficulty,
    this.quiz = const [],
    this.flashcards = const [],
  });
}

class Lesson {
  final String title;
  final List<LessonSection> sections;

  const Lesson({required this.title, required this.sections});
}

class LessonSection {
  final String? heading;
  final String? text;
  final String? code;
  final String? note;

  const LessonSection({this.heading, this.text, this.code, this.note});
}

class QuizQuestion {
  final String question;
  final String? code;
  final List<String> options;
  final int correctIndex;
  final String? explanation;

  const QuizQuestion({
    required this.question,
    this.code,
    required this.options,
    required this.correctIndex,
    this.explanation,
  });
}

class Flashcard {
  final String front;
  final String back;
  final String? code;

  const Flashcard({required this.front, required this.back, this.code});
}

enum DifficultyLevel { beginner, intermediate, advanced }
