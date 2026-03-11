// lib/features/info/info_screen.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/app_theme.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  // Funciones para abrir los enlaces con url_launcher
  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('No se pudo abrir $urlString');
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Acerca del CBTIS 66'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Encabezado visual
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              decoration: const BoxDecoration(
                color: AppTheme.burgundy,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const Icon(Icons.school, size: 80, color: AppTheme.white),
                  const SizedBox(height: 15),
                  Text(
                    'CBTIS 66',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: AppTheme.white,
                          fontSize: 32,
                        ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Agustín de Iturbide',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.white.withOpacity(0.9),
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Tarjetas de información
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildInfoCard(
                    context,
                    icon: Icons.location_on,
                    title: 'Dirección',
                    subtitle:
                        '16 de septiembre esq. J.R claveria C.P 95110\nCol. Hoja del Maíz\nTierra Blanca, Veracruz',
                    onTap: () => _launchUrl(
                        'https://maps.google.com/?q=CBTis+66+Tierra+Blanca'),
                  ),
                  const SizedBox(height: 15),
                  _buildInfoCard(
                    context,
                    icon: Icons.phone,
                    title: 'Teléfono',
                    subtitle: '274 743 0962',
                    onTap: () => _makePhoneCall('2747430962'),
                  ),
                  const SizedBox(height: 15),
                  _buildInfoCard(
                    context,
                    icon: Icons.language,
                    title: 'Página Web',
                    subtitle: 'www.cbtis66.edu.mx',
                    onTap: () => _launchUrl('http://www.cbtis66.edu.mx'),
                  ),
                  const SizedBox(height: 15),
                  _buildInfoCard(
                    context,
                    icon: Icons.facebook,
                    title: 'Facebook',
                    subtitle: 'Cbtis 66 Agustín de Iturbide',
                    onTap: () => _launchUrl('https://www.facebook.com/cbtis66'),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget reutilizable para crear tarjetas limpias y escalables
  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.burgundy.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppTheme.burgundy, size: 28),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.burgundy,
                          ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
