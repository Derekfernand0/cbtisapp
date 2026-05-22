// lib/features/test/test_screen.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math'; // Importación necesaria para la aleatoriedad
import '../../core/theme/app_theme.dart';

// Modelo de la pregunta
class Question {
  final String text;
  final String specialtyId;
  Question(this.text, this.specialtyId);
}

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int _currentIndex = 0;
  bool _isFinished = false;

  // Lista que contendrá las 30 preguntas generadas aleatoriamente para el intento actual
  final List<Question> _currentTestQuestions = [];

  // Puntuaciones acumuladas por especialidad
  final Map<String, int> _scores = {
    'Programación': 0,
    'Electricidad': 0,
    'Soporte': 0,
    'Ciberseguridad': 0,
    'Contabilidad': 0,
    'Alimentos': 0,
  };

  // BANCO DE PREGUNTAS: 120 preguntas en total (20 por especialidad)
  final List<Question> _questionBank = [
    // --- PROGRAMACIÓN (20) ---
    Question(
        '¿Te apasiona descubrir cómo funcionan los algoritmos detrás de las redes sociales?',
        'Programación'),
    Question(
        '¿Te motiva pasar horas buscando un error lógico en una estructura de código hasta que funcione?',
        'Programación'),
    Question(
        '¿Te interesa aprender sobre Inteligencia Artificial y automatización de procesos?',
        'Programación'),
    Question(
        '¿Disfrutas diseñando soluciones digitales que faciliten la vida de otras personas?',
        'Programación'),
    Question(
        '¿Prefieres trabajar en proyectos donde el pensamiento abstracto y matemático son clave?',
        'Programación'),
    Question(
        '¿Te gustaría aprender a crear y gestionar bases de datos para aplicaciones?',
        'Programación'),
    Question(
        '¿Te llama la atención el desarrollo de videojuegos y su programación interna?',
        'Programación'),
    Question(
        '¿Estarías dispuesto a aprender múltiples lenguajes como Python, Java o C++?',
        'Programación'),
    Question(
        '¿Te interesa entender cómo el software se comunica con el hardware?',
        'Programación'),
    Question(
        '¿Te gustaría optimizar el rendimiento y la velocidad de una aplicación móvil?',
        'Programación'),
    Question(
        '¿Te divierte diseñar interfaces de usuario (UI/UX) intuitivas y visuales?',
        'Programación'),
    Question(
        '¿Te interesa la domótica o la programación de pequeños robots (Arduino/Raspberry)?',
        'Programación'),
    Question(
        '¿Te gustaría trabajar en equipos de desarrollo usando metodologías ágiles (Scrum)?',
        'Programación'),
    Question(
        '¿Eres bueno resolviendo acertijos y rompecabezas lógicos complejos?',
        'Programación'),
    Question('¿Te gustaría crear páginas web desde cero usando código puro?',
        'Programación'),
    Question(
        '¿Sientes curiosidad por usar terminales y consolas de comandos en lugar de ventanas?',
        'Programación'),
    Question('¿Te interesaría analizar grandes volúmenes de datos (Big Data)?',
        'Programación'),
    Question(
        '¿Participarías en un Hackatón para programar una solución en 24 horas?',
        'Programación'),
    Question(
        '¿Te llama la atención la programación detrás de los servidores (Backend)?',
        'Programación'),
    Question(
        '¿Harías scripts de código para automatizar tareas repetitivas en tu computadora?',
        'Programación'),

    // --- ELECTRICIDAD (20) ---
    Question(
        '¿Te sientes cómodo trabajando con herramientas físicas y diagramas?',
        'Electricidad'),
    Question(
        '¿Te interesa la generación de energías limpias y paneles solares?',
        'Electricidad'),
    Question('¿Te gustaría aprender a reparar y embobinar motores eléctricos?',
        'Electricidad'),
    Question(
        '¿Prefieres el trabajo práctico de campo instalando sistemas de iluminación?',
        'Electricidad'),
    Question(
        '¿Te intriga saber cómo funcionan las protecciones y breakers de una fábrica?',
        'Electricidad'),
    Question(
        '¿Te preguntas cómo se distribuye la energía desde la planta hasta tu casa?',
        'Electricidad'),
    Question(
        '¿Te gustaría saber diagnosticar por qué un electrodoméstico dejó de funcionar?',
        'Electricidad'),
    Question(
        '¿Serías capaz de diseñar el plano del cableado completo de una vivienda?',
        'Electricidad'),
    Question(
        '¿Te llama la atención usar herramientas de medición como multímetros y pinzas perimétricas?',
        'Electricidad'),
    Question(
        '¿Estarías dispuesto a trabajar con normas estrictas de seguridad para alta tensión?',
        'Electricidad'),
    Question(
        '¿Te interesa la programación de Controladores Lógicos Programables (PLC) industriales?',
        'Electricidad'),
    Question(
        '¿Te gustaría dar mantenimiento preventivo a transformadores de energía?',
        'Electricidad'),
    Question(
        '¿Tienes facilidad para entender las diferencias entre circuitos en serie y en paralelo?',
        'Electricidad'),
    Question(
        '¿Disfrutas reparando fallos en instalaciones cuando se va la luz?',
        'Electricidad'),
    Question(
        '¿Te gustaría usar software de diseño (AutoCAD) para trazar planos eléctricos?',
        'Electricidad'),
    Question(
        '¿Te interesa ensamblar y organizar tableros de control industrial?',
        'Electricidad'),
    Question(
        '¿Te llama la atención la automatización de maquinarias en fábricas?',
        'Electricidad'),
    Question(
        '¿Eres meticuloso y cuidadoso al manipular cables y empalmes eléctricos?',
        'Electricidad'),
    Question(
        '¿Te gustaría entender la relación entre electricidad y magnetismo aplicado a motores?',
        'Electricidad'),
    Question(
        '¿Te interesaría tener tu propio negocio de instalación y mantenimiento eléctrico residencial?',
        'Electricidad'),

    // --- SOPORTE Y GESTIÓN DE TI (20) ---
    Question(
        '¿Eres la persona a la que todos acuden cuando una PC deja de funcionar?',
        'Soporte'),
    Question(
        '¿Te interesa el ensamblaje de hardware y armar computadoras desde cero?',
        'Soporte'),
    Question(
        '¿Disfrutas configurando redes LAN y garantizando una conectividad estable?',
        'Soporte'),
    Question(
        '¿Te gustaría especializarte en el mantenimiento preventivo de tecnología?',
        'Soporte'),
    Question(
        '¿Te motiva aprender a instalar y gestionar sistemas operativos Windows o Linux?',
        'Soporte'),
    Question(
        '¿Te gustaría gestionar cuentas de usuario y permisos en una empresa?',
        'Soporte'),
    Question('¿Te divierte configurar y optimizar routers, módems y switches?',
        'Soporte'),
    Question(
        '¿Tienes paciencia para detectar por qué una computadora se volvió lenta y solucionarlo?',
        'Soporte'),
    Question(
        '¿Te visualizas trabajando en una mesa de ayuda (Help Desk) atendiendo problemas técnicos?',
        'Soporte'),
    Question(
        '¿Te gustaría aprender a clonar discos duros y gestionar copias de respaldo corporativas?',
        'Soporte'),
    Question(
        '¿Sabes o quieres aprender a configurar impresoras en red para una oficina entera?',
        'Soporte'),
    Question(
        '¿Te relaja abrir una computadora para limpiarla y cambiarle la pasta térmica?',
        'Soporte'),
    Question(
        '¿Te interesaría administrar y mantener servidores locales en funcionamiento 24/7?',
        'Soporte'),
    Question(
        '¿Te gustaría aprender técnicas para recuperar archivos borrados por accidente?',
        'Soporte'),
    Question(
        '¿Acostumbras mantener los drivers, BIOS y firmware de tus equipos siempre actualizados?',
        'Soporte'),
    Question(
        '¿Te llama la atención aprender a ponchar cables de red UTP estructurado?',
        'Soporte'),
    Question(
        '¿Sabrías diagnosticar si una falla es de la memoria RAM o de la fuente de poder?',
        'Soporte'),
    Question(
        '¿Te gustaría brindar asistencia y control remoto a usuarios con problemas técnicos?',
        'Soporte'),
    Question(
        '¿Disfrutas comparando especificaciones de piezas para armar una Workstation potente?',
        'Soporte'),
    Question(
        '¿Te interesaría monitorear el ancho de banda y la salud de una red escolar o empresarial?',
        'Soporte'),

    // --- CIBERSEGURIDAD (20) ---
    Question(
        '¿Te preocupa la privacidad de los datos en internet y cómo protegerlos?',
        'Ciberseguridad'),
    Question(
        '¿Te interesa aprender técnicas de "hacking ético" para encontrar vulnerabilidades?',
        'Ciberseguridad'),
    Question(
        '¿Te gustaría monitorear redes para detectar ataques digitales en tiempo real?',
        'Ciberseguridad'),
    Question(
        '¿Disfrutas investigando sobre encriptación y protocolos de seguridad en la web?',
        'Ciberseguridad'),
    Question(
        '¿Te visualizas trabajando como analista forense digital tras un hackeo?',
        'Ciberseguridad'),
    Question(
        '¿Te intriga saber cómo asegurar una red WiFi corporativa contra intrusos?',
        'Ciberseguridad'),
    Question(
        '¿Eres bueno identificando correos falsos y técnicas de Phishing o ingeniería social?',
        'Ciberseguridad'),
    Question(
        '¿Te gustaría configurar Firewalls avanzados para bloquear tráfico malicioso?',
        'Ciberseguridad'),
    Question(
        '¿Participarías en programas de recompensas buscando fallos en páginas web (Bug Bounty)?',
        'Ciberseguridad'),
    Question(
        '¿Te interesa entender el código de virus, troyanos y ransomware para neutralizarlos?',
        'Ciberseguridad'),
    Question(
        '¿Te gustaría liderar el plan de recuperación de una empresa tras un ciberataque?',
        'Ciberseguridad'),
    Question(
        '¿Crees que proteger las bases de datos de clientes es la parte más vital de una empresa?',
        'Ciberseguridad'),
    Question(
        '¿Te gustaría usar sistemas operativos orientados a pruebas de penetración como Kali Linux?',
        'Ciberseguridad'),
    Question(
        '¿Te interesaría auditar la seguridad lógica y las contraseñas de toda una organización?',
        'Ciberseguridad'),
    Question(
        '¿Te llama la atención implementar sistemas de autenticación de dos factores (2FA)?',
        'Ciberseguridad'),
    Question(
        '¿Te gustaría administrar VPNs corporativas para conexiones seguras a distancia?',
        'Ciberseguridad'),
    Question(
        '¿Tienes interés en estudiar las leyes y regulaciones sobre delitos informáticos?',
        'Ciberseguridad'),
    Question(
        '¿Te gustaría aprender esteganografía para ocultar información dentro de imágenes?',
        'Ciberseguridad'),
    Question(
        '¿Te parece interesante proteger las transacciones y tokens bancarios en línea?',
        'Ciberseguridad'),
    Question(
        '¿Te gustaría pasar horas analizando registros (logs) para rastrear el origen de un ataque?',
        'Ciberseguridad'),

    // --- CONTABILIDAD (20) ---
    Question(
        '¿Eres una persona sumamente organizada con los registros y tus finanzas personales?',
        'Contabilidad'),
    Question(
        '¿Te interesa el mundo de las leyes fiscales, los impuestos y el SAT?',
        'Contabilidad'),
    Question(
        '¿Disfrutas analizando reportes financieros para detectar fugas de dinero?',
        'Contabilidad'),
    Question(
        '¿Te gustaría aprender a realizar auditorías para verificar la transparencia de una empresa?',
        'Contabilidad'),
    Question(
        '¿Prefieres un entorno de trabajo donde el orden documental y numérico es vital?',
        'Contabilidad'),
    Question(
        '¿Te interesaría aprender a calcular nóminas, seguros y prestaciones de empleados?',
        'Contabilidad'),
    Question(
        '¿Eres bueno o te gustaría dominar Excel y hojas de cálculo a nivel profesional?',
        'Contabilidad'),
    Question(
        '¿Te visualizas proyectando presupuestos y metas económicas anuales?',
        'Contabilidad'),
    Question(
        '¿Te gustaría tener las bases financieras para emprender y administrar tu propio negocio?',
        'Contabilidad'),
    Question(
        '¿Sientes curiosidad por cómo funciona la bolsa de valores y las inversiones empresariales?',
        'Contabilidad'),
    Question(
        '¿Te gustaría saber cómo calcular el retorno de inversión y la rentabilidad de un proyecto?',
        'Contabilidad'),
    Question(
        '¿Llevarías un registro meticuloso de ingresos y egresos (libro diario/mayor)?',
        'Contabilidad'),
    Question(
        '¿Te interesa aprender a realizar declaraciones anuales de personas físicas y morales?',
        'Contabilidad'),
    Question(
        '¿Te atrae la idea de trabajar en instituciones bancarias o de crédito?',
        'Contabilidad'),
    Question(
        '¿Eres lo suficientemente observador para detectar errores o posibles fraudes financieros?',
        'Contabilidad'),
    Question(
        '¿Te gustaría llevar la gestión de inventarios y analizar costos de producción?',
        'Contabilidad'),
    Question(
        '¿Te visualizas interpretando balances generales para los directivos de una compañía?',
        'Contabilidad'),
    Question(
        '¿Te gustaría ser el asesor estratégico que evite que una empresa quiebre?',
        'Contabilidad'),
    Question(
        '¿Tienes habilidad para administrar y optimizar el uso de recursos limitados?',
        'Contabilidad'),
    Question(
        '¿Te parece interesante aprender a leer, emitir y clasificar facturas electrónicas?',
        'Contabilidad'),

    // --- PRODUCCIÓN DE ALIMENTOS (20) ---
    Question(
        '¿Te interesa la ciencia y la química detrás de la conservación de la comida?',
        'Alimentos'),
    Question(
        '¿Disfrutas trabajando en laboratorios midiendo pH, acidez y biotecnología?',
        'Alimentos'),
    Question(
        '¿Te gustaría diseñar procesos industriales para crear nuevos productos comestibles?',
        'Alimentos'),
    Question(
        '¿Eres muy estricto con las normas de higiene y caducidad en lo que consumes?',
        'Alimentos'),
    Question(
        '¿Te motiva saber cómo transformar materia prima del campo en productos procesados?',
        'Alimentos'),
    Question(
        '¿Te llama la atención el proceso de fermentación (crear quesos, yogurt, bebidas)?',
        'Alimentos'),
    Question(
        '¿Sueles leer y analizar la información nutricional de las etiquetas en los supermercados?',
        'Alimentos'),
    Question(
        '¿Te visualizas como gerente de control de calidad en una fábrica empacadora?',
        'Alimentos'),
    Question(
        '¿Te gustaría aprender a operar la maquinaria industrial que procesa comida a gran escala?',
        'Alimentos'),
    Question(
        '¿Estarías dispuesto a cultivar e identificar microorganismos en cajas Petri?',
        'Alimentos'),
    Question(
        '¿Te sentirías cómodo usando batas, cofias y equipo de bioseguridad diariamente?',
        'Alimentos'),
    Question(
        '¿Te gusta experimentar para mejorar el sabor, color o textura de un alimento?',
        'Alimentos'),
    Question(
        '¿Te apasiona garantizar que los alimentos lleguen seguros y sin contaminación al público?',
        'Alimentos'),
    Question(
        '¿Quieres conocer a fondo técnicas térmicas como la pasteurización y esterilización?',
        'Alimentos'),
    Question(
        '¿Te interesaría formular dietas o productos especiales (sin gluten, bajos en sodio)?',
        'Alimentos'),
    Question(
        '¿Te gustaría emprender tu propia marca de alimentos artesanales o envasados?',
        'Alimentos'),
    Question(
        '¿Te divierte la idea de dirigir paneles de pruebas sensoriales (degustación de productos)?',
        'Alimentos'),
    Question(
        '¿Te gustaría aprender a gestionar la "cadena de frío" para evitar descomposiciones?',
        'Alimentos'),
    Question(
        '¿Sientes curiosidad por el uso regulado de aditivos y conservadores químicos permitidos?',
        'Alimentos'),
    Question(
        '¿Te gustaría dominar las normativas internacionales (ISO) de inocuidad alimentaria?',
        'Alimentos'),
  ];

  @override
  void initState() {
    super.initState();
    _generateRandomTest();
  }

  // --- LÓGICA DEL BANCO DE PREGUNTAS ALEATORIAS ---
  void _generateRandomTest() {
    final random = Random();
    _currentTestQuestions.clear();

    // Obtenemos los nombres de las 6 especialidades de las llaves del mapa de puntajes
    final List<String> specialties = _scores.keys.toList();

    // 1. Iteramos sobre cada especialidad
    for (String specialty in specialties) {
      // 2. Filtramos todas las preguntas que pertenecen a esta especialidad (son 20)
      List<Question> specialtyQuestions =
          _questionBank.where((q) => q.specialtyId == specialty).toList();

      // 3. Mezclamos esas 20 preguntas
      specialtyQuestions.shuffle(random);

      // 4. Tomamos exactamente las primeras 5 y las añadimos al examen actual
      _currentTestQuestions.addAll(specialtyQuestions.take(5));
    }

    // 5. Finalmente, mezclamos las 30 preguntas resultantes para que el orden sea totalmente aleatorio
    _currentTestQuestions.shuffle(random);
  }

  // Función para registrar la respuesta y avanzar
  void _answerQuestion(int points) {
    final currentSpecialty = _currentTestQuestions[_currentIndex].specialtyId;

    setState(() {
      _scores[currentSpecialty] = (_scores[currentSpecialty] ?? 0) + points;

      if (_currentIndex < _currentTestQuestions.length - 1) {
        _currentIndex++;
      } else {
        _isFinished = true;
      }
    });
  }

  void _resetTest() {
    setState(() {
      _currentIndex = 0;
      _isFinished = false;
      // Ponemos los puntajes en cero
      _scores.updateAll((key, value) => 0);
      // ¡Generamos un examen totalmente nuevo para el siguiente intento!
      _generateRandomTest();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Test Vocacional'),
        elevation: 0,
      ),
      body: _isFinished ? _buildResults() : _buildQuiz(),
    );
  }

  // UI del Cuestionario
  Widget _buildQuiz() {
    final progress = (_currentIndex + 1) / _currentTestQuestions.length;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Barra de progreso
          Text(
            'Pregunta ${_currentIndex + 1} de ${_currentTestQuestions.length}',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppTheme.burgundy,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.shade300,
            valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.burgundy),
            minHeight: 10,
            borderRadius: BorderRadius.circular(5),
          ),
          const SizedBox(height: 40),

          // Pregunta con transición suave
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(
                _currentTestQuestions[_currentIndex].text,
                key: ValueKey<int>(_currentIndex),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textDark,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Botones de respuesta
          _buildAnswerButton('¡Me encanta!', 3, Colors.green.shade600),
          const SizedBox(height: 15),
          _buildAnswerButton('Me parece bien', 2, Colors.blue.shade600),
          const SizedBox(height: 15),
          _buildAnswerButton('Poco', 1, Colors.orange.shade600),
          const SizedBox(height: 15),
          _buildAnswerButton('Nada', 0, Colors.red.shade600),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildAnswerButton(String text, int points, Color color) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: AppTheme.white,
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 2,
      ),
      onPressed: () => _answerQuestion(points),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  // UI de los Resultados (Gráfica y Top 3)
  Widget _buildResults() {
    // Ordenar puntajes para obtener el Top 3
    final sortedScores = _scores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final top3 = sortedScores.take(3).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Icon(Icons.emoji_events, size: 80, color: Colors.amber),
          const SizedBox(height: 10),
          Text(
            '¡Test Completado!',
            style: Theme.of(context)
                .textTheme
                .displayLarge
                ?.copyWith(fontSize: 28),
          ),
          const SizedBox(height: 20),

          Text(
            'Tus áreas de mayor compatibilidad:',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),

          // Mostrar el podio del Top 3
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildTopItem(top3[0], Icons.looks_one, Colors.amber, 20),
                const Divider(),
                _buildTopItem(top3[1], Icons.looks_two, Colors.grey, 18),
                const Divider(),
                _buildTopItem(top3[2], Icons.looks_3, Colors.brown, 18),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Contenedor de la Gráfica
          Container(
            height: 250,
            padding: const EdgeInsets.only(top: 20, right: 20, bottom: 10),
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 15,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const titles = [
                          'Prog',
                          'Elec',
                          'Sop',
                          'Ciber',
                          'Conta',
                          'Alim'
                        ];
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            titles[value.toInt()],
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                barGroups:
                    _scores.entries.toList().asMap().entries.map((entry) {
                  int index = entry.key;
                  double score = entry.value.value.toDouble();
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: score,
                        color: AppTheme.burgundy,
                        width: 20,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(5)),
                        backDrawRodData: BackgroundBarChartRodData(
                          show: true,
                          toY:
                              15, // Puntuación máxima por especialidad (5 preguntas x 3 pts = 15)
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 30),

          // Botón para reiniciar (ahora generará nuevas preguntas)
          OutlinedButton.icon(
            onPressed: _resetTest,
            icon: const Icon(Icons.refresh, color: AppTheme.burgundy),
            label: const Text('Volver a intentar (Nuevas Preguntas)',
                style: TextStyle(color: AppTheme.burgundy)),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              side: const BorderSide(color: AppTheme.burgundy, width: 2),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
            ),
          ),
        ],
      ),
    );
  }

  // Widget auxiliar para las filas del Top 3
  Widget _buildTopItem(MapEntry<String, int> entry, IconData icon, Color color,
      double fontSize) {
    return ListTile(
      leading: Icon(icon, color: color, size: 30),
      title: Text(
        entry.key,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
            color: AppTheme.textDark),
      ),
      trailing: Text('${entry.value} pts',
          style:
              const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
    );
  }
}
