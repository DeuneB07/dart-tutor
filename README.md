# Dart Tutor

A Flutter app to learn and practice Dart — covering syntax, modern language features, and best practices.

## Features

- **19 topics** from beginner to advanced, with bilingual support (English / Spanish)
- **Lessons** with structured sections, code examples and notes
- **Quizzes** with multiple-choice questions, including "What does this code print?" exercises
- **Flashcards** with spaced-repetition-style review
- **Progress tracking** per topic (quiz scores persisted locally)
- **Light / dark theme** toggle
- **Localization** — UI strings in English and Spanish via ARB files

## Topics covered

| # | Topic | Level |
|---|-------|-------|
| 1 | Variables & Types | Beginner |
| 2 | Null Safety | Beginner |
| 3 | Functions | Beginner |
| 4 | Control Flow | Beginner |
| 5 | Collections | Beginner |
| 6 | Classes & OOP | Intermediate |
| 7 | Inheritance & Mixins | Intermediate |
| 8 | Generics | Intermediate |
| 9 | Async / Await | Intermediate |
| 10 | Streams | Advanced |
| 11 | Error Handling | Intermediate |
| 12 | Enums | Intermediate |
| 13 | Extension Methods | Intermediate |
| 14 | Records & Pattern Matching | Advanced |
| 15 | Extension Types (Dart 3.3) | Advanced |
| 16 | Dot Shorthands (Dart 3.10) | Intermediate |
| 17 | Modern Constructors (Dart 3.12–3.13) | Intermediate |
| 18 | Wildcard Variables (Dart 3.7) | Intermediate |
| 19 | Isolates | Advanced |

## Tech stack

- Flutter (Material 3)
- `flutter_localizations` + ARB files for i18n
- `shared_preferences` for local progress persistence

## Getting started

```bash
flutter pub get
flutter run
```

Requires Flutter 3.x and Dart 3.7 or later.
