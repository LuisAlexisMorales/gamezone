class Videojuego {
  final int id;
  final String nombre;
  final String genero;
  final String plataforma;
  final double calificacion;
  final String descripcion;
  final String imagen;

  Videojuego({
    required this.id,
    required this.nombre,
    required this.genero,
    required this.plataforma,
    required this.calificacion,
    required this.descripcion,
    required this.imagen,
  });

  factory Videojuego.fromJson(Map<String, dynamic> json) {
    return Videojuego(
      id: json['id'] as int,
      nombre: json['nombre'] as String,
      genero: json['genero'] as String,
      plataforma: json['plataforma'] as String,
      calificacion: (json['calificacion'] as num).toDouble(),
      descripcion: json['descripcion'] as String,
      imagen: json['imagen'] as String,
    );
  }
}
