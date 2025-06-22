import 'dart:io'; 
import 'package:flutter/material.dart';
import 'profile.dart'; 
import 'configuration.dart'; 
// import 'feedback.dart'; 

import '../models/post_model.dart'; 
import '../services/database_helper.dart'; 

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentTab = 0; //Para las pestañas Rescate/Info Cuidados
  int _selectedIndex = 0; //Para la seleccion del Drawer
  List<Post> _allPosts = [];

  final List<Map<String, dynamic>> _initialRescuePostsData = [
    {
      'user': 'Carlos Mendez',
      'image': 'assets/perro1.jpg',
      'name': 'Boby',
      'description': 'Rescatado en Santa Cruz. Necesita una casa urgente. Hablar al +56972522637',
      'location': 'Santa Cruz, Chile',
      'date': '2024-06-20T10:00:00Z', 
      'liked': false 
    },
    {
      'user': 'Consuelo Rodriguez',
      'image': 'assets/gato1.jpg',
      'name': 'Oliver',
      'description': 'Encontrado en Universidad Santo Tomas. Hablar al +56975683421',
      'location': 'Talca centro',
      'date': '2024-06-15T14:30:00Z',
      'liked': true 
    },
  ];

  final Map<String, Map<String, String>> careInfo = {
    'Perros': {
      'Labrador Retriever': 'Necesitan ejercicio diario. Propensos a obesidad. Pelaje requiere cepillado semanal.',
      'Chihuahua': 'Sensibles al frío. Necesitan socialización temprana. Alimentación controlada por tamaño.',
      'Pastor Alemán': 'Mucha energia. Necesitan espacio. Propensos a displasia de cadera.'
    },
    'Gatos': {
      'Siamés': 'Muy vocales. Necesitan atencion. Pelaje corto facil de mantener.',
      'Persa': 'Requiere cepillado diario. Propenso a problemas respiratorios. Tranquilo.',
      'Maine Coon': 'Grande y peludo. Necesita espacio. Personalidad juguetona.'
    },
    'Pájaros': {
      'Loro': 'Necesitan jaulas grandes, mucha interacción, juguetes para estimular su mente y una dieta variada (frutas, verduras, y algunas semillas).',
      'Canario': 'Requieren una jaula adecuada, dieta basada en alpiste y otras semillas, suplementos vitamínicos, frutas y verduras frescas. Agua limpia siempre disponible.'

    }
  };

  @override
  void initState() {
    super.initState();
    _loadAllPostsFromDb();
  }

  Future<void> _loadAllPostsFromDb() async {
    print("Home: Attempting to insert initial data if empty.");
    await DatabaseHelper.instance.insertInitialDataIfEmpty(_initialRescuePostsData);
    print("Home: Loading all posts from DB.");
    final postsFromDb = await DatabaseHelper.instance.getAllPosts();
    print("Home: Loaded ${postsFromDb.length} posts from DB.");
    if (mounted) {
      setState(() {
        _allPosts = postsFromDb;
      });
    }
  }

  void _toggleLike(Post post) {
    setState(() {
      post.liked = !post.liked;
    });

    //await DatabaseHelper.instance.updatePost(post);   //por si quiero guardar el me gusta en la base de datos

  }

  String _formatDate(String isoDate) {
    try {
      final DateTime date = DateTime.parse(isoDate);
      return "${date.day}/${date.month}/${date.year}";
    } catch (e) {
      return isoDate;

    }
  }

  Widget _buildAnimalPostCard({required Post post}) {
    bool isFileImage = post.imagePath.startsWith('/');

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue[100],
                  child: Text(post.user.isNotEmpty ? post.user[0].toUpperCase() : '?', style: TextStyle(color: Colors.blue[700], fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.user, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      Text(post.location, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                    ],
                  ),
                ),
                Text(_formatDate(post.date), style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              ],
            ),
          ),

          ClipRRect(
            borderRadius: BorderRadius.circular(0),
            child: isFileImage
                ? Image.file(
                    File(post.imagePath),
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(height: 220, color: Colors.grey[300], child: const Center(child: Icon(Icons.broken_image, size: 60, color: Colors.grey))),
                  )
                : Image.asset(
                    post.imagePath,
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(height: 220, color: Colors.grey[300], child: const Center(child: Icon(Icons.pets, size: 60, color: Colors.grey))),
                  ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.name,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 40, 80, 120)),
                ),
                const SizedBox(height: 8),
                Text(
                  post.description,
                  style: TextStyle(fontSize: 15, color: Colors.grey[850]),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
            
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildActionButton(
                      post.liked ? Icons.favorite : Icons.favorite_border,
                      post.liked ? 'Te gusta' : 'Me gusta',
                      post,
                      isLikeButton: true,
                    ),
                    _buildActionButton(Icons.share, 'Compartir', post),
                    _buildActionButton(Icons.info_outline, 'Detalles', post),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, Post post, {bool isLikeButton = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(
            icon,
            color: isLikeButton && post.liked ? Colors.redAccent[700] : Colors.blue[700], //corazon rojo
            size: 28, 
          ),
          onPressed: () {
            if (isLikeButton) {
              _toggleLike(post);
            } else if (label == 'Compartir') {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Funcionalidad "Compartir" para ${post.name} no implementada')),
              );
            } else if (label == 'Detalles') {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Funcionalidad "Detalles" para ${post.name} no implementada')),
              );
            }
          },
          padding: EdgeInsets.zero, 
          constraints: const BoxConstraints(), 
        ),
        Text(
          label,
          style: TextStyle(fontSize: 11, color: Colors.blue[700], fontWeight: isLikeButton && post.liked ? FontWeight.bold : FontWeight.normal),
        ),
      ],
    );
  }

  Widget _buildRescueTab() {
    if (_allPosts.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text("Cargando publicaciones..."),
          ],
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: _loadAllPostsFromDb,
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 4, right: 4),
        itemCount: _allPosts.length,
        itemBuilder: (context, index) {
          final post = _allPosts[index];
          return _buildAnimalPostCard(post: post);
        },
      ),
    );
  }

  Widget _buildCareInfoTab() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildAnimalTypeCard('Perros', Icons.pets), //icono perros
        const SizedBox(height: 16),
        _buildAnimalTypeCard('Gatos', Icons.pest_control_rodent_outlined), //icono gatos
        const SizedBox(height: 16),
        _buildAnimalTypeCard('Pájaros', Icons.flutter_dash), //icono pajaros
      ],
    );
  }

  Widget _buildAnimalTypeCard(String animalType, IconData icon) {
    if (careInfo[animalType] == null) {
      return Card(
        elevation: 2,
        child: ListTile(
          leading: Icon(icon, color: Colors.grey[600]),
          title: Text(animalType, style: const TextStyle(fontWeight: FontWeight.w500)),
          subtitle: const Text('Información no disponible.'),
        ),
      );
    }
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ExpansionTile(
        leading: Icon(icon, color: Colors.blue[800], size: 30),
        title: Text(animalType, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        children: careInfo[animalType]!.entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.key, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                const SizedBox(height: 5),
                Text(entry.value, style: TextStyle(color: Colors.grey[700], fontSize: 14)),
                if (entry.key != careInfo[animalType]!.entries.last.key)
                  const Divider(height: 25, thickness: 0.5),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTabButton(String text, int index) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: _currentTab == index ? Colors.blue[700] : Colors.grey[300],
            foregroundColor: _currentTab == index ? Colors.white : Colors.black87,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
        onPressed: () {
          setState(() {
            _currentTab = index;
            if (index == 0) { //si cambiamos a la pestaña de rescates recargamos
              _loadAllPostsFromDb();
            }
          });
        },
        child: Text(text),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue[800]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/logo.png', width: 70, height: 70),
                const SizedBox(height: 10),
                const Text('HappyPets', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: _selectedIndex == 0 ? Colors.blue[700] : Colors.grey[700]),
            title: Text('Inicio', style: TextStyle(fontWeight: _selectedIndex == 0 ? FontWeight.bold : FontWeight.normal)),
            selected: _selectedIndex == 0,
            selectedTileColor: Colors.blue[50],
            onTap: () {
              Navigator.pop(context);
              setState(() => _selectedIndex = 0);
              _loadAllPostsFromDb(); //recargar
            },
          ),
          ListTile(
            leading: Icon(Icons.person, color: _selectedIndex == 1 ? Colors.blue[700] : Colors.grey[700]),
            title: Text('Mi Perfil', style: TextStyle(fontWeight: _selectedIndex == 1 ? FontWeight.bold : FontWeight.normal)),
            selected: _selectedIndex == 1,
            selectedTileColor: Colors.blue[50],
            onTap: () async {
              Navigator.pop(context);
              setState(() => _selectedIndex = 1);

              //espera a que profilePage se cierre y recargar posts si hubo cambios
              await Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
              _loadAllPostsFromDb(); //recargar posts leugo de volver de profilePage
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: _selectedIndex == 2 ? Colors.blue[700] : Colors.grey[700]),
            title: Text('Configuración', style: TextStyle(fontWeight: _selectedIndex == 2 ? FontWeight.bold : FontWeight.normal)),
            selected: _selectedIndex == 2,
            selectedTileColor: Colors.blue[50],
            onTap: () {
              Navigator.pop(context);
              setState(() => _selectedIndex = 2);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ConfigurationPage()));
            },
          ),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blue[800],
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('En proceso de implementación')),
              );
            },
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Row(
              children: [
                _buildTabButton('🐾 Rescates', 0),
                const SizedBox(width: 10),
                _buildTabButton('💡 Info Cuidados', 1),
              ],
            ),
          ),
          Expanded(
            child: _currentTab == 0 ? _buildRescueTab() : _buildCareInfoTab(),
          ),
        ],
      ),
    );
  }
}