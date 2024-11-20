import 'package:flutter/material.dart'; 

class AboutPage extends StatelessWidget {
  const AboutPage({super.key}); // Construtor da página "Sobre".

  // Função para abrir um cliente de e-mail com um endereço e assunto pré-definidos.
  Future<void> _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto', 
      path: 'contato@mobility.com.br', 
      query: encodeQueryParameters(<String, String>{ 
        'subject': 'Contato pelo Aplicativo', 
      }),
    );
    await launchUrl(emailLaunchUri); 
  }

  
  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries 
        .map((MapEntry<String, String> e) => 
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&'); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar( // Barra de aplicativo no topo.
        title: const Text('Sobre Nós'), // Título da barra de aplicativo.
        backgroundColor: const Color(0xFF4CAF50), // Cor de fundo da barra.
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), 
        child: SingleChildScrollView( 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
              // Imagem ou logo aqui
              // Image.asset('lib/imagens/logo.png', height: 100), 

              const SizedBox(height: 16), 
              const Text(
                'Bem-vindo ao nosso aplicativo!', 
                style: TextStyle(
                  fontSize: 24, 
                  fontWeight: FontWeight.bold, 
                ),
              ),
              const SizedBox(height: 16), 
              const Text(
                'Nossa Missão', 
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold, 
                ),
              ),
              const SizedBox(height: 8), 
              const Text(
                'Nosso objetivo é proporcionar uma experiência de transporte inclusiva e acessível para todos, especialmente para pessoas com deficiência. Acreditamos que todos merecem liberdade e conforto em seus deslocamentos.', // Descrição da missão.
                style: TextStyle(fontSize: 16), 
              ),
              const SizedBox(height: 16), 
              const Text(
                'Nossa História', 
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold, 
                ),
              ),
              const SizedBox(height: 8), 
              const Text(
                'Fundado em 2024, nosso aplicativo surgiu da necessidade de atender a um público que frequentemente enfrenta desafios em transporte. Com uma equipe apaixonada, trabalhamos para oferecer um serviço que se adapte às suas necessidades.', // Descrição da história.
                style: TextStyle(fontSize: 16), 
              ),
              const SizedBox(height: 16), 
              const Text(
                'Entre em Contato', 
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold, 
                ),
              ),
              const SizedBox(height: 8), 
              GestureDetector( 
                onTap: _launchEmail, 
                child: const Text(
                  'contato@mobility.com.br',
                  style: TextStyle(
                    fontSize: 16, 
                    color: Colors.blue, 
                    decoration: TextDecoration.underline, 
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  launchUrl(Uri emailLaunchUri) {} // Função placeholder para abrir a URL (deve ser implementada).
}
