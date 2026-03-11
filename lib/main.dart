import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MiPrimerJuego());
}

// 1. La estructura base de la App
class MiPrimerJuego extends StatelessWidget {
  const MiPrimerJuego({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PantallaJuego(),
    );
  }
}

// 2. La pantalla del juego (Stateful porque cambia constantemente)
class PantallaJuego extends StatefulWidget {
  const PantallaJuego({super.key});

  @override
  State<PantallaJuego> createState() => _PantallaJuegoState();
}

class _PantallaJuegoState extends State<PantallaJuego> {
  // Variables del jugador y puntuación
  double jugadorX = 0; // -1 es izquierda, 1 es derecha
  int puntuacion = 0;

  // Variables de la bala
  double balaX = 0;
  double balaY = 1; // 1 es abajo, -1 es arriba
  bool disparando = false;

  // Variables del Invasor
  double enemigoX = 0;
  double enemigoY = -0.8;
  int direccionEnemigo = 1; // 1 derecha, -1 izquierda

  Timer? timer;

  @override
  void initState() {
    super.initState();
    iniciarJuego();
  }

  // 3. El "Motor" del juego: se ejecuta cada 30 milisegundos
  void iniciarJuego() {
    timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      actualizarJuego();
    });
  }

  void actualizarJuego() {
    setState(() {
      // Mover al enemigo de lado a lado
      enemigoX += 0.02 * direccionEnemigo;
      if (enemigoX >= 1 || enemigoX <= -1) {
        direccionEnemigo *= -1; // Cambia de dirección al chocar con la pared
        enemigoY += 0.1; // Baja un poco hacia el jugador
      }

      // Mover la bala si se disparó
      if (disparando) {
        balaY -= 0.05;
        if (balaY < -1) {
          disparando = false; // La bala salió de la pantalla
        }
      }

      // Detectar Colisión (Bala choca con enemigo)
      if (disparando &&
          (balaY - enemigoY).abs() < 0.1 &&
          (balaX - enemigoX).abs() < 0.2) {
        puntuacion += 10;
        disparando = false;
        balaY = 1;
        // Reiniciar al enemigo arriba
        enemigoY = -0.8;
        enemigoX = 0;
      }

      // Fin del juego (El enemigo llegó abajo)
      if (enemigoY > 0.8) {
        timer?.cancel();
        mostrarGameOver();
      }
    });
  }

  void mostrarGameOver() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('¡Fin del Juego!'),
        content: Text('Tu puntuación final fue: $puntuacion'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              reiniciarJuego();
            },
            child: const Text('Jugar de nuevo'),
          ),
        ],
      ),
    );
  }

  void reiniciarJuego() {
    setState(() {
      puntuacion = 0;
      enemigoY = -0.8;
      enemigoX = 0;
      jugadorX = 0;
      disparando = false;
      balaY = 1;
    });
    iniciarJuego();
  }

  // 4. Los controles táctiles
  void moverIzquierda() {
    setState(() {
      if (jugadorX > -0.8) jugadorX -= 0.2;
    });
  }

  void moverDerecha() {
    setState(() {
      if (jugadorX < 0.8) jugadorX += 0.2;
    });
  }

  void disparar() {
    if (!disparando) {
      setState(() {
        disparando = true;
        balaX = jugadorX;
        balaY = 0.8; // Sale desde la punta de la nave
      });
    }
  }

  // 5. Los "Gráficos" de nuestra app
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Espacio exterior
      body: Column(
        children: [
          // Pantalla del juego
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                // Texto de Puntuación
                Positioned(
                  top: 50,
                  left: 20,
                  child: Text(
                    'Puntos: $puntuacion',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // El Jugador (Nave)
                Container(
                  alignment: Alignment(jugadorX, 0.9),
                  child: const Icon(
                    Icons.rocket,
                    color: Colors.blueAccent,
                    size: 60,
                  ),
                ),
                // El Invasor
                Container(
                  alignment: Alignment(enemigoX, enemigoY),
                  child: const Icon(
                    Icons.adb,
                    color: Colors.greenAccent,
                    size: 50,
                  ),
                ),
                // La Bala
                if (disparando)
                  Container(
                    alignment: Alignment(balaX, balaY),
                    child: Container(
                      width: 4,
                      height: 20,
                      color: Colors.redAccent,
                    ),
                  ),
              ],
            ),
          ),
          // Controles (Botones)
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.grey[900],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: moverIzquierda,
                    icon: const Icon(
                      Icons.arrow_circle_left,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                    ),
                    onPressed: disparar,
                    child: const Text(
                      'FIRE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: moverDerecha,
                    icon: const Icon(
                      Icons.arrow_circle_right,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
