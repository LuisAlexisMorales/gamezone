import 'package:flutter/material.dart';

import '../services/favoritos_service.dart';
import '../widgets/avatar_perfil.dart';
import '../widgets/tarjeta_estadistica.dart';

class PerfilScreen extends StatefulWidget {
  final FavoritosService? servicio;
  const PerfilScreen({super.key, this.servicio});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  String nombre = 'Jugador';
  final controlador = TextEditingController();

  @override
  void dispose() {
    controlador.dispose();
    super.dispose();
  }

  Future<void> editarNombre() async {
    controlador.text = nombre;
    final formulario = GlobalKey<FormState>();
    final nuevoNombre = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar nombre'),
        content: Form(
          key: formulario,
          child: TextFormField(
            controller: controlador,
            autofocus: true,
            maxLength: 40,
            decoration: const InputDecoration(labelText: 'Nombre'),
            validator: (valor) => valor == null || valor.trim().isEmpty
                ? 'Escribe tu nombre'
                : null,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              if (formulario.currentState!.validate()) {
                Navigator.pop(context, controlador.text.trim());
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
    if (mounted && nuevoNombre != null) setState(() => nombre = nuevoNombre);
  }

  @override
  Widget build(BuildContext context) {
    final servicio = widget.servicio ?? FavoritosService.instancia;
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: ListenableBuilder(
        listenable: servicio,
        builder: (context, child) {
          final favoritos = servicio.favoritos;
          final generos = favoritos.map((juego) => juego.genero).toSet();
          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Center(child: AvatarPerfil(nombre: nombre)),
              const SizedBox(height: 16),
              Text(
                nombre,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Center(
                child: TextButton.icon(
                  onPressed: editarNombre,
                  icon: const Icon(Icons.edit),
                  label: const Text('Editar nombre'),
                ),
              ),
              const Text(
                'Tu perfil y tus favoritos se guardan durante esta sesión.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              TarjetaEstadistica(
                icono: Icons.favorite,
                titulo: 'Videojuegos favoritos',
                valor: '${favoritos.length}',
              ),
              TarjetaEstadistica(
                icono: Icons.category,
                titulo: 'Géneros en tus favoritos',
                valor: '${generos.length}',
              ),
            ],
          );
        },
      ),
    );
  }
}
