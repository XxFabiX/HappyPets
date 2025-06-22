import 'package:flutter/material.dart';
import 'profile.dart';
import 'configuration.dart';
import 'feedback.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentTab = 0; 
  int _selectedIndex = 0; 

  //datos de prueba rescate 
  final List<Map<String, dynamic>> rescuePosts = [
    {
      'user': 'Carlos Mendez',
      'image': 'assets/perro1.jpg',
      'name': 'Boby',
      'description': 'Rescatado en Santa Cruz. Necesita una casa urgente. Hablar al +56972522637',
      'location': 'Santa Cruz, Chile',
      'date': 'Hace 2 días'
    },
    {
      'user': 'Consuelo Rodriguez',
      'image': 'assets/gato1.jpg',
      'name': 'Oliver',
      'description': 'Encontrado en Universidad Santo Tomas. Hablar al +56975683421',
      'location': 'Talca centro',
      'date': 'Hace 1 semana'
    },
    {
      'user': 'Refugio Patitas',
      'image': 'assets/perro2.jpg',
      'name': 'Rex',
      'description': 'Rescatado de maltrato, busca cuidados especiales. Intagram refugio_patitas',
      'location': 'Pucon',
      'date': 'Hace 3 días'
    },
    {
      'user': 'Lukas Zuñiga',
      'image': 'assets/gato2.jpg',
      'name': 'Michi',
      'description': 'Rescatado de la lluvia, busca adopcion responsable. Intagram lksZuñiga23',
      'location': 'San gregorio',
      'date': 'Ayer'
    },
    {
      'user': 'Ana Vidal',
      'image': 'assets/perro3.jpg',
      'name': 'Canela',
      'description': 'Abandonada en carretera, muy cariñosa. Mandar mensaje al +56987890401',
      'location': 'La Cisterna',
      'date': 'Hace 5 días'
    },
  ];

  //datos de cuidados 
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
    }
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      drawer: _buildDrawer(),
      body: Column(
        children: [

          //selector de pestañas
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(child: _buildTabButton('Rescate', 0)),
                const SizedBox(width: 10),
                Expanded(child: _buildTabButton('Info Cuidados', 1)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _currentTab == 0 ? _buildRescueTab() : _buildCareInfoTab(),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/logo.png', width: 80, height: 80),
                  const SizedBox(height: 10),
                  const Text('HappyPets', 
                      style: TextStyle(color: Colors.white, fontSize: 24)),
                ],
              ),
            ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            selected: _selectedIndex == 0,
            onTap: () {
              Navigator.pop(context);
              setState(() => _selectedIndex = 0);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Perfil'),
            selected: _selectedIndex == 1,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configuración'),
            selected: _selectedIndex == 2,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ConfigurationPage()),
              );
            },
          ),

          /*ListTile(
            leading: const Icon(Icons.feedback),
            title: const Text('Tu Opinión'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/feedback');
            },
          ),*/
        
        ],
      ),
    );
  }

  Widget _buildTabButton(String text, int index) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: _currentTab == index ? Colors.blue[800] : Colors.grey[300],
        foregroundColor: _currentTab == index ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      onPressed: () {
        setState(() {
          _currentTab = index;
        });
      },
      child: Text(text),
    );
  }

  Widget _buildRescueTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: rescuePosts.length,
      itemBuilder: (context, index) {
        final post = rescuePosts[index];
        return _buildAnimalPost(
          imagePath: post['image'],
          name: post['name'],
          description: post['description'],
          location: post['location'],
          user: post['user'],
          date: post['date'],
        );
      },
    );
  }

  Widget _buildAnimalPost({
    required String imagePath,
    required String name,
    required String description,
    required String location,
    required String user,
    required String date,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //info usuario parte arriba
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue[100],
                  child: Text(user[0], style: const TextStyle(color: Colors.blue)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user, style: const TextStyle(fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(location, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                ),
                Text(date, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          
          //imagen
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.zero, bottom: Radius.circular(0)),
            child: Image.asset(
              imagePath,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          
          //contenido
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                //nombre
                Row(
                  children: [
                    const Icon(Icons.pets, size: 20, color: Colors.blue),
                    const SizedBox(width: 8),
                    Text(
                      name,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                
                //descripcion
                Text(description),
                const SizedBox(height: 16),
                
                //botones
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
        Text(label, style: TextStyle(color: Colors.blue[800], fontSize: 12)),
      ],
    );
  }

  Widget _buildCareInfoTab() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildAnimalTypeCard('Perros', Icons.pets),
        const SizedBox(height: 16),
        _buildAnimalTypeCard('Gatos', Icons.pets),
      ],
    );
  }

  Widget _buildAnimalTypeCard(String animalType, IconData icon) {
    return Card(
      elevation: 3,
      child: ExpansionTile(
        leading: Icon(icon, color: Colors.blue[800]),
        title: Text(
          animalType,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        children: [
          ...careInfo[animalType]!.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.key,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    entry.value,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const Divider(height: 20),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}