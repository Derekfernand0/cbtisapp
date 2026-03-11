// lib/features/specialties/specialty_model.dart

class Specialty {
  final String id;
  final String name;
  final String imagePath;
  final String description;
  final String videoUrl;

  Specialty({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.description,
    required this.videoUrl,
  });
}

// Lista estática con los datos de las especialidades
final List<Specialty> cbtisSpecialties = [
  Specialty(
    id: 'prog',
    name: 'Programación',
    imagePath: 'assets/images/programacion.png',
    description:
        'Aprende a desarrollar software, aplicaciones móviles y sitios web utilizando lenguajes modernos y metodologías ágiles. \n\n(Aquí agregaremos toda la información del folleto).',
    videoUrl:
        'https://www.youtube.com/watch?v=dQw4w9WgXcQ', // Link de prueba (cambiar después)
  ),
  Specialty(
    id: 'elec',
    name: 'Electricidad',
    imagePath: 'assets/images/electricidad.png',
    description:
        'Mantenimiento de sistemas eléctricos, residenciales e industriales.',
    videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
  ),
  Specialty(
    id: 'soporte',
    name: 'Soporte y Mantenimiento',
    imagePath: 'assets/images/soporte y mantenimiento.png',
    description:
        'Ensambla, configura y repara equipos de cómputo y redes locales.',
    videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
  ),
  Specialty(
    id: 'ciber',
    name: 'Ciberseguridad',
    imagePath: 'assets/images/ciberseguridad.png',
    description:
        'Protege infraestructuras, redes y datos contra ataques digitales.',
    videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
  ),
  Specialty(
    id: 'conta',
    name: 'Contabilidad',
    imagePath: 'assets/images/contabilidad.png',
    description:
        'Gestiona el control financiero, fiscal y administrativo de empresas.',
    videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
  ),
  Specialty(
    id: 'alim',
    name: 'Producción de Alimentos',
    imagePath: 'assets/images/alimentos.png',
    description:
        'Procesamiento, conservación y control de calidad de productos alimenticios.',
    videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
  ),
];
