import '../models/topic.dart';

const List<Topic> kTopicsEn = [
  // ─────────────────────────────────────────────
  // 1. VARIABLES & TYPES
  // ─────────────────────────────────────────────
  Topic(
    id: 'variables',
    title: 'Variables & Types',
    subtitle: 'var, final, const, primitive types and type inference',
    icon: '📦',
    difficulty: DifficultyLevel.beginner,
    quiz: [
      QuizQuestion(
        question: 'What is the key difference between `final` and `const`?',
        options: [
          'There is no difference, they are synonyms',
          '`final` is assigned once at runtime; `const` is evaluated at compile time',
          '`const` can be reassigned; `final` cannot',
          '`final` only works with primitive types',
        ],
        correctIndex: 1,
        explanation: '`final` allows values calculated at runtime (like DateTime.now()), while `const` requires the value to be known before the program runs.',
      ),
      QuizQuestion(
        question: 'What type does Dart infer for `var x = 3.14`?',
        options: ['int', 'num', 'double', 'dynamic'],
        correctIndex: 2,
        explanation: 'Dart infers `double` because 3.14 is a floating-point literal.',
      ),
      QuizQuestion(
        question: 'What happens if you try to reassign a `var` variable with a different type?',
        options: ['It converts automatically', 'Runtime error', 'Compile-time error', 'Nothing, `var` is dynamic'],
        correctIndex: 2,
        explanation: 'Once Dart infers the type of a `var` variable, that type is fixed. Assigning a value of a different type is a compile-time error.',
      ),
      QuizQuestion(
        question: 'Which of these declarations is invalid?',
        options: ['const pi = 3.14159;', 'final name = "Ana";', 'const now = DateTime.now();', 'var points = 100;'],
        correctIndex: 2,
        explanation: '`DateTime.now()` is computed at runtime, so it cannot be used with `const`. Use `final` instead.',
      ),
      QuizQuestion(
        question: 'What does this code print?',
        code: '''
var x = 10;
final y = x * 2;
x = 5;
print(y);''',
        options: ['5', '10', '20', 'Compile error'],
        correctIndex: 2,
        explanation: '`y` is initialized with `x * 2` when x is 10, so y = 20. Changing `x` afterwards does not affect `y` because it was already fixed as `final`.',
      ),
    ],
    flashcards: [
      Flashcard(
        front: 'What is type inference?',
        back: 'When you use `var`, Dart deduces the type from the assigned value. Once inferred, the type does not change.',
        code: 'var city = "Madrid"; // Dart infers String',
      ),
      Flashcard(
        front: '`final` vs `const`',
        back: '`final`: immutable value assigned once, can be computed at runtime.\n`const`: compile-time constant, value known before the program runs.',
        code: 'final now = DateTime.now(); // OK\nconst pi = 3.14159;           // OK',
      ),
      Flashcard(
        front: 'When to use `dynamic`?',
        back: 'Only when the type is genuinely unknown at compile time (e.g. deserializing arbitrary JSON). Avoid it whenever possible: you lose type safety.',
      ),
      Flashcard(
        front: 'Safe String → number conversion',
        back: '`int.tryParse()` returns `null` on failure instead of throwing an exception. Use `int.parse()` only when you know the value is valid.',
        code: 'int? n = int.tryParse("abc"); // null, no error',
      ),
    ],
    lessons: [
      Lesson(
        title: 'Declaring variables',
        sections: [
          LessonSection(
            text: 'In Dart you can declare variables in three main ways: with an explicit type, with `var` (type inference), or with `dynamic` (dynamic type).',
          ),
          LessonSection(
            heading: 'Explicit type',
            text: 'You declare the variable by specifying its type directly. Dart will know the type at compile time.',
            code: '''
String name = 'Ana';
int age = 25;
double price = 9.99;
bool isActive = true;

print(name);  // Ana
print(age);   // 25
''',
          ),
          LessonSection(
            heading: 'var — type inference',
            text: 'With `var`, Dart deduces the type from the assigned value. Once the type is set, it cannot change.',
            code: '''
var city   = 'Madrid';  // Dart infers: String
var points = 100;       // Dart infers: int
var ratio  = 3.14;      // Dart infers: double

// city = 42; ← ERROR: a String cannot receive an int
''',
          ),
          LessonSection(
            heading: 'dynamic — no type restriction',
            text: '`dynamic` disables type checking. Use it only when strictly necessary, because you lose compile-time type safety.',
            code: '''
dynamic value = 'Hello';
print(value.runtimeType); // String

value = 99;
print(value.runtimeType); // int

value = [1, 2, 3];
print(value.runtimeType); // List<int>
''',
            note: 'Avoid `dynamic` except in very specific cases (e.g. JSON deserialization). Always prefer explicit types or `var`.',
          ),
        ],
      ),
      Lesson(
        title: 'final and const',
        sections: [
          LessonSection(
            text: 'Dart has two modifiers for values that should not change: `final` and `const`. Both create immutable variables, but with one key difference.',
          ),
          LessonSection(
            heading: 'final — single assignment at runtime',
            text: 'A `final` variable is assigned only once. Its value can be computed at runtime.',
            code: '''
final today = DateTime.now(); // computed when run
final pi = 3.14159;

// pi = 3.0; ← ERROR: cannot reassign a final
''',
          ),
          LessonSection(
            heading: 'const — compile-time constant',
            text: '`const` requires the value to be known before the program runs. Use it for values that never change under any circumstance.',
            code: '''
const gravity = 9.8;
const appName = 'Dart Tutor';
const maxAttempts = 3;

// const now = DateTime.now(); ← ERROR: DateTime.now() is not constant
''',
          ),
          LessonSection(
            heading: 'Practical difference',
            code: '''
// ✅ final: value computed at runtime
final String greeting = 'Hello ' + 'World'; // OK
final DateTime start = DateTime.now();       // OK

// ✅ const: value known at compile time
const int version = 3;
const String prefix = 'DT';

// const list → completely immutable
const colors = ['red', 'green', 'blue'];
// colors.add('yellow'); ← ERROR at runtime
''',
            note: 'Use `const` whenever you can. It makes code more efficient because Dart can share the same instance in memory.',
          ),
        ],
      ),
      Lesson(
        title: 'Numeric types and Strings',
        sections: [
          LessonSection(
            heading: 'int and double',
            code: '''
int integer = 42;
int hex    = 0xFF;       // Hexadecimal: 255
int binary = 0b1010;     // Binary: 10

double decimal    = 1.5;
double scientific = 1.5e3; // 1500.0

// Conversions
double d = integer.toDouble(); // 42.0
int i    = decimal.toInt();    // 1 (truncates)
int r    = decimal.round();    // 2 (rounds)

// num can be int or double
num any = 10;
any = 10.5; // OK
''',
          ),
          LessonSection(
            heading: 'String',
            code: r'''
// Single or double quotes, both valid
String s1 = 'Hello Dart';
String s2 = "Hello Dart";

// Variable interpolation
String name = 'Carlos';
print('Hello, $name!');          // Hello, Carlos!
print('Length: ${name.length}'); // Length: 6

// Multi-line strings with triple quotes
String paragraph = """
This is a text
on multiple lines.
""";

// Useful methods
'  hello  '.trim();           // 'hello'
'dart'.toUpperCase();         // 'DART'
'DART'.toLowerCase();         // 'dart'
'hello world'.split(' ');     // ['hello', 'world']
'dart'.contains('ar');        // true
'dart'.replaceAll('a', '@');  // 'd@rt'
''',
          ),
          LessonSection(
            heading: 'Type conversions',
            code: '''
// String → number
int n    = int.parse('42');
double d = double.parse('3.14');

// Number → String
String s         = 42.toString();
String twoDecimals = 3.14159.toStringAsFixed(2); // '3.14'

// Safe conversion (avoids exception)
int? safe = int.tryParse('abc'); // null, no error
''',
          ),
        ],
      ),
    ],
  ),

  // ─────────────────────────────────────────────
  // 2. NULL SAFETY
  // ─────────────────────────────────────────────
  Topic(
    id: 'null_safety',
    title: 'Null Safety',
    subtitle: 'Nullable types, ?., ??, and ! operators',
    icon: '🛡️',
    difficulty: DifficultyLevel.beginner,
    quiz: [
      QuizQuestion(
        question: 'What does `null?.toUpperCase()` return?',
        options: ['Throws NullPointerException', '"NULL"', 'null', 'Compile error'],
        correctIndex: 2,
        explanation: 'The `?.` operator returns `null` if the object is null, instead of throwing an exception.',
      ),
      QuizQuestion(
        question: 'What is the value of `result` after `String? x; var result = x ?? "empty";`?',
        options: ['null', '"empty"', 'Error', '"x"'],
        correctIndex: 1,
        explanation: 'The `??` operator returns the right-hand operand when the left-hand one is null.',
      ),
      QuizQuestion(
        question: 'When should you use the `!` operator (force unwrap)?',
        options: [
          'Whenever a variable is nullable',
          'Only when you are 100% sure the value is not null',
          'It is equivalent to `??`',
          'To convert null to false',
        ],
        correctIndex: 1,
        explanation: '`!` tells Dart the value is not null. If it is null at runtime, a NullPointerException is thrown. Use it only with absolute certainty.',
      ),
      QuizQuestion(
        question: 'What is `late` used for?',
        options: [
          'To declare variables that will never be null',
          'To initialize a variable after its declaration, promising it will be assigned before use',
          'It is a synonym for `final`',
          'To declare asynchronous variables',
        ],
        correctIndex: 1,
        explanation: '`late` indicates the variable will be initialized before its first use, even though it is not initialized at declaration. Accessing it before initialization throws LateInitializationError.',
      ),
      QuizQuestion(
        question: 'What does this code print?',
        code: '''
String? name;
String result = name ?? 'Anonymous';
name = 'Ana';
print(result);''',
        options: ['Ana', 'null', 'Anonymous', 'Compile error'],
        correctIndex: 2,
        explanation: '`??` evaluates at the moment of assignment: when line 2 runs, `name` is null, so `result` receives "Anonymous". Changing `name` afterwards has no effect on `result`.',
      ),
    ],
    flashcards: [
      Flashcard(
        front: 'What does it mean for a type to be non-nullable?',
        back: 'Since Dart 2.12, variables cannot be null by default. To allow null you must add `?` to the type.',
        code: 'String name = "Ana";  // never null\nString? nickname;      // can be null',
      ),
      Flashcard(
        front: '`?.` operator (null-aware access)',
        back: 'Accesses a property or method only if the object is not null. If null, returns null without throwing an error.',
        code: 'String? s = null;\nprint(s?.length); // null, no error',
      ),
      Flashcard(
        front: '`??` operator (null coalescing)',
        back: 'Returns the left value if not null; if null, returns the right value (default value).',
        code: 'String? name;\nprint(name ?? "Anonymous"); // Anonymous',
      ),
      Flashcard(
        front: 'Type promotion with null check',
        back:
            'Inside an `if (x != null)`, Dart "promotes" the type of `x` from nullable to non-nullable automatically.',
        code: 'String? email;\nif (email != null) {\n  print(email.length); // OK, already String\n}',
      ),
    ],
    lessons: [
      Lesson(
        title: 'What is Null Safety?',
        sections: [
          LessonSection(
            text: 'Since Dart 2.12, the language guarantees that no variable can be `null` unless you explicitly allow it. This eliminates the dreaded "Null Pointer Exception" errors.',
          ),
          LessonSection(
            heading: 'Non-nullable by default',
            code: '''
// Without null safety (before Dart 2.12):
// String name = null; // Could cause runtime crashes

// With null safety:
String name = 'Ana';
// name = null; ← ERROR at compile time ✅

// To allow null, add ?
String? optionalName = null; // OK
optionalName = 'Luis';       // OK
''',
          ),
          LessonSection(
            heading: 'The ?. operator (null-aware access)',
            text: 'Accesses properties or methods only if the object is not null. If null, returns null instead of throwing an error.',
            code: '''
String? text = null;

// Without ?.  ← dangerous
// print(text.length); ← would throw exception

// With ?.  ← safe
print(text?.length); // null (no error)

String? name = 'Dart';
print(name?.toUpperCase()); // DART
''',
          ),
          LessonSection(
            heading: 'The ?? operator (null coalescing)',
            text: 'Returns the left value if not null; if null, returns the right value (default value).',
            code: '''
String? nickname = null;
String name = nickname ?? 'Anonymous';
print(name); // Anonymous

int? points = null;
int total = points ?? 0;
print(total); // 0

// Also as assignment: ??=
points ??= 100; // Assigns 100 only if points is null
print(points);  // 100
''',
          ),
          LessonSection(
            heading: 'The ! operator (force unwrap)',
            text: 'Forces Dart to treat a nullable variable as non-nullable. Use it only when you are 100% sure the value is not null.',
            code: '''
String? value = 'Dart';

// You tell Dart: "trust me, it's not null"
String definite = value!;
print(definite.length); // 4

// ⚠️ DANGER: if value IS null, throws exception at runtime
String? nullable = null;
// String crash = nullable!; ← NullPointerException at runtime
''',
            note: 'Always prefer `?.` or `??` before `!`. The `!` operator is your promise to the compiler; if you break it, the program crashes.',
          ),
        ],
      ),
      Lesson(
        title: 'Null checks and late',
        sections: [
          LessonSection(
            heading: 'Checking with if',
            code: '''
String? email;

if (email != null) {
  // Inside the if, Dart knows email is not null
  // This is called "promotion" or "narrowing"
  print(email.length); // OK, no ?
}

// Promotion also works with other patterns
String? city;
if (city == null) return;
// From here, city is non-nullable
print(city.toUpperCase()); // OK
''',
          ),
          LessonSection(
            heading: 'late — deferred initialization',
            text: '`late` tells Dart you will initialize the variable before using it, even if not at declaration. Useful for dependency injection or variables assigned in a constructor.',
            code: '''
late String connection;

void connect() {
  connection = 'postgresql://localhost:5432/db';
}

void show() {
  connect();
  print(connection); // OK, already assigned
}

// late + final: assigned exactly once
late final String config;

void init() {
  config = 'production';
}
// config = 'other'; ← ERROR: already assigned
''',
            note: 'If you access a `late` variable before it is initialized, you get a LateInitializationError at runtime. Use it carefully.',
          ),
        ],
      ),
    ],
  ),

  // ─────────────────────────────────────────────
  // 3. FUNCTIONS
  // ─────────────────────────────────────────────
  Topic(
    id: 'functions',
    title: 'Functions',
    subtitle: 'Parameters, arrow functions, closures and higher-order functions',
    icon: '⚡',
    difficulty: DifficultyLevel.beginner,
    quiz: [
      QuizQuestion(
        question: 'What is the equivalent of `int double_(int x) => x * 2;` in long form?',
        options: [
          'int double_(int x) { x * 2; }',
          'int double_(int x) { return x * 2; }',
          'double_(int x) { return x * 2; }',
          'int double_(x) => x * 2;',
        ],
        correctIndex: 1,
        explanation: 'The arrow function `=>` is syntactic sugar for `{ return expression; }`. The return type and parameter type must be present.',
      ),
      QuizQuestion(
        question: 'What type of parameters go inside curly braces `{}`?',
        options: [
          'Required positional parameters',
          'Optional positional parameters',
          'Named parameters',
          'Generic parameters',
        ],
        correctIndex: 2,
        explanation: 'Parameters inside `{}` are named parameters: they are passed by name when calling the function, e.g. `f(name: "Ana")`.',
      ),
      QuizQuestion(
        question: 'What is a closure in Dart?',
        options: [
          'A function with no parameters',
          'A function that captures variables from the scope where it was created',
          'A private method of a class',
          'A function that returns void',
        ],
        correctIndex: 1,
        explanation: 'A closure "remembers" the variables from the outer scope where it was defined, even when executed outside that scope.',
      ),
      QuizQuestion(
        question: 'What does `required` do on a named parameter?',
        options: [
          'Gives it a default value',
          'Converts it to positional',
          'Forces the caller to pass that parameter',
          'Only works with nullable types',
        ],
        correctIndex: 2,
        explanation: 'Without `required`, a named parameter is optional (can be omitted). With `required`, the compiler forces the caller to provide it.',
      ),
      QuizQuestion(
        question: 'What does this code print?',
        code: '''
int mul(int a, [int b = 2]) => a * b;

print(mul(5));
print(mul(5, 3));''',
        options: ['5\n15', '10\n15', '2\n3', 'Compile error'],
        correctIndex: 1,
        explanation: 'The optional parameter `b` has default value 2. First call: 5 × 2 = 10. Second: 5 × 3 = 15.',
      ),
    ],
    flashcards: [
      Flashcard(
        front: 'Arrow function `=>`',
        back: 'Short notation for functions with a single return expression. Equivalent to `{ return expr; }`.',
        code: 'int square(int x) => x * x;',
      ),
      Flashcard(
        front: 'Optional positional parameters `[ ]`',
        back: 'Parameters in brackets are optional and passed by position. Their type must be nullable or have a default value.',
        code: 'String greet(String name, [String? title]) {\n  return title != null ? "\$title \$name" : name;\n}',
      ),
      Flashcard(
        front: 'Named parameters `{ }`',
        back: 'Passed by name when calling. Optional by default; use `required` to make them mandatory.',
        code: 'void config({required String host, int port = 8080}) {}',
      ),
      Flashcard(
        front: 'First-class functions',
        back: 'In Dart, functions are objects. You can assign them to variables, pass them as arguments, and return them from other functions.',
        code: 'var operation = (int a, int b) => a + b;\nprint(operation(3, 4)); // 7',
      ),
    ],
    lessons: [
      Lesson(
        title: 'Declaring functions',
        sections: [
          LessonSection(
            heading: 'Basic function',
            code: '''
// Return type  name  parameters
int add(int a, int b) {
  return a + b;
}

print(add(3, 4)); // 7

// void: returns nothing
void greet(String name) {
  print('Hello, \$name!');
}

// The compiler can infer the return type, but being explicit is better
''',
          ),
          LessonSection(
            heading: 'Arrow function (=>)',
            text: 'When a function has a single expression as its body, you can use the arrow notation `=>`. It is equivalent to `{ return expression; }`.',
            code: '''
int multiply(int a, int b) => a * b;

String toUpperCase(String s) => s.toUpperCase();

bool isEven(int n) => n % 2 == 0;

print(multiply(3, 4));    // 12
print(toUpperCase('dart')); // DART
print(isEven(6));           // true
''',
          ),
        ],
      ),
      Lesson(
        title: 'Parameter types',
        sections: [
          LessonSection(
            heading: 'Optional positional parameters [ ]',
            code: '''
// Parameters in [] are optional
String introduce(String name, [String? title]) {
  if (title != null) {
    return '\$title \$name';
  }
  return name;
}

print(introduce('Ana'));          // Ana
print(introduce('Ana', 'Dr.')); // Dr. Ana
''',
          ),
          LessonSection(
            heading: 'Named parameters { }',
            text: 'Parameters in `{}` are passed by name and are optional by default. They can have default values.',
            code: '''
void configure({
  String host = 'localhost',
  int port = 8080,
  bool ssl = false,
}) {
  print('\${ssl ? "https" : "http"}://\$host:\$port');
}

configure();                          // http://localhost:8080
configure(port: 443, ssl: true);      // https://localhost:443
configure(host: 'example.com');       // http://example.com:8080

// With required: the caller MUST pass that parameter
void createUser({
  required String name,
  required String email,
  int age = 0,
}) {
  print('\$name (\$email), \$age years old');
}

createUser(name: 'Luis', email: 'luis@example.com'); // OK
// createUser(email: 'x@y.com'); ← ERROR: name missing
''',
          ),
        ],
      ),
      Lesson(
        title: 'First-class functions and closures',
        sections: [
          LessonSection(
            text: 'In Dart, functions are first-class objects: you can assign them to variables, pass them as parameters, and return them from other functions.',
          ),
          LessonSection(
            heading: 'Functions as variables',
            code: '''
// A function can live in a variable
int Function(int, int) operation = add;

int add(int a, int b) => a + b;
int subtract(int a, int b) => a - b;

operation = add;
print(operation(5, 3)); // 8

operation = subtract;
print(operation(5, 3)); // 2
''',
          ),
          LessonSection(
            heading: 'Anonymous functions and lambdas',
            code: '''
// Anonymous function assigned to variable
var square = (int x) => x * x;
print(square(5)); // 25

// Passed directly as argument
var numbers = [1, 2, 3, 4, 5];
var squares = numbers.map((n) => n * n).toList();
print(squares); // [1, 4, 9, 16, 25]

var evens = numbers.where((n) => n % 2 == 0).toList();
print(evens); // [2, 4]
''',
          ),
          LessonSection(
            heading: 'Closures — capture their environment',
            text: 'A closure is a function that "remembers" the variables from the scope where it was created, even when executed outside that scope.',
            code: '''
Function createCounter() {
  int count = 0; // Outer scope variable

  return () {
    count++; // Inner function "remembers" count
    return count;
  };
}

var counter = createCounter();
print(counter()); // 1
print(counter()); // 2
print(counter()); // 3

var otherCounter = createCounter(); // Independent instance
print(otherCounter()); // 1
''',
          ),
          LessonSection(
            heading: 'Higher-order functions',
            text: 'They receive or return other functions. `map`, `where`, and `reduce` are classic examples.',
            code: '''
// Receives a function as parameter
int applyTwice(int Function(int) f, int x) {
  return f(f(x));
}

int double_(int n) => n * 2;

print(applyTwice(double_, 3)); // double_(double_(3)) = 12

// reduce: combines all elements
var nums = [1, 2, 3, 4, 5];
var sum = nums.reduce((acc, val) => acc + val);
print(sum); // 15
''',
          ),
        ],
      ),
    ],
  ),

  // ─────────────────────────────────────────────
  // 4. CONTROL FLOW
  // ─────────────────────────────────────────────
  Topic(
    id: 'control_flow',
    title: 'Control Flow',
    subtitle: 'if/else, switch, for, while, break and continue',
    icon: '🔀',
    difficulty: DifficultyLevel.beginner,
    quiz: [
      QuizQuestion(
        question: 'What does this code print?',
        code: '''
for (int i = 0; i < 5; i++) {
  if (i == 3) break;
  if (i % 2 == 0) continue;
  print(i);
}''',
        options: ['0 2', '1 3', '1', '0 1 2'],
        correctIndex: 2,
        explanation: 'i=0: even → continue; i=1: odd → prints 1; i=2: even → continue; i=3: break. Only prints 1.',
      ),
      QuizQuestion(
        question: 'What is the difference between `while` and `do-while`?',
        options: [
          'There is no difference',
          '`do-while` executes the body at least once; `while` may never execute it',
          '`while` executes the body at least once',
          '`do-while` only works with counters',
        ],
        correctIndex: 1,
        explanation:
            'In `do-while`, the condition is checked AFTER executing the body, so it always runs at least once.',
      ),
      QuizQuestion(
        question: 'What is special about the Dart 3 switch expression?',
        options: [
          'It needs `break` at the end of each case',
          'It only works with enums',
          'It returns a value and does not need `break`',
          'It is identical to the classic switch',
        ],
        correctIndex: 2,
        explanation: 'The Dart 3 switch expression is an expression that returns a value directly. It does not need `break` and uses `=>` for each case.',
      ),
      QuizQuestion(
        question: 'What does this code print?',
        code: '''
int x = 4;
String r = switch (x) {
  1     => 'one',
  2 || 3 => 'two or three',
  _ when x > 3 => 'greater than three',
  _     => 'other',
};
print(r);''',
        options: ['one', 'two or three', 'greater than three', 'other'],
        correctIndex: 2,
        explanation: 'x=4 does not match 1 or 2/3. The guard `_ when x > 3` is satisfied (4 > 3), so the result is "greater than three".',
      ),
    ],
    flashcards: [
      Flashcard(
        front: 'Ternary operator',
        back: 'Compact form of if/else that returns a value: `condition ? ifTrue : ifFalse`.',
        code: 'String status = active ? "online" : "offline";',
      ),
      Flashcard(
        front: 'switch expression (Dart 3)',
        back: 'A switch that returns a value. Uses `=>` for each case and `_` as default. No `break` needed.',
        code: 'String msg = switch (score) {\n  >= 9 => "Excellent",\n  >= 5 => "Pass",\n  _    => "Fail",\n};',
      ),
      Flashcard(
        front: '`break` vs `continue`',
        back: '`break` terminates the loop completely. `continue` skips to the next iteration without ending the loop.',
      ),
      Flashcard(
        front: 'for-in',
        back: 'Iterates over any Iterable (List, Set, Map.keys…) without managing indices manually.',
        code: 'for (var fruit in fruits) { print(fruit); }',
      ),
    ],
    lessons: [
      Lesson(
        title: 'if / else and ternary operator',
        sections: [
          LessonSection(
            code: '''
int temperature = 22;

if (temperature > 30) {
  print('It''s hot');
} else if (temperature > 20) {
  print('Pleasant temperature');
} else {
  print('It''s cold');
}
// Pleasant temperature

// Ternary operator: condition ? ifTrue : ifFalse
String result = temperature > 25 ? 'hot' : 'cool';
print(result); // cool
''',
          ),
        ],
      ),
      Lesson(
        title: 'switch and pattern matching (Dart 3)',
        sections: [
          LessonSection(
            heading: 'Classic switch',
            code: '''
String day = 'monday';

switch (day) {
  case 'monday':
  case 'tuesday':
  case 'wednesday':
  case 'thursday':
  case 'friday':
    print('Weekday');
    break;
  case 'saturday':
  case 'sunday':
    print('Weekend');
    break;
  default:
    print('Unknown day');
}
''',
          ),
          LessonSection(
            heading: 'switch expression (Dart 3)',
            text: 'From Dart 3, `switch` can be used as an expression that returns a value.',
            code: '''
int score = 8;

String grade = switch (score) {
  >= 9 => 'Excellent',
  >= 7 => 'Good',
  >= 5 => 'Pass',
  _    => 'Fail',  // _ is the default case
};

print(grade); // Good

// With types (sealed classes / pattern matching)
Object shape = Circle(radius: 5);

double area = switch (shape) {
  Circle(radius: var r)              => 3.14159 * r * r,
  Rectangle(width: var w, height: var h) => w * h,
  _ => 0.0,
};
''',
            note: 'The switch expression is one of Dart 3\'s biggest contributions. It is more concise and does not need `break`.',
          ),
        ],
      ),
      Lesson(
        title: 'Loops',
        sections: [
          LessonSection(
            heading: 'Classic for',
            code: '''
for (int i = 0; i < 5; i++) {
  print(i); // 0 1 2 3 4
}

// for-in: iterates over iterables
var fruits = ['apple', 'pear', 'grape'];
for (var fruit in fruits) {
  print(fruit);
}
''',
          ),
          LessonSection(
            heading: 'forEach, map and where',
            code: '''
var numbers = [1, 2, 3, 4, 5];

numbers.forEach((n) => print(n));

// map transforms each element
var doubled = numbers.map((n) => n * 2).toList();
print(doubled); // [2, 4, 6, 8, 10]

// where filters elements
var greaterThan3 = numbers.where((n) => n > 3).toList();
print(greaterThan3); // [4, 5]
''',
          ),
          LessonSection(
            heading: 'while and do-while',
            code: '''
int i = 0;
while (i < 3) {
  print(i); // 0, 1, 2
  i++;
}

// do-while: executes at least once
int j = 10;
do {
  print('j = \$j');
  j--;
} while (j > 10);
// Prints "j = 10" even though the condition was false at start
''',
          ),
          LessonSection(
            heading: 'break and continue',
            code: '''
// break: exits the loop
for (int i = 0; i < 10; i++) {
  if (i == 5) break;
  print(i); // 0 1 2 3 4
}

// continue: skips to the next iteration
for (int i = 0; i < 6; i++) {
  if (i % 2 == 0) continue;
  print(i); // 1 3 5
}

// Labels: break/continue in nested loops
outer:
for (int i = 0; i < 3; i++) {
  for (int j = 0; j < 3; j++) {
    if (j == 1) continue outer;
    print('\$i,\$j');
  }
}
// 0,0  1,0  2,0
''',
          ),
        ],
      ),
    ],
  ),

  // ─────────────────────────────────────────────
  // 5. COLLECTIONS
  // ─────────────────────────────────────────────
  Topic(
    id: 'collections',
    title: 'Collections',
    subtitle: 'List, Set, Map and their most useful methods',
    icon: '📚',
    difficulty: DifficultyLevel.beginner,
    quiz: [
      QuizQuestion(
        question: 'What is the main difference between List and Set?',
        options: [
          'List is faster than Set',
          'Set does not allow duplicate elements and does not guarantee order; List allows duplicates and maintains order',
          'Set can only contain Strings',
          'There is no practical difference',
        ],
        correctIndex: 1,
        explanation: 'List maintains insertion order and allows duplicates. Set automatically removes duplicates and does not guarantee a specific order.',
      ),
      QuizQuestion(
        question: 'What does `[1,2,3].map((x) => x * 2)` return?',
        options: [
          'List<int> [2, 4, 6]',
          'An Iterable<int> (you need .toList() to get a list)',
          'void',
          'Set<int> {2, 4, 6}',
        ],
        correctIndex: 1,
        explanation: '`map()` returns a lazy `Iterable`, not a List. To get a List you must chain `.toList()`.',
      ),
      QuizQuestion(
        question: 'What does the spread operator `...` do in collections?',
        options: [
          'Creates a copy of the collection',
          'Inserts all elements of another collection into the new one',
          'Sorts the collection',
          'Removes duplicates',
        ],
        correctIndex: 1,
        explanation: 'The spread operator `...list` expands all elements of `list` inside the new collection.',
      ),
      QuizQuestion(
        question: 'How do you safely access a Map key that might not exist?',
        options: [
          'map.get("key")',
          'map["key"] — never throws an error',
          'map["key"] returns null if the key does not exist',
          'map.find("key")',
        ],
        correctIndex: 2,
        explanation: 'In Dart, accessing a non-existent key in a Map returns `null`. That is why Map value types are nullable: `V?`.',
      ),
      QuizQuestion(
        question: 'What does this code print?',
        code: '''
var nums = [1, 2, 3, 4, 5];
var result = nums
    .where((n) => n.isOdd)
    .map((n) => n * 10)
    .toList();
print(result);''',
        options: ['[1, 3, 5]', '[10, 30, 50]', '[10, 20, 30, 40, 50]', '[2, 4]'],
        correctIndex: 1,
        explanation: '`where` filters the odd numbers → [1, 3, 5]. Then `map` multiplies each by 10 → [10, 30, 50].',
      ),
    ],
    flashcards: [
      Flashcard(
        front: 'Remove duplicates from a List',
        back: 'Convert the list to a Set (which does not allow duplicates) and back to a List.',
        code: 'var unique = [1,2,2,3].toSet().toList(); // [1,2,3]',
      ),
      Flashcard(
        front: 'Set operations',
        back: 'Set has `union`, `intersection` and `difference` to operate on sets declaratively.',
        code: 'var a = {1,2,3}; var b = {2,3,4};\na.intersection(b); // {2,3}',
      ),
      Flashcard(
        front: 'Collection `if` and `for`',
        back: 'Dart allows conditionals and loops inside collection literals to build them declaratively.',
        code: 'var menu = [\n  "Home",\n  if (isAdmin) "Admin",\n  for (var i in extras) i,\n];',
      ),
      Flashcard(
        front: '`where` vs `map`',
        back:
            '`where` filters elements that match a condition. `map` transforms each element. Both return an Iterable.',
        code: 'nums.where((n) => n > 3)  // filters\nnums.map((n) => n * 2)   // transforms',
      ),
    ],
    lessons: [
      Lesson(
        title: 'List',

        sections: [
          LessonSection(
            text: 'A `List` is an ordered collection of elements. Indices start at 0.',
            code: '''
// Creation
List<int> numbers = [1, 2, 3, 4, 5];
var fruits = <String>['apple', 'pear', 'grape'];
var empty  = <double>[];

// Access and modification
print(numbers[0]);    // 1
print(numbers.last);  // 5
numbers[0] = 10;

// Add / remove
fruits.add('orange');
fruits.addAll(['kiwi', 'mango']);
fruits.remove('pear');         // by value
fruits.removeAt(0);            // by index
fruits.insert(1, 'plum');      // insert at position

// Info
print(fruits.length);             // count
print(fruits.isEmpty);            // bool
print(fruits.contains('kiwi'));   // bool
print(fruits.indexOf('grape'));   // index or -1

// Transformations
var upper  = fruits.map((f) => f.toUpperCase()).toList();
var withA  = fruits.where((f) => f.contains('a')).toList();
var total  = [1,2,3,4,5].reduce((a, b) => a + b); // 15

// Sort
numbers.sort(); // ascending
numbers.sort((a, b) => b.compareTo(a)); // descending

// Spread operator
var extra    = [6, 7, 8];
var combined = [...numbers, ...extra];
''',
          ),
          LessonSection(
            heading: 'Immutable List',
            code: '''
// Non-modifiable list
final fixed = List<int>.unmodifiable([1, 2, 3]);
// fixed.add(4); ← UnsupportedError at runtime

// Fixed-size list
var fixed2 = List<int>.filled(3, 0); // [0, 0, 0]
fixed2[1] = 5; // OK: you can change values
// fixed2.add(6); ← UnsupportedError
''',
          ),
        ],
      ),
      Lesson(
        title: 'Set',
        sections: [
          LessonSection(
            text: 'A `Set` is a collection of unique elements with no guaranteed order. Ideal for removing duplicates or checking membership.',
            code: '''
Set<String> colors = {'red', 'green', 'blue'};
var set2 = <int>{1, 2, 3, 3, 2}; // {1, 2, 3} — duplicates removed

// Add / remove
colors.add('yellow');
colors.remove('green');

// Contains
print(colors.contains('red')); // true

// Set operations
var a = {1, 2, 3, 4};
var b = {3, 4, 5, 6};

print(a.union(b));        // {1, 2, 3, 4, 5, 6}
print(a.intersection(b)); // {3, 4}
print(a.difference(b));   // {1, 2}

// Convert list with duplicates to Set
var list = [1, 2, 2, 3, 3, 3];
var noDuplicates = list.toSet().toList();
print(noDuplicates); // [1, 2, 3]
''',
          ),
        ],
      ),
      Lesson(
        title: 'Map',
        sections: [
          LessonSection(
            text: 'A `Map` is a collection of key-value pairs. Keys are unique; values can repeat.',
            code: '''
// Creation
Map<String, int> ages = {
  'Ana':  25,
  'Luis': 30,
  'Sara': 28,
};

var config = <String, dynamic>{
  'host':  'localhost',
  'port':  8080,
  'ssl':   false,
};

// Access
print(ages['Ana']);         // 25
print(ages['Unknown']);     // null (key does not exist)

// Safe access with default value
int age = ages['Bea'] ?? 0;

// Modify / add
ages['Ana']   = 26;   // update
ages['Pedro'] = 22;   // add new key

// Remove
ages.remove('Luis');

// Info
print(ages.length);                // number of pairs
print(ages.containsKey('Sara'));   // true
print(ages.containsValue(22));     // true
print(ages.keys.toList());         // ['Ana', 'Sara', 'Pedro']
print(ages.values.toList());       // [26, 28, 22]

// Iterate
ages.forEach((name, age) {
  print('\$name is \$age years old');
});

// map() on a Map
var upper = ages.map((k, v) => MapEntry(k.toUpperCase(), v));
''',
          ),
        ],
      ),
      Lesson(
        title: 'Collections and null safety',
        sections: [
          LessonSection(
            code: '''
// List of nullable elements
List<String?> names = ['Ana', null, 'Luis'];
for (var n in names) {
  print(n?.toUpperCase() ?? 'NO NAME');
}

// Remove nulls
var noNulls = names.whereType<String>().toList();
print(noNulls); // ['Ana', 'Luis']

// Conditional spread
List<int>? extras;
var base = [1, 2, 3, ...?extras]; // ...? ignores if null
print(base); // [1, 2, 3]

// Collection if / for
var showAdmin = true;
var menu = [
  'Home',
  'Profile',
  if (showAdmin) 'Admin',
];

var squares = [
  for (var i = 1; i <= 5; i++) i * i,
];
print(squares); // [1, 4, 9, 16, 25]
''',
          ),
        ],
      ),
    ],
  ),

  // ─────────────────────────────────────────────
  // 6. CLASSES & OOP
  // ─────────────────────────────────────────────
  Topic(
    id: 'oop',
    title: 'Classes & OOP',
    subtitle: 'Constructors, getters/setters, static members',
    icon: '🧱',
    difficulty: DifficultyLevel.intermediate,
    quiz: [
      QuizQuestion(
        question: 'What does `Person(this.name, this.age)` do in a constructor?',
        options: [
          'Creates automatic getters',
          'It is an initializing formal: assigns the parameter directly to the field with the same name',
          'Declares the fields as static',
          'It is equivalent to a factory constructor',
        ],
        correctIndex: 1,
        explanation: '`this.field` in constructor parameters is an "initializing formal": Dart automatically assigns the parameter value to the corresponding field.',
      ),
      QuizQuestion(
        question: 'When should you use a `factory` constructor?',
        options: [
          'When you need more than one constructor',
          'When the constructor must return an existing instance (cache, singleton) or a subtype',
          'Only for abstract classes',
          'For private constructors',
        ],
        correctIndex: 1,
        explanation: 'A `factory` constructor can return any instance of the type or its subtypes. Ideal for Singleton, object pools or factory method patterns.',
      ),
      QuizQuestion(
        question: 'What distinguishes a getter from a regular method?',
        options: [
          'Getters are always static',
          'A getter is accessed like a property (no parentheses); a method requires parentheses',
          'Getters cannot perform calculations',
          'There is no practical difference',
        ],
        correctIndex: 1,
        explanation: 'Getters are accessed as `object.property` without parentheses. They are useful for computed properties that have no state of their own.',
      ),
    ],
    flashcards: [
      Flashcard(
        front: 'Named constructor',
        back: 'Allows multiple constructors with different names, each with its own initialization logic.',
        code: 'Point.origin() : x = 0, y = 0;\nPoint.from(Point p) : x = p.x, y = p.y;',
      ),
      Flashcard(
        front: 'const constructor',
        back: 'If all fields are `final` and the constructor is `const`, Dart can reuse the same instance in memory for identical values.',
        code: 'const c1 = Color(255,0,0);\nconst c2 = Color(255,0,0);\nidentical(c1, c2); // true',
      ),
      Flashcard(
        front: 'Computed getter',
        back:
            'A getter is a property computed from other fields. Declared with `get` and accessed without parentheses.',
        code: 'double get area => _width * _height;',
      ),
      Flashcard(
        front: 'Static members',
        back: 'Belong to the class, not to instances. Accessed with `ClassName.member`, not `object.member`.',
        code: 'MathUtils.pi       // OK\nMathUtils().pi     // Error',
      ),
    ],
    lessons: [
      Lesson(
        title: 'Declaring classes',
        sections: [
          LessonSection(
            code: '''
class Person {
  String name;
  int age;

  Person(this.name, this.age);

  String introduce() => 'I am \$name and I am \$age years old.';

  @override
  String toString() => 'Person(\$name, \$age)';
}

var p = Person('Ana', 25);
print(p.introduce()); // I am Ana and I am 25 years old.
print(p);            // Person(Ana, 25)
''',
          ),
        ],
      ),
      Lesson(
        title: 'Constructor types',
        sections: [
          LessonSection(
            heading: 'Named constructor',
            code: '''
class Point {
  final double x;
  final double y;

  Point(this.x, this.y);

  Point.origin() : x = 0, y = 0;
  Point.from(Point other) : x = other.x, y = other.y;

  @override
  String toString() => 'Point(\$x, \$y)';
}

var p1 = Point(3, 4);
var p2 = Point.origin(); // Point(0.0, 0.0)
var p3 = Point.from(p1); // Point(3.0, 4.0)
''',
          ),
          LessonSection(
            heading: 'Factory constructor',
            text: 'A `factory` constructor can return existing instances (cache, singleton) or subtypes.',
            code: '''
class Logger {
  static final Logger _instance = Logger._internal();

  Logger._internal();

  factory Logger() => _instance;

  void log(String msg) => print('[LOG] \$msg');
}

var a = Logger();
var b = Logger();
print(identical(a, b)); // true — Singleton
a.log('Hello');
''',
          ),
          LessonSection(
            heading: 'const constructors',
            code: '''
class Color {
  final int r, g, b;

  const Color(this.r, this.g, this.b);

  static const red   = Color(255, 0, 0);
  static const green = Color(0, 255, 0);
  static const blue  = Color(0, 0, 255);
}

const c1 = Color(255, 0, 0);
const c2 = Color(255, 0, 0);
print(identical(c1, c2)); // true
''',
          ),
        ],
      ),
      Lesson(
        title: 'Getters, Setters and static members',
        sections: [
          LessonSection(
            heading: 'Getters and Setters',
            code: '''
class Rectangle {
  double _width;
  double _height;

  Rectangle(this._width, this._height);

  double get area      => _width * _height;
  double get perimeter => 2 * (_width + _height);

  set width(double value) {
    if (value <= 0) throw ArgumentError('Width must be positive');
    _width = value;
  }

  double get width => _width;
}

var rect = Rectangle(5, 3);
print(rect.area);      // 15.0
print(rect.perimeter); // 16.0
rect.width = 10;
print(rect.area);      // 30.0
''',
          ),
          LessonSection(
            heading: 'Static members',
            code: '''
class MathUtils {
  static const double pi = 3.14159265358979;

  static double circumference(double radius) => 2 * pi * radius;
  static double circleArea(double radius)    => pi * radius * radius;
}

print(MathUtils.pi);
print(MathUtils.circumference(5)); // 31.4159...
print(MathUtils.circleArea(5));    // 78.5398...
''',
          ),
        ],
      ),
    ],
  ),

  // ─────────────────────────────────────────────
  // 7. INHERITANCE & MIXINS
  // ─────────────────────────────────────────────
  Topic(
    id: 'inheritance',
    title: 'Inheritance & Mixins',
    subtitle: 'extends, super, override, abstract and with',
    icon: '🧬',
    difficulty: DifficultyLevel.intermediate,
    quiz: [
      QuizQuestion(
        question: 'How many classes can a class extend in Dart?',
        options: ['Unlimited', 'Two', 'Only one', 'Three at most'],
        correctIndex: 2,
        explanation: 'Dart does not support multiple inheritance. A class can only extend one base class with `extends`. To reuse code from multiple sources, use mixins.',
      ),
      QuizQuestion(
        question: 'What is the difference between `extends` and `implements`?',
        options: [
          'They are equivalent',
          '`extends` inherits implementation; `implements` only contracts the interface (you must re-implement everything)',
          '`implements` inherits implementation; `extends` only the interface',
          '`extends` is for abstract classes; `implements` for concrete ones',
        ],
        correctIndex: 1,
        explanation: 'With `extends` you inherit implemented methods. With `implements` you only adopt the interface: you must implement all members from scratch.',
      ),
      QuizQuestion(
        question: 'What advantage do mixins have over multiple inheritance?',
        options: [
          'They are faster at runtime',
          'They allow code reuse across multiple classes without the diamond problem',
          'They allow access to private fields',
          'Mixins completely replace inheritance',
        ],
        correctIndex: 1,
        explanation: 'Mixins allow sharing behavior between classes without requiring inheritance. Dart resolves conflicts with a deterministic linearization.',
      ),
    ],
    flashcards: [
      Flashcard(
        front: '`extends` vs `implements` vs `with`',
        back: '`extends`: inherits implementation (one class only).\n`implements`: adopts interface (no code inheritance, multiple).\n`with`: mixes in behavior from a mixin.',
      ),
      Flashcard(
        front: 'Abstract class',
        back: 'Cannot be instantiated directly. Defines abstract methods (no body) that subclasses must implement. Can have concrete methods too.',
        code: 'abstract class Shape {\n  double area();\n  void describe() => print(area());\n}',
      ),
      Flashcard(
        front: 'Mixin with `on` restriction',
        back: 'With `on BaseClass`, the mixin can only be applied to subclasses of that base. Guarantees certain methods exist.',
        code: 'mixin Domesticable on Animal {\n  void adopt(String owner) {}\n}',
      ),
      Flashcard(
        front: '`super` in constructors',
        back: 'Calls the parent constructor. With the modern `super.parameter` syntax the argument is passed to the parent directly.',
        code: 'class Dog extends Animal {\n  Dog(super.name, super.age, this.breed);\n}',
      ),
    ],
    lessons: [
      Lesson(
        title: 'Inheritance with extends',
        sections: [
          LessonSection(
            code: '''
class Animal {
  String name;
  int age;

  Animal(this.name, this.age);

  void breathe() => print('\$name breathes');
  void sleep()   => print('\$name sleeps');

  @override
  String toString() => '\$name (\$age years old)';
}

class Dog extends Animal {
  String breed;

  Dog(super.name, super.age, this.breed);

  @override
  void breathe() {
    super.breathe();
    print('... and pants');
  }

  void bark() => print('\$name: Woof!');
}

var rex = Dog('Rex', 3, 'Labrador');
rex.bark();    // Rex: Woof!
rex.breathe(); // Rex breathes \n ... and pants
rex.sleep();   // Rex sleeps (inherited)

print(rex is Dog);    // true
print(rex is Animal); // true
''',
          ),
        ],
      ),
      Lesson(
        title: 'Abstract classes and interfaces',
        sections: [
          LessonSection(
            heading: 'Abstract class',
            text: 'Cannot be instantiated directly. Defines a template with methods that subclasses must implement.',
            code: '''
abstract class Shape {
  double area();
  double perimeter();

  void describe() => print('Area: \${area()}, Perimeter: \${perimeter()}');
}

class Circle extends Shape {
  final double radius;
  Circle(this.radius);

  @override
  double area() => 3.14159 * radius * radius;

  @override
  double perimeter() => 2 * 3.14159 * radius;
}

var c = Circle(5);
c.describe(); // Area: 78.53..., Perimeter: 31.41...
''',
          ),
          LessonSection(
            heading: 'Interfaces with implements',
            text:
                'In Dart any class can be used as an interface with `implements`. You must implement ALL its members.',
            code: '''
class Flyer  { void fly()  => print('Flying generically'); }
class Swimmer { void swim() => print('Swimming generically'); }

class Duck implements Flyer, Swimmer {
  @override void fly()  => print('Duck flies low');
  @override void swim() => print('Duck swims in the pond');
}

var duck = Duck();
duck.fly();  // Duck flies low
duck.swim(); // Duck swims in the pond
''',
          ),
        ],
      ),
      Lesson(
        title: 'Mixins',
        sections: [
          LessonSection(
            text: 'A `mixin` is a reusable block of code you can "mix into" a class without inheritance. It solves the diamond problem of multiple inheritance.',
            code: '''
mixin Serializable {
  Map<String, dynamic> toJson();

  String toJsonString() {
    return toJson().toString();
  }
}

mixin Validable {
  bool isValid();

  void validate() {
    if (!isValid()) throw Exception('Invalid object');
  }
}

class User with Serializable, Validable {
  final String email;
  final String name;

  User(this.email, this.name);

  @override
  Map<String, dynamic> toJson() => {'email': email, 'name': name};

  @override
  bool isValid() => email.contains('@') && name.isNotEmpty;
}

var u = User('ana@example.com', 'Ana');
u.validate();
print(u.toJsonString()); // {email: ana@example.com, name: Ana}
''',
          ),
          LessonSection(
            heading: 'on — restricting a mixin',
            code: '''
mixin Domesticable on Animal {
  String? owner;

  void adopt(String ownerName) {
    owner = ownerName;
    print('\${this.name} was adopted by \$owner');
  }
}

class Cat extends Animal with Domesticable {
  Cat(super.name, super.age);
}

var cat = Cat('Whiskers', 2);
cat.adopt('Maria'); // Whiskers was adopted by Maria
''',
          ),
        ],
      ),
    ],
  ),

  // ─────────────────────────────────────────────
  // 8. GENERICS
  // ─────────────────────────────────────────────
  Topic(
    id: 'generics',
    title: 'Generics',
    subtitle: 'Parameterized types for reusable and type-safe code',
    icon: '🔧',
    difficulty: DifficultyLevel.intermediate,
    quiz: [
      QuizQuestion(
        question: 'What does `<T extends Comparable<T>>` mean?',
        options: [
          'T must be a concrete class',
          'T must implement Comparable, guaranteeing it has a compareTo method',
          'T can only be int or String',
          'T cannot be null',
        ],
        correctIndex: 1,
        explanation: '`extends` in a type parameter is a constraint: T must implement `Comparable<T>`, guaranteeing you can call `compareTo` on values of type T.',
      ),
      QuizQuestion(
        question: 'What is the advantage of generics over using `dynamic`?',
        options: [
          'Generics are slower but safer',
          'With generics the compiler verifies types; `dynamic` disables that verification',
          'There is no real difference',
          'Generics only work with collections',
        ],
        correctIndex: 1,
        explanation: 'Generics allow writing reusable code while maintaining compile-time type safety. `dynamic` sacrifices that safety.',
      ),
    ],
    flashcards: [
      Flashcard(
        front: 'What is a generic type?',
        back: 'A parameterized type that works with any type T specified at use. Allows writing reusable code with type safety.',
        code: 'class Box<T> {\n  T content;\n  Box(this.content);\n}',
      ),
      Flashcard(
        front: 'Type parameter naming conventions',
        back: 'T: general generic type.\nE: element (in collections).\nK, V: key and value (in Map).\nR: return type.',
      ),
      Flashcard(
        front: 'Type constraint with `extends`',
        back: 'Limits which types can be used as type parameters, guaranteeing certain methods exist.',
        code: 'T max<T extends Comparable<T>>(T a, T b)\n  => a.compareTo(b) >= 0 ? a : b;',
      ),
    ],
    lessons: [
      Lesson(
        title: 'Generic classes and functions',
        sections: [
          LessonSection(
            text: 'Generics allow writing code that works with different types while maintaining type safety. `List<T>`, `Map<K,V>` are generics you already use.',
          ),
          LessonSection(
            heading: 'Generic class',
            code: '''
class Box<T> {
  T content;

  Box(this.content);

  T get() => content;
  void store(T newValue) => content = newValue;

  @override
  String toString() => 'Box<\${T}>(content: \$content)';
}

var intBox    = Box<int>(42);
var stringBox = Box<String>('Hello');
var doubleBox = Box(3.14); // Dart infers Box<double>

print(intBox.get());    // 42
print(stringBox.get()); // Hello

// intBox.store('text'); ← ERROR: expected int
''',
          ),
          LessonSection(
            heading: 'Generic function',
            code: '''
T first<T>(List<T> list) {
  if (list.isEmpty) throw StateError('Empty list');
  return list.first;
}

print(first([1, 2, 3]));       // 1
print(first(['a', 'b', 'c'])); // a

Map<K, V> combine<K, V>(List<K> keys, List<V> values) {
  assert(keys.length == values.length);
  return Map.fromIterables(keys, values);
}

var map = combine(['a', 'b'], [1, 2]);
print(map); // {a: 1, b: 2}
''',
          ),
          LessonSection(
            heading: 'Constraints with extends',
            code: '''
T maximum<T extends Comparable<T>>(T a, T b) {
  return a.compareTo(b) >= 0 ? a : b;
}

print(maximum(3, 7));        // 7
print(maximum('abc', 'xy')); // xy

abstract class Scoreable { int get score; }

class Player extends Scoreable {
  final String name;
  @override final int score;
  Player(this.name, this.score);
}

T winner<T extends Scoreable>(T a, T b) {
  return a.score >= b.score ? a : b;
}
''',
          ),
        ],
      ),
    ],
  ),

  // ─────────────────────────────────────────────
  // 9. ASYNC / AWAIT
  // ─────────────────────────────────────────────
  Topic(
    id: 'async',
    title: 'Async / Await',
    subtitle: 'Future, async, await and asynchronous operations',
    icon: '⏳',
    difficulty: DifficultyLevel.intermediate,
    quiz: [
      QuizQuestion(
        question: 'What type does a function marked `async` always return?',
        options: ['void', 'dynamic', 'Future<T>', 'Stream<T>'],
        correctIndex: 2,
        explanation: 'Every `async` function returns a `Future`. If the body returns `T`, the function returns `Future<T>`. If it returns `void`, it returns `Future<void>`.',
      ),
      QuizQuestion(
        question: 'What is `Future.wait()` used for?',
        options: [
          'To wait for a Future with a timeout',
          'To run several Futures in parallel and wait for all of them to complete',
          'To cancel a Future',
          'To convert a Future to a Stream',
        ],
        correctIndex: 1,
        explanation: '`Future.wait([f1, f2, f3])` launches all Futures in parallel and returns a Future that completes when all have finished. Much more efficient than awaiting them in series.',
      ),
      QuizQuestion(
        question: 'What is the correct way to catch errors in async/await code?',
        options: [
          '.onError()',
          'Errors cannot be caught in async',
          'try/catch around the await',
          'Only with .catchError()',
        ],
        correctIndex: 2,
        explanation: 'In async/await code, use `try/catch` just like in synchronous code. It is more readable than `.catchError()` and supports multiple error types with `on`.',
      ),
    ],
    flashcards: [
      Flashcard(
        front: 'What is a Future?',
        back: 'Represents a value that will be available in the future. It can be in three states: incomplete, complete with a value, or complete with an error.',
        code: 'Future<String> name = Future.value("Ana");',
      ),
      Flashcard(
        front: '`async` / `await`',
        back: 'Syntactic sugar over Futures. `await` "pauses" the function until the Future completes, making async code as readable as sync code.',
        code: 'Future<void> main() async {\n  String s = await getData();\n  print(s);\n}',
      ),
      Flashcard(
        front: 'Parallel vs sequential execution',
        back: 'Multiple sequential `await` calls = series (slow). `Future.wait([...])` = parallel (fast). Use parallel when Futures are independent.',
        code: '// Series: 2s\nvar a = await f1(); var b = await f2();\n// Parallel: 1s\nvar [a,b] = await Future.wait([f1(), f2()]);',
      ),
    ],
    lessons: [
      Lesson(
        title: 'What is a Future?',
        sections: [
          LessonSection(
            text: 'A `Future<T>` represents a value that will be available in the future — a "promise" that at some point you will have a result of type T (or an error).',
            code: '''
Future<String> getName() {
  return Future.value('Ana'); // Resolved immediately
}

Future<int> computeLater() {
  return Future.delayed(
    Duration(seconds: 2),
    () => 42,
  );
}

getName().then((name) {
  print('Name: \$name');
}).catchError((error) {
  print('Error: \$error');
});
''',
          ),
        ],
      ),
      Lesson(
        title: 'async / await',
        sections: [
          LessonSection(
            text: '`async/await` is syntactic sugar over Futures. It lets you write async code that looks synchronous — much more readable.',
            code: '''
Future<String> getUser(int id) async {
  await Future.delayed(Duration(milliseconds: 500));
  return 'User #\$id';
}

Future<void> main() async {
  print('Starting...');

  String user = await getUser(1);
  print(user); // User #1

  String u2 = await getUser(2);
  print(u2); // User #2

  print('Done');
}
''',
          ),
          LessonSection(
            heading: 'Parallel execution with Future.wait',
            code: '''
Future<String> getName() async {
  await Future.delayed(Duration(seconds: 1));
  return 'Ana';
}

Future<int> getAge() async {
  await Future.delayed(Duration(seconds: 1));
  return 25;
}

// Sequential: takes ~2 seconds
Future<void> sequential() async {
  var name = await getName();
  var age  = await getAge();
  print('\$name, \$age');
}

// Parallel: takes ~1 second
Future<void> parallel() async {
  var results = await Future.wait([getName(), getAge()]);
  print('\${results[0]}, \${results[1]}');
}
''',
            note: 'Use `Future.wait` when you have multiple independent operations. It is much more efficient than running them in series.',
          ),
          LessonSection(
            heading: 'Error handling in async',
            code: '''
Future<String> getData(String url) async {
  if (url.isEmpty) {
    throw ArgumentError('URL cannot be empty');
  }
  await Future.delayed(Duration(milliseconds: 100));
  return 'Data from \$url';
}

Future<void> main() async {
  try {
    var data = await getData('');
    print(data);
  } catch (e) {
    print('Caught error: \$e');
  }

  var result = await getData('https://api.com')
    .catchError((e) => 'Default value');
  print(result);
}
''',
          ),
        ],
      ),
    ],
  ),

  // ─────────────────────────────────────────────
  // 10. STREAMS
  // ─────────────────────────────────────────────
  Topic(
    id: 'streams',
    title: 'Streams',
    subtitle: 'Asynchronous data flows, StreamController and transformations',
    icon: '🌊',
    difficulty: DifficultyLevel.advanced,
    quiz: [
      QuizQuestion(
        question: 'How does a Stream differ from a Future?',
        options: [
          'A Stream is faster',
          'A Future emits a single value; a Stream can emit multiple values over time',
          'A Stream cannot emit errors',
          'There is no practical difference',
        ],
        correctIndex: 1,
        explanation: 'Future: 0 or 1 value in the future. Stream: a sequence of 0 to N values over time. Streams can also emit error events.',
      ),
      QuizQuestion(
        question: 'What does `yield` do in an async generator (`async*`)?',
        options: [
          'Ends the function',
          'Emits a value to the Stream without ending the function',
          'It is equivalent to `return`',
          'Pauses the function indefinitely',
        ],
        correctIndex: 1,
        explanation: '`yield` emits a value to the Stream and "pauses" the function until the consumer requests the next value. The function continues from where it left off.',
      ),
    ],
    flashcards: [
      Flashcard(
        front: 'Single-subscriber Stream vs broadcast',
        back: 'Normal Stream: only one subscriber at a time. Broadcast stream: multiple simultaneous subscribers. Use `StreamController.broadcast()` for the latter.',
      ),
      Flashcard(
        front: 'Async generator `async*`',
        back: 'An `async*` function returns a Stream. Use `yield` to emit values and `await` to wait for async operations between emissions.',
        code: 'Stream<int> counter() async* {\n  for (int i = 0; i < 5; i++) {\n    await Future.delayed(Duration(seconds: 1));\n    yield i;\n  }\n}',
      ),
      Flashcard(
        front: 'Stream transformations',
        back: 'Streams have `map`, `where`, `take`, `skip` just like Iterables, but asynchronously.',
        code: 'stream.where((n) => n.isEven).map((n) => n * 2)',
      ),
    ],
    lessons: [
      Lesson(
        title: 'What is a Stream?',
        sections: [
          LessonSection(
            text: 'If a `Future` emits a single value in the future, a `Stream` emits multiple values over time. Think of it as a pipe through which data flows.',
            code: '''
Stream<int> countTo5() async* {
  for (int i = 1; i <= 5; i++) {
    await Future.delayed(Duration(milliseconds: 200));
    yield i;
  }
}

Future<void> main() async {
  await for (var number in countTo5()) {
    print(number); // 1 2 3 4 5 (with pauses)
  }
  print('Stream completed');
}
''',
          ),
          LessonSection(
            heading: 'StreamController',
            text: 'For more complex cases, use `StreamController` to emit events manually.',
            code: '''
import 'dart:async';

Future<void> main() async {
  var controller = StreamController<String>();

  controller.stream.listen(
    (data) => print('Received: \$data'),
    onError: (e) => print('Error: \$e'),
    onDone: () => print('Stream closed'),
  );

  controller.add('First');
  controller.add('Second');
  controller.addError('something went wrong');
  controller.add('Third');
  controller.close();

  await Future.delayed(Duration(milliseconds: 100));
}
''',
          ),
          LessonSection(
            heading: 'Stream transformations',
            code: '''
Stream<int> numbers() async* {
  for (int i = 1; i <= 10; i++) yield i;
}

Future<void> main() async {
  await for (var n in numbers().map((x) => x * x)) {
    print(n); // 1 4 9 16 25 36 49 64 81 100
  }

  await for (var n in numbers().where((x) => x % 2 == 0)) {
    print(n); // 2 4 6 8 10
  }

  await for (var n in numbers().take(3)) {
    print(n); // 1 2 3
  }

  var list = await numbers().toList();
  print(list); // [1, 2, ..., 10]
}
''',
          ),
        ],
      ),
    ],
  ),

  // ─────────────────────────────────────────────
  // 11. ERROR HANDLING
  // ─────────────────────────────────────────────
  Topic(
    id: 'error_handling',
    title: 'Error Handling',
    subtitle: 'try/catch/finally, Exception, Error and custom exceptions',
    icon: '🚨',
    difficulty: DifficultyLevel.intermediate,
    quiz: [
      QuizQuestion(
        question: 'Is `finally` executed if the code in `try` throws an exception?',
        options: [
          'No, finally only runs on the happy path',
          'Yes, finally always runs regardless of whether there was an error or not',
          'It depends on the type of exception',
          'Only if there is a `catch` that captures the exception',
        ],
        correctIndex: 1,
        explanation: '`finally` ALWAYS runs: if try succeeds, if it throws a caught exception, or an uncaught one. Ideal for releasing resources.',
      ),
      QuizQuestion(
        question: 'What is the difference between `Exception` and `Error` in Dart?',
        options: [
          'They are synonyms',
          'Exception: expected recoverable condition. Error: programming failure that should not occur.',
          'Error: recoverable condition. Exception: serious failure.',
          'Exception is only used in async',
        ],
        correctIndex: 1,
        explanation: 'In Dart, `Exception` represents situations the program can anticipate (network, format). `Error` represents programming bugs (out-of-range index, unexpected null).',
      ),
      QuizQuestion(
        question: 'What does `on FormatException catch (e)` do?',
        options: [
          'Catches any exception',
          'Catches only exceptions of type FormatException',
          'Rethrows the exception',
          'It is a special finally block',
        ],
        correctIndex: 1,
        explanation: 'The `on Type` clause filters by exception type. It only runs if the thrown exception is of that type or a subtype.',
      ),
    ],
    flashcards: [
      Flashcard(
        front: 'try/catch/finally structure',
        back: 'try: code that may fail.\non/catch: handles specific error types.\nfinally: always runs (release resources, close connections).',
      ),
      Flashcard(
        front: 'Creating custom exceptions',
        back: 'Implement `Exception` for domain errors of your app. Add informative fields and override `toString`.',
        code: 'class InsufficientFunds implements Exception {\n  final double balance, amount;\n  InsufficientFunds(this.balance, this.amount);\n}',
      ),
      Flashcard(
        front: '`on` vs `catch`',
        back: '`on ErrorType`: catches that type without accessing the error object.\n`catch (e)`: accesses the error object.\n`on ErrorType catch (e)`: both together.',
      ),
    ],
    lessons: [
      Lesson(
        title: 'try / catch / finally',
        sections: [
          LessonSection(
            code: '''
void divide(int a, int b) {
  try {
    if (b == 0) throw ArgumentError('Cannot divide by zero');
    print(a ~/ b);
  } on ArgumentError catch (e) {
    print('Invalid argument: \${e.message}');
  } on RangeError catch (e, stackTrace) {
    print('Out of range: \$e');
    print(stackTrace);
  } catch (e) {
    print('Unknown error: \$e');
  } finally {
    print('Operation finished');
  }
}

divide(10, 2);  // 5 \n Operation finished
divide(10, 0);  // Invalid argument... \n Operation finished
''',
          ),
        ],
      ),
      Lesson(
        title: 'Exception vs Error',
        sections: [
          LessonSection(
            text: 'Dart distinguishes between `Exception` (expected recoverable condition) and `Error` (programming failure that should never occur in production).',
            code: '''
// Exceptions: conditions the program CAN anticipate
try {
  int n = int.parse('abc'); // FormatException
} on FormatException {
  print('Invalid format');
}

// Errors: bugs in the code
try {
  var list = [1, 2, 3];
  print(list[10]); // RangeError
} on RangeError catch (e) {
  print('Invalid index: \$e');
}
''',
          ),
          LessonSection(
            heading: 'Custom exceptions',
            code: '''
class InsufficientFundsException implements Exception {
  final double balance;
  final double amount;

  InsufficientFundsException({required this.balance, required this.amount});

  @override
  String toString() =>
      'InsufficientFunds: tried to withdraw \$amount but only have \$balance';
}

class BankAccount {
  double _balance;
  BankAccount(this._balance);

  void withdraw(double amount) {
    if (amount > _balance) {
      throw InsufficientFundsException(balance: _balance, amount: amount);
    }
    _balance -= amount;
    print('Withdrawal successful. Balance: \$_balance');
  }
}

void main() {
  var account = BankAccount(100);
  try {
    account.withdraw(150);
  } on InsufficientFundsException catch (e) {
    print(e);
  }
}
''',
          ),
        ],
      ),
    ],
  ),

  // ─────────────────────────────────────────────
  // 12. ENUMS
  // ─────────────────────────────────────────────
  Topic(
    id: 'enums',
    title: 'Enums',
    subtitle: 'Simple enumerations and enhanced enums (Dart 2.17)',
    icon: '🏷️',
    difficulty: DifficultyLevel.intermediate,
    quiz: [
      QuizQuestion(
        question: 'Which property of an enum returns its name as a String?',
        options: ['.toString()', '.name', '.label', '.identifier'],
        correctIndex: 1,
        explanation: 'The `.name` property returns the enum value\'s name as a String. For example, `Status.active.name` returns `"active"`.',
      ),
      QuizQuestion(
        question: 'What is an Enhanced Enum (Dart 2.17+)?',
        options: [
          'An enum that can have null as a value',
          'An enum with its own properties, constructors and methods',
          'An enum that inherits from another class',
          'An enum that can be modified at runtime',
        ],
        correctIndex: 1,
        explanation: 'Enhanced Enums from Dart 2.17 allow adding fields, const constructors and methods to enumerations, turning them into richer types.',
      ),
      QuizQuestion(
        question: 'In Dart 3, what is the advantage of exhaustive switch with enums?',
        options: [
          'It is faster',
          'The compiler detects missing cases in the switch, preventing uncovered branches',
          'It allows modifying the enum values',
          'It only works with simple enums',
        ],
        correctIndex: 1,
        explanation: 'In Dart 3, switch on enums is exhaustive: the compiler gives an error if you do not cover all possible enum values (or have a `_` default case).',
      ),
    ],
    flashcards: [
      Flashcard(
        front: 'Useful enum properties',
        back: '`.name`: name as String.\n`.index`: position (0-based).\n`Enum.values`: list of all values.',
        code: 'Status.active.name;  // "active"\nStatus.active.index; // 0\nStatus.values;       // [active, inactive, ...]',
      ),
      Flashcard(
        front: 'Enhanced Enum with properties',
        back: 'Dart 2.17+ allows adding fields and methods to enums. The constructor must be `const`.',
        code: 'enum Planet {\n  earth(massKg: 5.97e24);\n  final double massKg;\n  const Planet({required this.massKg});\n}',
      ),
      Flashcard(
        front: 'Enum implementing an interface',
        back: 'An enum can implement interfaces and override their methods, one per enum value.',
        code: 'enum TrafficLight implements Describable {\n  red, green;\n  @override\n  String describe() => switch(this) { .red => "Stop", _ => "Go" };\n}',
      ),
    ],
    lessons: [
      Lesson(
        title: 'Basic enums',
        sections: [
          LessonSection(
            code: '''
enum Status    { active, inactive, pending, blocked }
enum Direction { north, south, east, west }

void main() {
  var status = Status.active;

  if (status == Status.active) {
    print('User is active');
  }

  // Exhaustive switch (Dart 3 detects missing cases)
  switch (status) {
    case Status.active:
      print('Online');
    case Status.inactive:
      print('Offline');
    case Status.pending:
      print('Awaiting verification');
    case Status.blocked:
      print('Account blocked');
  }

  print(status.name);  // 'active'
  print(status.index); // 0

  for (var e in Status.values) {
    print(e.name);
  }
}
''',
          ),
        ],
      ),
      Lesson(
        title: 'Enhanced Enums (Dart 2.17+)',
        sections: [
          LessonSection(
            text: 'Dart 2.17 introduced enums with properties, constructors and methods. They are like classes inside an enumeration.',
            code: '''
enum Planet {
  mercury(massKg: 3.30e23, radiusKm: 2440),
  venus  (massKg: 4.87e24, radiusKm: 6052),
  earth  (massKg: 5.97e24, radiusKm: 6371),
  mars   (massKg: 6.42e23, radiusKm: 3390);

  final double massKg;
  final double radiusKm;

  const Planet({required this.massKg, required this.radiusKm});

  double get gravity =>
      (6.674e-11 * massKg) / (radiusKm * 1000) / (radiusKm * 1000);

  String get description =>
      '\$name: radius=\${radiusKm}km, g=\${gravity.toStringAsFixed(2)}m/s²';
}

void main() {
  for (var p in Planet.values) {
    print(p.description);
  }
  // earth: radius=6371km, g=9.82m/s²
}
''',
          ),
          LessonSection(
            heading: 'Enum implementing interfaces',
            code: '''
interface class Describable {
  String describe();
}

enum TrafficLight implements Describable {
  red, yellow, green;

  @override
  String describe() => switch (this) {
    TrafficLight.red    => 'STOP — Do not pass',
    TrafficLight.yellow => 'CAUTION — Get ready',
    TrafficLight.green  => 'GO — You may pass',
  };

  bool get canPass => this == TrafficLight.green;
}

void main() {
  var light = TrafficLight.green;
  print(light.describe()); // GO — You may pass
  print(light.canPass);    // true
}
''',
          ),
        ],
      ),
    ],
  ),

  // ─────────────────────────────────────────────
  // 13. EXTENSION METHODS
  // ─────────────────────────────────────────────
  Topic(
    id: 'extensions',
    title: 'Extension Methods',
    subtitle: 'Add functionality to existing types without modifying them',
    icon: '🔌',
    difficulty: DifficultyLevel.intermediate,
    quiz: [
      QuizQuestion(
        question: 'What does an extension allow you to do?',
        options: [
          'Modify the source code of an existing class',
          'Add methods, getters and operators to a type without modifying its source code',
          'Create subclasses of sealed types',
          'Change the return type of existing methods',
        ],
        correctIndex: 1,
        explanation: 'Extensions add functionality to existing types (including stdlib ones) without modifying them. The added code is only visible where the extension is imported.',
      ),
      QuizQuestion(
        question: 'Can extensions add instance fields?',
        options: [
          'Yes, like any class',
          'No, they can only add methods, getters, setters and operators',
          'Only static fields',
          'Only if the type is a concrete class',
        ],
        correctIndex: 1,
        explanation: 'Extensions cannot add state (instance fields) because they have no access to the object\'s internal storage. They can only operate on the type\'s public members.',
      ),
    ],
    flashcards: [
      Flashcard(
        front: 'Extension syntax',
        back: '`extension ExtensionName on TargetType { ... }`. The name is optional but recommended for resolving import conflicts.',
        code: 'extension StringUtils on String {\n  String get capitalized => ...\n}',
      ),
      Flashcard(
        front: 'When to use extensions?',
        back: 'When you want to add utilities to a type you do not control (String, int, List…) without creating standalone functions. Keeps code readable and OOP-oriented.',
      ),
      Flashcard(
        front: 'Generic extension',
        back: 'You can create extensions on generic types to operate on collections of any type.',
        code: 'extension ListUtils<T> on List<T> {\n  T? get firstOrNull => isEmpty ? null : first;\n}',
      ),
    ],
    lessons: [
      Lesson(
        title: 'Extending existing types',
        sections: [
          LessonSection(
            text: 'Extensions let you add methods, getters and operators to existing types (even from the standard library) without modifying their source code.',
            code: '''
extension StringUtils on String {
  String get capitalized {
    if (isEmpty) return this;
    return '\${this[0].toUpperCase()}\${substring(1).toLowerCase()}';
  }

  bool get isEmail => contains('@') && contains('.');

  String repeat(int times) => this * times;

  int? toIntOrNull() => int.tryParse(this);
}

extension IntUtils on int {
  bool get isEven_  => this % 2 == 0;
  bool get isOdd_   => !isEven_;

  Duration get seconds => Duration(seconds: this);
  Duration get minutes => Duration(minutes: this);

  List<int> get range => List.generate(this, (i) => i);
}

void main() {
  print('hello world'.capitalized);  // Hello world
  print('user@mail.com'.isEmail);    // true
  print('ha'.repeat(3));             // hahaha
  print('42'.toIntOrNull());         // 42
  print('abc'.toIntOrNull());        // null

  print(4.isEven_);  // true
  print(3.isOdd_);   // true
  print(5.range);    // [0, 1, 2, 3, 4]
}
''',
          ),
          LessonSection(
            heading: 'Extensions on collections',
            code: '''
extension ListUtils<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;
  T? get lastOrNull  => isEmpty ? null : last;

  List<T> get shuffled {
    var copy = List<T>.from(this);
    copy.shuffle();
    return copy;
  }
}

extension NumList on List<num> {
  num get sum     => fold(0, (acc, x) => acc + x);
  double get mean => sum / length;
  num get max     => reduce((a, b) => a > b ? a : b);
  num get min     => reduce((a, b) => a < b ? a : b);
}

void main() {
  var nums = [3, 1, 4, 1, 5, 9, 2, 6];
  print(nums.sum);   // 31
  print(nums.mean);  // 3.875
  print(nums.max);   // 9
  print(nums.min);   // 1

  var list = [1, 2, 3];
  print(list.firstOrNull);      // 1
  print(<int>[].firstOrNull);   // null
}
''',
          ),
        ],
      ),
    ],
  ),

  // ─────────────────────────────────────────────
  // 14. RECORDS & PATTERN MATCHING
  // ─────────────────────────────────────────────
  Topic(
    id: 'records_patterns',
    title: 'Records & Pattern Matching',
    subtitle: 'Dart 3 features: records, destructuring and patterns',
    icon: '🎯',
    difficulty: DifficultyLevel.advanced,
    quiz: [
      QuizQuestion(
        question: 'Are `(1, "hello")` and `(1, "hello")` equal in Dart?',
        options: [
          'No, because they are different objects in memory',
          'Yes, records compare by value (structural equality)',
          'It depends on the == operator you define',
          'Only if they are const',
        ],
        correctIndex: 1,
        explanation: 'Records have structural equality by default: two records are equal if they have the same types and values in the same positions, with no need to implement `==`.',
      ),
      QuizQuestion(
        question: 'How do you access the second element of a positional record `(10, "Ana")`?',
        options: ['.second', '.[1]', '.\$2', '.get(1)'],
        correctIndex: 2,
        explanation: 'Positional record fields are accessed with `.\$1`, `.\$2`, etc. (1-based index). Named fields are accessed by their name.',
      ),
      QuizQuestion(
        question: 'What are sealed classes in Dart 3?',
        options: [
          'Classes that cannot have subclasses',
          'Classes whose subclasses must be in the same file, enabling exhaustive switch',
          'Classes that automatically implement equals and hashCode',
          'Classes that cannot be instantiated',
        ],
        correctIndex: 1,
        explanation: '`sealed class` restricts subclasses to the same file. This lets the compiler verify that a switch is exhaustive over all possible subclasses.',
      ),
    ],
    flashcards: [
      Flashcard(
        front: 'Record: what it is and what it is for',
        back: 'An immutable composite type that groups several values. Ideal for returning multiple values from a function without creating a class.',
        code: '(String, int) person = ("Ana", 25);\nvar (name, age) = person; // destructuring',
      ),
      Flashcard(
        front: 'Positional record vs named record',
        back: 'Positional: `(int, String)` — access with `.\$1`, `.\$2`.\nNamed: `({String email, int age})` — access with `.email`, `.age`.',
      ),
      Flashcard(
        front: 'Pattern matching in switch (Dart 3)',
        back: 'Dart 3 switch can destructure objects, Records and Maps directly in cases, with optional guard clauses (`when`).',
        code: 'switch (shape) {\n  Circle(radius: var r) => 3.14 * r * r,\n  _ => 0.0,\n}',
      ),
      Flashcard(
        front: 'Guard clause in switch',
        back: 'Adds an extra condition with `when` after the pattern. The case only activates if the pattern matches AND the condition is true.',
        code: 'switch (n) {\n  int x when x > 0 => "positive",\n  _ => "not positive",\n}',
      ),
    ],
    lessons: [
      Lesson(
        title: 'Records (Dart 3)',
        sections: [
          LessonSection(
            text: '`Records` are immutable composite types that group multiple values. Like named tuples. No need to create a class for every small grouping.',
            code: '''
// Positional record
(int, String) person = (25, 'Ana');
print(person.\$1); // 25 (1-based index)
print(person.\$2); // Ana

// Named fields record
({String name, int age}) user = (name: 'Luis', age: 30);
print(user.name); // Luis
print(user.age);  // 30

// Mixed
(int, {String email}) account = (1, email: 'a@b.com');
print(account.\$1);    // 1
print(account.email);  // a@b.com

// Records are immutable
// user.name = 'Pedro'; ← ERROR: cannot modify

// Structural equality (by value, not by reference)
var r1 = (1, 'hello');
var r2 = (1, 'hello');
print(r1 == r2); // true
''',
          ),
          LessonSection(
            heading: 'Records as multiple return values',
            code: '''
// Before Records, you had to create a class or use List/Map
// Now you can return multiple values with type safety

(double min, double max, double mean) statistics(List<double> data) {
  final mn = data.reduce((a, b) => a < b ? a : b);
  final mx = data.reduce((a, b) => a > b ? a : b);
  final avg = data.reduce((a, b) => a + b) / data.length;
  return (mn, mx, avg);
}

void main() {
  var stats = statistics([4.0, 2.5, 8.1, 1.3, 6.7]);

  var (min, max, mean) = stats;
  print('Min: \$min, Max: \$max, Mean: \$mean');
  // Min: 1.3, Max: 8.1, Mean: 4.52
}
''',
          ),
        ],
      ),
      Lesson(
        title: 'Pattern Matching (Dart 3)',
        sections: [
          LessonSection(
            text: 'Dart 3 introduces pattern matching: a powerful way to destructure and check values expressively.',
            code: '''
// Variable patterns: extract and bind values
var (a, b) = (1, 2);
print('\$a \$b'); // 1 2

// List pattern
var [x, y, ...rest] = [1, 2, 3, 4, 5];
print('\$x \$y \$rest'); // 1 2 [3, 4, 5]

// Map pattern
var {'name': name, 'age': age} = {'name': 'Ana', 'age': 25};
print('\$name is \$age years old'); // Ana is 25 years old

// Object pattern
class Point {
  final int x, y;
  const Point(this.x, this.y);
}

var point = Point(3, 4);
var Point(x: px, y: py) = point;
print('(\$px, \$py)'); // (3, 4)
''',
          ),
          LessonSection(
            heading: 'switch with patterns',
            code: '''
Object shape = {'type': 'circle', 'radius': 5.0};

String description = switch (shape) {
  {'type': 'circle', 'radius': double r} =>
      'Circle with radius \$r',
  {'type': 'rectangle', 'width': double w, 'height': double h} =>
      'Rectangle \$w x \$h',
  String s => 'Unknown shape: \$s',
  _ => 'Not a valid shape',
};

print(description); // Circle with radius 5.0

// Guard clauses: extra condition after the pattern
int n = 7;
String kind = switch (n) {
  int x when x < 0 => 'negative',
  0                => 'zero',
  int x when x.isEven => 'positive even',
  _ => 'positive odd',
};
print(kind); // positive odd
''',
          ),
          LessonSection(
            heading: 'Sealed classes + Pattern Matching',
            text: '`sealed classes` are the perfect companion for exhaustive switch: Dart can verify you handle all possible cases.',
            code: '''
sealed class Shape {}

class Circle    extends Shape { final double radius; Circle(this.radius); }
class Rectangle extends Shape { final double width, height; Rectangle(this.width, this.height); }
class Triangle  extends Shape { final double base, height; Triangle(this.base, this.height); }

double calculateArea(Shape shape) => switch (shape) {
  Circle(radius: var r)             => 3.14159 * r * r,
  Rectangle(width: var w, height: var h) => w * h,
  Triangle(base: var b, height: var h)   => 0.5 * b * h,
  // No _ needed: class is sealed and all cases are covered
};

void main() {
  print(calculateArea(Circle(5)));       // 78.539...
  print(calculateArea(Rectangle(4, 6))); // 24.0
  print(calculateArea(Triangle(3, 8)));  // 12.0
}
''',
          ),
        ],
      ),
    ],
  ),

  // ─────────────────────────────────────────────
  // 15. EXTENSION TYPES (Dart 3.3)
  // ─────────────────────────────────────────────
  Topic(
    id: 'extension_types',
    title: 'Extension Types (Dart 3.3)',
    subtitle: 'Zero-cost wrappers with static type safety',
    icon: '🧊',
    difficulty: DifficultyLevel.advanced,
    quiz: [
      QuizQuestion(
        question: 'What is the key difference between an extension type and a regular wrapper class?',
        options: [
          'An extension type is slower',
          'An extension type has zero cost at runtime: it does not create a new object in memory',
          'An extension type can have instance fields',
          'There is no practical difference',
        ],
        correctIndex: 1,
        explanation: 'An extension type is erased by the compiler at compile time. At runtime it is exactly the represented type, with no wrapper object overhead.',
      ),
      QuizQuestion(
        question: 'What does `implements int` do in an extension type?',
        options: [
          'Inherits the implementation of int',
          'Exposes the interface of int, allowing the extension type to be used where an int is expected',
          'Makes the extension type mutable',
          'Only works for primitive types',
        ],
        correctIndex: 1,
        explanation: 'With `implements BaseType`, the extension type exposes all members of the base type. Without it, only explicitly declared members are exposed.',
      ),
    ],
    flashcards: [
      Flashcard(
        front: 'What is an extension type?',
        back: 'A zero-cost wrapper: adds compile-time type safety without creating additional objects at runtime. The compiler erases it.',
        code: 'extension type Meters(double value) {\n  Meters operator +(Meters o) => Meters(value + o.value);\n}',
      ),
      Flashcard(
        front: 'Use case: typed IDs',
        back: 'Avoids confusing different IDs that are internally the same type (int, String). The compiler catches the error instead of your code.',
        code: 'extension type UserId(int value) {}\nextension type ProductId(int value) {}\n// createOrder(productId, userId) ← compile error',
      ),
      Flashcard(
        front: '`implements` in extension type',
        back: 'With `implements int` the extension type exposes all members of int. Without it, the base type\'s members are private to the extension type.',
        code: 'extension type UserId(int value) implements int {\n  // Can now be used where an int is expected\n}',
      ),
    ],
    lessons: [
      Lesson(
        title: 'What are Extension Types?',
        sections: [
          LessonSection(
            text: 'An `extension type` is a **zero-cost wrapper** around another type. It adds compile-time type safety without creating a new object in memory. Unlike a class that wraps a value: when compiled, the extension type disappears and only the represented type remains.',
          ),
          LessonSection(
            heading: 'Basic syntax',
            code: '''
// Declaration: name(represented type)
extension type Meters(double value) {
  Meters operator +(Meters other) => Meters(value + other.value);
  Meters operator *(double factor) => Meters(value * factor);

  String get formatted => '\${value.toStringAsFixed(2)} m';
}

extension type Kilograms(double value) {
  String get formatted => '\${value.toStringAsFixed(2)} kg';
}

void main() {
  var distance = Meters(5.0);
  var doubled  = distance * 2;
  print(doubled.formatted); // 10.00 m

  // ✅ The compiler prevents mixing incompatible types
  var weight = Kilograms(70.0);
  // var sum = distance + weight; ← ERROR: incompatible types
}
''',
          ),
          LessonSection(
            heading: 'Zero cost at runtime',
            text: 'Unlike a regular wrapper class, the extension type does not generate a new object. `Meters(5.0)` is exactly the same `5.0` in memory.',
            code: '''
extension type UserId(int value) implements int {
  bool get isAdmin => value < 0;
}

void main() {
  UserId id = UserId(42);

  // Since it implements int, we can use it where an int is expected
  print(id + 1);     // 43 (int operation)
  print(id.isEven);  // true

  print(id.isAdmin); // false (own method)
}
''',
            note: 'With `implements BaseType` the extension type exposes the base type\'s interface. Without it, only what you declare explicitly is exposed.',
          ),
          LessonSection(
            heading: 'Use case: typed IDs',
            text: 'The most common use is giving meaningful names to primitive types, avoiding confusing e.g. a user ID with a product ID.',
            code: '''
extension type UserId(int value) { }
extension type ProductId(int value) { }
extension type OrderId(String value) { }

// Without extension types:
// void createOrder(int userId, int productId) ← easy to mix up!

// With extension types:
void createOrder(UserId userId, ProductId productId) {
  print('User \${userId.value} buys product \${productId.value}');
}

void main() {
  var u = UserId(1);
  var p = ProductId(99);

  createOrder(u, p); // OK
  // createOrder(p, u); ← ERROR at compile time ✅
}
''',
          ),
        ],
      ),
    ],
  ),

  // ─────────────────────────────────────────────
  // 16. DOT SHORTHANDS (Dart 3.10)
  // ─────────────────────────────────────────────
  Topic(
    id: 'dot_shorthands',
    title: 'Dot Shorthands (Dart 3.10)',
    subtitle: 'Omit the type name when the context infers it',
    icon: '✂️',
    difficulty: DifficultyLevel.intermediate,
    quiz: [
      QuizQuestion(
        question: 'In which version of Dart were dot shorthands introduced?',
        options: ['Dart 3.0', 'Dart 3.7', 'Dart 3.10', 'Dart 3.13'],
        correctIndex: 2,
        explanation: 'Dot shorthands (`.value`) were introduced in Dart 3.10.',
      ),
      QuizQuestion(
        question: 'When can you use a dot shorthand like `.error`?',
        options: [
          'Always',
          'Only with enums',
          'When Dart can infer the type from context (variable type, parameter, or switch case)',
          'Only in named parameters',
        ],
        correctIndex: 2,
        explanation: 'Dot shorthands only work when the compiler can deduce the expected type from context. If there is ambiguity, the full name is still required.',
      ),
    ],
    flashcards: [
      Flashcard(
        front: 'What are dot shorthands?',
        back: 'They allow omitting the type name when Dart can infer it from context. Instead of `LogLevel.error`, write `.error`.',
        code: 'logMessage("msg", level: .error); // infers LogLevel.error',
      ),
      Flashcard(
        front: 'Dot shorthands work with...',
        back:
            '• Enum values\n• Named constructors\n• Static methods\n• Static fields\n• Typed variables\n• Switch cases',
        code: 'Color bg = .red;\nswitch (d) { .north => "North" }',
      ),
    ],
    lessons: [
      Lesson(
        title: 'The problem they solve',
        sections: [
          LessonSection(
            text: 'Before Dart 3.10, when passing a value to a function that already declared the expected type, you had to repeat the type name. **Dot shorthands** (`.`) let you omit that name when Dart can infer it from context.',
          ),
          LessonSection(
            heading: 'With enums',
            code: '''
enum Level { basic, intermediate, advanced }

// Before Dart 3.10:
void configure({Level level = Level.basic}) {
  print(level);
}
configure(level: Level.advanced);

// With dot shorthands (Dart 3.10+):
void configureNew({Level level = .basic}) { // .basic infers Level.basic
  print(level);
}
configureNew(level: .advanced); // .advanced infers Level.advanced
''',
          ),
          LessonSection(
            heading: 'With constructors',
            code: '''
class Color {
  final int r, g, b;
  const Color(this.r, this.g, this.b);

  static const red   = Color(255, 0, 0);
  static const green = Color(0, 255, 0);
  static const blue  = Color(0, 0, 255);
}

void paintBackground(Color color) => print('Background: \$color');

// Before:
paintBackground(Color.red);
paintBackground(Color(128, 0, 128));

// With dot shorthands:
paintBackground(.red);           // Shorthand to static field
paintBackground(.blue);
paintBackground(Color(128, 0, 128)); // Constructor with args: still needs name
''',
          ),
          LessonSection(
            heading: 'With static methods and typed variables',
            code: '''
enum Direction { north, south, east, west }

// In a typed variable, the shorthand also works
Direction heading = .north;
heading = .south;

// In lists and conditional expressions
List<Direction> route = [.north, .east, .east, .south];

// In switch
String describe(Direction d) => switch (d) {
  .north => 'Upward',
  .south => 'Downward',
  .east  => 'To the right',
  .west  => 'To the left',
};
''',
            note: 'The shorthand only works when Dart can deduce the type from context: variable type, function parameter, or switch branch. If there is ambiguity, the full name is still required.',
          ),
        ],
      ),
    ],
  ),

  // ─────────────────────────────────────────────
  // 17. MODERN CONSTRUCTORS (Dart 3.12 / 3.13)
  // ─────────────────────────────────────────────
  Topic(
    id: 'primary_constructors',
    title: 'Modern Constructors',
    subtitle: 'Primary constructors (3.13) and private named parameters (3.12)',
    icon: '🏗️',
    difficulty: DifficultyLevel.intermediate,
    quiz: [
      QuizQuestion(
        question: 'With private named parameters (Dart 3.12), what is the parameter name at the call site for `Hummingbird({required this._petName})`?',
        options: ['_petName', 'petName', 'private_petName', 'Compile error'],
        correctIndex: 1,
        explanation: 'The public parameter name at the call site is without the underscore: `petName`. The field inside the class remains private: `_petName`.',
      ),
      QuizQuestion(
        question: 'What is the correct way to declare `class Point` with a primary constructor (Dart 3.13)?',
        options: [
          'class Point { int x, y; }',
          'class Point(final int x, final int y);',
          'class Point = (int x, int y);',
          'primary class Point(int x, int y);',
        ],
        correctIndex: 1,
        explanation: 'With primary constructors (Dart 3.13), parameters are declared in the class header. A class with no body can end with `;`.',
      ),
      QuizQuestion(
        question: 'What is the `new` keyword used for inside a class with a primary constructor?',
        options: [
          'To create instances from within the class itself',
          'To declare additional named constructors',
          'To mark the constructor as factory',
          'It is a reserved word with no use in this context',
        ],
        correctIndex: 1,
        explanation: 'In the body of a class with a primary constructor, `new constructorName(params)` declares an additional named constructor.',
      ),
    ],
    flashcards: [
      Flashcard(
        front: 'Private named parameters (Dart 3.12)',
        back: 'Allows `this._field` in named parameters. The call site uses the name without underscore; the internal field is private.',
        code: 'class Cfg({ required this._host });\nvar c = Cfg(host: "localhost"); // without _',
      ),
      Flashcard(
        front: 'Primary constructor: simple class',
        back: 'Declares parameters directly in the class header. Eliminates the repetition of fields + constructor.',
        code: '// Before: 4 lines. Now: 1\nclass Point(final int x, final int y);',
      ),
      Flashcard(
        front: 'Primary constructor with named params',
        back: 'Named parameters and default values work exactly like in regular constructors.',
        code: 'class Server(String host, {\n  int port = 8080,\n  bool ssl = false,\n});',
      ),
      Flashcard(
        front: 'Additional constructors with `new`',
        back: 'Inside a class with a primary constructor, use `new name()` to declare named constructors. `factory` also works.',
        code: 'class Color(int r, int g, int b) {\n  new grey(int n) : this(n, n, n);\n}',
      ),
    ],
    lessons: [
      Lesson(
        title: 'Private Named Parameters (Dart 3.12)',
        sections: [
          LessonSection(
            text: 'Before Dart 3.12, you could not use `this._field` syntax with named parameters in constructors. You had to write an explicit initializer just to strip the underscore. Dart 3.12 fixes that.',
          ),
          LessonSection(
            heading: 'The old problem',
            code: '''
// Dart <3.12: private field + named parameter = forced boilerplate
class Configuration {
  final String _host;
  final int _port;

  // You had to write this manually:
  Configuration({required String host, required int port})
    : _host = host,
      _port = port;
}
''',
          ),
          LessonSection(
            heading: 'With Dart 3.12+',
            code: '''
// Dart 3.12+: this._field works with named parameters ✅
class Configuration {
  final String _host;
  final int _port;

  // The call site parameter name is 'host' and 'port' (without underscore)
  Configuration({required this._host, required this._port});

  @override
  String toString() => '\$_host:\$_port';
}

void main() {
  var cfg = Configuration(host: 'localhost', port: 8080);
  print(cfg); // localhost:8080
}

// Also works with late and default values
class Session {
  final String _token;
  final Duration _timeout;

  Session({
    required this._token,
    this._timeout = const Duration(hours: 1),
  });
}
''',
            note: 'The public parameter name (at the call site) is the name without the underscore. Fields remain private inside the class.',
          ),
        ],
      ),
      Lesson(
        title: 'Primary Constructors (Dart 3.13)',
        sections: [
          LessonSection(
            text: '**Primary constructors** are the biggest syntax improvement for classes in Dart. They let you declare fields and constructor in a single line, directly in the class header.',
          ),
          LessonSection(
            heading: 'Simple class: from 4 lines to 1',
            code: '''
// Before (Dart <3.13):
class Point {
  final int x;
  final int y;
  Point(this.x, this.y);
}

// With primary constructor (Dart 3.13):
class Point(final int x, final int y);

// Exactly equivalent! Same properties, same constructor.
void main() {
  var p = Point(3, 4);
  print(p.x); // 3
  print(p.y); // 4
}
''',
          ),
          LessonSection(
            heading: 'With named parameters and default values',
            code: '''
// Optional named parameters with default value
class Server(
  String host, {
  int port = 8080,
  bool ssl = false,
});

// Required named parameters
class User(
  final String name, {
  required final String email,
  int age = 0,
});

void main() {
  var srv = Server('localhost', ssl: true, port: 443);
  var u   = User('Ana', email: 'ana@example.com');

  print(srv.host); // localhost
  print(u.name);   // Ana
}
''',
          ),
          LessonSection(
            heading: 'Additional constructors with new and factory',
            code: '''
class Color(final int r, final int g, final int b) {
  // Named constructor using "new"
  new grey(int level) : this(level, level, level);

  // Factory using "factory"
  factory fromHex(String hex) {
    final n = int.parse(hex.replaceFirst('#', ''), radix: 16);
    return Color((n >> 16) & 0xFF, (n >> 8) & 0xFF, n & 0xFF);
  }

  @override
  String toString() => 'rgb(\$r, \$g, \$b)';
}

void main() {
  var red   = Color(255, 0, 0);
  var grey  = Color.grey(128);
  var green = Color.fromHex('#00FF00');

  print(red);   // rgb(255, 0, 0)
  print(grey);  // rgb(128, 128, 128)
  print(green); // rgb(0, 255, 0)
}
''',
          ),
          LessonSection(
            heading: 'Inheritance with primary constructors',
            code: '''
class Animal(final String name, final int age);

// super.parameter works the same way
class Dog(super.name, super.age, final String breed)
    extends Animal;

// With additional body
class Cat(super.name, super.age) extends Animal {
  void meow() => print('\$name: Meow!');
}

void main() {
  var dog = Dog('Rex', 3, 'Labrador');
  print(dog.name);  // Rex
  print(dog.breed); // Labrador

  var cat = Cat('Whiskers', 2);
  cat.meow(); // Whiskers: Meow!
}
''',
            note: 'Primary constructors are especially useful for simple data classes (DTOs, value objects, models). For classes with complex constructor logic, the body constructor is still the right choice.',
          ),
          LessonSection(
            heading: 'Before vs after comparison',
            code: '''
// ─── BEFORE (Dart <3.13) ───────────────────────
class ProductBefore {
  final String name;
  final double price;
  final int stock;

  ProductBefore({
    required this.name,
    required this.price,
    this.stock = 0,
  });
}

// ─── NOW (Dart 3.13) ────────────────────────
class Product({
  required final String name,
  required final double price,
  final int stock = 0,
});

// Identical usage in both cases:
void main() {
  var p = Product(name: 'Dart Book', price: 29.99, stock: 10);
  print(p.name); // Dart Book
}
''',
          ),
        ],
      ),
    ],
  ),

  // ─────────────────────────────────────────────
  // 18. WILDCARD VARIABLES (Dart 3.7)
  // ─────────────────────────────────────────────
  Topic(
    id: 'wildcards',
    title: 'Wildcard Variables (Dart 3.7)',
    subtitle: 'Using _ to ignore variables and parameters',
    icon: '🃏',
    difficulty: DifficultyLevel.intermediate,
    quiz: [
      QuizQuestion(
        question: 'What does Dart 3.7 allow with `_` that was not possible before?',
        options: [
          'Using _ as a class name',
          'Having multiple _ in the same scope without conflict, since it creates no binding',
          'Using _ as a return type',
          'Declaring private fields with __',
        ],
        correctIndex: 1,
        explanation: 'Before 3.7, `_` was a regular variable name and could only appear once per scope. Since 3.7, it is a non-binding variable that can be repeated.',
      ),
      QuizQuestion(
        question: 'What is the semantic purpose of using `_` instead of a name like `unused`?',
        options: [
          'The compiler optimizes it better',
          'It explicitly communicates that the value is intentionally ignored — a language convention',
          'It is required for unused variables',
          'Just personal style, no difference',
        ],
        correctIndex: 1,
        explanation: '`_` is the standard Dart convention for "this value is intentionally ignored". Names like `unused` are ambiguous; `_` is unambiguous.',
      ),
    ],
    flashcards: [
      Flashcard(
        front: 'Wildcard `_` in Dart 3.7',
        back: 'Since Dart 3.7, `_` is a special non-binding variable. You can use it multiple times in the same scope to explicitly discard values.',
        code: 'var (a, _, _) = (1, 2, 3); // _ discarded twice',
      ),
      Flashcard(
        front: '_ in function parameters',
        back: 'Use `_` when the API requires a parameter you do not need. Communicates that the value is intentionally ignored.',
        code: 'list.forEach((_) => count++);\nmap.forEach((_, v) => print(v));',
      ),
      Flashcard(
        front: '_ in catch',
        back: 'You can use `_` to discard both the exception and the stack trace if you only want the catch block to exist.',
        code: 'try { ... } catch (_, _) {\n  // both ignored\n}',
      ),
    ],
    lessons: [
      Lesson(
        title: 'Wildcard variables with _',
        sections: [
          LessonSection(
            text: 'Since Dart 3.7, the underscore `_` is a **non-binding variable**: you can use it to intentionally ignore values, and you can have multiple `_` in the same scope without conflict. Before 3.7, `_` was a regular variable name — only one per scope.',
          ),
          LessonSection(
            heading: 'Multiple _ in the same scope',
            code: '''
// Before 3.7: only one _ per scope
// var (_, _, c) = (1, 2, 3); ← ERROR before 3.7

// Dart 3.7+: _ can be repeated
var (a, _, _) = (10, 20, 30);
print(a); // 10 — the two _ are discarded without error
''',
          ),
          LessonSection(
            heading: 'In loops and catch',
            code: '''
var list = ['a', 'b', 'c'];
int count = 0;

// _ makes clear the element does not matter, only the iteration
for (var _ in list) {
  count++;
}
print(count); // 3

// catch: ignore both the exception and the stack trace
try {
  int.parse('not a number');
} catch (_, _) {
  // Both discarded: we just want to continue
  print('Parse failed');
}
''',
          ),
          LessonSection(
            heading: 'In function parameters',
            code: '''
// When the API requires certain parameters but you do not need them
var ticks = Stream.periodic(Duration(seconds: 1), (i) => i).take(3);
ticks.listen((_) => print('Tick!')); // the value does not matter

// Map.forEach: ignore the key, only use the value
var ages = {'Ana': 25, 'Luis': 30};
ages.forEach((_, age) => print('Age: \$age'));
''',
          ),
          LessonSection(
            heading: 'In pattern matching',
            code: '''
var point = (x: 3, y: 7, z: -1);

// Only interested in y
var (x: _, y: value, z: _) = point;
print(value); // 7

// In switch: _ as type wildcard
String classify(Object obj) => switch (obj) {
  int n when n > 0 => 'positive integer',
  int _            => 'non-positive integer', // binds int but does not use it
  String s         => 'string: \$s',
  _                => 'other type',           // default: anything
};

print(classify(5));      // positive integer
print(classify(-3));     // non-positive integer
print(classify('hi'));   // string: hi
print(classify(3.14));   // other type
''',
            note: 'Using `_` instead of names like `unused` or `x` communicates in a standard way that the value is intentionally ignored. It is a language convention, not just a style.',
          ),
        ],
      ),
    ],
  ),

  // ─────────────────────────────────────────────
  // 19. ISOLATES
  // ─────────────────────────────────────────────
  Topic(
    id: 'isolates',
    title: 'Isolates',
    subtitle: 'True parallelism in Dart: Isolate.run and message passing',
    icon: '⚙️',
    difficulty: DifficultyLevel.advanced,
    quiz: [
      QuizQuestion(
        question: 'How do two Isolates communicate with each other?',
        options: [
          'They share memory directly',
          'Through message passing with SendPort and ReceivePort',
          'With global variables',
          'They cannot communicate',
        ],
        correctIndex: 1,
        explanation: 'Isolates do not share memory. They communicate by sending messages through channels: `SendPort` to send and `ReceivePort` to receive.',
      ),
      QuizQuestion(
        question: 'When should you use an Isolate?',
        options: [
          'For any asynchronous operation',
          'Only for network operations',
          'For heavy tasks that would block the main thread (parsing large JSON, intensive calculations)',
          'For all I/O operations',
        ],
        correctIndex: 2,
        explanation: 'I/O operations are already non-blocking in Dart with async/await. Isolates are for CPU-intensive computation that cannot be done asynchronously.',
      ),
    ],
    flashcards: [
      Flashcard(
        front: 'What is an Isolate?',
        back: 'An independent execution unit in Dart with its own memory. It does not share state with other Isolates. Enables true parallelism (multiple CPU cores).',
      ),
      Flashcard(
        front: '`Isolate.run()` (Dart 2.19+)',
        back: 'Simple way to run a function in a separate isolate. Returns a Future with the result. The main thread is not blocked.',
        code: 'int res = await Isolate.run(() => computeFib(40));',
      ),
      Flashcard(
        front: 'Future vs Isolate',
        back: 'Future/async: concurrency (one task at a time, but without blocking). Isolate: parallelism (multiple tasks simultaneously on different threads/cores).',
      ),
    ],
    lessons: [
      Lesson(
        title: 'What are Isolates?',
        sections: [
          LessonSection(
            text: 'Dart is single-threaded by design, but `Isolates` enable true parallelism. Each isolate has its own memory and communicates via message passing (does not share memory directly).',
          ),
          LessonSection(
            heading: 'Isolate.run — simple form',
            code: '''
import 'dart:isolate';

// Heavy task that would block the main thread
int computeFibonacci(int n) {
  if (n <= 1) return n;
  return computeFibonacci(n - 1) + computeFibonacci(n - 2);
}

Future<void> main() async {
  print('Computing fib(40)...');

  // Runs the function in a separate isolate
  // The main thread is NOT blocked
  int result = await Isolate.run(() => computeFibonacci(40));

  print('fib(40) = \$result'); // fib(40) = 102334155
}
''',
            note: '`Isolate.run` is the simplest form (Dart 2.19+). For more complex cases with bidirectional communication, use `ReceivePort` and `SendPort`.',
          ),
          LessonSection(
            heading: 'Communication with ReceivePort and SendPort',
            code: '''
import 'dart:isolate';

void worker(SendPort sendPort) {
  // This code runs in the separate isolate
  for (int i = 0; i < 5; i++) {
    sendPort.send('Message \$i from worker');
  }
  sendPort.send(null); // End signal
}

Future<void> main() async {
  var receivePort = ReceivePort();

  // Create the isolate and pass the SendPort
  await Isolate.spawn(worker, receivePort.sendPort);

  // Listen for messages
  await for (var message in receivePort) {
    if (message == null) {
      receivePort.close();
      break;
    }
    print('Main received: \$message');
  }
}
''',
          ),
        ],
      ),
    ],
  ),
];
