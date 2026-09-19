// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Dart Tutor';

  @override
  String get homeSubtitle => 'Aprende Dart desde cero hasta nivel avanzado';

  @override
  String get topicsTitle => 'Temas';

  @override
  String get lessonsLabel => 'lecciones';

  @override
  String get lessonLabel => 'lección';

  @override
  String get difficultyBeginner => 'Principiante';

  @override
  String get difficultyIntermediate => 'Intermedio';

  @override
  String get difficultyAdvanced => 'Avanzado';

  @override
  String topicProgress(int done, int total) {
    return '$done de $total lecciones';
  }

  @override
  String get noteLabel => 'Nota';

  @override
  String get backToTopics => 'Volver a temas';

  @override
  String get nextLesson => 'Siguiente lección';

  @override
  String get previousLesson => 'Lección anterior';

  @override
  String lessonOf(int current, int total) {
    return 'Lección $current de $total';
  }

  @override
  String get searchHint => 'Buscar temas...';

  @override
  String get noResults => 'No se encontraron temas';

  @override
  String get allLevels => 'Todos los niveles';

  @override
  String get filterBy => 'Filtrar';

  @override
  String get markDone => 'Marcar como completada';

  @override
  String get markUndone => 'Marcar como no completada';

  @override
  String get lessonDone => 'Lección completada';

  @override
  String progressLabel(int done, int total) {
    return '$done/$total lecciones completadas';
  }

  @override
  String get takeQuiz => 'Hacer quiz';

  @override
  String get quizTitle => 'Quiz';

  @override
  String quizResult(int score) {
    return '$score% correctas';
  }

  @override
  String quizBestScore(int score) {
    return 'Mejor: $score%';
  }

  @override
  String get quizCorrect => '¡Correcto!';

  @override
  String get quizIncorrect => 'Incorrecto';

  @override
  String get quizFinish => 'Finalizar quiz';

  @override
  String get quizRetry => 'Reintentar';

  @override
  String quizQuestionOf(int current, int total) {
    return 'Pregunta $current de $total';
  }

  @override
  String get quizExplanation => 'Explicación';

  @override
  String get flashcardsTitle => 'Flashcards';

  @override
  String get flashcardTap => 'Toca para voltear';

  @override
  String flashcardOf(int current, int total) {
    return '$current / $total';
  }

  @override
  String get flashcardKnow => 'Lo sé';

  @override
  String get flashcardReview => 'Repasar';

  @override
  String get flashcardDone => '¡Sesión completada!';

  @override
  String get flashcardRestart => 'Empezar de nuevo';

  @override
  String get noQuiz => 'No hay quiz disponible para este tema';

  @override
  String get noFlashcards => 'No hay flashcards disponibles para este tema';

  @override
  String get codeCopy => 'Copiar';

  @override
  String get codeCopied => 'Copiado';

  @override
  String get lightMode => 'Modo claro';

  @override
  String get darkMode => 'Modo oscuro';

  @override
  String get flashcardFrontLabel => 'Concepto';

  @override
  String get flashcardBackLabel => 'Explicación';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsThemeLight => 'Claro';

  @override
  String get settingsThemeDark => 'Oscuro';

  @override
  String get settingsThemeSystem => 'Sistema';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageSystem => 'Sistema';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsLanguageSpanish => 'Español';

  @override
  String get settingsPalette => 'Paleta de colores';

  @override
  String get settingsData => 'Datos';

  @override
  String get settingsResetProgress => 'Resetear progreso';

  @override
  String get settingsResetProgressSubtitle =>
      'Elimina todas las lecciones completadas y puntuaciones de quiz';

  @override
  String get settingsResetConfirmTitle => '¿Resetear progreso?';

  @override
  String get settingsResetConfirmBody =>
      'Esto eliminará permanentemente todas tus lecciones completadas y puntuaciones de quiz. Esta acción no se puede deshacer.';

  @override
  String get settingsResetConfirm => 'Resetear';

  @override
  String get settingsResetDone => 'Progreso reseteado';

  @override
  String get cancel => 'Cancelar';
}
