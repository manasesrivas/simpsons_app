class Personaje {
  final int id;
  final String nombre;
  final String ocupacion;
  final String imagenUrl;
  final String edad;
  final String estado;

  Personaje({
    required this.id,
    required this.nombre,
    required this.ocupacion,
    required this.imagenUrl,
    required this.edad,
    required this.estado,
  });

  factory Personaje.fromJson(Map<String, dynamic> json) {
    final ruta = json['portrait_path'] as String?;
    return Personaje(
      id: json['id'],
      nombre: json['name'] ?? 'Sin nombre',
      ocupacion: json['occupation'],
      edad: json['age'].toString(),
      estado: json['status'] ?? 'desconocido',
      imagenUrl: 'https://cdn.thesimpsonsapi.com/500$ruta',
    );
  }
}