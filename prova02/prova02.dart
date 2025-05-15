import 'package:flutter/material.dart';
import 'dart:math';
 
void main() {
  runApp(MaterialApp(
    home: JogoDoTesouro(),
  ));
}
 
class JogoDoTesouro extends StatefulWidget {
  @override
  _JogoDoTesouroState createState() => _JogoDoTesouroState();
}
 
class _JogoDoTesouroState extends State<JogoDoTesouro> {
  int? posicaoTesouro;
  int? posicaoBomba;
  int? posicaoMonstro;
  List<String> buttonText = List.filled(20, '');
  List<bool> buttonEnabled = List.filled(20, true);
  String mensagem = 'Encontre o Tesouro, evite o Monstro e a Bomba!';
  bool gameOver = false;
 
  void iniciarJogo() {
    Random random = Random(); // Declare random here but don't need to use it
 
    // Gera 3 posições distintas
    List<int> posicoes = List.generate(20, (i) => i)..shuffle(random);
    posicaoTesouro = posicoes[0];
    posicaoBomba = posicoes[1];
    posicaoMonstro = posicoes[2];
 
    setState(() {
      buttonText = List.generate(20, (i) => '${i + 1}');
      buttonEnabled = List.filled(20, true);
      mensagem = 'Encontre o Tesouro, evite o Monstro e a Bomba!';
      gameOver = false;
    });
  }
 
  void _onButtonPressed(int index) {
    setState(() {
      if (index == posicaoTesouro) {
        buttonText[index] = '💰';
        mensagem = 'Você encontrou o Tesouro! 🏆';
        gameOver = true;
      } else if (index == posicaoBomba) {
        buttonText[index] = '💣';
        mensagem = 'Você encontrou a Bomba! Fim de jogo.';
        gameOver = true;
      } else if (index == posicaoMonstro) {
        buttonText[index] = '👹';
        mensagem = 'Você foi pego pelo Monstro! Fim de jogo.';
        gameOver = true;
      } else {
        buttonText[index] = '❌';
        int tesouroReal = posicaoTesouro!;
        if (index < tesouroReal) {
          mensagem = 'O tesouro está em um número maior!';
        } else {
          mensagem = 'O tesouro está em um número menor!';
        }
      }
      buttonEnabled[index] = false;
    });
  }
 
  @override
  void initState() {
    super.initState();
    iniciarJogo();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('The Jogo'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              mensagem,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GridView.builder(
                itemCount: 20,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    onPressed: buttonEnabled[index] && !gameOver
                        ? () => _onButtonPressed(index)
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonEnabled[index]
                          ? Colors.blue
                          : Colors.grey.shade400,
                      padding: EdgeInsets.all(8),
                      minimumSize: Size(40, 40),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                    child: Text(buttonText[index]),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: ElevatedButton(
              onPressed: iniciarJogo,
              child: Text('Novo Jogo'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
