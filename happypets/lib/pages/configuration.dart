import 'package:flutter/material.dart';
import 'splash.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({super.key});

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {

  // Datos del usuario editables
  String userName = "Juana Pérez";
  String userEmail = "juanita.perez@gmail.com";
  String userPhone = "+596 1234 4321";
  
  // controladores para los campos de edicion
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();

    //inicializar controladores con los valores actuales
    nameController = TextEditingController(text: userName);
    emailController = TextEditingController(text: userEmail);
    phoneController = TextEditingController(text: userPhone);
  }

  @override
  void dispose() {

    //limpiador los controladores cuando el widget se destruya
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  //mostrar dialogo de edicion
  void _showEditDialog(String field) {
    TextEditingController controller;
    String title;
    
    //seleccionar controlador y titulos
    switch(field) {
      case 'name':
        controller = nameController;
        title = 'Editar Nombre';
        break;
      case 'email':
        controller = emailController;
        title = 'Editar Correo';
        break;
      case 'phone':
        controller = phoneController;
        title = 'Editar Teléfono';
        break;
      default:
        return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: 'Ingrese nuevo $field',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  //actualizar valores
                  if (field == 'name') userName = controller.text;
                  if (field == 'email') userEmail = controller.text;
                  if (field == 'phone') userPhone = controller.text;
                });
                Navigator.pop(context);
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          //info personal
          Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 20),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Información Personal',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildProfileInfoRow(
                    icon: Icons.person,
                    label: 'Nombre',
                    value: userName,
                    onEdit: () => _showEditDialog('name'),
                  ),
                  const Divider(height: 30),
                  _buildProfileInfoRow(
                    icon: Icons.email,
                    label: 'Correo',
                    value: userEmail,
                    onEdit: () => _showEditDialog('email'),
                  ),
                  const Divider(height: 30),
                  _buildProfileInfoRow(
                    icon: Icons.phone,
                    label: 'Teléfono',
                    value: userPhone,
                    onEdit: () => _showEditDialog('phone'),
                  ),
                ],
              ),
            ),
          ),

          //configuraciones generales
          Card(
            elevation: 3,
            child: Column(
              children: [
                _buildSettingsOption(
                  icon: Icons.notifications,
                  title: 'Notificaciones',
                  onTap: () {},
                ),
                const Divider(height: 1),
                _buildSettingsOption(
                  icon: Icons.security,
                  title: 'Privacidad',
                  onTap: () {},
                ),
                const Divider(height: 1),
                _buildSettingsOption(
                  icon: Icons.help,
                  title: 'Ayuda y Soporte',
                  onTap: () => _showHelpDialog(context),
                ),
                const Divider(height: 1),
                _buildSettingsOption(
                  icon: Icons.info,
                  title: 'Acerca de',
                  onTap: () => _showAboutDialog(context),
                ),
              ],
            ),
          ),

          //botn de cerrar sesion 
          const SizedBox(height: 30),
          ElevatedButton.icon(
            icon: const Icon(Icons.logout),
            label: const Text('Cerrar Sesión'),
            onPressed: () {
              //navegacion al SplashScreen limpiando el stack
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const SplashScreen()),
                (Route<dynamic> route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[400],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //widget para construir filas de informacion del perfil
  Widget _buildProfileInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onEdit,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue[800]),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.edit, size: 20),
          onPressed: onEdit,
          color: Colors.blue[800],
        ),
      ],
    );
  }

  //widget para opciones de configuracion
  Widget _buildSettingsOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue[800]),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  //dialogo de Ayuda y Soporte
  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ayuda y Soporte'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Para asistencia, contactarse al correo:',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'support@happy.pets.cl',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  //Acerca de
  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Acerca de HappyPets'),
          content: const SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Esta aplicacion surge de un proyecto en la Universidad de Talca, '
                  'para el curso de Programacion de Dispositivos Moviles. \n\n'
                  'Profesor: Manuel Moscoso \n'
                  'Desarrollador: Fabián Arévalo Valenzuela \n\n'
                  'Aplicacion creada para ir en ayuda de animales en situacion de calle '
                  'o en busca de un hogar.',
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}
