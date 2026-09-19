import 'package:shared_preferences/shared_preferences.dart';

class ProgressService {
  static const _keyPrefix = 'lesson_done_';
  static const _quizPrefix = 'quiz_score_';

  // ── Lecciones ──────────────────────────────────────────────

  static String _lessonKey(String topicId, int lessonIndex) => '$_keyPrefix${topicId}_$lessonIndex';

  static Future<void> markLessonDone(String topicId, int lessonIndex) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_lessonKey(topicId, lessonIndex), true);
  }

  static Future<void> markLessonUndone(String topicId, int lessonIndex) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_lessonKey(topicId, lessonIndex));
  }

  static Future<bool> isLessonDone(String topicId, int lessonIndex) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_lessonKey(topicId, lessonIndex)) ?? false;
  }

  /// Devuelve cuántas lecciones completadas tiene un tema.
  static Future<int> completedCount(String topicId, int totalLessons) async {
    final prefs = await SharedPreferences.getInstance();
    int count = 0;
    for (int i = 0; i < totalLessons; i++) {
      if (prefs.getBool(_lessonKey(topicId, i)) ?? false) count++;
    }
    return count;
  }

  /// Devuelve un Set de índices de lecciones completadas para un tema.
  static Future<Set<int>> completedLessons(String topicId, int totalLessons) async {
    final prefs = await SharedPreferences.getInstance();
    final done = <int>{};
    for (int i = 0; i < totalLessons; i++) {
      if (prefs.getBool(_lessonKey(topicId, i)) ?? false) done.add(i);
    }
    return done;
  }

  // ── Quiz ────────────────────────────────────────────────────

  static String _quizKey(String topicId) => '$_quizPrefix$topicId';

  /// Guarda la mejor puntuación de un quiz (0–100).
  static Future<void> saveQuizScore(String topicId, int score) async {
    final prefs = await SharedPreferences.getInstance();
    final prev = prefs.getInt(_quizKey(topicId)) ?? 0;
    if (score > prev) await prefs.setInt(_quizKey(topicId), score);
  }

  static Future<int?> bestQuizScore(String topicId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_quizKey(topicId));
  }

  // ── Reset ────────────────────────────────────────────────────

  static Future<void> resetAll() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys().where((k) => k.startsWith(_keyPrefix) || k.startsWith(_quizPrefix)).toList();
    for (final k in keys) {
      await prefs.remove(k);
    }
  }
}
