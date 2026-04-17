// lib/features/requirements/requirements_screen.dart
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class RequirementsScreen extends StatelessWidget {
  const RequirementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de requisitos con sus respectivos iconos
    final List<Map<String, dynamic>> requirementsList = [
      {'icon': Icons.cake, 'text': 'Copia del acta de nacimiento tamaño carta'},
      {
        'icon': Icons.badge,
        'text': 'Copia de la CURP actualizada ampliada a tamaño carta'
      },
      {
        'icon': Icons.school,
        'text':
            'Constancia de estudios de tercer grado de secundaria con promedio'
      },
      {'icon': Icons.verified_user, 'text': 'Constancia de buena conducta'},
      {'icon': Icons.photo_camera, 'text': 'Dos fotografías tamaño infantil'},
      {
        'icon': Icons.home,
        'text': 'Copia de comprobante de domicilio actualizado'
      },
      {
        'icon': Icons.credit_card,
        'text': 'Copia de credencial INE del padre o tutor'
      },
      {'icon': Icons.folder, 'text': 'Un folder tamaño carta azul marino'},
      {
        'icon': Icons.edit_document,
        'text': 'Llenar formato de datos del aspirante'
      },
    ];

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Solicitud de Ficha'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Encabezado llamativo
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(25),
            decoration: const BoxDecoration(
              color: AppTheme.burgundy,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                const Icon(Icons.inventory_2, size: 60, color: AppTheme.white),
                const SizedBox(height: 15),
                Text(
                  'Requisitos',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: AppTheme.white,
                        fontSize: 28,
                      ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Prepara tus documentos',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.white.withOpacity(0.9),
                      ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Lista de requerimientos
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              physics: const BouncingScrollPhysics(), // Scroll suave
              itemCount: requirementsList.length,
              itemBuilder: (context, index) {
                final item = requirementsList[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: const Border(
                        left: BorderSide(
                          color: AppTheme.burgundy,
                          width: 5,
                        ),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      leading: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppTheme.burgundy.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          item['icon'],
                          color: AppTheme.burgundy,
                        ),
                      ),
                      title: Text(
                        item['text'],
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      // Agregamos un número para que se vea como una lista ordenada visualmente
                      trailing: Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.withOpacity(0.3),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
