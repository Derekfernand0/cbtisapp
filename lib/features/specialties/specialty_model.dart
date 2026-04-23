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

// Lista estática con los datos reales de las especialidades del CBTIS 66
final List<Specialty> cbtisSpecialties = [
  Specialty(
    id: 'prog',
    name: 'Programación',
    imagePath: 'assets/images/programacion.png',
    description: '''OBJETIVO:
Esta carrera de técnico ofrece las competencias profesionales que permiten al estudiante realizar actividades dirigidas a: analizar, diseñar, desarrollar, instalar, y mantener software de aplicación tomando como base los requerimientos del usuario.

CAMPO LABORAL:
• Trabajos en edición de software
• Servicios de diseño de sistemas de cómputo
• Escuelas de computación del sector público y privado

INGRESO AL NIVEL SUPERIOR EN:
• Ing. en Sistemas computacionales
• Ing. en Software y redes
• Ing. en Informática
• Ing. en Tecnologías computacionales
• Lic. en Analista de sistemas
• Lic. Bioinformática''',
    videoUrl: 'assets/videos/PR.mp4',
  ),
  Specialty(
    id: 'elec',
    name: 'Electricidad',
    imagePath: 'assets/images/electricidad.png',
    description: '''OBJETIVO:
Esta carrera de técnico ofrece las competencias profesionales que permiten al estudiante sustentar la demanda de ocupación de Técnicos Electricistas en el sector productivo y de servicios, capaz de diseñar y realizar instalaciones eléctricas residenciales y comerciales, así como proporcionar mantenimiento a máquinas eléctricas.

CAMPO LABORAL:
• Eléctrico en sistemas de iluminación
• Auxiliar eléctrico
• Emprendedor de servicios eléctricos
• Instalador de sistemas eléctricos residenciales o comerciales

INGRESO AL NIVEL SUPERIOR EN:
• Ing. Eléctrico
• Ing. Mecatrónica
• Ing. Industrial
• Ing. Electromecánico
• Ing. en Energías renovables
• Ing. Electrónica
• Ing. en Programación PLC''',
    videoUrl: 'assets/videos/EL.mp4',
  ),
  Specialty(
    id: 'soporte',
    name: 'Soporte y Gestión de TI',
    imagePath: 'assets/images/soporte y mantenimiento.png',
    description: '''OBJETIVO:
La carrera habilita a los egresados para la instalación y mantenimiento de redes y dispositivos electrónicos, instalación de hardware y software, proporcionando soporte técnico al cliente e integrándolo a la vida laboral con un pensamiento crítico, científico, holista y sistemático.

CAMPO LABORAL:
• Jefe de soporte técnico
• Analista de mantenimiento
• Computación electrónica
• Auxiliar de informática
• Servicios de telecomunicaciones
• Ensamble de equipos de cómputo

INGRESO AL NIVEL SUPERIOR EN:
• Ing. Sistemas computacionales
• Ing. Electrónica
• Ing. Industrial
• Ing. Mecatrónica
• Ing. Robótica''',
    videoUrl: 'assets/videos/SP.mp4',
  ),
  Specialty(
    id: 'ciber',
    name: 'Ciberseguridad',
    imagePath: 'assets/images/ciberseguridad.png',
    description: '''OBJETIVO:
La carrera permite al egresado salvaguardar la integridad de los sistemas informáticos contra amenazas cibernéticas, empleando herramientas, procedimientos y aplicación de la normativa vigente de seguridad, para mantener los sistemas en operación en un entorno digital y conectado.

CAMPO LABORAL:
• Analista de seguridad
• Ethical hacker
• Forense digital
• Arquitecto de seguridad

INGRESO AL NIVEL SUPERIOR EN:
• Ingeniería en inteligencia de datos
• Inteligencia en ciberseguridad
• Ingeniería informática''',
    videoUrl: 'assets/videos/CI.mp4',
  ),
  Specialty(
    id: 'conta',
    name: 'Contabilidad',
    imagePath: 'assets/images/contabilidad.png',
    description: '''OBJETIVO:
Esta carrera de técnico ofrece las competencias profesionales que permiten al estudiante registrar operaciones contables de empresas comerciales y de servicios operando los procesos contables a través de un sistema electrónico, así como registrar operaciones contables de una entidad fabril, determinar contribuciones y asistir en actividades de auditoría.

CAMPO LABORAL:
• Auxiliar de contabilidad
• Instituciones bancarias
• Instituciones de préstamos y de servicios

INGRESO AL NIVEL SUPERIOR EN:
• Lic. en Contabilidad
• Lic. en Administración
• Lic. en Economía
• Lic. en Gestión y dirección de negocios
• Lic. en Administración de empresas turísticas''',
    videoUrl: 'assets/videos/CO.mp4',
  ),
  Specialty(
    id: 'alim',
    name: 'Producción de Alimentos',
    imagePath: 'assets/images/alimentos.png',
    description: '''OBJETIVO:
Permite al egresado, a través de la articulación de saberes de diversos campos, realizar los análisis físicos, químicos y microbiológicos para proceso de alimentos y su conservación de acuerdo a las normativas vigentes de calidad, inocuidad y seguridad nacionales e internacionales.

CAMPO LABORAL:
• Industria agroalimentaria
• Apoyo de la gerencia de producción
• Apoyo en la gerencia de proyectos
• Crear su propia empresa
• Mercadotecnia de autoservicio
• Planeador de inventarios
• Supervisión de embarques
• Administrador de procesos de calidad
• Analista de gestión de la calidad
• Asistente de formulación y desarrollo
• Coordinador de producción
• Gerente de restaurante

INGRESO AL NIVEL SUPERIOR EN:
• Ing. Industrias alimentarias
• Ing. Ambiental
• Ing. Agroindustrial
• Ing. Agrícola sustentable
• Ing. Industrial
• Ing. Químico industrial
• Ing. Química en alimentos
• Lic. en Enfermería
• Lic. en Médico cirujano
• Lic. en Nutrición''',
    videoUrl: 'assets/videos/AL.mp4',
  ),
];
