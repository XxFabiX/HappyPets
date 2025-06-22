import 'package:flutter/material.dart';
import 'feedback.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de HappyPets'),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'HappyPets',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Esta aplicación surge de un proyecto en la Universidad de Talca, '
              'para el curso de Programación de Dispositivos Móviles.\n\n'
              'Profesor: Manuel Moscoso\n'
              'Desarrollador: Fabián Arévalo Valenzuela\n\n'
              'Aplicación creada para ayudar a animales en situación de calle o en busca de un hogar.',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FeedbackPage()),
                  );
                },
                icon: const Icon(Icons.feedback),
                label: const Text('Deja tu opinión'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
