import 'package:flutter/material.dart';
import 'home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final String _savedEmail = "juanita.perez@gmail.com";
  final String _savedPassword = "12345678";
  bool _isLoading = false;
  bool _showLoginForm = false;
  bool _loginError = false;
  bool _showLogoOnly = true;  //estado para controlar vista del logo

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = _savedEmail;
    _passwordController.text = _savedPassword;
    
    // Mostrar logo
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _showLogoOnly = false;
        _showLoginForm = true;
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _loginError = false;
      });

      Future.delayed(const Duration(seconds: 1), () {
        if (_emailController.text == _savedEmail && 
            _passwordController.text == _savedPassword) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage(title: 'HappyPets')),
          );
        } else {
          setState(() {
            _isLoading = false;
            _loginError = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _showLogoOnly 
            ? _buildLogoOnly() 
            : SingleChildScrollView(  //muestra el formulario luego dle logo
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLogo(),
                    const SizedBox(height: 40),
                    _buildLoginForm(),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildLogoOnly() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLogo(),
      ],
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Image.asset(
          'assets/logo.png',
          width: 100,
          height: 100,
        ),
        const SizedBox(height: 20),
        const Text(
          'HappyPets',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Column(
      children: [
        const Text(
          'Iniciar Sesion',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Correo electrónico',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese su correo';
                    } else if (value != _savedEmail) {
                      return 'Correo incorrecto';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese su contraseña';
                    } else if (value != _savedPassword) {
                      return 'Contraseña incorrecta';
                    }
                    return null;
                  },
                ),
                
                if (_loginError)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'Inicio sesion incorrecto. Use:\nEmail: $_savedEmail\nPassword: $_savedPassword',
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                
                const SizedBox(height: 30),
                
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[800],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: _isLoading ? null : _login,
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Ingresar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}