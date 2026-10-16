import 'package:flutter/material.dart';

import 'catalogo_screen.dart';
import 'favoritos_screen.dart';
import 'inicio_screen.dart';
import 'perfil_screen.dart';

class NavegacionScreen extends StatefulWidget {
  const NavegacionScreen({super.key});

  @override
  State<NavegacionScreen> createState() => _NavegacionScreenState();
}

class _NavegacionScreenState extends State<NavegacionScreen> {
  int indice = 0;
  late final List<Widget> pantallas = [
    InicioScreen(
      alAbrirCatalogo: () => seleccionar(1),
      alAbrirFavoritos: () => seleccionar(2),
    ),
    const CatalogoScreen(),
    const FavoritosScreen(),
    const PerfilScreen(),
  ];

  void seleccionar(int nuevoIndice) => setState(() => indice = nuevoIndice);

  @override
  Widget build(BuildContext context) => Scaffold(
    body: IndexedStack(index: indice, children: pantallas),
    bottomNavigationBar: NavigationBar(
      selectedIndex: indice,
      onDestinationSelected: seleccionar,
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Principal'),
        NavigationDestination(
          icon: Icon(Icons.grid_view_rounded),
          label: 'Catálogo',
        ),
        NavigationDestination(
          icon: Icon(Icons.favorite_border),
          label: 'Favoritos',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          label: 'Perfil',
        ),
      ],
    ),
  );
}
