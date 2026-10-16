import 'package:flutter/material.dart';

import 'screens/inicio_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const GameZoneApp());
}

class GameZoneApp extends StatelessWidget {
  const GameZoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GameZone',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.obtenerTema(),
      home: InicioScreen(),
    );
  }
}
