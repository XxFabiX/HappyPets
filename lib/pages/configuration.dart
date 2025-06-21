import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'splash.dart';
import 'profile.dart';
import '../main.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({super.key});

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  bool _showEmail = true;
  bool _showPhone = true;
  String _currentTheme = 'system';

  String userName = "";
  String userEmail = "";
  String userPhone = "";

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _showEmail = prefs.getBool('show_email') ?? true;
      _showPhone = prefs.getBool('show_phone') ?? true;
      _currentTheme = prefs.getString('app_theme') ?? 'system';
      userName = prefs.getString('user_name') ?? "Juana Pérez";
      userEmail = prefs.getString('user_email') ?? "juanita.perez@gmail.com";
      userPhone = prefs.getString('user_phone') ?? "+596 1234 4321";
    });

    nameController = TextEditingController(text: userName);
    emailController = TextEditingController(text: userEmail);
    phoneController = TextEditingController(text: userPhone);
  }

  Future<void> _saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', userName);
    await prefs.setString('user_email', userEmail);
    await prefs.setString('user_phone', userPhone);
  }

  @override
  void dispose() {
    
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }


  void _showEditDialog(String field) {
    TextEditingController controller;
    String title;

    switch (field) {
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
              onPressed: () async {
                setState(() {

                  if (field == 'name') userName = controller.text;
                  if (field == 'email') userEmail = controller.text;
                  if (field == 'phone') userPhone = controller.text;
                });
                await _saveUserData();
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

          Card(
            elevation: 3,
            child: Column(
              children: [
                _buildSettingsOption(
                  icon: Icons.notifications,
                  title: 'Notificaciones',
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.brightness_6, color: Colors.blue[800]),
                  title: const Text('Tema de la aplicación'),
                  subtitle: Text(_getThemeText(_currentTheme)),
                  onTap: () => _showThemeSelectionDialog(context),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text('Mostrar email en perfil'),
                  value: _showEmail,
                  onChanged: (value) async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('show_email', value);
                    if (!mounted) return;
                    setState(() => _showEmail = value);
                  },
                ),
                SwitchListTile(
                  title: const Text('Mostrar teléfono en perfil'),
                  value: _showPhone,
                  onChanged: (value) async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('show_phone', value);
                    if (!mounted) return;
                    setState(() => _showPhone = value);
                  },
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

          const SizedBox(height: 30),
          ElevatedButton.icon(
            icon: const Icon(Icons.logout),
            label: const Text('Cerrar Sesión'),
            onPressed: () {

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


  Widget _buildProfileInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onEdit,
  }) {
    if ((label == 'Correo' && !_showEmail) ||
        (label == 'Teléfono' && !_showPhone)) {
      return const SizedBox();
    }

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
                style: const TextStyle(fontSize: 14, color: Colors.grey),
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

  String _getThemeText(String theme) {
    switch (theme) {
      case 'light':
        return 'Claro';
      case 'dark':
        return 'Oscuro';
      default:
        return 'Sistema (recomendado)';
    }
  }

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

  void _showThemeSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Seleccionar tema'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildThemeOption(context, 'Sistema', 'system'),
              _buildThemeOption(context, 'Claro', 'light'),
              _buildThemeOption(context, 'Oscuro', 'dark'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildThemeOption(BuildContext context, String text, String value) {
    return ListTile(
      title: Text(text),
      trailing: _currentTheme == value
          ? const Icon(Icons.check, color: Colors.blue)
          : null,
      onTap: () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('app_theme', value);
        if (mounted) setState(() => _currentTheme = value);
        Navigator.pop(context);

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => MyApp(initialTheme: value),
          ),
          (route) => false,
        );
      },
    );
  }
}
