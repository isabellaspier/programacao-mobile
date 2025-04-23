// Importa os widgets e temas do Material Design
import 'package:flutter/material.dart';
// Necessário para usar restrições de entrada de texto com TextInputFormatter
import 'package:flutter/services.dart'; 

// Função principal: ponto de entrada da aplicação
void main() => runApp(IMCCalculatorApp());

// Classe principal do app: um widget sem estado (StatelessWidget)
class IMCCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC', // Título da aplicação
      home: IMCCalculatorPage(), // Tela principal
      debugShowCheckedModeBanner: false, // Remove banner de debug
    );
  }
}

// Tela principal do app, com estado (StatefulWidget)
class IMCCalculatorPage extends StatefulWidget {
  @override
  _IMCCalculatorPageState createState() => _IMCCalculatorPageState();
}

class _IMCCalculatorPageState extends State<IMCCalculatorPage> {
  // Controladores para os campos de altura e peso
  final _alturaController = TextEditingController();
  final _pesoController = TextEditingController();

  // Variáveis para armazenar o resultado do IMC e mensagens
  double? _imc;
  String _classificacao = "";
  String _errorMessage = "";

  // Função para calcular o IMC
  void _calcularIMC() {
    setState(() {
      _errorMessage = ""; // Limpa mensagens de erro anteriores
    });

    // Converte os textos para double (substitui vírgula por ponto)
    final double? altura = double.tryParse(_alturaController.text.replaceAll(',', '.'));
    final double? peso = double.tryParse(_pesoController.text);

    // Validação dos valores
    if (altura == null || peso == null || altura <= 0 || peso <= 0) {
      setState(() {
        _errorMessage = "Por favor, insira valores válidos para altura e peso.";
      });
      return;
    }

    // Cálculo do IMC
    final imc = peso / (altura * altura);

    // Atualiza o estado com o resultado
    setState(() {
      _imc = imc;
      _classificacao = _classificarIMC(imc);
    });
  }

  // Classificação do IMC baseado no valor calculado
  String _classificarIMC(double imc) {
    if (imc < 19) {
      return "Abaixo do peso";
    } else if (imc < 24) {
      return "Peso normal";
    } else if (imc < 30) {
      return "Sobrepeso";
    } else if (imc < 40) {
      return "Obesidade";
    } else {
      return "Obesidade Mórbida";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior do app
      appBar: AppBar(
        title: const Text('Calculadora de IMC'), // Título da barra
        backgroundColor: Colors.teal, // Cor de fundo da AppBar
        centerTitle: true, // Centraliza o título
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Espaçamento interno
        child: Column( // Empilha os elementos verticalmente
          children: [
            Row( // Linha para inputs lado a lado
              children: [
                Expanded( // Ajusta responsivamente o campo
                  child: TextField(
                    controller: _alturaController, // Controlador de altura
                    keyboardType: TextInputType.number, // Tipo de teclado numérico
                    inputFormatters: [
                      // Permite apenas números com até 2 casas decimais
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+[,\.]?\d{0,2}$')),
                    ],
                    decoration: InputDecoration(
                      labelText: 'Altura (m)', // Rótulo do campo
                      hintText: 'Ex: 1,75', // Dica de preenchimento
                      hintStyle: TextStyle(color: Colors.grey[400]), // Estilo da dica
                      prefixIcon: const Icon(Icons.height), // Ícone do campo
                      border: const OutlineInputBorder(), // Borda do campo
                    ),
                  ),
                ),
                const SizedBox(width: 10), // Espaço entre os campos
                Expanded(
                  child: TextField(
                    controller: _pesoController, // Controlador de peso
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Peso (kg)',
                      hintText: 'Ex: 70',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      prefixIcon: const Icon(Icons.monitor_weight),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20), // Espaço entre input e botão
            Center(
              child: ElevatedButton(
                onPressed: _calcularIMC, // Chama a função de cálculo
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal, // Cor do botão
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text(
                  'Calcular IMC',
                  style: TextStyle(color: Colors.white), // Cor do texto do botão
                ),
              ),
            ),
            const SizedBox(height: 20), // Espaço antes das mensagens
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage, // Mostra mensagem de erro
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            if (_imc != null)
              Container(
                // Container para destacar o resultado
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.teal[50], // Fundo claro
                  borderRadius: BorderRadius.circular(10), // Cantos arredondados
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.withOpacity(0.5).withValues(), // Sombra
                      offset: const Offset(0, 4), // Deslocamento da sombra
                      blurRadius: 8, // Suavidade da sombra
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'Resultado:',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${_imc!.toStringAsFixed(2)}', // Exibe o valor do IMC com 2 casas
                      style: const TextStyle(fontSize: 24, color: Colors.teal),
                    ),
                    Text(
                      'Classificação: $_classificacao', // Exibe classificação
                      style: const TextStyle(fontSize: 18, color: Colors.teal),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 20), // Espaço antes da tabela
            Table(
              // Tabela de classificação do IMC
              border: TableBorder.all(color: Colors.teal), // Borda da tabela
              children: [
                _buildTableRow('Abaixo do peso', '< 19'),
                _buildTableRow('Peso normal', '19 - 24'),
                _buildTableRow('Sobrepeso', '25 - 29'),
                _buildTableRow('Obesidade', '30 - 39'),
                _buildTableRow('Obesidade Mórbida', '> 40'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Função auxiliar para construir uma linha da tabela
  TableRow _buildTableRow(String title, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center, // Centraliza o texto
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center, // Centraliza o texto
          ),
        ),
      ],
    );
  }
}
