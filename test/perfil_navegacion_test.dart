import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gamezone/main.dart';
import 'package:gamezone/models/videojuego.dart';
import 'package:gamezone/screens/perfil_screen.dart';
import 'package:gamezone/services/favoritos_service.dart';
import 'package:gamezone/widgets/avatar_perfil.dart';

void main() {
  testWidgets('Perfil valida el nombre y permite editarlo', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: PerfilScreen()));
    await tester.tap(find.text('Editar nombre'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), '  ');
    await tester.tap(find.text('Guardar'));
    await tester.pump();
    expect(find.text('Escribe tu nombre'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField), 'Alejandro');
    await tester.tap(find.text('Guardar'));
    await tester.pumpAndSettle();
    expect(find.text('Alejandro'), findsOneWidget);
    expect(find.text('A'), findsOneWidget);
  });

  testWidgets('Estadísticas reaccionan a los favoritos y géneros únicos', (
    tester,
  ) async {
    final servicio = FavoritosService();
    addTearDown(servicio.dispose);
    await tester.pumpWidget(
      MaterialApp(home: PerfilScreen(servicio: servicio)),
    );
    expect(find.text('0'), findsNWidgets(2));
    for (final id in [1, 2]) {
      servicio.agregar(
        Videojuego(
          id: id,
          nombre: 'Juego',
          genero: 'RPG',
          plataforma: 'PC',
          calificacion: 9,
          descripcion: '',
          imagen: 'https://example.com/a.jpg',
        ),
      );
    }
    await tester.pump();
    expect(find.text('2'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('Navegación conserva búsqueda y conecta las cinco pantallas', (
    tester,
  ) async {
    await tester.pumpWidget(const GameZoneApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Catálogo').last);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Minecraft');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Minecraft').last);
    await tester.pumpAndSettle();
    expect(find.text('Detalle del videojuego'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Perfil').last);
    await tester.pumpAndSettle();
    expect(find.byType(AvatarPerfil), findsOneWidget);
    await tester.tap(find.text('Favoritos').last);
    await tester.pumpAndSettle();
    expect(find.text('Todavía no tienes favoritos'), findsOneWidget);
    await tester.tap(find.text('Inicio').last);
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Abrir catálogo'));
    await tester.pumpAndSettle();
    expect(
      tester.widget<TextField>(find.byType(TextField)).controller!.text,
      'Minecraft',
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('Avatar admite nombre vacío y caracteres Unicode', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: AvatarPerfil(nombre: '')),
      ),
    );
    expect(find.text('?'), findsOneWidget);
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: AvatarPerfil(nombre: '🎮 Jugador')),
      ),
    );
    expect(find.text('🎮'), findsOneWidget);
  });

  testWidgets(
    'Perfil y estadísticas admiten texto grande en pantalla pequeña',
    (tester) async {
      tester.view.physicalSize = const Size(320, 480);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: const TextScaler.linear(2)),
            child: child!,
          ),
          home: const PerfilScreen(),
        ),
      );
      await tester.scrollUntilVisible(
      find.text('Géneros en tus favoritos'),
        100,
      );
      expect(tester.takeException(), isNull);
    },
  );
}
