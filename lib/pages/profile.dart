import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'new_post.dart'; 
import '../models/post_model.dart'; 
import '../services/database_helper.dart'; 

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  bool _showEmail = true;
  bool _showPhone = true;
  String _userName = "Usuario";
  String _userEmail = "";
  String _userPhone = "";
  List<Post> _userPosts = [];   //lista para los posts del usuario desde la DB

  @override
  void initState() {
    super.initState();
    _loadProfilePreferencesAndPosts();
  }

  Future<void> _loadProfilePreferencesAndPosts() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        _showEmail = prefs.getBool('show_email') ?? true;
        _showPhone = prefs.getBool('show_phone') ?? true;
        _userName = prefs.getString('user_name') ?? 'Juana Pérez';
        _userEmail =
            prefs.getString('user_email') ?? 'juanita@gmail.com';
        _userPhone = prefs.getString('user_phone') ?? '+596 1234 4321';
      });
      if (_userName != "Usuario" && _userName.isNotEmpty) {
        _loadUserPosts();
      }
    }
  }

  Future<void> _loadUserPosts() async {
    //asume que los posts creados por el usuario se guardan con user: tu
    final posts = await DatabaseHelper.instance.getUserPosts("Tú");
    if (mounted) {
      setState(() {
        _userPosts = posts;
      });
    }
  }

  void _deletePostFromDb(int postId) async {
    await DatabaseHelper.instance.deletePost(postId);
    _loadUserPosts(); //recargar post luego de eliminar
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Publicación eliminada')),
      );
    }
  }

  void _showDeleteConfirmationDialog(int postId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Eliminación'),
          content: const Text('¿Estás seguro de que deseas eliminar esta publicación permanentemente?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
              onPressed: () {
                _deletePostFromDb(postId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildAnimalPostCard({required Post post}) {
    bool isFileImage = post.imagePath.startsWith('/');

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: isFileImage
                ? Image.file(
                    File(post.imagePath),
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(height: 200, color: Colors.grey[300], child: const Center(child: Icon(Icons.broken_image, size: 50, color: Colors.grey))),
                  )
                : Image.asset( //esto seria para posts con images de assets si los tuviera en DB
                    post.imagePath,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(height: 200, color: Colors.grey[300], child: const Center(child: Icon(Icons.pets, size: 50, color: Colors.grey))),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.name,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 50, 100, 150)),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: Colors.grey[700]),
                    const SizedBox(width: 4),
                    Text(post.location, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  post.description,
                  style: TextStyle(fontSize: 15, color: Colors.grey[800]),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildActionButton(Icons.favorite_border, 'Me gusta'),
                    _buildActionButton(Icons.share, 'Compartir'),

                    //boton de eliminar solo se muestra si el post.id es valido
                    if (post.id != null && post.id! > 0)
                      IconButton(
                        icon: Icon(Icons.delete_forever, color: Colors.red[700], size: 28),
                        onPressed: () {
                          _showDeleteConfirmationDialog(post.id!);
                        },
                        tooltip: 'Eliminar Publicación',
                      )
                    else  //da espacio si no hay boton
                      const SizedBox(width: 48),
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
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon, color: Colors.blue[800]),
          onPressed: () {
            if (label == 'Me gusta') {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Funcionalidad en proceso de implementación')),
              );
            } else if (label == 'Compartir') {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Funcionalidad en proceso de implementación')),
              );
            }
          },
        ),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.blue[800])),
      ],
    );
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
            //Info del perfil
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blue[800]!, width: 3),
              ),
              child: const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/FotoPerfil.jpg'),
              ),
            ),
            const SizedBox(height: 12),
            Text(_userName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            if (_showEmail)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.email, size: 18, color: Colors.grey[700]),
                  const SizedBox(width: 8),
                  Text(_userEmail, style: TextStyle(fontSize: 15, color: Colors.grey[700])),
                ],
              ),
            if (_showEmail) const SizedBox(height: 4),
            if (_showPhone)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.phone, size: 18, color: Colors.grey[700]),
                  const SizedBox(width: 8),
                  Text(_userPhone, style: TextStyle(fontSize: 15, color: Colors.grey[700])),
                ],
              ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                final result = await Navigator.push<bool>(
                  context,
                  MaterialPageRoute(builder: (context) => const NewPostPage()),
                );
                if (result == true && mounted) {
                  _loadUserPosts();
                }
              },
              icon: const Icon(Icons.add_circle_outline),
              label: const Text('Crear Nueva Publicación'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle: const TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 24),
            //Fin de la inf del perfil

            //MIS PUBLICACIONES
            const Row(
              children: [
                Expanded(child: Divider(thickness: 1, endIndent: 10)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'MIS PUBLICACIONES',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 65, 112, 166)),
                  ),
                ),
                Expanded(child: Divider(thickness: 1, indent: 10)),
              ],
            ),
            const SizedBox(height: 20),


            //lista de posts del usuario desde la base de datos
            if (_userPosts.isEmpty && (_userName != "Usuario" && _userName.isNotEmpty))
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text('Aún no tienes publicaciones. ¡Crea una!', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
              )
            else if (_userName == "Usuario" || _userName.isEmpty) //mientras carga el nombre
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text('Cargando tus publicaciones...', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _userPosts.length,
                itemBuilder: (context, index) {
                  final post = _userPosts[index];
                  return _buildAnimalPostCard(post: post); 
                },
              ),
          ],
        ),
      ),
    );
  }
}

//Se dejó todo relativamente encaminado para luego hacer un login con diferentes usuarios