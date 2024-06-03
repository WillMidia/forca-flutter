import 'package:flutter/material.dart';
import 'game_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forca do Oceano'),
        backgroundColor: Color(0xFF006994), // Cor de fundo azul oceano
      ),
      backgroundColor: Color(0xFF006994), // Cor de fundo azul claro
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/ocean_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.water_drop_sharp,
                size: 100,
                color: Color(0xFFB2EBF2), // Cor azul oceano
              ),
              SizedBox(height: 20),
              Text(
                'Forca Ocean20',
                style: TextStyle(
                  fontSize: 36, // Aumenta o tamanho da fonte
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Cor branca para contraste
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GameScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  backgroundColor: Color.fromARGB(255, 148, 187, 202), // Cor azul oceano
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Começar Jogo',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
