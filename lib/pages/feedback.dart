import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  Map<String, dynamic> feedbackData = {};
  final Map<String, List<int>> responses = {};
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadFeedbackData();
  }

  Future<void> loadFeedbackData() async {
    final String jsonString = await rootBundle.loadString('encuesta/feedback.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    setState(() {
      feedbackData = jsonMap;
      for (var section in feedbackData.keys) {
        responses[section] = List.filled(feedbackData[section].length, 0);
      }
    });
  }

  Widget buildStarRating(int sectionIndex, int questionIndex, String sectionKey) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(6, (i) {
        return IconButton(
          icon: Icon(
            Icons.star,
            color: i <= responses[sectionKey]![questionIndex]
                ? Colors.orange
                : Colors.grey,
          ),
          onPressed: () {
            setState(() {
              responses[sectionKey]![questionIndex] = i;
            });
          },
        );
      }),
    );
  }

  Future<bool> _isGmailInstalled() async {
    const gmailUrl = 'googlegmail://';
    return await canLaunchUrl(Uri.parse(gmailUrl));
  }

  Future<void> _openGmail(String body) async {
    final Uri gmailUri = Uri(
      scheme: 'googlegmail',
      path: '/co',
      queryParameters: {
        'to': 'fabian.0151.valenzuela@gmail.com',
        'subject': 'Opinión sobre HappyPets',
        'body': body,
      },
    );

    if (await canLaunchUrl(gmailUri)) {
      await launchUrl(gmailUri);
    } else {
      await _openGenericEmail(body);
    }
  }

  Future<void> _openGenericEmail(String body) async {
    final Uri mailtoUri = Uri(
      scheme: 'mailto',
      path: 'fabian.0151.valenzuela@gmail.com',
      queryParameters: {
        'subject': 'Opinión sobre HappyPets',
        'body': body,
      },
    );

    if (await canLaunchUrl(mailtoUri)) {
      await launchUrl(mailtoUri);
    } else {
      await _showCopyDialog(body);
    }
  }

  Future<void> _showCopyDialog(String feedbackContent) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('No se pudo abrir el correo'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                const Text('Por favor copie este texto y envíelo manualmente:'),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SelectableText(feedbackContent),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Copiar'),
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: feedbackContent));
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Texto copiado al portapapeles')),
                  );
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showSendOptions(String body) async {
    final isGmailInstalled = await _isGmailInstalled();

    final option = await showDialog<int>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enviar feedback'),
        content: const Text('¿Cómo deseas enviar tu opinión?'),
        actions: [
          if (isGmailInstalled)
            TextButton(
              onPressed: () => Navigator.pop(context, 1),
              child: const Row(
                children: [
                  Icon(Icons.mail, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Abrir Gmail'),
                ],
              ),
            ),
          TextButton(
            onPressed: () => Navigator.pop(context, 2),
            child: const Row(
              children: [
                Icon(Icons.email),
                SizedBox(width: 8),
                Text('Otra app de correo'),
              ],
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 3),
            child: const Row(
              children: [
                Icon(Icons.copy),
                SizedBox(width: 8),
                Text('Copiar texto'),
              ],
            ),
          ),
        ],
      ),
    );

    switch (option) {
      case 1:
        await _openGmail(body);
        break;
      case 2:
        await _openGenericEmail(body);
        break;
      case 3:
        await Clipboard.setData(ClipboardData(text: body));
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Texto copiado al portapapeles')),
          );
        }
        break;
    }
  }

  Future<void> _sendFeedback() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor ingrese su nombre o correo')),
      );
      return;
    }

    final StringBuffer body = StringBuffer();
    body.writeln('Usuario: $name\n');
    
    feedbackData.forEach((section, questions) {
      body.writeln('[$section]');
      for (int i = 0; i < questions.length; i++) {
        body.writeln('${questions[i]['titulo']}: ${responses[section]![i]} estrellas');
      }
      body.writeln();
    });

    await _showSendOptions(body.toString());
  }

  @override
  Widget build(BuildContext context) {
    if (feedbackData.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tu Opinión'),
        backgroundColor: Colors.blue[800],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Por favor responde estas preguntas:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...feedbackData.entries.map((entry) {
            final String section = entry.key;
            final List questions = entry.value;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  section.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 8),
                ...List.generate(questions.length, (i) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(questions[i]['titulo']),
                      buildStarRating(i, i, section),
                    ],
                  );
                }),
                const Divider(height: 32),
              ],
            );
          }).toList(),
          const Text('Tu nombre o correo:'),
          const SizedBox(height: 8),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Ej: juanita@gmail.com',
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            icon: const Icon(Icons.send),
            label: const Text('Enviar opinión'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[800],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: _sendFeedback,
          )
        ],
      ),
    );
  }
}