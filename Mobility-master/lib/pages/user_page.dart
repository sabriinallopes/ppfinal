import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String name = "Fernanda Pires ";
  String email = "fernandapires@gmail.com";
  String phone = "(11)985417563";
  String cpf = "14256483812";
  String disability = "Visual";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perfil do Usuário',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF4CAF50),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Informações Pessoais',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 20),
            _buildInfoTile('Nome', name),
            _buildInfoTile('E-mail', email),
            _buildInfoTile('Telefone', phone),
            _buildInfoTile('CPF', cpf),
            _buildInfoTile('Condições de Acessibilidade', disability),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(
                      name: name,
                      email: email,
                      phone: phone,
                      cpf: cpf,
                      disability: disability,
                      onProfileUpdated: (updatedName, updatedEmail,
                          updatedPhone, updatedCpf, updatedDisability) {
                        setState(() {
                          name = updatedName;
                          email = updatedEmail;
                          phone = updatedPhone;
                          cpf = updatedCpf;
                          disability = updatedDisability;
                        });
                      },
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Editar Informações',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                fontSize: 18,
              )), // Cor do texto
          Text(value,
              style: const TextStyle(
                fontSize: 18,
              )),
        ],
      ),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final String cpf;
  final String disability;
  final Function(String, String, String, String, String) onProfileUpdated;

  const EditProfilePage({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.cpf,
    required this.disability,
    required this.onProfileUpdated,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _disabilityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
    _emailController.text = widget.email;
    _phoneController.text = widget.phone;
    _cpfController.text = widget.cpf;
    _disabilityController.text = widget.disability;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField('Nome', _nameController),
            _buildTextField('E-mail', _emailController),
            _buildTextField('Telefone', _phoneController),
            _buildTextField('CPF', _cpfController),
            _buildTextField(
                'Condições de Acessibilidade', _disabilityController),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_validateInputs()) {
                  widget.onProfileUpdated(
                    _nameController.text,
                    _emailController.text,
                    _phoneController.text,
                    _cpfController.text,
                    _disabilityController.text,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Perfil atualizado com sucesso!')),
                  );

                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Salvar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
        ),
      ),
    );
  }

  bool _validateInputs() {
    if (_nameController.text.isEmpty) {
      _showError('Por favor, insira seu nome.');
      return false;
    }
    if (_emailController.text.isEmpty || !_emailController.text.contains('@')) {
      _showError('Por favor, insira um e-mail válido.');
      return false;
    }
    if (_phoneController.text.isEmpty) {
      _showError('Por favor, insira seu telefone.');
      return false;
    }
    if (_cpfController.text.isEmpty || _cpfController.text.length != 11) {
      _showError('Por favor, insira um CPF válido (11 dígitos).');
      return false;
    }
    if (_disabilityController.text.isEmpty) {
      _showError('Por favor, insira o tipo de deficiência.');
      return false;
    }
    return true;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
