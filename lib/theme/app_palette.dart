import 'package:flutter/material.dart';

class AppPalette {
  final String id;
  final String name;
  final String description;
  final Color seed;

  const AppPalette({required this.id, required this.name, required this.description, required this.seed});
}

// Palettes: first is the app default (official Dart blue).
// The rest are inspired by Ocarina of Time characters —
// names are evocative, not direct references.
const List<AppPalette> kPalettes = [
  AppPalette(id: 'dart', name: 'Dart', description: 'Official Dart language blue', seed: Color(0xFF0175C2)),
  AppPalette(id: 'fern', name: 'Fern', description: 'Forest green, dew and ancient wood', seed: Color(0xFF1B6B3A)),
  AppPalette(id: 'ivory', name: 'Ivory', description: 'Sapphire blue, wisdom and royalty', seed: Color(0xFF1A3D8B)),
  AppPalette(id: 'gilded', name: 'Gilded', description: 'Warm amber gold, ancient relics', seed: Color(0xFF7B5400)),
  AppPalette(id: 'dusk', name: 'Dusk', description: 'Deep violet, shadow and power', seed: Color(0xFF52097A)),
  AppPalette(id: 'ember', name: 'Ember', description: 'Warm chestnut, open fields at sunset', seed: Color(0xFF8B2E00)),
];

AppPalette paletteById(String id) => kPalettes.firstWhere((p) => p.id == id, orElse: () => kPalettes.first);
