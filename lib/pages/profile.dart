import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'new_post.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  bool _showEmail = true;
  bool _showPhone = true;

  String userName = "";
  String userEmail = "";
  String userPhone = "";

  List<Map<String, dynamic>> _userPosts = [];

  @override
  void initState() {
    super.initState();
    _loadProfilePreferences();
  }

  Future<void> _loadProfilePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        _showEmail = prefs.getBool('show_email') ?? true;
        _showPhone = prefs.getBool('show_phone') ?? true;
        userName = prefs.getString('user_name') ?? 'Juana Pérez';
        userEmail = prefs.getString('user_email') ?? 'juanita.perez@gmail.com';
        userPhone = prefs.getString('user_phone') ?? '+596 1234 4321';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfil'),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Foto de perfil
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.blue[800]!,
                  width: 3,
                ),
              ),
              child: const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/FotoPerfil.jpg'),
              ),
            ),
            const SizedBox(height: 20),

            //Datos personales
            Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [

                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 63, 120, 207),
                      ),
                    ),
                    const SizedBox(height: 8),


                    if (_showEmail)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.email, size: 18, color: Colors.grey),
                          const SizedBox(width: 8),
                          Text(userEmail, style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                    if (_showEmail) const SizedBox(height: 8),


                    if (_showPhone)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.phone, size: 18, color: Colors.grey),
                          const SizedBox(width: 8),
                          Text(userPhone, style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            //Boton contacto
            ElevatedButton.icon(
              icon: const Icon(Icons.message, size: 20),
              label: const Text('Enviar mensaje'),
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Nueva publicacion
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewPostPage(
                      onPostCreated: (post) {
                        setState(() {
                          //post['liked'] = false;
                          _userPosts.add(post);
                        });
                      },
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Nueva publicación'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),

            const Row(
              children: [
                Expanded(
                  child: Divider(thickness: 1, indent: 20, endIndent: 10),
                ),
                Text(
                  '  MIS PUBLICACIONES  ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 65, 112, 166),
                  ),
                ),
                Expanded(
                  child: Divider(thickness: 1, indent: 10, endIndent: 20),
                ),
              ],
            ),
            const SizedBox(height: 20),


            _buildAnimalPost(
              imagePath: 'assets/MaxyCloe.jpg',
              name: 'Max y Cloe',
              description: 'Rescatados a las afueras de Av.Lircay. Edad: Aprox. 2 años. Busca hogar responsable.',
              location: 'Talca, Chile',
            ),
            const SizedBox(height: 20),
            _buildAnimalPost(
              imagePath: 'assets/Luna.jpg',
              name: 'Luna',
              description: 'Encontrada en Universidad de Talca. Vacunada y esterilizada.',
              location: 'Campus Norte, Talca',
              
            ),
            for (var post in _userPosts)
              _buildAnimalPost(
                imagePath: (post['image'] as File).path,
                name: post['name'],
                description: post['description'],
                location: post['location'],
              ),
          ],
        ),
      ),
    );
  }


  Widget _buildAnimalPost({
    required String imagePath,
    required String name,
    required String description,
    required String location,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: imagePath.startsWith('/')
                ? Image.file(
                    File(imagePath),
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    imagePath,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  children: [
                    const Icon(Icons.pets, size: 20, color: Color.fromARGB(255, 96, 137, 183)),
                    const SizedBox(width: 8),
                    Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(location, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 12),

                Text(description),
                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildActionButton(Icons.favorite_border, 'Me gusta'),
                    _buildActionButton(Icons.share, 'Compartir'),
                    _buildActionButton(Icons.info_outline, 'Detalles'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, color: Colors.blue[800]),
          onPressed: () {},
        ),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.blue[800])),
      ],
    );
  }
}
