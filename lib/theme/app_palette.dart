import 'package:flutter/material.dart';

class AppPalette {
  final String id;
  final String name;
  final String description;
  // Seed: drives primary tonal palette
  final Color seed;
  // Secondary and tertiary seeds: independently seeded
  final Color secondary;
  final Color tertiary;
  // Surface overrides for light / dark
  final Color lightSurface;
  final Color darkSurface;

  const AppPalette({
    required this.id,
    required this.name,
    required this.description,
    required this.seed,
    required this.secondary,
    required this.tertiary,
    required this.lightSurface,
    required this.darkSurface,
  });

  /// Builds a full ColorScheme by seeding each role independently
  /// so secondary and tertiary are genuinely different from primary.
  ColorScheme scheme(Brightness brightness) {
    final base = ColorScheme.fromSeed(seedColor: seed, brightness: brightness);

    final sec = ColorScheme.fromSeed(
        seedColor: secondary, brightness: brightness);
    final ter = ColorScheme.fromSeed(
        seedColor: tertiary, brightness: brightness);

    return base.copyWith(
      // Secondary role
      secondary: sec.primary,
      onSecondary: sec.onPrimary,
      secondaryContainer: sec.primaryContainer,
      onSecondaryContainer: sec.onPrimaryContainer,
      // Tertiary role
      tertiary: ter.primary,
      onTertiary: ter.onPrimary,
      tertiaryContainer: ter.primaryContainer,
      onTertiaryContainer: ter.onPrimaryContainer,
      // Surface
      surface: brightness == Brightness.light ? lightSurface : darkSurface,
    );
  }
}

// ── Palettes ──────────────────────────────────────────────────
//
// Default: official Dart colours.
// The rest are inspired by Ocarina of Time characters —
// names are evocative, not direct references.

const List<AppPalette> kPalettes = [

  // ── Dart (default) ────────────────────────────────────────
  AppPalette(
    id: 'dart',
    name: 'Dart',
    description: 'Official Dart language colours',
    seed:         Color(0xFF0175C2), // Dart Blue
    secondary:    Color(0xFF54C5F8), // Dart Sky
    tertiary:     Color(0xFF01579B), // Dart Dark
    lightSurface: Color(0xFFF4F8FF),
    darkSurface:  Color(0xFF070D14),
  ),

  // ── Fern (Link / Kokiri Forest) ───────────────────────────
  // Link's iconic green tunic as the primary.
  // Navi's fairy blue as secondary — a constant companion.
  // Kokiri Emerald gold for the sacred forest treasure.
  // Light: morning filtering through Kokiri Forest leaves.
  // Dark: the Lost Woods at midnight, a single firefly.
  AppPalette(
    id: 'fern',
    name: 'Fern',
    description: 'Kokiri tunic, fairy light, forest emerald',
    seed:         Color(0xFF2E7D32), // Link's tunic
    secondary:    Color(0xFF0288D1), // Navi blue
    tertiary:     Color(0xFFF57F17), // Kokiri gold
    lightSurface: Color(0xFFEFF8EF), // forest morning mist
    darkSurface:  Color(0xFF030B03), // Lost Woods night
  ),

  // ── Ivory (Zelda / Wisdom) ────────────────────────────────
  // Royal violet for Zelda's Triforce of Wisdom aura.
  // Crown gold as secondary — her regal identity.
  // Sapphire blue for the royal dress trim and Hyrule Castle.
  // Light: palace marble under golden sunlight.
  // Dark: the castle tower at night, a violet moon.
  AppPalette(
    id: 'ivory',
    name: 'Ivory',
    description: 'Triforce of Wisdom violet, crown gold, royal blue',
    seed:         Color(0xFF6A1B9A), // Wisdom aura violet
    secondary:    Color(0xFFF9A825), // crown gold
    tertiary:     Color(0xFF1565C0), // royal blue trim
    lightSurface: Color(0xFFFAF5FF), // ivory palace marble
    darkSurface:  Color(0xFF06010E), // castle night sky
  ),

  // ── Gilded (Triforce / Sacred Realm) ─────────────────────
  // Bright Triforce gold as the blazing primary.
  // Ganon's corruption crimson seeps in as secondary.
  // Ancient stone and bronze as earthen tertiary.
  // Light: parchment map lit by the Triforce glow.
  // Dark: the Sacred Realm, bathed in golden light.
  AppPalette(
    id: 'gilded',
    name: 'Gilded',
    description: 'Triforce gold, sacred realm, ancient stone',
    seed:         Color(0xFFF9A825), // Triforce gold (vivid)
    secondary:    Color(0xFFC62828), // corruption crimson
    tertiary:     Color(0xFF4E342E), // ancient stone
    lightSurface: Color(0xFFFFFDE7), // parchment
    darkSurface:  Color(0xFF100900), // sacred realm shadow
  ),

  // ── Dusk (Ganondorf / Power) ──────────────────────────────
  // Blood crimson for Ganondorf's burning eyes and rage.
  // Dark amethyst for his evil sorcery as secondary.
  // Shadow indigo for the darkness he spreads.
  // Light: an ominous crimson haze over Hyrule Desert.
  // Dark: pure void — the Dark World corrupted.
  AppPalette(
    id: 'dusk',
    name: 'Dusk',
    description: 'Ganon\'s wrath, dark sorcery, shadow realm',
    seed:         Color(0xFFC62828), // blood crimson
    secondary:    Color(0xFF6A0080), // dark sorcery
    tertiary:     Color(0xFF1A237E), // shadow indigo
    lightSurface: Color(0xFFFFF8F8), // ominous pale haze
    darkSurface:  Color(0xFF0F0000), // the Dark World
  ),

  // ── Ember (Epona / Hyrule Field) ─────────────────────────
  // Vivid sunset orange for Epona galloping at golden hour.
  // Hyrule field grass green as secondary.
  // Open horizon sky blue as tertiary.
  // Light: warm wheat and golden grass under the sun.
  // Dark: campfire embers on the starlit Hyrule plains.
  AppPalette(
    id: 'ember',
    name: 'Ember',
    description: 'Sunset gallop, Hyrule field, open horizon',
    seed:         Color(0xFFE65100), // vivid sunset orange
    secondary:    Color(0xFF558B2F), // field grass
    tertiary:     Color(0xFF0277BD), // horizon sky
    lightSurface: Color(0xFFFFF3E0), // golden wheat
    darkSurface:  Color(0xFF110700), // ember night
  ),
];

AppPalette paletteById(String id) =>
    kPalettes.firstWhere((p) => p.id == id, orElse: () => kPalettes.first);
