import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gamezone/main.dart';
import 'package:gamezone/models/videojuego.dart';
import 'package:gamezone/screens/favoritos_screen.dart';
import 'package:gamezone/services/favoritos_service.dart';
import 'package:gamezone/widgets/boton_favorito.dart';
import 'package:gamezone/widgets/estado_vacio.dart';

Videojuego juego(int id) => Videojuego(
  id: id,
  nombre: 'Juego $id',
  genero: 'Aventura',
  plataforma: 'PC',
  calificacion: 9,
  descripcion: 'Una aventura.',
  imagen: 'https://example.com/juego$id.jpg',
);

void main() {
  late FavoritosService servicio;
  setUp(() => servicio = FavoritosService());
  tearDown(() => servicio.dispose());

  test('Evita duplicados por ID y notifica solamente cambios reales', () {
    var cambios = 0;
    servicio.addListener(() => cambios++);
    servicio.agregar(juego(1));
    servicio.agregar(juego(1));
    servicio.eliminar(99);
    expect(servicio.favoritos.length, 1);
    expect(servicio.esFavorito(1), isTrue);
    expect(cambios, 1);
    servicio.eliminar(1);
    expect(servicio.favoritos, isEmpty);
    expect(cambios, 2);
  });

  test('Expone una copia inmutable y alterna favoritos independientes', () {
    servicio.agregar(juego(1));
    final copia = servicio.favoritos;
    expect(() => copia.clear(), throwsUnsupportedError);
    servicio.alternar(juego(2));
    servicio.alternar(juego(1));
    expect(copia.length, 1);
    expect(servicio.favoritos.single.id, 2);
  });

  testWidgets('Dos corazones se sincronizan con el mismo servicio', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Row(
            children: [
              BotonFavorito(videojuego: juego(1), servicio: servicio),
              BotonFavorito(videojuego: juego(1), servicio: servicio),
            ],
          ),
        ),
      ),
    );
    await tester.tap(find.byType(IconButton).first);
    await tester.pump();
    expect(find.byTooltip('Quitar de favoritos'), findsNWidgets(2));
    await tester.tap(find.byType(IconButton).last);
    await tester.pump();
    expect(find.byTooltip('Agregar a favoritos'), findsNWidgets(2));
  });

  testWidgets('Lista, detalle, eliminación y recuperación del estado vacío', (
    tester,
  ) async {
    servicio.agregar(juego(1));
    await tester.pumpWidget(
      MaterialApp(home: FavoritosScreen(servicio: servicio)),
    );
    await tester.pumpAndSettle();
    expect(find.text('Juego 1'), findsOneWidget);
    expect(find.text('Aventura'), findsOneWidget);
    // Las imágenes de red fallan en widget tests: se debe mostrar el respaldo.
    expect(find.byIcon(Icons.videogame_asset), findsOneWidget);
    await tester.tap(find.text('Juego 1'));
    await tester.pumpAndSettle();
    expect(find.text('Detalle del videojuego'), findsOneWidget);
    await tester.tap(find.byTooltip('Quitar de favoritos').last);
    await tester.pump();
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.byType(EstadoVacio), findsOneWidget);
    servicio.agregar(juego(2));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Quitar de favoritos'));
    await tester.pumpAndSettle();
    expect(find.byType(EstadoVacio), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Estado vacío admite pantalla pequeña y texto ampliado', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 320);
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
        home: FavoritosScreen(servicio: servicio),
      ),
    );
    expect(find.byType(EstadoVacio), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Inicio permite abrir Favoritos', (tester) async {
    await tester.pumpWidget(const GameZoneApp());
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Abrir favoritos'));
    await tester.pumpAndSettle();
    expect(find.byType(FavoritosScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
