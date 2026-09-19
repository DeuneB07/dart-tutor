import '../models/topic.dart';

const List<Topic> kTopicsEs = [
  // ─────────────────────────────────────────────
  // 1. VARIABLES & TIPOS
  // ─────────────────────────────────────────────
  Topic(
    id: 'variables',
    title: 'Variables y Tipos',
    subtitle: 'var, final, const, tipos primitivos y type inference',
    icon: '📦',
    difficulty: DifficultyLevel.beginner,
    quiz: [
      QuizQuestion(
        question: '¿Cuál es la diferencia clave entre `final` y `const`?',
        options: [
          'No hay diferencia, son sinónimos',
          '`final` se asigna una vez en ejecución; `const` se evalúa en tiempo de compilación',
          '`const` puede reasignarse; `final` no',
          '`final` solo funciona con tipos primitivos',
        ],
        correctIndex: 1,
        explanation: '`final` permite valores calculados al ejecutar (como DateTime.now()), mientras que `const` exige que el valor sea conocido antes de ejecutar el programa.',
      ),
      QuizQuestion(
        question: '¿Qué tipo infiere Dart para `var x = 3.14`?',
        options: ['int', 'num', 'double', 'dynamic'],
        correctIndex: 2,
        explanation: 'Dart infiere `double` porque 3.14 es un literal de coma flotante.',
      ),
      QuizQuestion(
        question: '¿Qué ocurre si intentas reasignar una variable `var` con un tipo diferente?',
        options: [
          'Se convierte automáticamente',
          'Error en tiempo de ejecución',
          'Error en tiempo de compilación',
          'Nada, `var` es dinámico',
        ],
        correctIndex: 2,
        explanation: 'Una vez que Dart infiere el tipo de una variable `var`, ese tipo queda fijado. Intentar asignar un valor de tipo distinto es un error de compilación.',
      ),
      QuizQuestion(
        question: '¿Cuál de estas declaraciones es inválida?',
        options: ['const pi = 3.14159;', 'final nombre = "Ana";', 'const ahora = DateTime.now();', 'var puntos = 100;'],
        correctIndex: 2,
        explanation: '`DateTime.now()` se calcula en tiempo de ejecución, por lo que no puede usarse con `const`. Usa `final` en su lugar.',
      ),
      QuizQuestion(
        question: '¿Qué imprime este código?',
        code: '''
var x = 10;
final y = x * 2;
x = 5;
print(y);''',
        options: ['5', '10', '20', 'Error de compilación'],
        correctIndex: 2,
        explanation: '`y` se inicializa con `x * 2` cuando x vale 10, por lo que y = 20. Cambiar `x` después no afecta a `y` porque ya quedó fijado al ser `final`.',
      ),
    ],
    flashcards: [
      Flashcard(
        front: '¿Qué es la inferencia de tipos?',
        back:
            'Cuando usas `var`, Dart deduce el tipo a partir del valor asignado. Una vez inferido, el tipo no cambia.',
        code: 'var ciudad = "Madrid"; // Dart infiere String',
      ),
      Flashcard(
        front: '`final` vs `const`',
        back: '`final`: valor inmutable asignado una vez, puede calcularse en ejecución.\n`const`: constante de tiempo de compilación, valor conocido antes de ejecutar.',
        code: 'final ahora = DateTime.now(); // OK\nconst pi = 3.14159;           // OK',
      ),
      Flashcard(
        front: '¿Cuándo usar `dynamic`?',
        back: 'Solo cuando el tipo es genuinamente desconocido en compilación (ej: deserializar JSON arbitrario). Evítalo siempre que sea posible: pierdes seguridad de tipos.',
      ),
      Flashcard(
        front: 'Conversión segura String → número',
        back: '`int.tryParse()` devuelve `null` si falla en lugar de lanzar excepción. Usa `int.parse()` solo si sabes que el valor es válido.',
        code: 'int? n = int.tryParse("abc"); // null, sin error',
      ),
    ],
    lessons: [
      Lesson(
        title: 'Declaración de variables',
        sections: [
          LessonSection(
            text: 'En Dart puedes declarar variables de tres formas principales: con un tipo explícito, con `var` (inferencia de tipo) o con `dynamic` (tipo dinámico).',
          ),
          LessonSection(
            heading: 'Tipo explícito',
            text:
                'Declaras la variable indicando su tipo directamente. Dart sabrá qué tipo es en tiempo de compilación.',
            code: '''
String nombre = 'Ana';
int edad = 25;
double precio = 9.99;
bool esActivo = true;

print(nombre); // Ana
print(edad);   // 25
''',
          ),
          LessonSection(
            heading: 'var — inferencia de tipo',
            text: 'Con `var`, Dart deduce el tipo a partir del valor asignado. Una vez asignado el tipo, no puede cambiar.',
            code: '''
var ciudad = 'Madrid';   // Dart infiere: String
var puntos = 100;        // Dart infiere: int
var ratio = 3.14;        // Dart infiere: double

// ciudad = 42; ← ERROR: un String no puede recibir un int
''',
          ),
          LessonSection(
            heading: 'dynamic — sin restricción de tipo',
            text: '`dynamic` desactiva la verificación de tipos. Úsalo solo cuando sea estrictamente necesario, porque pierdes la seguridad en tiempo de compilación.',
            code: '''
dynamic valor = 'Hola';
print(valor.runtimeType); // String

valor = 99;
print(valor.runtimeType); // int

valor = [1, 2, 3];
print(valor.runtimeType); // List<int>
''',
            note: 'Evita `dynamic` salvo casos muy concretos (deserialización de JSON, por ejemplo). Prefiere siempre tipos explícitos o `var`.',
          ),
        ],
      ),
      Lesson(
        title: 'final y const',
        sections: [
          LessonSection(
            text: 'Dart tiene dos modificadores para valores que no deben cambiar: `final` y `const`. Ambos crean variables inmutables, pero con una diferencia clave.',
          ),
          LessonSection(
            heading: 'final — asignación única en tiempo de ejecución',
            text: 'Una variable `final` se asigna una sola vez. Su valor puede calcularse en tiempo de ejecución.',
            code: '''
final fechaHoy = DateTime.now(); // Se calcula al ejecutar
final pi = 3.14159;

// pi = 3.0; ← ERROR: no se puede reasignar un final
''',
          ),
          LessonSection(
            heading: 'const — constante en tiempo de compilación',
            text: '`const` requiere que el valor sea conocido antes de ejecutar el programa. Se usa para valores que nunca cambian bajo ninguna circunstancia.',
            code: '''
const gravitacion = 9.8;
const appNombre = 'Dart Tutor';
const maxIntentos = 3;

// const ahora = DateTime.now(); ← ERROR: DateTime.now() no es constante
''',
          ),
          LessonSection(
            heading: 'Diferencia práctica',
            code: '''
// ✅ final: valor calculado al ejecutar
final String saludo = 'Hola ' + 'Mundo'; // OK
final DateTime inicio = DateTime.now();   // OK

// ✅ const: valor conocido en tiempo de compilación
const int version = 3;
const String prefijo = 'DT';

// Lista const → completamente inmutable
const colores = ['rojo', 'verde', 'azul'];
// colores.add('amarillo'); ← ERROR en runtime
''',
            note: 'Usa `const` siempre que puedas. Hace el código más eficiente porque Dart puede compartir la misma instancia en memoria.',
          ),
        ],
      ),
      Lesson(
        title: 'Tipos numéricos y Strings',
        sections: [
          LessonSection(
            heading: 'int y double',
            code: '''
int entero = 42;
int hex = 0xFF;        // Hexadecimal: 255
int binario = 0b1010;  // Binario: 10

double decimal = 1.5;
double cientifico = 1.5e3; // 1500.0

// Conversiones
double d = entero.toDouble(); // 42.0
int i = decimal.toInt();      // 1 (trunca)
int r = decimal.round();      // 2 (redondea)

// num puede ser int o double
num cualquiera = 10;
cualquiera = 10.5; // OK
''',
          ),
          LessonSection(
            heading: 'String',
            code: '''
// Comillas simples o dobles, ambas válidas
String s1 = 'Hola Dart';
String s2 = "Hola Dart";

// Interpolación de variables
String nombre = 'Carlos';
print('Hola, \$nombre!');          // Hola, Carlos!
print('Edad: \${nombre.length}');  // Edad: 6

// Strings multilínea con triple comilla
String parrafo = \'\'\'
Esto es un texto
en varias líneas.
\'\'\';

// Métodos útiles
'  hola  '.trim();          // 'hola'
'dart'.toUpperCase();       // 'DART'
'DART'.toLowerCase();       // 'dart'
'hola mundo'.split(' ');    // ['hola', 'mundo']
'dart'.contains('ar');      // true
'dart'.replaceAll('a','@'); // 'd@rt'
''',
          ),
          LessonSection(
            heading: 'Conversiones entre tipos',
            code: '''
// String → número
int n = int.parse('42');
double d = double.parse('3.14');

// Número → String
String s = 42.toString();
String con2decimales = 3.14159.toStringAsFixed(2); // '3.14'

// Manejo seguro (evita excepción)
int? seguro = int.tryParse('abc'); // null, no lanza error
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
    subtitle: 'Tipos nullables, operadores ?., ??, y !',
    icon: '🛡️',
    difficulty: DifficultyLevel.beginner,
    quiz: [
      QuizQuestion(
        question: '¿Qué devuelve `null?.toUpperCase()`?',
        options: ['Lanza NullPointerException', '"NULL"', 'null', 'Error de compilación'],
        correctIndex: 2,
        explanation: 'El operador `?.` devuelve `null` si el objeto es null, en lugar de lanzar una excepción.',
      ),
      QuizQuestion(
        question: '¿Qué valor tiene `resultado` tras ejecutar `String? x; var resultado = x ?? "vacío";`?',
        options: ['null', '"vacío"', 'Error', '"x"'],
        correctIndex: 1,
        explanation: 'El operador `??` devuelve el operando de la derecha cuando el de la izquierda es null.',
      ),
      QuizQuestion(
        question: '¿Cuándo usar el operador `!` (force unwrap)?',
        options: [
          'Siempre que una variable sea nullable',
          'Solo cuando estás 100% seguro de que el valor no es null',
          'Es equivalente a `??`',
          'Para convertir null a false',
        ],
        correctIndex: 1,
        explanation: '`!` le dice a Dart que el valor no es null. Si en tiempo de ejecución sí lo es, lanza un NullPointerException. Úsalo solo con certeza absoluta.',
      ),
      QuizQuestion(
        question: '¿Para qué sirve `late`?',
        options: [
          'Para declarar variables que nunca serán null',
          'Para inicializar una variable después de su declaración, prometiendo que se asignará antes de usarla',
          'Es un sinónimo de `final`',
          'Para declarar variables asíncronas',
        ],
        correctIndex: 1,
        explanation: '`late` indica que la variable se inicializará antes de su primer uso, aunque no en el momento de la declaración. Acceder a ella antes de inicializarla lanza LateInitializationError.',
      ),
      QuizQuestion(
        question: '¿Qué imprime este código?',
        code: '''
String? nombre;
String resultado = nombre ?? 'Anónimo';
nombre = 'Ana';
print(resultado);''',
        options: ['Ana', 'null', 'Anónimo', 'Error de compilación'],
        correctIndex: 2,
        explanation: '`??` evalúa en el momento de la asignación: cuando se ejecuta la línea 2, `nombre` es null, así que `resultado` recibe "Anónimo". Cambiar `nombre` después no tiene efecto sobre `resultado`.',
      ),
    ],
    flashcards: [
      Flashcard(
        front: '¿Qué significa que un tipo sea non-nullable?',
        back: 'Desde Dart 2.12, las variables no pueden ser null por defecto. Para permitir null debes añadir `?` al tipo.',
        code: 'String nombre = "Ana"; // nunca null\nString? apodo;          // puede ser null',
      ),
      Flashcard(
        front: 'Operador `?.` (null-aware access)',
        back:
            'Accede a una propiedad o método solo si el objeto no es null. Si es null, devuelve null sin lanzar error.',
        code: 'String? s = null;\nprint(s?.length); // null, no error',
      ),
      Flashcard(
        front: 'Operador `??` (null coalescing)',
        back: 'Devuelve el valor izquierdo si no es null; si es null, devuelve el valor derecho (valor por defecto).',
        code: 'String? nombre;\nprint(nombre ?? "Anónimo"); // Anónimo',
      ),
      Flashcard(
        front: 'Type promotion con null check',
        back: 'Dentro de un `if (x != null)`, Dart "promociona" el tipo de `x` de nullable a non-nullable automáticamente.',
        code: 'String? email;\nif (email != null) {\n  print(email.length); // OK, ya es String\n}',
      ),
    ],
    lessons: [
      Lesson(
        title: '¿Qué es Null Safety?',
        sections: [
          LessonSection(
            text: 'Desde Dart 2.12, el lenguaje garantiza que ninguna variable puede ser `null` a menos que tú lo permitas explícitamente. Esto elimina los temidos errores "Null Pointer Exception".',
          ),
          LessonSection(
            heading: 'Non-nullable por defecto',
            code: '''
// Sin null safety (antes de Dart 2.12):
// String nombre = null; // Podía causar crashes en runtime

// Con null safety:
String nombre = 'Ana';
// nombre = null; ← ERROR en tiempo de compilación ✅

// Para permitir null, agrega ?
String? nombreOpcional = null; // OK
nombreOpcional = 'Luis';       // OK
''',
          ),
          LessonSection(
            heading: 'El operador ?. (null-aware access)',
            text: 'Accede a propiedades o métodos solo si el objeto no es null. Si es null, devuelve null en lugar de lanzar un error.',
            code: '''
String? texto = null;

// Sin ?.  ← peligroso
// print(texto.length); ← lanzaría excepción

// Con ?.  ← seguro
print(texto?.length); // null (no hay error)

String? nombre = 'Dart';
print(nombre?.toUpperCase()); // DART
''',
          ),
          LessonSection(
            heading: 'El operador ?? (null coalescing)',
            text: 'Devuelve el valor de la izquierda si no es null; si es null, devuelve el valor de la derecha (valor por defecto).',
            code: '''
String? apodo = null;
String nombre = apodo ?? 'Anónimo';
print(nombre); // Anónimo

int? puntos = null;
int total = puntos ?? 0;
print(total); // 0

// También como asignación: ??=
puntos ??= 100; // Asigna 100 solo si puntos es null
print(puntos);  // 100
''',
          ),
          LessonSection(
            heading: 'El operador ! (force unwrap)',
            text: 'Fuerza a Dart a tratar una variable nullable como no-nullable. Úsalo solo cuando estés 100% seguro de que el valor no es null.',
            code: '''
String? valor = 'Dart';

// Le dices a Dart: "confía en mí, no es null"
String definitivo = valor!;
print(definitivo.length); // 4

// ⚠️ PELIGRO: si valor ES null, lanza excepción en runtime
String? nulo = null;
// String crash = nulo!; ← NullPointerException en runtime
''',
            note: 'Prefiere siempre `?.` o `??` antes de `!`. El operador `!` es una promesa tuya al compilador; si la incumples, el programa falla.',
          ),
        ],
      ),
      Lesson(
        title: 'Comprobaciones de null y late',
        sections: [
          LessonSection(
            heading: 'Comprobación con if',
            code: '''
String? email;

if (email != null) {
  // Dentro del if, Dart sabe que email no es null
  // Se llama "promotion" o "narrowing"
  print(email.length); // OK, sin ?
}

// Promotion también funciona con otros operadores
String? ciudad;
if (ciudad == null) return;
// A partir de aquí, ciudad es non-nullable
print(ciudad.toUpperCase()); // OK
''',
          ),
          LessonSection(
            heading: 'late — inicialización diferida',
            text: '`late` le dice a Dart que inicializarás la variable antes de usarla, aunque no lo hagas en la declaración. Útil para inyección de dependencias o variables que se asignan en el constructor.',
            code: '''
late String conexion;

void conectar() {
  conexion = 'postgresql://localhost:5432/db';
}

void mostrar() {
  conectar();
  print(conexion); // OK, ya fue asignada
}

// late + final: se asigna exactamente una vez
late final String config;

void init() {
  config = 'produccion';
}
// config = 'otro'; ← ERROR: ya fue asignada
''',
            note: 'Si accedes a una variable `late` antes de inicializarla, obtendrás un LateInitializationError en runtime. Úsalo con cuidado.',
          ),
        ],
      ),
    ],
  ),

  // ─────────────────────────────────────────────
  // 3. FUNCIONES
  // ─────────────────────────────────────────────
  Topic(
    id: 'functions',
    title: 'Funciones',
    subtitle: 'Parámetros, arrow functions, closures y funciones de orden superior',
    icon: '⚡',
    difficulty: DifficultyLevel.beginner,
    quiz: [
      QuizQuestion(
        question: '¿Cuál es el equivalente de `int doble(int x) => x * 2;` en forma larga?',
        options: [
          'int doble(int x) { x * 2; }',
          'int doble(int x) { return x * 2; }',
          'doble(int x) { return x * 2; }',
          'int doble(x) => x * 2;',
        ],
        correctIndex: 1,
        explanation: 'La arrow function `=>` es azúcar sintáctico para `{ return expresion; }`. El tipo de retorno y el tipo del parámetro deben estar presentes.',
      ),
      QuizQuestion(
        question: '¿Qué tipo de parámetros van entre llaves `{}`?',
        options: [
          'Parámetros posicionales obligatorios',
          'Parámetros posicionales opcionales',
          'Parámetros con nombre (named parameters)',
          'Parámetros genéricos',
        ],
        correctIndex: 2,
        explanation: 'Los parámetros entre `{}` son named parameters: se pasan indicando su nombre al llamar la función, p.ej. `f(nombre: "Ana")`.',
      ),
      QuizQuestion(
        question: '¿Qué es una closure en Dart?',
        options: [
          'Una función sin parámetros',
          'Una función que captura variables del ámbito donde fue creada',
          'Un método privado de una clase',
          'Una función que retorna void',
        ],
        correctIndex: 1,
        explanation: 'Una closure "recuerda" las variables del ámbito exterior donde fue definida, incluso cuando se ejecuta fuera de ese ámbito.',
      ),
      QuizQuestion(
        question: '¿Qué hace `required` en un named parameter?',
        options: [
          'Le da un valor por defecto',
          'Lo convierte en posicional',
          'Hace obligatorio que el llamante pase ese parámetro',
          'Solo funciona con tipos nullable',
        ],
        correctIndex: 2,
        explanation: 'Sin `required`, un named parameter es opcional (puede omitirse). Con `required`, el compilador obliga al llamante a pasarlo.',
      ),
      QuizQuestion(
        question: '¿Qué imprime este código?',
        code: '''
int mul(int a, [int b = 2]) => a * b;

print(mul(5));
print(mul(5, 3));''',
        options: ['5\n15', '10\n15', '2\n3', 'Error de compilación'],
        correctIndex: 1,
        explanation:
            'El parámetro opcional `b` tiene valor por defecto 2. Primera llamada: 5 × 2 = 10. Segunda: 5 × 3 = 15.',
      ),
    ],
    flashcards: [
      Flashcard(
        front: 'Arrow function `=>`',
        back: 'Notación corta para funciones con una sola expresión de retorno. Equivale a `{ return expr; }`.',
        code: 'int cuadrado(int x) => x * x;',
      ),
      Flashcard(
        front: 'Parámetros posicionales opcionales `[ ]`',
        back: 'Los parámetros entre corchetes son opcionales y se pasan por posición. Su tipo debe ser nullable o tener valor por defecto.',
        code: 'String saludo(String nombre, [String? titulo]) {\n  return titulo != null ? "\$titulo \$nombre" : nombre;\n}',
      ),
      Flashcard(
        front: 'Named parameters `{ }`',
        back: 'Se pasan por nombre al llamar. Son opcionales por defecto; usa `required` para hacerlos obligatorios.',
        code: 'void config({required String host, int puerto = 8080}) {}',
      ),
      Flashcard(
        front: 'Funciones de primer orden',
        back: 'En Dart, las funciones son objetos. Puedes asignarlas a variables, pasarlas como argumentos y retornarlas desde otras funciones.',
        code: 'var operacion = (int a, int b) => a + b;\nprint(operacion(3, 4)); // 7',
      ),
    ],
    lessons: [
      Lesson(
        title: 'Declaración de funciones',
        sections: [
          LessonSection(
            heading: 'Función básica',
            code: '''
// Tipo de retorno  nombre  parámetros
int sumar(int a, int b) {
  return a + b;
}

print(sumar(3, 4)); // 7

// void: no devuelve nada
void saludar(String nombre) {
  print('Hola, \$nombre!');
}

// Si el compilador puede inferir el retorno, puedes omitirlo
// (aunque es mejor ser explícito)
''',
          ),
          LessonSection(
            heading: 'Arrow function (=>)',
            text: 'Cuando una función tiene una sola expresión como cuerpo, puedes usar la notación flecha `=>`. Es equivalente a `{ return expresion; }`.',
            code: '''
int multiplicar(int a, int b) => a * b;

String mayusculas(String s) => s.toUpperCase();

bool esPar(int n) => n % 2 == 0;

print(multiplicar(3, 4)); // 12
print(mayusculas('dart')); // DART
print(esPar(6)); // true
''',
          ),
        ],
      ),
      Lesson(
        title: 'Tipos de parámetros',
        sections: [
          LessonSection(
            heading: 'Parámetros posicionales opcionales [ ]',
            code: '''
// Los parámetros entre [] son opcionales
String presentar(String nombre, [String? titulo]) {
  if (titulo != null) {
    return '\$titulo \$nombre';
  }
  return nombre;
}

print(presentar('Ana'));         // Ana
print(presentar('Ana', 'Dra.')); // Dra. Ana
''',
          ),
          LessonSection(
            heading: 'Parámetros con nombre { }',
            text: 'Los parámetros entre `{}` se pasan por nombre y son opcionales por defecto. Pueden tener valor por defecto.',
            code: '''
void configurar({
  String host = 'localhost',
  int puerto = 8080,
  bool ssl = false,
}) {
  print('\${ssl ? "https" : "http"}://\$host:\$puerto');
}

configurar();                          // http://localhost:8080
configurar(puerto: 443, ssl: true);    // https://localhost:443
configurar(host: 'example.com');       // http://example.com:8080

// Con required: el llamante DEBE pasar ese parámetro
void crearUsuario({
  required String nombre,
  required String email,
  int edad = 0,
}) {
  print('\$nombre (\$email), \$edad años');
}

crearUsuario(nombre: 'Luis', email: 'luis@ejemplo.com'); // OK
// crearUsuario(email: 'x@y.com'); ← ERROR: falta nombre
''',
          ),
        ],
      ),
      Lesson(
        title: 'Funciones de primer orden y closures',
        sections: [
          LessonSection(
            text: 'En Dart, las funciones son objetos de primera clase: puedes asignarlas a variables, pasarlas como parámetros y retornarlas desde otras funciones.',
          ),
          LessonSection(
            heading: 'Funciones como variables',
            code: '''
// Una función puede vivir en una variable
int Function(int, int) operacion = sumar;

int sumar(int a, int b) => a + b;
int restar(int a, int b) => a - b;

operacion = sumar;
print(operacion(5, 3)); // 8

operacion = restar;
print(operacion(5, 3)); // 2
''',
          ),
          LessonSection(
            heading: 'Funciones anónimas y lambdas',
            code: '''
// Función anónima asignada a variable
var cuadrado = (int x) => x * x;
print(cuadrado(5)); // 25

// Pasada directamente como argumento
var numeros = [1, 2, 3, 4, 5];
var cuadrados = numeros.map((n) => n * n).toList();
print(cuadrados); // [1, 4, 9, 16, 25]

var pares = numeros.where((n) => n % 2 == 0).toList();
print(pares); // [2, 4]
''',
          ),
          LessonSection(
            heading: 'Closures — capturan su entorno',
            text: 'Una closure es una función que "recuerda" las variables del ámbito donde fue creada, incluso cuando se ejecuta fuera de ese ámbito.',
            code: '''
Function crearContador() {
  int cuenta = 0; // Variable del entorno exterior

  return () {
    cuenta++; // La función interna "recuerda" cuenta
    return cuenta;
  };
}

var contador = crearContador();
print(contador()); // 1
print(contador()); // 2
print(contador()); // 3

var otroContador = crearContador(); // Instancia independiente
print(otroContador()); // 1
''',
          ),
          LessonSection(
            heading: 'Funciones de orden superior',
            text: 'Reciben o retornan otras funciones. Los métodos `map`, `where` y `reduce` son ejemplos clásicos.',
            code: '''
// Recibe una función como parámetro
int aplicarDosVeces(int Function(int) f, int x) {
  return f(f(x));
}

int duplicar(int n) => n * 2;

print(aplicarDosVeces(duplicar, 3)); // duplicar(duplicar(3)) = 12

// reduce: combina todos los elementos
var nums = [1, 2, 3, 4, 5];
var suma = nums.reduce((acc, val) => acc + val);
print(suma); // 15
''',
          ),
        ],
      ),
    ],
  ),

  // ─────────────────────────────────────────────
  // 4. CONTROL DE FLUJO
  // ─────────────────────────────────────────────
  Topic(
    id: 'control_flow',
    title: 'Control de Flujo',
    subtitle: 'if/else, switch, for, while, break y continue',
    icon: '🔀',
    difficulty: DifficultyLevel.beginner,
    quiz: [
      QuizQuestion(
        question: '¿Qué imprime este código?',
        code: '''
for (int i = 0; i < 5; i++) {
  if (i == 3) break;
  if (i % 2 == 0) continue;
  print(i);
}''',
        options: ['0 2', '1 3', '1', '0 1 2'],
        correctIndex: 2,
        explanation: 'i=0: par → continue; i=1: impar → imprime 1; i=2: par → continue; i=3: break. Solo imprime 1.',
      ),
      QuizQuestion(
        question: '¿Cuál es la diferencia entre `while` y `do-while`?',
        options: [
          'No hay diferencia',
          '`do-while` ejecuta el cuerpo al menos una vez, `while` puede no ejecutarlo nunca',
          '`while` ejecuta el cuerpo al menos una vez',
          '`do-while` solo funciona con contadores',
        ],
        correctIndex: 1,
        explanation: 'En `do-while`, la condición se comprueba DESPUÉS de ejecutar el cuerpo, así que este siempre se ejecuta al menos una vez.',
      ),
      QuizQuestion(
        question: '¿Qué característica tiene el switch expression de Dart 3?',
        options: [
          'Necesita `break` al final de cada caso',
          'Solo funciona con enums',
          'Devuelve un valor y no necesita `break`',
          'Es idéntico al switch clásico',
        ],
        correctIndex: 2,
        explanation: 'El switch expression de Dart 3 es una expresión que devuelve un valor directamente. No necesita `break` y usa `=>` para cada caso.',
      ),
      QuizQuestion(
        question: '¿Qué imprime este código?',
        code: '''
int x = 4;
String r = switch (x) {
  1     => 'uno',
  2 || 3 => 'dos o tres',
  _ when x > 3 => 'mayor que tres',
  _     => 'otro',
};
print(r);''',
        options: ['uno', 'dos o tres', 'mayor que tres', 'otro'],
        correctIndex: 2,
        explanation: 'x=4 no coincide con 1 ni con 2/3. El guardia `_ when x > 3` se cumple (4 > 3), por lo que el resultado es "mayor que tres".',
      ),
    ],
    flashcards: [
      Flashcard(
        front: 'Operador ternario',
        back: 'Forma compacta de if/else que devuelve un valor: `condicion ? siTrue : siFalse`.',
        code: 'String estado = activo ? "online" : "offline";',
      ),
      Flashcard(
        front: 'switch expression (Dart 3)',
        back: 'Versión del switch que devuelve un valor. Usa `=>` para cada caso y `_` como default. No necesita `break`.',
        code: 'String msg = switch (nota) {\n  >= 9 => "Sobresaliente",\n  >= 5 => "Aprobado",\n  _    => "Suspenso",\n};',
      ),
      Flashcard(
        front: '`break` vs `continue`',
        back:
            '`break` termina el bucle completamente. `continue` salta a la siguiente iteración sin terminar el bucle.',
      ),
      Flashcard(
        front: 'for-in',
        back: 'Itera sobre cualquier Iterable (List, Set, Map.keys…) sin gestionar índices manualmente.',
        code: 'for (var fruta in frutas) { print(fruta); }',
      ),
    ],
    lessons: [
      Lesson(
        title: 'if / else y operador ternario',
        sections: [
          LessonSection(
            code: '''
int temperatura = 22;

if (temperatura > 30) {
  print('Hace calor');
} else if (temperatura > 20) {
  print('Temperatura agradable');
} else {
  print('Hace frío');
}
// Temperatura agradable

// Operador ternario: condicion ? siTrue : siFalse
String resultado = temperatura > 25 ? 'calor' : 'fresco';
print(resultado); // fresco
''',
          ),
        ],
      ),
      Lesson(
        title: 'switch y pattern matching (Dart 3)',
        sections: [
          LessonSection(
            heading: 'switch clásico',
            code: '''
String dia = 'lunes';

switch (dia) {
  case 'lunes':
  case 'martes':
  case 'miercoles':
  case 'jueves':
  case 'viernes':
    print('Día laborable');
    break;
  case 'sabado':
  case 'domingo':
    print('Fin de semana');
    break;
  default:
    print('Día desconocido');
}
''',
          ),
          LessonSection(
            heading: 'switch expression (Dart 3)',
            text: 'A partir de Dart 3, `switch` puede usarse como expresión que devuelve un valor.',
            code: '''
int nota = 8;

String calificacion = switch (nota) {
  >= 9 => 'Sobresaliente',
  >= 7 => 'Notable',
  >= 5 => 'Aprobado',
  _    => 'Suspenso',  // _ es el caso por defecto
};

print(calificacion); // Notable

// Con tipos (sealed classes / pattern matching)
Object forma = Circulo(radio: 5);

double area = switch (forma) {
  Circulo(radio: var r)     => 3.14159 * r * r,
  Rectangulo(ancho: var w, alto: var h) => w * h,
  _ => 0.0,
};
''',
            note: 'El switch expression es uno de los grandes aportes de Dart 3. Es más conciso y no necesita `break`.',
          ),
        ],
      ),
      Lesson(
        title: 'Bucles',
        sections: [
          LessonSection(
            heading: 'for clásico',
            code: '''
for (int i = 0; i < 5; i++) {
  print(i); // 0 1 2 3 4
}

// for-in: recorre iterables
var frutas = ['manzana', 'pera', 'uva'];
for (var fruta in frutas) {
  print(fruta);
}
''',
          ),
          LessonSection(
            heading: 'forEach, map y where',
            code: '''
var numeros = [1, 2, 3, 4, 5];

numeros.forEach((n) => print(n));

// map transforma cada elemento
var dobles = numeros.map((n) => n * 2).toList();
print(dobles); // [2, 4, 6, 8, 10]

// where filtra elementos
var mayoresDe3 = numeros.where((n) => n > 3).toList();
print(mayoresDe3); // [4, 5]
''',
          ),
          LessonSection(
            heading: 'while y do-while',
            code: '''
int i = 0;
while (i < 3) {
  print(i); // 0, 1, 2
  i++;
}

// do-while: ejecuta al menos una vez
int j = 10;
do {
  print('j = \$j');
  j--;
} while (j > 10);
// Imprime "j = 10" aunque la condición era falsa al inicio
''',
          ),
          LessonSection(
            heading: 'break y continue',
            code: '''
// break: sale del bucle
for (int i = 0; i < 10; i++) {
  if (i == 5) break;
  print(i); // 0 1 2 3 4
}

// continue: salta a la siguiente iteración
for (int i = 0; i < 6; i++) {
  if (i % 2 == 0) continue;
  print(i); // 1 3 5
}

// Labels: break/continue en bucles anidados
externo:
for (int i = 0; i < 3; i++) {
  for (int j = 0; j < 3; j++) {
    if (j == 1) continue externo;
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
  // 5. COLECCIONES
  // ─────────────────────────────────────────────
  Topic(
    id: 'collections',
    title: 'Colecciones',
    subtitle: 'List, Set, Map y sus métodos más útiles',
    icon: '📚',
    difficulty: DifficultyLevel.beginner,
    quiz: [
      QuizQuestion(
        question: '¿Cuál es la diferencia principal entre List y Set?',
        options: [
          'List es más rápido que Set',
          'Set no permite elementos duplicados y no garantiza orden; List sí permite duplicados y mantiene orden',
          'Set solo puede contener Strings',
          'No hay diferencia práctica',
        ],
        correctIndex: 1,
        explanation: 'List mantiene el orden de inserción y permite duplicados. Set elimina automáticamente los duplicados y no garantiza un orden específico.',
      ),
      QuizQuestion(
        question: '¿Qué devuelve `[1,2,3].map((x) => x * 2)`?',
        options: [
          'List<int> [2, 4, 6]',
          'Un Iterable<int> (necesitas .toList() para obtener una lista)',
          'void',
          'Set<int> {2, 4, 6}',
        ],
        correctIndex: 1,
        explanation: '`map()` devuelve un `Iterable` perezoso (lazy), no una List. Para obtener una List debes encadenar `.toList()`.',
      ),
      QuizQuestion(
        question: '¿Qué hace el spread operator `...` en colecciones?',
        options: [
          'Crea una copia de la colección',
          'Inserta todos los elementos de otra colección en la nueva',
          'Ordena la colección',
          'Elimina duplicados',
        ],
        correctIndex: 1,
        explanation:
            'El spread operator `...lista` expande todos los elementos de `lista` dentro de la nueva colección.',
      ),
      QuizQuestion(
        question: '¿Cómo accedes de forma segura a una clave de un Map que podría no existir?',
        options: [
          'mapa.get("clave")',
          'mapa["clave"] — nunca lanza error',
          'mapa["clave"] devuelve null si la clave no existe',
          'mapa.find("clave")',
        ],
        correctIndex: 2,
        explanation: 'En Dart, acceder a una clave inexistente en un Map devuelve `null`. Por eso las claves de Map devuelven un tipo nullable: `V?`.',
      ),
      QuizQuestion(
        question: '¿Qué imprime este código?',
        code: '''
var nums = [1, 2, 3, 4, 5];
var resultado = nums
    .where((n) => n.isOdd)
    .map((n) => n * 10)
    .toList();
print(resultado);''',
        options: ['[1, 3, 5]', '[10, 30, 50]', '[10, 20, 30, 40, 50]', '[2, 4]'],
        correctIndex: 1,
        explanation: '`where` filtra los impares → [1, 3, 5]. Luego `map` multiplica cada uno por 10 → [10, 30, 50].',
      ),
    ],
    flashcards: [
      Flashcard(
        front: 'Eliminar duplicados de una List',
        back: 'Convierte la lista a Set (que no admite duplicados) y de vuelta a List.',
        code: 'var sin = [1,2,2,3].toSet().toList(); // [1,2,3]',
      ),
      Flashcard(
        front: 'Operaciones de conjuntos con Set',
        back: 'Set tiene `union`, `intersection` y `difference` para operar conjuntos de forma declarativa.',
        code: 'var a = {1,2,3}; var b = {2,3,4};\na.intersection(b); // {2,3}',
      ),
      Flashcard(
        front: 'Colección `if` y `for`',
        back: 'Dart permite condicionales y bucles dentro de literales de colección para construirlas de forma declarativa.',
        code: 'var menu = [\n  "Inicio",\n  if (esAdmin) "Admin",\n  for (var i in extras) i,\n];',
      ),
      Flashcard(
        front: '`where` vs `map`',
        back: '`where` filtra elementos que cumplen una condición. `map` transforma cada elemento. Ambos devuelven Iterable.',
        code: 'nums.where((n) => n > 3)  // filtra\nnums.map((n) => n * 2)   // transforma',
      ),
    ],
    lessons: [
      Lesson(
        title: 'List',
        sections: [
          LessonSection(
            text: 'Una `List` es una colección ordenada de elementos. Los índices empiezan en 0.',
            code: '''
// Creación
List<int> numeros = [1, 2, 3, 4, 5];
var frutas = <String>['manzana', 'pera', 'uva'];
var vacia = <double>[];

// Acceso y modificación
print(numeros[0]);   // 1
print(numeros.last); // 5
numeros[0] = 10;

// Añadir / eliminar
frutas.add('naranja');
frutas.addAll(['kiwi', 'mango']);
frutas.remove('pera');        // por valor
frutas.removeAt(0);           // por índice
frutas.insert(1, 'ciruela');  // inserta en posición

// Información
print(frutas.length);           // cantidad
print(frutas.isEmpty);          // bool
print(frutas.contains('kiwi')); // bool
print(frutas.indexOf('uva'));   // índice o -1

// Transformaciones
var mayus = frutas.map((f) => f.toUpperCase()).toList();
var conA  = frutas.where((f) => f.contains('a')).toList();
var total = [1,2,3,4,5].reduce((a, b) => a + b); // 15

// Ordenar
numeros.sort(); // ascendente
numeros.sort((a, b) => b.compareTo(a)); // descendente

// Spread operator
var extra = [6, 7, 8];
var combinado = [...numeros, ...extra];
''',
          ),
          LessonSection(
            heading: 'List inmutable',
            code: '''
// Lista no modificable
final fija = List<int>.unmodifiable([1, 2, 3]);
// fija.add(4); ← UnsupportedError en runtime

// Lista de tamaño fijo
var fija2 = List<int>.filled(3, 0); // [0, 0, 0]
fija2[1] = 5; // OK: puedes cambiar valores
// fija2.add(6); ← UnsupportedError
''',
          ),
        ],
      ),
      Lesson(
        title: 'Set',
        sections: [
          LessonSection(
            text: 'Un `Set` es una colección de elementos únicos y sin orden garantizado. Ideal para eliminar duplicados o verificar pertenencia.',
            code: '''
Set<String> colores = {'rojo', 'verde', 'azul'};
var set2 = <int>{1, 2, 3, 3, 2}; // {1, 2, 3} — duplicados eliminados

// Añadir / eliminar
colores.add('amarillo');
colores.remove('verde');

// Contiene
print(colores.contains('rojo')); // true

// Operaciones de conjuntos
var a = {1, 2, 3, 4};
var b = {3, 4, 5, 6};

print(a.union(b));        // {1, 2, 3, 4, 5, 6}
print(a.intersection(b)); // {3, 4}
print(a.difference(b));   // {1, 2}

// Convertir lista con duplicados a Set
var lista = [1, 2, 2, 3, 3, 3];
var sinDuplicados = lista.toSet().toList();
print(sinDuplicados); // [1, 2, 3]
''',
          ),
        ],
      ),
      Lesson(
        title: 'Map',
        sections: [
          LessonSection(
            text:
                'Un `Map` es una colección de pares clave-valor. Las claves son únicas; los valores pueden repetirse.',
            code: '''
// Creación
Map<String, int> edades = {
  'Ana': 25,
  'Luis': 30,
  'Sara': 28,
};

var config = <String, dynamic>{
  'host': 'localhost',
  'puerto': 8080,
  'ssl': false,
};

// Acceso
print(edades['Ana']);            // 25
print(edades['Desconocido']);    // null (clave no existe)

// Acceso seguro con valor por defecto
int edad = edades['Bea'] ?? 0;

// Modificar / añadir
edades['Ana'] = 26;           // actualiza
edades['Pedro'] = 22;         // añade nueva clave

// Eliminar
edades.remove('Luis');

// Información
print(edades.length);              // cantidad de pares
print(edades.containsKey('Sara')); // true
print(edades.containsValue(22));   // true
print(edades.keys.toList());       // ['Ana', 'Sara', 'Pedro']
print(edades.values.toList());     // [26, 28, 22]

// Iterar
edades.forEach((nombre, edad) {
  print('\$nombre tiene \$edad años');
});

// map() en un Map
var mayus = edades.map((k, v) => MapEntry(k.toUpperCase(), v));
''',
          ),
        ],
      ),
      Lesson(
        title: 'Colecciones y null safety',
        sections: [
          LessonSection(
            code: '''
// Lista de elementos nullable
List<String?> nombres = ['Ana', null, 'Luis'];
for (var n in nombres) {
  print(n?.toUpperCase() ?? 'SIN NOMBRE');
}

// Eliminar nulls
var sinNulos = nombres.whereType<String>().toList();
print(sinNulos); // ['Ana', 'Luis']

// Spread condicional
List<int>? extras;
var base = [1, 2, 3, ...?extras]; // ...? ignora si es null
print(base); // [1, 2, 3]

// Colección if / for
var mostrarAdmin = true;
var menu = [
  'Inicio',
  'Perfil',
  if (mostrarAdmin) 'Admin',
];

var cuadrados = [
  for (var i = 1; i <= 5; i++) i * i,
];
print(cuadrados); // [1, 4, 9, 16, 25]
''',
          ),
        ],
      ),
    ],
  ),

  // ─────────────────────────────────────────────
  // 6. CLASES Y POO
  // ─────────────────────────────────────────────
  Topic(
    id: 'oop',
    title: 'Clases y POO',
    subtitle: 'Constructores, getters/setters, métodos estáticos',
    icon: '🧱',
    difficulty: DifficultyLevel.intermediate,
    quiz: [
      QuizQuestion(
        question: '¿Qué hace `Persona(this.nombre, this.edad)` en un constructor?',
        options: [
          'Crea getters automáticos',
          'Es un initializing formal: asigna el parámetro directamente al campo con el mismo nombre',
          'Declara los campos como static',
          'Es equivalente a un constructor factory',
        ],
        correctIndex: 1,
        explanation: '`this.campo` en los parámetros del constructor es un "initializing formal": Dart asigna automáticamente el valor del parámetro al campo correspondiente.',
      ),
      QuizQuestion(
        question: '¿Cuándo usar un constructor `factory`?',
        options: [
          'Cuando necesitas más de un constructor',
          'Cuando el constructor debe devolver una instancia ya existente (caché, singleton) o un subtipo',
          'Solo para clases abstractas',
          'Para constructores privados',
        ],
        correctIndex: 1,
        explanation: 'Un constructor `factory` puede retornar cualquier instancia del tipo o sus subtipos, no solo `new`. Ideal para Singleton, pool de objetos o factory method.',
      ),
      QuizQuestion(
        question: '¿Qué diferencia a un getter de un método normal?',
        options: [
          'Los getters son siempre estáticos',
          'Un getter se accede como propiedad (sin paréntesis), un método requiere paréntesis',
          'Los getters no pueden hacer cálculos',
          'No hay diferencia práctica',
        ],
        correctIndex: 1,
        explanation: 'Los getters se acceden como `objeto.propiedad` sin paréntesis. Son útiles para propiedades calculadas que no tienen estado propio.',
      ),
    ],
    flashcards: [
      Flashcard(
        front: 'Constructor con nombre',
        back: 'Permite tener múltiples constructores con distintos nombres, cada uno con su lógica de inicialización.',
        code: 'Punto.origen() : x = 0, y = 0;\nPunto.desde(Punto p) : x = p.x, y = p.y;',
      ),
      Flashcard(
        front: 'const constructor',
        back: 'Si todos los campos son `final` y el constructor es `const`, Dart puede reutilizar la misma instancia en memoria para valores idénticos.',
        code: 'const c1 = Color(255,0,0);\nconst c2 = Color(255,0,0);\nidentical(c1, c2); // true',
      ),
      Flashcard(
        front: 'Getter calculado',
        back: 'Un getter es una propiedad que se calcula a partir de otros campos. Se declara con `get` y se accede sin paréntesis.',
        code: 'double get area => _ancho * _alto;',
      ),
      Flashcard(
        front: 'Miembros estáticos',
        back: 'Pertenecen a la clase, no a las instancias. Se acceden con `NombreClase.miembro`, no con `objeto.miembro`.',
        code: 'MathUtils.pi       // OK\nMathUtils().pi     // Error',
      ),
    ],
    lessons: [
      Lesson(
        title: 'Declaración de clases',
        sections: [
          LessonSection(
            code: '''
class Persona {
  // Propiedades
  String nombre;
  int edad;

  // Constructor
  Persona(this.nombre, this.edad);

  // Método
  String presentarse() => 'Soy \$nombre y tengo \$edad años.';

  // toString para impresión legible
  @override
  String toString() => 'Persona(\$nombre, \$edad)';
}

var p = Persona('Ana', 25);
print(p.presentarse()); // Soy Ana y tengo 25 años.
print(p);              // Persona(Ana, 25)
''',
          ),
        ],
      ),
      Lesson(
        title: 'Tipos de constructores',
        sections: [
          LessonSection(
            heading: 'Constructor con nombre',
            code: '''
class Punto {
  final double x;
  final double y;

  // Constructor principal
  Punto(this.x, this.y);

  // Constructor con nombre
  Punto.origen() : x = 0, y = 0;
  Punto.desde(Punto otro) : x = otro.x, y = otro.y;

  @override
  String toString() => 'Punto(\$x, \$y)';
}

var p1 = Punto(3, 4);
var p2 = Punto.origen(); // Punto(0.0, 0.0)
var p3 = Punto.desde(p1); // Punto(3.0, 4.0)
''',
          ),
          LessonSection(
            heading: 'Constructor factory',
            text: 'Un constructor `factory` puede devolver instancias ya existentes (caché, singleton) o subtipos.',
            code: '''
class Logger {
  static final Logger _instancia = Logger._interno();

  Logger._interno(); // Constructor privado

  factory Logger() => _instancia; // Siempre devuelve la misma instancia

  void log(String msg) => print('[LOG] \$msg');
}

var a = Logger();
var b = Logger();
print(identical(a, b)); // true — misma instancia (Singleton)
a.log('Hola');
''',
          ),
          LessonSection(
            heading: 'const constructors',
            code: '''
class Color {
  final int r, g, b;

  const Color(this.r, this.g, this.b);

  static const rojo  = Color(255, 0, 0);
  static const verde = Color(0, 255, 0);
  static const azul  = Color(0, 0, 255);
}

// Con const, Dart reutiliza la misma instancia en memoria
const c1 = Color(255, 0, 0);
const c2 = Color(255, 0, 0);
print(identical(c1, c2)); // true
''',
          ),
        ],
      ),
      Lesson(
        title: 'Getters, Setters y miembros estáticos',
        sections: [
          LessonSection(
            heading: 'Getters y Setters',
            code: '''
class Rectangulo {
  double _ancho;
  double _alto;

  Rectangulo(this._ancho, this._alto);

  // Getter
  double get area => _ancho * _alto;
  double get perimetro => 2 * (_ancho + _alto);

  // Setter con validación
  set ancho(double valor) {
    if (valor <= 0) throw ArgumentError('El ancho debe ser positivo');
    _ancho = valor;
  }

  double get ancho => _ancho;
}

var rect = Rectangulo(5, 3);
print(rect.area);      // 15.0
print(rect.perimetro); // 16.0
rect.ancho = 10;
print(rect.area);      // 30.0
// rect.ancho = -1; ← ArgumentError
''',
          ),
          LessonSection(
            heading: 'Miembros estáticos',
            code: '''
class MathUtils {
  static const double pi = 3.14159265358979;

  // Método estático: se llama en la clase, no en instancias
  static double circunferencia(double radio) => 2 * pi * radio;
  static double areaCirculo(double radio) => pi * radio * radio;
}

print(MathUtils.pi);
print(MathUtils.circunferencia(5)); // 31.4159...
print(MathUtils.areaCirculo(5));    // 78.5398...

// MathUtils().pi ← No se puede: static pertenece a la clase
''',
          ),
        ],
      ),
    ],
  ),

  // ─────────────────────────────────────────────
  // 7. HERENCIA Y MIXINS
  // ─────────────────────────────────────────────
  Topic(
    id: 'inheritance',
    title: 'Herencia y Mixins',
    subtitle: 'extends, super, override, abstract y with',
    icon: '🧬',
    difficulty: DifficultyLevel.intermediate,
    quiz: [
      QuizQuestion(
        question: '¿Cuántas clases puede extender una clase en Dart?',
        options: ['Ilimitadas', 'Dos', 'Solo una', 'Tres como máximo'],
        correctIndex: 2,
        explanation: 'Dart no soporta herencia múltiple. Una clase solo puede extender una clase base con `extends`. Para reutilizar código de múltiples fuentes, usa mixins.',
      ),
      QuizQuestion(
        question: '¿Cuál es la diferencia entre `extends` e `implements`?',
        options: [
          'Son equivalentes',
          '`extends` hereda implementación; `implements` solo contrata la interfaz (debes reimplementar todo)',
          '`implements` hereda implementación; `extends` solo la interfaz',
          '`extends` es para clases abstractas; `implements` para concretas',
        ],
        correctIndex: 1,
        explanation: 'Con `extends` heredas los métodos implementados. Con `implements` solo adoptas la interfaz: debes implementar todos los miembros desde cero.',
      ),
      QuizQuestion(
        question: '¿Qué ventaja tienen los mixins sobre la herencia múltiple?',
        options: [
          'Son más rápidos en ejecución',
          'Permiten reutilizar código en múltiples clases sin los problemas del diamante de herencia múltiple',
          'Permiten acceder a campos privados',
          'Los mixins reemplazan completamente a la herencia',
        ],
        correctIndex: 1,
        explanation: 'Los mixins permiten compartir comportamiento entre clases sin requerir herencia. Dart resuelve los conflictos con una linearización determinista.',
      ),
    ],
    flashcards: [
      Flashcard(
        front: '`extends` vs `implements` vs `with`',
        back: '`extends`: hereda implementación (una sola clase).\n`implements`: adopta interfaz (sin heredar código, múltiple).\n`with`: mezcla comportamiento de un mixin.',
      ),
      Flashcard(
        front: 'Clase abstracta',
        back: 'No puede instanciarse directamente. Define métodos abstractos (sin cuerpo) que las subclases deben implementar. Puede tener métodos concretos.',
        code: 'abstract class Forma {\n  double area(); // abstracto\n  void describir() => print(area()); // concreto\n}',
      ),
      Flashcard(
        front: 'Mixin con restricción `on`',
        back: 'Con `on ClaseBase`, el mixin solo puede aplicarse a subclases de esa base. Garantiza que ciertos métodos existen.',
        code: 'mixin Domesticable on Animal {\n  void adoptar(String duenio) {}\n}',
      ),
      Flashcard(
        front: '`super` en constructores',
        back: 'Llama al constructor del padre. Con la sintaxis moderna `super.parametro` el argumento se pasa al padre directamente.',
        code: 'class Perro extends Animal {\n  Perro(super.nombre, super.edad, this.raza);\n}',
      ),
    ],
    lessons: [
      Lesson(
        title: 'Herencia con extends',
        sections: [
          LessonSection(
            code: '''
class Animal {
  String nombre;
  int edad;

  Animal(this.nombre, this.edad);

  void respirar() => print('\$nombre respira');
  void dormir()   => print('\$nombre duerme');

  @override
  String toString() => '\$nombre (\$edad años)';
}

class Perro extends Animal {
  String raza;

  // super llama al constructor del padre
  Perro(super.nombre, super.edad, this.raza);

  // Override: redefinir el comportamiento
  @override
  void respirar() {
    super.respirar(); // Llama al original
    print('... y jadea');
  }

  void ladrar() => print('\$nombre: ¡Guau!');
}

var rex = Perro('Rex', 3, 'Labrador');
rex.ladrar();   // Rex: ¡Guau!
rex.respirar(); // Rex respira \n ... y jadea
rex.dormir();   // Rex duerme (heredado)
print(rex);     // Rex (3 años)

// Comprobación de tipos
print(rex is Perro);  // true
print(rex is Animal); // true
''',
          ),
        ],
      ),
      Lesson(
        title: 'Clases abstractas e interfaces',
        sections: [
          LessonSection(
            heading: 'Clase abstracta',
            text: 'No se puede instanciar directamente. Define una plantilla con métodos que las subclases deben implementar.',
            code: '''
abstract class Forma {
  // Método abstracto: sin implementación
  double area();
  double perimetro();

  // Método concreto: con implementación
  void describir() => print('Área: \${area()}, Perímetro: \${perimetro()}');
}

class Circulo extends Forma {
  final double radio;
  Circulo(this.radio);

  @override
  double area() => 3.14159 * radio * radio;

  @override
  double perimetro() => 2 * 3.14159 * radio;
}

var c = Circulo(5);
c.describir(); // Área: 78.53..., Perímetro: 31.41...
''',
          ),
          LessonSection(
            heading: 'Interfaces con implements',
            text: 'En Dart cualquier clase puede usarse como interfaz con `implements`. Debes implementar TODOS sus miembros.',
            code: '''
class Volador {
  void volar() => print('Volando genéricamente');
}

class Nadador {
  void nadar() => print('Nadando genéricamente');
}

// Pato implementa ambas interfaces
class Pato implements Volador, Nadador {
  @override
  void volar() => print('Pato vuela bajo');

  @override
  void nadar() => print('Pato nada en el estanque');
}

var pato = Pato();
pato.volar(); // Pato vuela bajo
pato.nadar(); // Pato nada en el estanque
''',
          ),
        ],
      ),
      Lesson(
        title: 'Mixins',
        sections: [
          LessonSection(
            text: 'Un `mixin` es un bloque de código reutilizable que puedes "mezclar" en una clase sin herencia. Soluciona el problema del "diamante" de la herencia múltiple.',
            code: '''
mixin Serializable {
  Map<String, dynamic> toJson();

  String toJsonString() {
    return toJson().toString();
  }
}

mixin Validable {
  bool esValido();

  void validar() {
    if (!esValido()) throw Exception('Objeto inválido');
  }
}

class Usuario with Serializable, Validable {
  final String email;
  final String nombre;

  Usuario(this.email, this.nombre);

  @override
  Map<String, dynamic> toJson() => {
    'email': email,
    'nombre': nombre,
  };

  @override
  bool esValido() => email.contains('@') && nombre.isNotEmpty;
}

var u = Usuario('ana@ejemplo.com', 'Ana');
u.validar();               // OK
print(u.toJsonString());   // {email: ana@ejemplo.com, nombre: Ana}
''',
          ),
          LessonSection(
            heading: 'on — restringir un mixin',
            code: '''
// Este mixin solo puede usarse en subclases de Animal
mixin Domesticable on Animal {
  String? duenio;

  void adoptar(String nombre) {
    duenio = nombre;
    print('\${this.nombre} fue adoptado por \$duenio');
  }
}

class Gato extends Animal with Domesticable {
  Gato(super.nombre, super.edad);
}

var gato = Gato('Whiskers', 2);
gato.adoptar('María'); // Whiskers fue adoptado por María
''',
          ),
        ],
      ),
    ],
  ),

  // ─────────────────────────────────────────────
  // 8. GENÉRICOS
  // ─────────────────────────────────────────────
  Topic(
    id: 'generics',
    title: 'Genéricos',
    subtitle: 'Tipos parametrizados para código reutilizable y seguro',
    icon: '🔧',
    difficulty: DifficultyLevel.intermediate,
    quiz: [
      QuizQuestion(
        question: '¿Qué significa `<T extends Comparable<T>>`?',
        options: [
          'T debe ser una clase concreta',
          'T debe implementar la interfaz Comparable, lo que garantiza que tiene el método compareTo',
          'T solo puede ser int o String',
          'T no puede ser null',
        ],
        correctIndex: 1,
        explanation: '`extends` en un parámetro de tipo es una restricción: T debe ser un tipo que implementa `Comparable<T>`. Esto garantiza que puedes llamar `compareTo` en valores de tipo T.',
      ),
      QuizQuestion(
        question: '¿Cuál es la ventaja de los genéricos frente a usar `dynamic`?',
        options: [
          'Los genéricos son más lentos pero más seguros',
          'Con genéricos, el compilador verifica los tipos, mientras que `dynamic` desactiva esa verificación',
          'No hay diferencia real',
          'Los genéricos solo funcionan con colecciones',
        ],
        correctIndex: 1,
        explanation: 'Los genéricos permiten escribir código reutilizable manteniendo la seguridad de tipos en tiempo de compilación. `dynamic` sacrifica esa seguridad.',
      ),
    ],
    flashcards: [
      Flashcard(
        front: '¿Qué es un tipo genérico?',
        back: 'Un tipo parametrizado que funciona con cualquier tipo T especificado al usarse. Permite escribir código reutilizable con seguridad de tipos.',
        code: 'class Caja<T> {\n  T contenido;\n  Caja(this.contenido);\n}',
      ),
      Flashcard(
        front: 'Convención de nombres de parámetros de tipo',
        back: 'T: tipo genérico general.\nE: elemento (en colecciones).\nK, V: clave y valor (en Map).\nR: tipo de retorno.',
      ),
      Flashcard(
        front: 'Restricción de tipo con `extends`',
        back: 'Limita qué tipos pueden usarse como parámetro de tipo, garantizando que ciertos métodos existen.',
        code: 'T max<T extends Comparable<T>>(T a, T b)\n  => a.compareTo(b) >= 0 ? a : b;',
      ),
    ],
    lessons: [
      Lesson(
        title: 'Clases y funciones genéricas',
        sections: [
          LessonSection(
            text: 'Los genéricos permiten escribir código que funciona con distintos tipos manteniendo la seguridad de tipos. `List<T>`, `Map<K,V>` son genéricos que ya usas.',
          ),
          LessonSection(
            heading: 'Clase genérica',
            code: '''
// T es un parámetro de tipo (convención: T, E, K, V, R)
class Caja<T> {
  T contenido;

  Caja(this.contenido);

  T obtener() => contenido;

  void guardar(T nuevo) => contenido = nuevo;

  @override
  String toString() => 'Caja<\${T}>(contenido: \$contenido)';
}

var cajaInt    = Caja<int>(42);
var cajaString = Caja<String>('Hola');
var cajaDoble  = Caja(3.14); // Dart infiere Caja<double>

print(cajaInt.obtener());    // 42
print(cajaString.obtener()); // Hola

// cajaInt.guardar('texto'); ← ERROR: esperaba int
''',
          ),
          LessonSection(
            heading: 'Función genérica',
            code: '''
// Función que trabaja con cualquier tipo
T primero<T>(List<T> lista) {
  if (lista.isEmpty) throw StateError('Lista vacía');
  return lista.first;
}

print(primero([1, 2, 3]));       // 1
print(primero(['a', 'b', 'c'])); // a

// Dos parámetros de tipo
Map<K, V> combinar<K, V>(List<K> claves, List<V> valores) {
  assert(claves.length == valores.length);
  return Map.fromIterables(claves, valores);
}

var mapa = combinar(['a', 'b'], [1, 2]);
print(mapa); // {a: 1, b: 2}
''',
          ),
          LessonSection(
            heading: 'Restricciones con extends',
            code: '''
// T debe extender Comparable (tener método compareTo)
T maximo<T extends Comparable<T>>(T a, T b) {
  return a.compareTo(b) >= 0 ? a : b;
}

print(maximo(3, 7));       // 7
print(maximo('abc', 'xy')); // xy (comparación lexicográfica)

// Con clase propia
abstract class Puntuable {
  int get puntos;
}

class Jugador extends Puntuable {
  final String nombre;
  @override
  final int puntos;
  Jugador(this.nombre, this.puntos);
}

T ganador<T extends Puntuable>(T a, T b) {
  return a.puntos >= b.puntos ? a : b;
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
    subtitle: 'Future, async, await y manejo de operaciones asíncronas',
    icon: '⏳',
    difficulty: DifficultyLevel.intermediate,
    quiz: [
      QuizQuestion(
        question: '¿Qué tipo devuelve siempre una función marcada como `async`?',
        options: ['void', 'dynamic', 'Future<T>', 'Stream<T>'],
        correctIndex: 2,
        explanation: 'Toda función `async` devuelve un `Future`. Si el cuerpo devuelve `T`, la función devuelve `Future<T>`. Si devuelve `void`, devuelve `Future<void>`.',
      ),
      QuizQuestion(
        question: '¿Para qué sirve `Future.wait()`?',
        options: [
          'Para esperar un Future con timeout',
          'Para ejecutar varios Futures en paralelo y esperar a que todos completen',
          'Para cancelar un Future',
          'Para convertir un Future en Stream',
        ],
        correctIndex: 1,
        explanation: '`Future.wait([f1, f2, f3])` lanza todos los Futures en paralelo y devuelve un Future que completa cuando todos han terminado. Es mucho más eficiente que `await`-arlos en serie.',
      ),
      QuizQuestion(
        question: '¿Cuál es la forma correcta de capturar errores en código async/await?',
        options: [
          '.onError()',
          'No se pueden capturar errores en async',
          'try/catch alrededor del await',
          'Solo con .catchError()',
        ],
        correctIndex: 2,
        explanation: 'En código async/await, se usa `try/catch` igual que en código síncrono. Es más legible que `.catchError()` y soporta múltiples tipos de error con `on`.',
      ),
    ],
    flashcards: [
      Flashcard(
        front: '¿Qué es un Future?',
        back: 'Representa un valor que estará disponible en el futuro. Puede estar en tres estados: incompleto, completo con valor, o completo con error.',
        code: 'Future<String> nombre = Future.value("Ana");',
      ),
      Flashcard(
        front: '`async` / `await`',
        back: 'Azúcar sintáctico sobre Futures. `await` "pausa" la función hasta que el Future completa, haciendo el código asíncrono tan legible como el síncrono.',
        code: 'Future<void> main() async {\n  String s = await obtenerDatos();\n  print(s);\n}',
      ),
      Flashcard(
        front: 'Ejecución paralela vs serie',
        back: 'Varios `await` seguidos = serie (lento). `Future.wait([...])` = paralelo (rápido). Usa paralelo cuando los Futures son independientes.',
        code: '// Serie: 2s\nvar a = await f1(); var b = await f2();\n// Paralelo: 1s\nvar [a,b] = await Future.wait([f1(), f2()]);',
      ),
    ],
    lessons: [
      Lesson(
        title: '¿Qué es un Future?',
        sections: [
          LessonSection(
            text: 'Un `Future<T>` representa un valor que estará disponible en el futuro. Es como una "promesa" de que en algún momento tendrás un resultado de tipo T (o un error).',
            code: '''
// Future simple
Future<String> obtenerNombre() {
  return Future.value('Ana'); // Resuelto inmediatamente
}

// Future con delay (simulando una llamada a red)
Future<int> calcularTarde() {
  return Future.delayed(
    Duration(seconds: 2),
    () => 42, // Devuelve 42 después de 2 segundos
  );
}

// Escuchar el resultado con .then() y .catchError()
obtenerNombre().then((nombre) {
  print('Nombre: \$nombre');
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
            text: '`async/await` es azúcar sintáctico sobre Futures. Permite escribir código asíncrono con apariencia síncrona, mucho más legible.',
            code: '''
// Una función async siempre devuelve un Future
Future<String> obtenerUsuario(int id) async {
  // Simulamos una llamada a base de datos
  await Future.delayed(Duration(milliseconds: 500));
  return 'Usuario #\$id';
}

Future<void> main() async {
  print('Iniciando...');

  // await "pausa" la ejecución hasta que el Future resuelve
  String usuario = await obtenerUsuario(1);
  print(usuario); // Usuario #1

  // Puedes encadenar awaits
  String u2 = await obtenerUsuario(2);
  print(u2); // Usuario #2

  print('Fin');
}
// Iniciando...
// Usuario #1
// Usuario #2
// Fin
''',
          ),
          LessonSection(
            heading: 'Ejecución paralela con Future.wait',
            code: '''
Future<String> obtenerNombre() async {
  await Future.delayed(Duration(seconds: 1));
  return 'Ana';
}

Future<int> obtenerEdad() async {
  await Future.delayed(Duration(seconds: 1));
  return 25;
}

// Secuencial: tarda ~2 segundos
Future<void> secuencial() async {
  var nombre = await obtenerNombre();
  var edad   = await obtenerEdad();
  print('\$nombre, \$edad');
}

// Paralelo: tarda ~1 segundo
Future<void> paralelo() async {
  var resultados = await Future.wait([
    obtenerNombre(),
    obtenerEdad(),
  ]);
  print('\${resultados[0]}, \${resultados[1]}');
}
''',
            note: 'Usa `Future.wait` cuando tengas múltiples operaciones independientes. Es mucho más eficiente que ejecutarlas en serie.',
          ),
          LessonSection(
            heading: 'Manejo de errores en async',
            code: '''
Future<String> obtenerDatos(String url) async {
  if (url.isEmpty) {
    throw ArgumentError('URL no puede estar vacía');
  }
  await Future.delayed(Duration(milliseconds: 100));
  return 'Datos de \$url';
}

Future<void> main() async {
  // Con try/catch (recomendado)
  try {
    var datos = await obtenerDatos('');
    print(datos);
  } catch (e) {
    print('Error capturado: \$e');
    // Error capturado: Invalid argument(s): URL no puede estar vacía
  }

  // With onError
  var resultado = await obtenerDatos('https://api.com')
    .catchError((e) => 'Valor por defecto');
  print(resultado);
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
    subtitle: 'Flujos de datos asíncronos, StreamController y transformaciones',
    icon: '🌊',
    difficulty: DifficultyLevel.advanced,
    quiz: [
      QuizQuestion(
        question: '¿En qué se diferencia un Stream de un Future?',
        options: [
          'Un Stream es más rápido',
          'Un Future emite un único valor; un Stream puede emitir múltiples valores a lo largo del tiempo',
          'Un Stream no puede emitir errores',
          'No hay diferencia práctica',
        ],
        correctIndex: 1,
        explanation: 'Future: 0 o 1 valor en el futuro. Stream: secuencia de 0 a N valores a lo largo del tiempo. Los Streams pueden también emitir eventos de error.',
      ),
      QuizQuestion(
        question: '¿Qué hace `yield` en un generador asíncrono (`async*`)?',
        options: [
          'Termina la función',
          'Emite un valor al Stream sin terminar la función',
          'Es equivalente a `return`',
          'Pausa indefinidamente la función',
        ],
        correctIndex: 1,
        explanation: '`yield` emite un valor al Stream y "pausa" la función hasta que el consumidor pida el siguiente valor. La función continúa desde donde se quedó.',
      ),
    ],
    flashcards: [
      Flashcard(
        front: 'Stream de un solo suscriptor vs broadcast',
        back: 'Stream normal: solo un suscriptor a la vez. Broadcast stream: múltiples suscriptores simultáneos. Un StreamController normal crea el primero; usa `StreamController.broadcast()` para el segundo.',
      ),
      Flashcard(
        front: 'Generador asíncrono `async*`',
        back: 'Una función `async*` devuelve un Stream. Usa `yield` para emitir valores y `await` para esperar operaciones asíncronas entre emisiones.',
        code: 'Stream<int> contador() async* {\n  for (int i = 0; i < 5; i++) {\n    await Future.delayed(Duration(seconds: 1));\n    yield i;\n  }\n}',
      ),
      Flashcard(
        front: 'Transformaciones de Stream',
        back: 'Los Streams tienen `map`, `where`, `take`, `skip` igual que los Iterables, pero de forma asíncrona.',
        code: 'stream.where((n) => n.isEven).map((n) => n * 2)',
      ),
    ],
    lessons: [
      Lesson(
        title: '¿Qué es un Stream?',
        sections: [
          LessonSection(
            text: 'Si un `Future` emite un solo valor en el futuro, un `Stream` emite múltiples valores a lo largo del tiempo. Piensa en él como una tubería por donde fluyen datos.',
            code: '''
// Stream simple de enteros
Stream<int> contarHasta5() async* {
  // async* define un generador asíncrono
  for (int i = 1; i <= 5; i++) {
    await Future.delayed(Duration(milliseconds: 200));
    yield i; // yield emite un valor al stream
  }
}

Future<void> main() async {
  // await for: escucha el stream de forma asíncrona
  await for (var numero in contarHasta5()) {
    print(numero); // 1 2 3 4 5 (con pausas)
  }
  print('Stream completado');
}
''',
          ),
          LessonSection(
            heading: 'StreamController',
            text: 'Para casos más complejos, usa `StreamController` para emitir eventos manualmente.',
            code: '''
import 'dart:async';

Future<void> main() async {
  var controller = StreamController<String>();

  // Escuchar el stream
  controller.stream.listen(
    (dato) => print('Recibido: \$dato'),
    onError: (e) => print('Error: \$e'),
    onDone: () => print('Stream cerrado'),
  );

  // Emitir datos
  controller.add('Primero');
  controller.add('Segundo');
  controller.addError('algo salió mal');
  controller.add('Tercero');
  controller.close(); // Cierra el stream

  await Future.delayed(Duration(milliseconds: 100));
}
''',
          ),
          LessonSection(
            heading: 'Transformaciones de Stream',
            code: '''
Stream<int> numeros() async* {
  for (int i = 1; i <= 10; i++) yield i;
}

Future<void> main() async {
  var stream = numeros();

  // map: transforma cada elemento
  await for (var n in stream.map((x) => x * x)) {
    print(n); // 1 4 9 16 25 36 49 64 81 100
  }

  // where: filtra elementos
  await for (var n in numeros().where((x) => x % 2 == 0)) {
    print(n); // 2 4 6 8 10
  }

  // take: solo los primeros N
  await for (var n in numeros().take(3)) {
    print(n); // 1 2 3
  }

  // Convertir a lista
  var lista = await numeros().toList();
  print(lista); // [1, 2, ..., 10]
}
''',
          ),
        ],
      ),
    ],
  ),

  // ─────────────────────────────────────────────
  // 11. MANEJO DE ERRORES
  // ─────────────────────────────────────────────
  Topic(
    id: 'error_handling',
    title: 'Manejo de Errores',
    subtitle: 'try/catch/finally, Exception, Error y errores personalizados',
    icon: '🚨',
    difficulty: DifficultyLevel.intermediate,
    quiz: [
      QuizQuestion(
        question: '¿Se ejecuta `finally` si el código en `try` lanza una excepción?',
        options: [
          'No, finally solo se ejecuta en el camino exitoso',
          'Sí, finally siempre se ejecuta independientemente de si hubo error o no',
          'Depende del tipo de excepción',
          'Solo si hay un `catch` que capture la excepción',
        ],
        correctIndex: 1,
        explanation: '`finally` se ejecuta SIEMPRE: si el try termina bien, si lanza una excepción capturada, o si lanza una no capturada. Es ideal para liberar recursos.',
      ),
      QuizQuestion(
        question: '¿Cuál es la diferencia entre `Exception` y `Error` en Dart?',
        options: [
          'Son sinónimos',
          'Exception: condición recuperable esperada. Error: fallo de programación que no debería ocurrir.',
          'Error: condición recuperable. Exception: fallo grave.',
          'Exception solo se usa en async',
        ],
        correctIndex: 1,
        explanation: 'En Dart, `Exception` representa situaciones que el programa puede anticipar (red, formato). `Error` representa bugs de programación (índice fuera de rango, null inesperado).',
      ),
      QuizQuestion(
        question: '¿Qué hace `on FormatException catch (e)`?',
        options: [
          'Captura cualquier excepción',
          'Captura solo excepciones de tipo FormatException',
          'Relanza la excepción',
          'Es un bloque finally especial',
        ],
        correctIndex: 1,
        explanation: 'La cláusula `on Tipo` filtra por tipo de excepción. Solo se ejecuta si la excepción lanzada es de ese tipo o subtipo.',
      ),
    ],
    flashcards: [
      Flashcard(
        front: 'Estructura try/catch/finally',
        back: 'try: código que puede fallar.\non/catch: maneja tipos específicos de error.\nfinally: siempre se ejecuta (liberar recursos, cerrar conexiones).',
      ),
      Flashcard(
        front: 'Crear excepciones personalizadas',
        back: 'Implementa `Exception` para errores de dominio de tu app. Añade campos informativos y sobrescribe `toString`.',
        code: 'class SaldoInsuficiente implements Exception {\n  final double saldo, monto;\n  SaldoInsuficiente(this.saldo, this.monto);\n}',
      ),
      Flashcard(
        front: '`on` vs `catch`',
        back: '`on TipoError`: captura ese tipo sin acceder al objeto error.\n`catch (e)`: accede al objeto error.\n`on TipoError catch (e)`: ambos juntos.',
      ),
    ],
    lessons: [
      Lesson(
        title: 'try / catch / finally',
        sections: [
          LessonSection(
            code: '''
void dividir(int a, int b) {
  try {
    if (b == 0) throw ArgumentError('No se puede dividir por cero');
    print(a ~/ b); // División entera
  } on ArgumentError catch (e) {
    // Captura solo ArgumentError
    print('Argumento inválido: \${e.message}');
  } on RangeError catch (e, stackTrace) {
    // También puedes capturar el stack trace
    print('Fuera de rango: \$e');
    print(stackTrace);
  } catch (e) {
    // Captura cualquier otro error
    print('Error desconocido: \$e');
  } finally {
    // Siempre se ejecuta, haya error o no
    print('Operación terminada');
  }
}

dividir(10, 2);  // 5 \n Operación terminada
dividir(10, 0);  // Argumento inválido... \n Operación terminada
''',
          ),
        ],
      ),
      Lesson(
        title: 'Exception vs Error',
        sections: [
          LessonSection(
            text: 'Dart diferencia entre `Exception` (condición recuperable esperada) y `Error` (fallo de programación, nunca debería ocurrir en producción).',
            code: '''
// Exceptions: condiciones que el programa PUEDE anticipar
// FormatException, IOException, TimeoutException...
try {
  int n = int.parse('abc'); // FormatException
} on FormatException {
  print('Formato inválido');
}

// Errors: bugs en el código
// RangeError, ArgumentError, StateError, NullPointerError...
try {
  var lista = [1, 2, 3];
  print(lista[10]); // RangeError: índice fuera de rango
} on RangeError catch (e) {
  print('Índice inválido: \$e');
}
''',
          ),
          LessonSection(
            heading: 'Excepciones personalizadas',
            code: '''
// Implementa Exception para errores del dominio de tu app
class SaldoInsuficienteException implements Exception {
  final double saldo;
  final double monto;

  SaldoInsuficienteException({required this.saldo, required this.monto});

  @override
  String toString() =>
      'SaldoInsuficiente: intentaste retirar \$monto pero solo tienes \$saldo';
}

class CuentaBancaria {
  double _saldo;

  CuentaBancaria(this._saldo);

  void retirar(double monto) {
    if (monto > _saldo) {
      throw SaldoInsuficienteException(saldo: _saldo, monto: monto);
    }
    _saldo -= monto;
    print('Retiro exitoso. Saldo: \$_saldo');
  }
}

void main() {
  var cuenta = CuentaBancaria(100);
  try {
    cuenta.retirar(150);
  } on SaldoInsuficienteException catch (e) {
    print(e); // SaldoInsuficiente: intentaste retirar 150.0 pero...
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
    subtitle: 'Enumeraciones simples y enhanced enums de Dart 2.17',
    icon: '🏷️',
    difficulty: DifficultyLevel.intermediate,
    quiz: [
      QuizQuestion(
        question: '¿Qué propiedad de un enum devuelve su nombre como String?',
        options: ['.toString()', '.name', '.label', '.identifier'],
        correctIndex: 1,
        explanation: 'La propiedad `.name` devuelve el nombre del valor del enum como String. Por ejemplo, `Estado.activo.name` devuelve `"activo"`.',
      ),
      QuizQuestion(
        question: '¿Qué es un Enhanced Enum (Dart 2.17+)?',
        options: [
          'Un enum que puede tener null como valor',
          'Un enum con propiedades, constructores y métodos propios',
          'Un enum que hereda de otra clase',
          'Un enum que puede modificarse en runtime',
        ],
        correctIndex: 1,
        explanation: 'Los Enhanced Enums de Dart 2.17 permiten añadir campos, constructores const y métodos a las enumeraciones, convirtiéndolas en tipos más ricos.',
      ),
      QuizQuestion(
        question: 'En Dart 3, ¿qué ventaja tiene el switch exhaustivo con enums?',
        options: [
          'Es más rápido',
          'El compilador detecta si faltan casos en el switch, evitando casos no cubiertos',
          'Permite modificar los valores del enum',
          'Solo funciona con enums simples',
        ],
        correctIndex: 1,
        explanation: 'En Dart 3, el switch sobre enums es exhaustivo: el compilador da error si no cubres todos los valores posibles del enum (o tienes un caso `_` por defecto).',
      ),
    ],
    flashcards: [
      Flashcard(
        front: 'Propiedades útiles de un enum',
        back: '`.name`: nombre como String.\n`.index`: posición (0-based).\n`Enum.values`: lista de todos los valores.',
        code: 'Estado.activo.name;  // "activo"\nEstado.activo.index; // 0\nEstado.values;       // [activo, inactivo, ...]',
      ),
      Flashcard(
        front: 'Enhanced Enum con propiedades',
        back: 'Dart 2.17+ permite añadir campos y métodos a los enums. El constructor debe ser `const`.',
        code: 'enum Planeta {\n  tierra(masaKg: 5.97e24);\n  final double masaKg;\n  const Planeta({required this.masaKg});\n}',
      ),
      Flashcard(
        front: 'Enum implementando interfaz',
        back: 'Un enum puede implementar interfaces y sobrescribir sus métodos, uno por cada valor del enum.',
        code: 'enum Semaforo implements Describible {\n  rojo, verde;\n  @override\n  String describir() => switch(this) { .rojo => "Stop", _ => "Go" };\n}',
      ),
    ],
    lessons: [
      Lesson(
        title: 'Enums básicos',
        sections: [
          LessonSection(
            code: '''
enum Estado { activo, inactivo, pendiente, bloqueado }

enum Direccion { norte, sur, este, oeste }

void main() {
  var estado = Estado.activo;

  // Comparación
  if (estado == Estado.activo) {
    print('El usuario está activo');
  }

  // switch exhaustivo (Dart 3 detecta casos faltantes)
  switch (estado) {
    case Estado.activo:
      print('Online');
    case Estado.inactivo:
      print('Offline');
    case Estado.pendiente:
      print('Esperando verificación');
    case Estado.bloqueado:
      print('Cuenta bloqueada');
  }

  // Propiedades útiles
  print(estado.name);  // 'activo'
  print(estado.index); // 0

  // Todos los valores
  for (var e in Estado.values) {
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
            text: 'Dart 2.17 introdujo enums con propiedades, constructores y métodos. Son como clases dentro de una enumeración.',
            code: '''
enum Planeta {
  mercurio(masaKg: 3.30e23, radioKm: 2440),
  venus   (masaKg: 4.87e24, radioKm: 6052),
  tierra  (masaKg: 5.97e24, radioKm: 6371),
  marte   (masaKg: 6.42e23, radioKm: 3390);

  // Propiedades
  final double masaKg;
  final double radioKm;

  // Constructor const
  const Planeta({required this.masaKg, required this.radioKm});

  // Métodos
  double get gravedad => (6.674e-11 * masaKg) / (radioKm * 1000) / (radioKm * 1000);

  String get descripcion =>
      '\$name: radio=\${radioKm}km, g=\${gravedad.toStringAsFixed(2)}m/s²';
}

void main() {
  for (var p in Planeta.values) {
    print(p.descripcion);
  }
  // tierra: radio=6371km, g=9.82m/s²
}
''',
          ),
          LessonSection(
            heading: 'Enum implementando interfaces',
            code: '''
interface class Describible {
  String describir();
}

enum Semaforo implements Describible {
  rojo, amarillo, verde;

  @override
  String describir() => switch (this) {
    Semaforo.rojo    => 'STOP — No pases',
    Semaforo.amarillo => 'PRECAUCIÓN — Prepárate',
    Semaforo.verde   => 'GO — Puedes pasar',
  };

  bool get puedePasar => this == Semaforo.verde;
}

void main() {
  var estado = Semaforo.verde;
  print(estado.describir());   // GO — Puedes pasar
  print(estado.puedePasar);    // true
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
    subtitle: 'Añade funcionalidad a tipos existentes sin modificarlos',
    icon: '🔌',
    difficulty: DifficultyLevel.intermediate,
    quiz: [
      QuizQuestion(
        question: '¿Qué permite hacer una extension?',
        options: [
          'Modificar el código fuente de una clase existente',
          'Añadir métodos, getters y operadores a un tipo sin modificar su código fuente',
          'Crear subclases de tipos sellados',
          'Cambiar el tipo de retorno de métodos existentes',
        ],
        correctIndex: 1,
        explanation: 'Las extensions añaden funcionalidad a tipos existentes (incluso de la stdlib) sin modificarlos. El código añadido es solo visible donde se importa la extension.',
      ),
      QuizQuestion(
        question: '¿Pueden las extensions añadir campos de instancia?',
        options: [
          'Sí, como cualquier clase',
          'No, solo pueden añadir métodos, getters, setters y operadores',
          'Solo campos estáticos',
          'Solo si el tipo es una clase concreta',
        ],
        correctIndex: 1,
        explanation: 'Las extensions no pueden añadir estado (campos de instancia) porque no tienen acceso al almacenamiento interno del objeto. Solo pueden operar con los miembros públicos del tipo.',
      ),
    ],
    flashcards: [
      Flashcard(
        front: 'Sintaxis de una extension',
        back: '`extension NombreExtension on TipoObjetivo { ... }`. El nombre es opcional pero recomendable para resolver conflictos de importación.',
        code: 'extension StringUtils on String {\n  String get capitalizada => ...\n}',
      ),
      Flashcard(
        front: '¿Cuándo usar extensions?',
        back: 'Cuando quieres añadir utilidades a un tipo que no controlas (String, int, List…) sin crear funciones sueltas. Mantiene el código más legible y orientado a objetos.',
      ),
      Flashcard(
        front: 'Extension genérica',
        back: 'Puedes crear extensions sobre tipos genéricos para operar sobre colecciones de cualquier tipo.',
        code: 'extension ListUtils<T> on List<T> {\n  T? get firstOrNull => isEmpty ? null : first;\n}',
      ),
    ],
    lessons: [
      Lesson(
        title: 'Extendiendo tipos existentes',
        sections: [
          LessonSection(
            text: 'Las extensiones te permiten añadir métodos, getters y operadores a tipos que ya existen (incluso de la librería estándar) sin modificar su código fuente.',
            code: '''
// Extendemos String con utilidades extra
extension StringUtils on String {
  String get capitalizada {
    if (isEmpty) return this;
    return '\${this[0].toUpperCase()}\${substring(1).toLowerCase()}';
  }

  bool get esEmail => contains('@') && contains('.');

  String repetir(int veces) => this * veces;

  int? toIntOrNull() => int.tryParse(this);
}

// Extendemos int
extension IntUtils on int {
  bool get esPar => this % 2 == 0;
  bool get esImpar => !esPar;

  Duration get segundos => Duration(seconds: this);
  Duration get minutos  => Duration(minutes: this);

  List<int> get rango => List.generate(this, (i) => i);
}

void main() {
  print('hola mundo'.capitalizada);  // Hola mundo
  print('user@mail.com'.esEmail);    // true
  print('ha'.repetir(3));            // hahaha
  print('42'.toIntOrNull());         // 42
  print('abc'.toIntOrNull());        // null

  print(4.esPar);      // true
  print(3.esImpar);    // true
  print(5.rango);      // [0, 1, 2, 3, 4]

  await Future.delayed(2.segundos);  // espera 2 segundos
}
''',
          ),
          LessonSection(
            heading: 'Extensiones en colecciones',
            code: '''
extension ListUtils<T> on List<T> {
  T? get primeroONull => isEmpty ? null : first;
  T? get ultimoONull  => isEmpty ? null : last;

  List<T> get barajado {
    var copia = List<T>.from(this);
    copia.shuffle();
    return copia;
  }
}

extension NumList on List<num> {
  num get suma    => fold(0, (acc, x) => acc + x);
  double get media => suma / length;
  num get maximo  => reduce((a, b) => a > b ? a : b);
  num get minimo  => reduce((a, b) => a < b ? a : b);
}

void main() {
  var nums = [3, 1, 4, 1, 5, 9, 2, 6];
  print(nums.suma);   // 31
  print(nums.media);  // 3.875
  print(nums.maximo); // 9
  print(nums.minimo); // 1

  var lista = [1, 2, 3];
  print(lista.primeroONull); // 1
  print(<int>[].primeroONull); // null
}
''',
          ),
        ],
      ),
    ],
  ),

  // ─────────────────────────────────────────────
  // 14. RECORDS Y PATTERN MATCHING
  // ─────────────────────────────────────────────
  Topic(
    id: 'records_patterns',
    title: 'Records y Pattern Matching',
    subtitle: 'Nuevas características de Dart 3: records, destructuring y patterns',
    icon: '🎯',
    difficulty: DifficultyLevel.advanced,
    quiz: [
      QuizQuestion(
        question: '¿Son iguales `(1, "hola")` y `(1, "hola")` en Dart?',
        options: [
          'No, porque son objetos distintos en memoria',
          'Sí, los records se comparan por valor (igualdad estructural)',
          'Depende del operador == que definas',
          'Solo si son const',
        ],
        correctIndex: 1,
        explanation: 'Los records tienen igualdad estructural por defecto: dos records son iguales si tienen los mismos tipos y valores en las mismas posiciones, sin necesidad de implementar `==`.',
      ),
      QuizQuestion(
        question: '¿Cómo se accede al segundo elemento de un record posicional `(10, "Ana")`?',
        options: ['.second', '.[1]', '.\$2', '.get(1)'],
        correctIndex: 2,
        explanation: 'Los campos posicionales de un record se acceden con `.\$1`, `.\$2`, etc. (índice 1-based). Los campos con nombre se acceden por su nombre.',
      ),
      QuizQuestion(
        question: '¿Qué son las sealed classes en Dart 3?',
        options: [
          'Clases que no pueden tener subclases',
          'Clases cuyas subclases deben estar en el mismo archivo, permitiendo switch exhaustivo',
          'Clases que implementan equals y hashCode automáticamente',
          'Clases que no pueden instanciarse',
        ],
        correctIndex: 1,
        explanation: 'Las `sealed class` restringen que sus subclases estén en el mismo archivo. Esto permite al compilador verificar que un switch es exhaustivo sobre todas las subclases posibles.',
      ),
    ],
    flashcards: [
      Flashcard(
        front: 'Record: qué es y para qué sirve',
        back: 'Tipo compuesto inmutable que agrupa varios valores. Ideal para retornar múltiples valores de una función sin crear una clase.',
        code: '(String, int) persona = ("Ana", 25);\nvar (nombre, edad) = persona; // destructuring',
      ),
      Flashcard(
        front: 'Record posicional vs con nombre',
        back: 'Posicional: `(int, String)` — acceso con `.\$1`, `.\$2`.\nCon nombre: `({String email, int edad})` — acceso con `.email`, `.edad`.',
      ),
      Flashcard(
        front: 'Pattern matching en switch (Dart 3)',
        back: 'El switch de Dart 3 puede desestructurar objetos, Records y Maps directamente en los casos, con guard clauses opcionales (`when`).',
        code: 'switch (forma) {\n  Circulo(radio: var r) => 3.14 * r * r,\n  _ => 0.0,\n}',
      ),
      Flashcard(
        front: 'Guard clause en switch',
        back: 'Añade una condición adicional con `when` después del patrón. El caso solo se activa si el patrón coincide Y la condición es true.',
        code: 'switch (n) {\n  int x when x > 0 => "positivo",\n  _ => "no positivo",\n}',
      ),
    ],
    lessons: [
      Lesson(
        title: 'Records (Dart 3)',
        sections: [
          LessonSection(
            text: 'Los `Records` son tipos compuestos inmutables que agrupan múltiples valores. Son como tuplas con nombre. No necesitas crear una clase para cada agrupación pequeña.',
            code: '''
// Record posicional
(int, String) persona = (25, 'Ana');
print(persona.\$1); // 25 (índice 1-based)
print(persona.\$2); // Ana

// Record con campos con nombre
({String nombre, int edad}) usuario = (nombre: 'Luis', edad: 30);
print(usuario.nombre); // Luis
print(usuario.edad);   // 30

// Mixto
(int, {String email}) cuenta = (1, email: 'a@b.com');
print(cuenta.\$1);     // 1
print(cuenta.email);   // a@b.com

// Records son inmutables
// usuario.nombre = 'Pedro'; ← ERROR: no se puede modificar

// Comparación estructural (por valor, no por referencia)
var r1 = (1, 'hola');
var r2 = (1, 'hola');
print(r1 == r2); // true ← dos records con mismos valores son iguales
''',
          ),
          LessonSection(
            heading: 'Records como retorno de múltiples valores',
            code: '''
// Antes de Records, tenías que crear una clase o usar List/Map
// Ahora puedes retornar múltiples valores con tipo seguro

(double minimo, double maximo, double media) estadisticas(List<double> datos) {
  final min = datos.reduce((a, b) => a < b ? a : b);
  final max = datos.reduce((a, b) => a > b ? a : b);
  final avg = datos.reduce((a, b) => a + b) / datos.length;
  return (min, max, avg);
}

void main() {
  var stats = estadisticas([4.0, 2.5, 8.1, 1.3, 6.7]);

  // Destructuring: desestructura el record
  var (min, max, media) = stats;
  print('Min: \$min, Max: \$max, Media: \$media');
  // Min: 1.3, Max: 8.1, Media: 4.52
}
''',
          ),
        ],
      ),
      Lesson(
        title: 'Pattern Matching (Dart 3)',
        sections: [
          LessonSection(
            text: 'Dart 3 introduce pattern matching: una forma poderosa de desestructurar y comprobar valores de forma expresiva.',
            code: '''
// Variable patterns: extrae y liga valores
var (a, b) = (1, 2);
print('\$a \$b'); // 1 2

// List pattern
var [x, y, ...resto] = [1, 2, 3, 4, 5];
print('\$x \$y \$resto'); // 1 2 [3, 4, 5]

// Map pattern
var {'nombre': nombre, 'edad': edad} = {'nombre': 'Ana', 'edad': 25};
print('\$nombre tiene \$edad años'); // Ana tiene 25 años

// Object pattern
class Punto {
  final int x, y;
  const Punto(this.x, this.y);
}

var punto = Punto(3, 4);
var Punto(x: px, y: py) = punto;
print('(\$px, \$py)'); // (3, 4)
''',
          ),
          LessonSection(
            heading: 'switch con patterns',
            code: '''
// Dart 3: switch maneja cualquier patrón
Object forma = {'tipo': 'circulo', 'radio': 5.0};

String descripcion = switch (forma) {
  {'tipo': 'circulo', 'radio': double r} =>
      'Círculo con radio \$r',
  {'tipo': 'rectangulo', 'ancho': double w, 'alto': double h} =>
      'Rectángulo \$w x \$h',
  String s => 'Forma desconocida: \$s',
  _ => 'No es una forma válida',
};

print(descripcion); // Círculo con radio 5.0

// Guard clauses: condición adicional tras el patrón
int n = 7;
String tipo = switch (n) {
  int x when x < 0 => 'negativo',
  0                => 'cero',
  int x when x.isEven => 'par positivo',
  _ => 'impar positivo',
};
print(tipo); // impar positivo
''',
          ),
          LessonSection(
            heading: 'Sealed classes + Pattern Matching',
            text: 'Las `sealed classes` son la pareja perfecta del switch exhaustivo: Dart puede verificar que tratas todos los casos posibles.',
            code: '''
sealed class Forma {}

class Circulo    extends Forma { final double radio; Circulo(this.radio); }
class Rectangulo extends Forma { final double ancho, alto; Rectangulo(this.ancho, this.alto); }
class Triangulo  extends Forma { final double base, altura; Triangulo(this.base, this.altura); }

double calcularArea(Forma forma) => switch (forma) {
  Circulo(radio: var r)            => 3.14159 * r * r,
  Rectangulo(ancho: var w, alto: var h) => w * h,
  Triangulo(base: var b, altura: var h) => 0.5 * b * h,
  // No necesitas _ porque la clase es sealed y cubriste todos los casos
};

void main() {
  print(calcularArea(Circulo(5)));        // 78.539...
  print(calcularArea(Rectangulo(4, 6)));  // 24.0
  print(calcularArea(Triangulo(3, 8)));   // 12.0
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
    title: 'Extension Types',
    subtitle: 'Wrappers de coste cero con seguridad de tipos (Dart 3.3)',
    icon: '🧊',
    difficulty: DifficultyLevel.advanced,
    quiz: [
      QuizQuestion(
        question: '¿Cuál es la diferencia clave entre un extension type y una clase envolvente normal?',
        options: [
          'Un extension type es más lento',
          'Un extension type tiene coste cero en runtime: no crea un objeto nuevo en memoria',
          'Un extension type puede tener campos de instancia',
          'No hay diferencia práctica',
        ],
        correctIndex: 1,
        explanation: 'Un extension type es eliminado por el compilador en tiempo de compilación. En runtime, es exactamente el tipo representado, sin overhead de objeto wrapper.',
      ),
      QuizQuestion(
        question: '¿Para qué sirve `implements int` en un extension type?',
        options: [
          'Para heredar la implementación de int',
          'Para exponer la interfaz de int, permitiendo usar el extension type donde se espera un int',
          'Para hacer el extension type mutable',
          'Solo para tipos primitivos',
        ],
        correctIndex: 1,
        explanation: 'Con `implements TipoBase`, el extension type expone todos los miembros del tipo base. Sin él, solo expone lo que declares explícitamente.',
      ),
    ],
    flashcards: [
      Flashcard(
        front: '¿Qué es un extension type?',
        back: 'Un wrapper de coste cero: añade seguridad de tipos en compilación sin crear objetos adicionales en runtime. El compilador lo elimina.',
        code: 'extension type Metros(double value) {\n  Metros operator +(Metros o) => Metros(value + o.value);\n}',
      ),
      Flashcard(
        front: 'Caso de uso: IDs tipados',
        back: 'Evita confundir distintos IDs que internamente son del mismo tipo (int, String). El compilador detecta el error en lugar de tu código.',
        code: 'extension type UserId(int value) {}\nextension type ProductId(int value) {}\n// crearOrden(productId, userId) ← error en compilación',
      ),
      Flashcard(
        front: '`implements` en extension type',
        back: 'Con `implements int` el extension type expone todos los miembros de int. Sin él, los miembros del tipo base son privados al extension type.',
        code:
            'extension type UsuarioId(int value) implements int {\n  // Ahora se puede usar donde se espera un int\n}',
      ),
    ],
    lessons: [
      Lesson(
        title: '¿Qué son los Extension Types?',
        sections: [
          LessonSection(
            text: 'Un `extension type` es un wrapper de **coste cero** alrededor de otro tipo. Añade seguridad de tipos en tiempo de compilación sin crear un objeto nuevo en memoria. Es distinto a una clase que envuelve un valor: al compilar, el extension type desaparece y queda solo el tipo representado.',
          ),
          LessonSection(
            heading: 'Sintaxis básica',
            code: '''
// Declaración: nombre(tipo representado)
extension type Metros(double value) {
  // Puedes añadir métodos y operadores
  Metros operator +(Metros otro) => Metros(value + otro.value);
  Metros operator *(double factor) => Metros(value * factor);

  String get formateado => '\${value.toStringAsFixed(2)} m';
}

extension type Kilogramos(double value) {
  String get formateado => '\${value.toStringAsFixed(2)} kg';
}

void main() {
  var distancia = Metros(5.0);
  var doble = distancia * 2;
  print(doble.formateado); // 10.00 m

  // ✅ El compilador impide mezclar tipos distintos
  var peso = Kilogramos(70.0);
  // var suma = distancia + peso; ← ERROR: tipos incompatibles
}
''',
          ),
          LessonSection(
            heading: 'Coste cero en runtime',
            text: 'A diferencia de una clase envolvente normal, el extension type no genera un objeto nuevo. `Metros(5.0)` es exactamente el mismo `5.0` en memoria.',
            code: '''
extension type UsuarioId(int value) implements int {
  bool get esAdmin => value < 0;
}

void main() {
  UsuarioId id = UsuarioId(42);

  // Como implements int, podemos usarlo donde se espera un int
  print(id + 1);     // 43 (operación de int)
  print(id.isEven);  // true

  print(id.esAdmin); // false (método propio)
}
''',
            note: 'Con `implements TipoBase` el extension type expone la interfaz del tipo base. Sin él, solo expone lo que declares explícitamente.',
          ),
          LessonSection(
            heading: 'Caso de uso: IDs tipados',
            text: 'El uso más común es dar nombres con significado a tipos primitivos, evitando confundir, por ejemplo, el ID de un usuario con el ID de un producto.',
            code: '''
extension type UserId(int value) { }
extension type ProductId(int value) { }
extension type OrderId(String value) { }

// Sin extension types:
// void crearOrden(int userId, int productId) ← ¡fácil confundir el orden!

// Con extension types:
void crearOrden(UserId userId, ProductId productId) {
  print('Usuario \${userId.value} compra producto \${productId.value}');
}

void main() {
  var u = UserId(1);
  var p = ProductId(99);

  crearOrden(u, p); // OK
  // crearOrden(p, u); ← ERROR en compilación ✅
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
    title: 'Dot Shorthands',
    subtitle: 'Omite el nombre del tipo cuando el contexto lo infiere (Dart 3.10)',
    icon: '✂️',
    difficulty: DifficultyLevel.intermediate,
    quiz: [
      QuizQuestion(
        question: '¿En qué versión de Dart se introdujeron los dot shorthands?',
        options: ['Dart 3.0', 'Dart 3.7', 'Dart 3.10', 'Dart 3.13'],
        correctIndex: 2,
        explanation: 'Los dot shorthands (`.valor`) se introdujeron en Dart 3.10.',
      ),
      QuizQuestion(
        question: '¿Cuándo puedes usar un dot shorthand como `.error`?',
        options: [
          'Siempre',
          'Solo con enums',
          'Cuando Dart puede inferir el tipo del contexto (tipo de variable, parámetro o caso de switch)',
          'Solo en parámetros con nombre',
        ],
        correctIndex: 2,
        explanation: 'Los dot shorthands solo funcionan cuando el compilador puede deducir el tipo esperado del contexto. Si hay ambigüedad, necesitas el nombre completo.',
      ),
    ],
    flashcards: [
      Flashcard(
        front: '¿Qué son los dot shorthands?',
        back: 'Permiten omitir el nombre del tipo cuando Dart puede inferirlo del contexto. En lugar de `LogLevel.error`, escribes `.error`.',
        code: 'logMessage("msg", level: .error); // infiere LogLevel.error',
      ),
      Flashcard(
        front: 'Dot shorthands funcionan con...',
        back: '• Valores de enum\n• Constructores con nombre\n• Métodos estáticos\n• Campos estáticos\n• Variables tipadas\n• Casos de switch',
        code: 'Color fondo = .rojo;\nswitch (d) { .norte => "Norte" }',
      ),
    ],
    lessons: [
      Lesson(
        title: 'El problema que resuelven',
        sections: [
          LessonSection(
            text: 'Antes de Dart 3.10, al pasar un valor a una función que ya declaraba el tipo esperado, tenías que repetir el nombre del tipo. Los **dot shorthands** (`.`) permiten omitir ese nombre cuando Dart puede inferirlo del contexto.',
          ),
          LessonSection(
            heading: 'Con enums',
            code: '''
enum Nivel { basico, intermedio, avanzado }

// Antes de Dart 3.10:
void configurar({Nivel nivel = Nivel.basico}) {
  print(nivel);
}
configurar(nivel: Nivel.avanzado);

// Con dot shorthands (Dart 3.10+):
void configurarNuevo({Nivel nivel = .basico}) { // .basico infiere Nivel.basico
  print(nivel);
}
configurarNuevo(nivel: .avanzado); // .avanzado infiere Nivel.avanzado
''',
          ),
          LessonSection(
            heading: 'Con constructores',
            code: '''
class Color {
  final int r, g, b;
  const Color(this.r, this.g, this.b);

  static const rojo  = Color(255, 0, 0);
  static const verde = Color(0, 255, 0);
  static const azul  = Color(0, 0, 255);
}

// El parámetro espera un Color, así que Dart infiere el tipo
void pintarFondo(Color color) => print('Fondo: \$color');

// Antes:
pintarFondo(Color.rojo);
pintarFondo(Color(128, 0, 128));

// Con dot shorthands:
pintarFondo(.rojo);          // Shorthand a campo estático
pintarFondo(.azul);
pintarFondo(Color(128, 0, 128)); // Constructor con args: aún necesitas el nombre
''',
          ),
          LessonSection(
            heading: 'Con métodos estáticos y variables tipadas',
            code: '''
enum Direccion { norte, sur, este, oeste }

// En una variable tipada, el shorthand también funciona
Direccion rumbo = .norte;
rumbo = .sur;

// En listas y expresiones condicionales
List<Direccion> ruta = [.norte, .este, .este, .sur];

// En switch
String describir(Direccion d) => switch (d) {
  .norte => 'Hacia arriba',
  .sur   => 'Hacia abajo',
  .este  => 'Hacia la derecha',
  .oeste => 'Hacia la izquierda',
};
''',
            note: 'El shorthand solo funciona cuando Dart puede deducir el tipo del contexto: tipo de variable, parámetro de función, o rama de switch. Si hay ambigüedad, sigue siendo necesario el nombre completo.',
          ),
        ],
      ),
    ],
  ),

  // ─────────────────────────────────────────────
  // 17. CONSTRUCTORES PRIMARIOS Y PRIVADOS (Dart 3.12/3.13)
  // ─────────────────────────────────────────────
  Topic(
    id: 'primary_constructors',
    title: 'Constructores Modernos',
    subtitle: 'Primary constructors (3.13) y private named parameters (3.12)',
    icon: '🏗️',
    difficulty: DifficultyLevel.intermediate,
    quiz: [
      QuizQuestion(
        question: 'Con private named parameters (Dart 3.12), ¿cómo se llama el parámetro al construir la clase `Hummingbird({required this._petName})`?',
        options: ['_petName', 'petName', 'private_petName', 'Es un error de compilación'],
        correctIndex: 1,
        explanation: 'El nombre público del parámetro en el call site es sin guión bajo: `petName`. El campo dentro de la clase sigue siendo privado: `_petName`.',
      ),
      QuizQuestion(
        question: '¿Cuál es la forma correcta de declarar `class Punto` con primary constructor (Dart 3.13)?',
        options: [
          'class Punto { int x, y; }',
          'class Punto(final int x, final int y);',
          'class Punto = (int x, int y);',
          'primary class Punto(int x, int y);',
        ],
        correctIndex: 1,
        explanation: 'Con primary constructors (Dart 3.13), los parámetros se declaran en la cabecera de la clase. Una clase sin cuerpo puede terminar en `;`.',
      ),
      QuizQuestion(
        question: '¿Para qué sirve la keyword `new` dentro de una clase con primary constructor?',
        options: [
          'Para crear instancias desde dentro de la propia clase',
          'Para declarar constructores con nombre adicionales',
          'Para marcar el constructor como factory',
          'Es una palabra reservada sin uso en este contexto',
        ],
        correctIndex: 1,
        explanation: 'En el cuerpo de una clase con primary constructor, `new nombreConstructor(params)` declara un constructor con nombre adicional.',
      ),
    ],
    flashcards: [
      Flashcard(
        front: 'Private named parameters (Dart 3.12)',
        back: 'Permite `this._campo` en parámetros nombrados. El call site usa el nombre sin guión bajo; el campo interno es privado.',
        code: 'class Cfg({ required this._host });\nvar c = Cfg(host: "localhost"); // sin _',
      ),
      Flashcard(
        front: 'Primary constructor: clase simple',
        back: 'Declara parámetros directamente en la cabecera de la clase. Elimina la repetición de campos + constructor.',
        code: '// Antes: 4 líneas. Ahora: 1\nclass Punto(final int x, final int y);',
      ),
      Flashcard(
        front: 'Primary constructor con named params',
        back: 'Los parámetros nombrados y los valores por defecto funcionan igual que en constructores normales.',
        code: 'class Servidor(String host, {\n  int puerto = 8080,\n  bool ssl = false,\n});',
      ),
      Flashcard(
        front: 'Constructores adicionales con `new`',
        back: 'Dentro de una clase con primary constructor, usa `new nombre()` para declarar constructores con nombre. `factory` también funciona.',
        code: 'class Color(int r, int g, int b) {\n  new gris(int n) : this(n, n, n);\n}',
      ),
    ],
    lessons: [
      Lesson(
        title: 'Private Named Parameters (Dart 3.12)',
        sections: [
          LessonSection(
            text: 'Antes de Dart 3.12, no podías usar la sintaxis `this._campo` con parámetros nombrados en constructores. Tenías que escribir un inicializador explícito que solo servía para quitar el guion bajo. Dart 3.12 lo soluciona.',
          ),
          LessonSection(
            heading: 'El problema anterior',
            code: '''
// Dart <3.12: campo privado + parámetro nombrado = boilerplate forzado
class Configuracion {
  final String _host;
  final int _puerto;

  // Tenías que escribir esto manualmente:
  Configuracion({required String host, required int puerto})
    : _host = host,
      _puerto = puerto;
}
''',
          ),
          LessonSection(
            heading: 'Con Dart 3.12+',
            code: '''
// Dart 3.12+: this._campo funciona con parámetros nombrados ✅
class Configuracion {
  final String _host;
  final int _puerto;

  // El nombre del parámetro al llamar es 'host' y 'puerto' (sin guión bajo)
  Configuracion({required this._host, required this._puerto});

  @override
  String toString() => '\$_host:\$_puerto';
}

void main() {
  // En el call site se usan los nombres sin guión bajo
  var cfg = Configuracion(host: 'localhost', puerto: 8080);
  print(cfg); // localhost:8080
}

// Funciona también con late y default values
class Sesion {
  final String _token;
  final Duration _timeout;

  Sesion({
    required this._token,
    this._timeout = const Duration(hours: 1),
  });
}
''',
            note: 'El nombre público del parámetro (en el call site) es el nombre sin el guión bajo. Los campos siguen siendo privados dentro de la clase.',
          ),
        ],
      ),
      Lesson(
        title: 'Primary Constructors (Dart 3.13)',
        sections: [
          LessonSection(
            text: 'Los **primary constructors** son la mejora de sintaxis más grande para clases en Dart. Permiten declarar los campos y el constructor en una sola línea, directamente en la cabecera de la clase.',
          ),
          LessonSection(
            heading: 'Clase básica: de 4 líneas a 1',
            code: '''
// Antes (Dart <3.13):
class Punto {
  final int x;
  final int y;
  Punto(this.x, this.y);
}

// Con primary constructor (Dart 3.13):
class Punto(final int x, final int y);

// ¡Exactamente equivalente! Mismas propiedades, mismo constructor.
void main() {
  var p = Punto(3, 4);
  print(p.x); // 3
  print(p.y); // 4
}
''',
          ),
          LessonSection(
            heading: 'Con parámetros nombrados y valores por defecto',
            code: '''
// Parámetros nombrados opcionales con valor por defecto
class Servidor(
  String host, {
  int puerto = 8080,
  bool ssl = false,
});

// Parámetros requeridos nombrados
class Usuario(
  final String nombre, {
  required final String email,
  int edad = 0,
});

void main() {
  var srv = Servidor('localhost', ssl: true, puerto: 443);
  var u = Usuario('Ana', email: 'ana@ejemplo.com');

  print(srv.host);    // localhost
  print(u.nombre);    // Ana
}
''',
          ),
          LessonSection(
            heading: 'Constructores adicionales con new y factory',
            code: '''
class Color(final int r, final int g, final int b) {
  // Constructor con nombre usando "new"
  new gris(int nivel) : this(nivel, nivel, nivel);

  // Factory usando "factory"
  factory fromHex(String hex) {
    final n = int.parse(hex.replaceFirst('#', ''), radix: 16);
    return Color((n >> 16) & 0xFF, (n >> 8) & 0xFF, n & 0xFF);
  }

  @override
  String toString() => 'rgb(\$r, \$g, \$b)';
}

void main() {
  var rojo  = Color(255, 0, 0);
  var gris  = Color.gris(128);       // new keyword → constructor nombrado
  var verde = Color.fromHex('#00FF00');

  print(rojo);   // rgb(255, 0, 0)
  print(gris);   // rgb(128, 128, 128)
  print(verde);  // rgb(0, 255, 0)
}
''',
          ),
          LessonSection(
            heading: 'Herencia con primary constructors',
            code: '''
class Animal(final String nombre, final int edad);

// super.parametro funciona igual
class Perro(super.nombre, super.edad, final String raza)
    extends Animal;

// Con cuerpo adicional
class Gato(super.nombre, super.edad) extends Animal {
  void maullar() => print('\$nombre: ¡Miau!');
}

void main() {
  var perro = Perro('Rex', 3, 'Labrador');
  print(perro.nombre); // Rex
  print(perro.raza);   // Labrador

  var gato = Gato('Whiskers', 2);
  gato.maullar(); // Whiskers: ¡Miau!
}
''',
            note: 'Los primary constructors son especialmente útiles para clases de datos simples (DTOs, value objects, modelos). Para clases con lógica compleja en el constructor, el constructor en cuerpo sigue siendo la opción correcta.',
          ),
          LessonSection(
            heading: 'Comparativa: antes vs ahora',
            code: '''
// ─── ANTES (Dart <3.13) ───────────────────────
class ProductoAntes {
  final String nombre;
  final double precio;
  final int stock;

  ProductoAntes({
    required this.nombre,
    required this.precio,
    this.stock = 0,
  });
}

// ─── AHORA (Dart 3.13) ────────────────────────
class Producto({
  required final String nombre,
  required final double precio,
  final int stock = 0,
});

// Uso idéntico en ambos casos:
void main() {
  var p = Producto(nombre: 'Dart Book', precio: 29.99, stock: 10);
  print(p.nombre); // Dart Book
}
''',
          ),
        ],
      ),
    ],
  ),

  // ─────────────────────────────────────────────
  // 19. WILDCARD VARIABLES (Dart 3.7)
  // ─────────────────────────────────────────────
  Topic(
    id: 'wildcards',
    title: 'Wildcard Variables',
    subtitle: 'El guión bajo _ como variable sin binding (Dart 3.7)',
    icon: '🃏',
    difficulty: DifficultyLevel.intermediate,
    quiz: [
      QuizQuestion(
        question: '¿Qué permite Dart 3.7 que no era posible antes con `_`?',
        options: [
          'Usar _ como nombre de clase',
          'Tener múltiples _ en el mismo ámbito sin conflicto, ya que no crea un binding',
          'Usar _ como tipo de retorno',
          'Declarar campos privados con __',
        ],
        correctIndex: 1,
        explanation: 'Antes de 3.7, `_` era un nombre de variable normal y solo podía aparecer una vez por ámbito. Desde 3.7, es una variable sin binding que puede repetirse.',
      ),
      QuizQuestion(
        question: '¿Cuál es el propósito semántico de usar `_` en lugar de un nombre como `unused`?',
        options: [
          'El compilador lo optimiza mejor',
          'Comunica explícitamente que el valor es ignorado intencionalmente, es una convención del lenguaje',
          'Es obligatorio para variables no usadas',
          'Solo estilo personal, sin diferencia',
        ],
        correctIndex: 1,
        explanation: '`_` es la convención estándar de Dart para "este valor se ignora intencionalmente". Nombres como `unused` son ambiguos; `_` es inequívoco.',
      ),
    ],
    flashcards: [
      Flashcard(
        front: 'Wildcard `_` en Dart 3.7',
        back: 'Desde Dart 3.7, `_` es una variable especial sin binding. Puedes usarla múltiples veces en el mismo ámbito para ignorar valores explícitamente.',
        code: 'var (a, _, _) = (1, 2, 3); // _ se descarta dos veces',
      ),
      Flashcard(
        front: '_ en parámetros de función',
        back: 'Usa `_` cuando la API requiere un parámetro que no necesitas. Comunica que el valor se ignora intencionalmente.',
        code: 'lista.forEach((_) => cuenta++);\nmapa.forEach((_, v) => print(v));',
      ),
      Flashcard(
        front: '_ en catch',
        back: 'Puedes usar `_` para descartar tanto la excepción como el stack trace si solo quieres que el bloque catch exista.',
        code: 'try { ... } catch (_, _) {\n  // ambos ignorados\n}',
      ),
    ],
    lessons: [
      Lesson(
        title: 'Variables wildcard con _',
        sections: [
          LessonSection(
            text: 'Desde Dart 3.7, el guión bajo `_` es una **variable sin binding**: puedes usarla para ignorar valores intencionalmente, y puedes tener múltiples `_` en el mismo ámbito sin conflicto. Antes de 3.7, `_` era un nombre de variable normal — solo uno por ámbito.',
          ),
          LessonSection(
            heading: 'Múltiples _ en el mismo ámbito',
            code: '''
// Antes de 3.7: solo un _ por ámbito
// var (_, _, c) = (1, 2, 3); ← ERROR antes de 3.7

// Dart 3.7+: _ puede repetirse
var (a, _, _) = (10, 20, 30);
print(a); // 10 — los dos _ se descartan sin error
''',
          ),
          LessonSection(
            heading: 'En bucles y catch',
            code: '''
var lista = ['a', 'b', 'c'];
int cuenta = 0;

// _ deja claro que el elemento no importa, solo la iteración
for (var _ in lista) {
  cuenta++;
}
print(cuenta); // 3

// catch: ignorar tanto la excepción como el stack trace
try {
  int.parse('no es un número');
} catch (_, _) {
  // Ambos descartados: solo queremos continuar
  print('Falló el parseo');
}
''',
          ),
          LessonSection(
            heading: 'En parámetros de función',
            code: '''
// Cuando la API exige ciertos parámetros pero no los necesitas
var ticks = Stream.periodic(Duration(seconds: 1), (i) => i).take(3);
ticks.listen((_) => print('¡Tick!')); // el valor no importa

// Map.forEach: ignorar la clave, solo usar el valor
var edades = {'Ana': 25, 'Luis': 30};
edades.forEach((_, edad) => print('Edad: \$edad'));
''',
          ),
          LessonSection(
            heading: 'En pattern matching',
            code: '''
var punto = (x: 3, y: 7, z: -1);

// Solo me interesa y
var (x: _, y: valor, z: _) = punto;
print(valor); // 7

// En switch: _ como wildcard de tipo
String clasificar(Object obj) => switch (obj) {
  int n when n > 0 => 'entero positivo',
  int _            => 'entero no positivo', // liga int pero no lo usa
  String s         => 'cadena: \$s',
  _                => 'otro tipo',          // default: cualquier cosa
};

print(clasificar(5));      // entero positivo
print(clasificar(-3));     // entero no positivo
print(clasificar('hola')); // cadena: hola
print(clasificar(3.14));   // otro tipo
''',
            note: 'Usar `_` en lugar de nombres como `unused` o `x` comunica de forma estándar que ese valor es intencionalmente ignorado. Es una convención del lenguaje, no solo un estilo.',
          ),
        ],
      ),
    ],
  ),

  // ─────────────────────────────────────────────
  // 20. ISOLATES
  // ─────────────────────────────────────────────
  Topic(
    id: 'isolates',
    title: 'Isolates',
    subtitle: 'Verdadero paralelismo en Dart: Isolate.run y comunicación',
    icon: '⚙️',
    difficulty: DifficultyLevel.advanced,
    quiz: [
      QuizQuestion(
        question: '¿Cómo se comunican dos Isolates entre sí?',
        options: [
          'Comparten memoria directamente',
          'Mediante paso de mensajes con SendPort y ReceivePort',
          'Con variables globales',
          'No pueden comunicarse',
        ],
        correctIndex: 1,
        explanation: 'Los Isolates no comparten memoria. Se comunican enviando mensajes a través de canales: `SendPort` para enviar y `ReceivePort` para recibir.',
      ),
      QuizQuestion(
        question: '¿Cuándo deberías usar un Isolate?',
        options: [
          'Para cualquier operación asíncrona',
          'Solo para operaciones de red',
          'Para tareas pesadas que bloquearían el hilo principal (parseo de JSON grande, cálculos intensivos)',
          'Para todas las operaciones de I/O',
        ],
        correctIndex: 2,
        explanation: 'Las operaciones de I/O ya son no bloqueantes en Dart con async/await. Los Isolates son para cómputo intensivo de CPU que no puede hacerse de forma asíncrona.',
      ),
    ],
    flashcards: [
      Flashcard(
        front: '¿Qué es un Isolate?',
        back: 'Una unidad de ejecución independiente en Dart con su propia memoria. No comparte estado con otros Isolates. Permite verdadero paralelismo (múltiples núcleos de CPU).',
      ),
      Flashcard(
        front: '`Isolate.run()` (Dart 2.19+)',
        back: 'Forma simple de ejecutar una función en un isolate separado. Retorna un Future con el resultado. El hilo principal no se bloquea.',
        code: 'int res = await Isolate.run(() => calcularFib(40));',
      ),
      Flashcard(
        front: 'Future vs Isolate',
        back: 'Future/async: concurrencia (una tarea a la vez, pero sin bloquear). Isolate: paralelismo (múltiples tareas simultáneas en distintos hilos/núcleos).',
      ),
    ],
    lessons: [
      Lesson(
        title: '¿Qué son los Isolates?',
        sections: [
          LessonSection(
            text: 'Dart es single-threaded por diseño, pero los `Isolates` permiten verdadero paralelismo. Cada isolate tiene su propia memoria y se comunica por paso de mensajes (no comparte memoria directamente).',
          ),
          LessonSection(
            heading: 'Isolate.run — forma simple',
            code: '''
import 'dart:isolate';

// Tarea pesada que bloquearía el hilo principal
int calcularFibonacci(int n) {
  if (n <= 1) return n;
  return calcularFibonacci(n - 1) + calcularFibonacci(n - 2);
}

Future<void> main() async {
  print('Calculando fib(40)...');

  // Corre la función en un isolate separado
  // El hilo principal NO se bloquea
  int resultado = await Isolate.run(() => calcularFibonacci(40));

  print('fib(40) = \$resultado'); // fib(40) = 102334155
}
''',
            note: '`Isolate.run` es la forma más sencilla (Dart 2.19+). Para casos más complejos con comunicación bidireccional, usa `ReceivePort` y `SendPort`.',
          ),
          LessonSection(
            heading: 'Comunicación con ReceivePort y SendPort',
            code: '''
import 'dart:isolate';

void trabajador(SendPort sendPort) {
  // Este código corre en el isolate separado
  for (int i = 0; i < 5; i++) {
    sendPort.send('Mensaje \$i del trabajador');
  }
  sendPort.send(null); // Señal de fin
}

Future<void> main() async {
  var receivePort = ReceivePort();

  // Crear el isolate y pasarle el SendPort
  await Isolate.spawn(trabajador, receivePort.sendPort);

  // Escuchar mensajes
  await for (var mensaje in receivePort) {
    if (mensaje == null) {
      receivePort.close();
      break;
    }
    print('Principal recibió: \$mensaje');
  }
}
''',
          ),
        ],
      ),
    ],
  ),
];
