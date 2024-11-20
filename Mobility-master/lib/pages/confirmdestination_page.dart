import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Pacote Google Maps.

class ConfirmDestinationPage extends StatefulWidget {
  final String destination; // Destino fornecido pelo usuário.
  final String departure; // Local de partida.

  const ConfirmDestinationPage({
    super.key,
    required this.destination, // Recebe o destino.
    required this.departure, // Recebe a partida.
  });

  @override
  _ConfirmDestinationPageState createState() =>
      _ConfirmDestinationPageState(); // Cria o estado da página.
}

class _ConfirmDestinationPageState extends State<ConfirmDestinationPage> {
  // Localização de partida (origem) e destino com coordenadas fixas para teste.
  LatLng userLocation = const LatLng(-23.561632, -46.656139); // ORIGEM
  LatLng destinationLocation =
      const LatLng(-23.543377, -46.638468); // Ibirapuera - destino

  Set<Marker> _markers = {}; // Para armazenar os marcadores.
  Set<Polyline> _polylines = {}; // Para armazenar a linha (rota).

  // Função para desenhar uma linha (polyline) entre a origem e o destino.
  void _drawRoute() {
    // Adicionando marcadores
    _markers.add(Marker(
      markerId: const MarkerId('user'),
      position: userLocation,
      infoWindow: const InfoWindow(title: 'Você está aqui'),
    ));

    _markers.add(Marker(
      markerId: const MarkerId('destination'),
      position: destinationLocation,
      infoWindow: InfoWindow(title: widget.destination),
    ));

    // Criando uma polyline (linha) entre a origem e o destino
    _polylines.add(Polyline(
      polylineId: const PolylineId('route'),
      points: [userLocation, destinationLocation], // Pontos que formam a rota.
      color: Colors.blue,
      width: 5,
    ));
  }

  @override
  void initState() {
    super.initState();
    _drawRoute(); // Desenha a rota ao iniciar a página.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmar Destino'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Destino',
                border: OutlineInputBorder(),
              ),
              readOnly: true,
              controller: TextEditingController(text: widget.destination),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Rota traçada!')),
              );
            },
            child: const Text('Iniciar Viagem'),
          ),
          // Mapa
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: userLocation, // Posição inicial do mapa.
                zoom: 14, // Nível de zoom inicial.
              ),
              markers: _markers, // Marcadores para origem e destino.
              polylines: _polylines, // Linhas da rota.
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Motorista: Claúdio Pinheiro',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Modelo do Carro: Nissan Kicks ',
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  'Cor: Preto',
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  'Placa: BOK3C58',
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 5),
                Text('Tempo estimado: 10 minutos'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
