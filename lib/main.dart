import 'package:flutter/material.dart';

import 'screens/navegacion_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const GameZoneApp());
}

class GameZoneApp extends StatelessWidget {
  const GameZoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GameZone - Jugadores',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.obtenerTema(),
      home: const NavegacionScreen(),
    );
  }
}
