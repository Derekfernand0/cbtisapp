// lib/features/test/test_screen.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
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

  // Puntuaciones acumuladas por especialidad
  final Map<String, int> _scores = {
    'Programación': 0,
    'Electricidad': 0,
    'Soporte': 0,
    'Ciberseguridad': 0,
    'Contabilidad': 0,
    'Alimentos': 0,
  };

  // Las 30 preguntas (5 por especialidad) mezcladas lógicamente
  final List<Question> _questions = [
    Question(
        '¿Te gustaría crear tus propias aplicaciones móviles y páginas web?',
        'Programación'),
    Question(
        '¿Te interesa saber cómo funcionan las instalaciones eléctricas de una casa?',
        'Electricidad'),
    Question('¿Disfrutas armar, desarmar y reparar computadoras?', 'Soporte'),
    Question('¿Te llama la atención proteger sistemas contra hackers y virus?',
        'Ciberseguridad'),
    Question(
        '¿Eres organizado con el dinero y te gustan las matemáticas financieras?',
        'Contabilidad'),
    Question(
        '¿Te interesa el proceso industrial detrás de la creación y conservación de comida?',
        'Alimentos'),
    Question(
        '¿Te gusta resolver problemas lógicos y rompecabezas?', 'Programación'),
    Question(
        '¿Te visualizas trabajando con motores y circuitos eléctricos industriales?',
        'Electricidad'),
    Question(
        '¿Tus amigos te piden ayuda cuando su PC o internet falla?', 'Soporte'),
    Question(
        '¿Te gustaría investigar delitos informáticos y rastrear ataques web?',
        'Ciberseguridad'),
    Question('¿Te gustaría llevar la administración y control de una empresa?',
        'Contabilidad'),
    Question(
        '¿Disfrutas aprender sobre química, fermentación y control de calidad?',
        'Alimentos'),
    Question(
        '¿Podrías pasar horas frente a una computadora jugando o haciendo otras actividades?',
        'Programación'),
    Question(
        '¿Te gustaría usar herramientas manuales para reparar fallas de energía?',
        'Electricidad'),
    Question(
        '¿Te interesa configurar redes LAN e instalar software en empresas?',
        'Soporte'),
    Question(
        '¿Te apasiona la idea de encontrar vulnerabilidades en un sistema antes que un atacante?',
        'Ciberseguridad'),
    Question('¿Eres detallista revisando documentos, facturas y reportes?',
        'Contabilidad'),
    Question('¿Te gustaría innovar creando nuevos productos alimenticios?',
        'Alimentos'),
    Question('¿Te interesa la Inteligencia Artificial y cómo programarla?',
        'Programación'),
    Question(
        '¿Comprendes fácilmente diagramas físicos e instrucciones técnicas?',
        'Electricidad'),
    Question(
        '¿Te gusta mantener tus dispositivos electrónicos siempre actualizados y rápidos?',
        'Soporte'),
    Question('¿Te preocupa la privacidad de los datos en internet?',
        'Ciberseguridad'),
    Question('¿Te gustaría entender cómo se calculan los impuestos y nóminas?',
        'Contabilidad'),
    Question(
        '¿Te interesa conocer las normas de higiene en fábricas procesadoras?',
        'Alimentos'),
    Question(
        '¿Te frustras poco y eres persistente cuando algo no funciona a la primera?',
        'Programación'),
    Question(
        '¿Tienes habilidad manual y precaución para trabajar con herramientas físicas?',
        'Electricidad'),
    Question(
        '¿Te gusta investigar en foros cuando un programa marca error hasta solucionarlo?',
        'Soporte'),
    Question(
        '¿Conoces o te interesa aprender sobre encriptación de contraseñas?',
        'Ciberseguridad'),
    Question('¿Eres bueno liderando proyectos escolares y organizando tareas?',
        'Contabilidad'),
    Question(
        '¿Disfrutas el trabajo práctico en laboratorios con bata y equipo de seguridad?',
        'Alimentos'),
  ];

  // Función para registrar la respuesta y avanzar
  void _answerQuestion(int points) {
    final currentSpecialty = _questions[_currentIndex].specialtyId;

    setState(() {
      _scores[currentSpecialty] = (_scores[currentSpecialty] ?? 0) + points;

      if (_currentIndex < _questions.length - 1) {
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
      _scores.updateAll((key, value) => 0);
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
    final progress = (_currentIndex + 1) / _questions.length;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Barra de progreso
          Text(
            'Pregunta ${_currentIndex + 1} de ${_questions.length}',
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
                _questions[_currentIndex].text,
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
    // 1. Ordenamos las especialidades de mayor a menor puntaje
    var sortedScores = _scores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value)); // Orden descendente

    // 2. Extraemos el Top 3
    var top3 = sortedScores.take(3).toList();

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

          // --- NUEVO: MOSTRAR EL TOP 3 ---
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
                // 🥇 Primer Lugar
                ListTile(
                  leading: const Icon(Icons.looks_one,
                      color: Colors.amber, size: 36),
                  title: Text(
                    top3[0].key,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppTheme.burgundy),
                  ),
                  trailing: Text(
                    '${top3[0].value} pts',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
                const Divider(),
                // 🥈 Segundo Lugar
                ListTile(
                  leading:
                      const Icon(Icons.looks_two, color: Colors.grey, size: 30),
                  title: Text(
                    top3[1].key,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  trailing: Text(
                    '${top3[1].value} pts',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
                const Divider(),
                // 🥉 Tercer Lugar
                ListTile(
                  leading:
                      const Icon(Icons.looks_3, color: Colors.brown, size: 30),
                  title: Text(
                    top3[2].key,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  trailing: Text(
                    '${top3[2].value} pts',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Contenedor de la Gráfica (Se mantiene igual para contexto visual)
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
                          toY: 15,
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

          // Botón para reiniciar
          OutlinedButton.icon(
            onPressed: _resetTest,
            icon: const Icon(Icons.refresh, color: AppTheme.burgundy),
            label: const Text('Volver a intentar',
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
}
