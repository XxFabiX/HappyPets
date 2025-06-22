import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'splash.dart'; 
//import 'profile.dart'; 
import '../main.dart';   
import 'about.dart';   

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({super.key});

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  bool _showEmail = true;
  bool _showPhone = true;
  String _currentTheme = 'system';

  String userName = "Cargando..."; 
  String userEmail = "Cargando...";
  String userPhone = "Cargando...";

  late TextEditingController nameController = TextEditingController(text: userName);
  late TextEditingController emailController = TextEditingController(text: userEmail);
  late TextEditingController phoneController = TextEditingController(text: userPhone);

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) { 
      setState(() {
        _showEmail = prefs.getBool('show_email') ?? true;
        _showPhone = prefs.getBool('show_phone') ?? true;
        _currentTheme = prefs.getString('app_theme') ?? 'system';
        userName = prefs.getString('user_name') ?? "Juana Pérez";
        userEmail = prefs.getString('user_email') ?? "juanita@gmail.com";
        userPhone = prefs.getString('user_phone') ?? "+596 1234 4321";


        nameController.text = userName;
        emailController.text = userEmail;
        phoneController.text = userPhone;
      });
    }
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
        /*
        case 'email':
        controller = emailController;
        title = 'Editar Correo';
        break;*/
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
                if (mounted) {
                  setState(() {
                    if (field == 'name') userName = controller.text;
                    //if (field == 'email') userEmail = controller.text;
                    if (field == 'phone') userPhone = controller.text;
                  });
                }
                await _saveUserData();
                if (mounted) Navigator.pop(context);
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProfileInfoRow({
    required IconData icon,
    required String label,
    required String value,
    VoidCallback? onEdit,
    bool isEditable = true, //visibilidad boton editar
  }) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), 
      child: Row(
        children: [
          Icon(icon, color: Colors.blue[700], size: 26),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
                const SizedBox(height: 2),
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

          if (isEditable && onEdit != null)
            IconButton(
              icon: Icon(Icons.edit_outlined, size: 22, color: Colors.blue[700]),
              onPressed: onEdit,
              tooltip: 'Editar $label',
              splashRadius: 20, 
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            )
          else
            const SizedBox(width: 48), 
        ],
      ),
    );
  }

  Widget _buildSettingsOption({
    required IconData icon,
    required String title,
    VoidCallback? onTap, 
    Widget? trailing, 
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue[800]),
      title: Text(title),
      trailing: trailing ?? (onTap != null ? const Icon(Icons.chevron_right) : null),
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
        return 'Sistema (predeterminado Claro)'; 
    }
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ayuda y Soporte'),
          content: const SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Para asistencia, contactarse a los correos:', textAlign: TextAlign.center),
                SizedBox(height: 10),
                SelectableText( 
                  'support@happy.pets.cl',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text('ó', textAlign: TextAlign.center),
                SizedBox(height: 5),
                SelectableText(
                  'fabian.0151.valenzuela@gmail.com',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                  textAlign: TextAlign.center,
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
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Seleccionar tema'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildThemeOption(dialogContext, 'Sistema', 'system'),
              _buildThemeOption(dialogContext, 'Claro', 'light'),
              _buildThemeOption(dialogContext, 'Oscuro', 'dark'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildThemeOption(BuildContext dialogContext, String text, String value) {
    return ListTile(
      title: Text(text),
      trailing: _currentTheme == value
          ? const Icon(Icons.check, color: Colors.blue)
          : null,
      onTap: () async {

        MyApp.of(context)?.changeTheme(value);

        //actualiza estado local y sharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('app_theme', value);
        if (mounted) {
          setState(() {
            _currentTheme = value;
          });
        }
        Navigator.pop(dialogContext); 
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
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.only(bottom: 20),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Información Personal',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                  const SizedBox(height: 10), 
                  _buildProfileInfoRow(
                    icon: Icons.person_outline,
                    label: 'Nombre',
                    value: userName,
                    onEdit: () => _showEditDialog('name'),
                    isEditable: true,
                  ),
                  const Divider(thickness: 0.5, height: 20),
                  _buildProfileInfoRow(
                    icon: Icons.email_outlined,
                    label: 'Correo',
                    value: userEmail,
                    // onEdit: () => _showEditDialog('email'),
                    isEditable: false,
                  ),
                  const Divider(thickness: 0.5, height: 20),
                  _buildProfileInfoRow(
                    icon: Icons.phone_outlined,
                    label: 'Teléfono',
                    value: userPhone,
                    onEdit: () => _showEditDialog('phone'),
                    isEditable: true,
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                _buildSettingsOption( 
                  icon: Icons.brightness_6_outlined,
                  title: 'Tema de la aplicación',
                  trailing: Text(_getThemeText(_currentTheme), style: TextStyle(color: Colors.grey[700])),
                  onTap: () => _showThemeSelectionDialog(context),
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                SwitchListTile(
                  title: const Text('Mostrar email en perfil'),
                  value: _showEmail,
                  onChanged: (value) async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('show_email', value);
                    if (!mounted) return;
                    setState(() => _showEmail = value);
                  },
                  secondary: Icon(Icons.visibility_outlined, color: Colors.blue[800]),
                  activeColor: Colors.blue[700],
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
                  secondary: Icon(Icons.contact_phone_outlined, color: Colors.blue[800]),
                  activeColor: Colors.blue[700],
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                _buildSettingsOption(
                  icon: Icons.security_outlined,
                  title: 'Privacidad',
                  onTap: () {
                     ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Sección de Privacidad no implementada')),
                    );
                  },
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                _buildSettingsOption(
                  icon: Icons.help_outline,
                  title: 'Ayuda y Soporte',
                  onTap: () => _showHelpDialog(context),
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                _buildSettingsOption(
                  icon: Icons.info_outline,
                  title: 'Acerca de',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AboutPage()),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            icon: const Icon(Icons.logout_outlined),
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
              padding: const EdgeInsets.symmetric(vertical: 14), 
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}