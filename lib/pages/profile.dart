import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
            //foto de perfil 
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

            //datos personales
            Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [

                    //nombre
                    const Text(
                      'Juana Pérez',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 63, 120, 207),
                      ),
                    ),
                    const SizedBox(height: 8),
                    
                    //correo con icono
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.email, size: 18, color: Colors.grey),
                        const SizedBox(width: 8),
                        const Text(
                          'juanita.perez@gmail.com',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    
                    //icono con telefono
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.phone, size: 18, color: Colors.grey),
                        const SizedBox(width: 8),
                        const Text(
                          '+596 1234 4321',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            //boton contacto
            ElevatedButton.icon(
              icon: const Icon(Icons.message, size: 20),
              label: const Text('Enviar mensaje'),
              onPressed: () {
                //contactar usuario
              },
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

            //titulo publicaciones
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

            //publicaciones
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
          ],
        ),
      ),
    );
  }

  //widget reutilizablepara publicaciones
  Widget _buildAnimalPost({
    required String imagePath,
    required String name,
    required String description,
    required String location,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //imagen esquina redonda prinipal
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
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

                //nombre y ubi
                Row(
                  children: [
                    const Icon(Icons.pets, size: 20, color: Color.fromARGB(255, 96, 137, 183)),
                    const SizedBox(width: 8),
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                
                //ubicaciion
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      location,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
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

  // Widget para botones de acción estilizados
  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, color: Colors.blue[800]),
          onPressed: () {},
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.blue[800],
          ),
        ),
      ],
    );
  }
}