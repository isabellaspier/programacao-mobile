#Equipe:
- Antônio Lopes de Freitas Neto
- Gabriel do Nascimento
- Isabella Caetano Spier

# Protótipo 4 - cardápio de restaurante japonês

## 1. My App

**Descrição**:
É o ponto de entrada principal do aplicativo. Ele define a estrutura básica, configura temas e define a tela inicial.

**Aplicações**:
Usado como base para inicial o aplicativo, configurar o tema visual e navegar até a tela inicial do menu do Cardápio Sushi da Tuiuti que foi feito o protótipo.

**Como usar**:
```dart
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cardápio Sushi da Tuiuti',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const MenuScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

## 2. MenuScreen

**Descrição**:
Representa uma tela dinâmica que pode exibir e interagir com os elementos do menu de forma eficiente. Como é um StatefulWidget, permite a criação de estados que podem ser atualizados conforme necessário durante a execução do aplicativo.

**Aplicações**:
Usado para implementar telas interativas e dinâmicas no aplicativo, especialmente útil para gerenciar mudanças de estado em tempo real.

**Como usar**:
```dart
class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

## 3. PaymentScreen

**Descrição**:
É uma tela estática que apresenta informações e funcionalidades relacionadas ao processamento de pagamentos. Recebe um item através de um mapa (Map<String, dynamic>) para exibir os detalhes específicos. 

**Aplicações**:
Usado para criar telas de pagamento no aplicativo, permitindo que informações sobre o item selecionado sejam transmitidas e exibidas de forma clara.

**Como usar**:
```dart
class PaymentScreen extends StatelessWidget {
  final Map<String, dynamic> item;

  const PaymentScreen({Key? key, required this.item}) : super(key: key);
}

## 4. Scaffold (tela de pagamento)

**Descrição**:
Define a estrutura da tela de pagamento usando o widget Scaffold, que organiza a interface com uma barra de aplicativos (AppBar) e um corpo principal (body). A tela exibe os detalhes do item selecionado, informações nutricionais (caso disponíveis) e uma ação para finalizar a compra.

**Aplicações**:
Usado para criar uma interface de usuário organizada e funcional, com destaque para informações e ações relacionadas ao item selecionado e ao processo de pagamento.

**Como usar**:
```dart
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Pagamento'), backgroundColor: const Color(0xFF4CAF50)),
    body: Column(
      children: [
        Text('Você selecionou:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Image.network(item['imageUrl'], height: 80, width: 80),
        Text(item['name']),
        Text(item['promotionalPrice'] ?? item['originalPrice'], style: TextStyle(color: Colors.green)),
        if (item.containsKey('nutrition')) Table(children: [/* Linhas da tabela nutricional */]),
        ElevatedButton(
          onPressed: () { /* Ação ao finalizar */ },
          child: Text('Finalizar Compra'),
        ),
      ],
    ),
  );
}
## 5. MenuScreenState

**Descrição**:
É responsável por gerenciar o estado da tela MenuScreen, armazenando e filtrando os itens do menu com base na categoria selecionada e na consulta de busca.

**Aplicações**:
Permite implementar funcionalidades dinâmicas, como seleção de categorias, filtragem e exibição de itens do cardápio

**Como usar**:
```dart
class _MenuScreenState extends State<MenuScreen> {
  String selectedCategory = 'Promoção do dia';
  String searchQuery = '';
  List<Map<String, dynamic>> filteredMenuItems = [];
  final List<Map<String, dynamic>> allMenuItems = [ /* Lista de itens */ ];
}

## 6. initState e FilterMenuItems

**Descrição**:
Inicializa o estado do widget e define a lógica de filtragem dos itens do menu. O método initState é executado ao criar o estado do widget, chamando a função filterMenuItems. A função filterMenuItems realiza a filtragem dos itens com base na categoria selecionada e na consulta de busca.

**Aplicações**:
Usado para preparar e atualizar os dados que serão exibidos na interface, permitindo que apenas os itens relevantes sejam mostrados ao usuário de acordo com as seleções feitas.

**Como usar**:
```dart
@override
void initState() {
  super.initState();
  filterMenuItems();
}

void filterMenuItems() {
  setState(() {
    filteredMenuItems = allMenuItems.where((item) {
      final matchesCategory = item['category'] == selectedCategory;
      final matchesSearch = item['name'].toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  });
}

## 7. build Scaffold

**Descrição**:
Define a tela principal do aplicativo, exibindo o título "Cardápio Sushi da Tuiuti", campo de busca, filtros por categoria, itens do menu e a navegação para a tela de pagamento. A estrutura utiliza Scaffold, AppBar, ChoiceChip e ListView para criar uma interface interativa e organizada.

**Aplicações**:
Facilita a navegação e a interação do usuário com o cardápio, permitindo buscas, filtragens e seleção de itens.

**Como usar**:
```dart
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Cardápio Sushi da Tuiuti'),
      backgroundColor: Colors.green,
    ),
    body: Column(
      children: [
        TextField(onChanged: (value) { searchQuery = value; filterMenuItems(); }),
        Wrap(children: ['Categorias'].map((category) => ChoiceChip(onSelected: (_) { setState(() { selectedCategory = category; filterMenuItems(); }); })).toList()),
        Expanded(
          child: ListView.builder(
            itemCount: filteredMenuItems.length,
            itemBuilder: (context, index) => Card(
              child: Row(
                children: [
                  Image.network(filteredMenuItems[index]['imageUrl']!, height: 100, width: 100),
                  Expanded(child: Text(filteredMenuItems[index]['name']!)),
                  ElevatedButton(onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (_) => PaymentScreen(item: filteredMenuItems[index])); }, child: Text('Pedir')),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

# Protótipo 2 - calculadora de IMC

## 1. IMCCalculatorApp

**Descrição**:
É o ponto de entrada principal da aplicação de cálculo de IMC (Índice de Massa Corporal). Ele define a estrutura inicial, configura o título da aplicação e remove o banner de depuração.

**Aplicações**:
Usado para inicializar o aplicativo e definir a tela principal (IMCCalculatorPage) onde os cálculos de IMC serão realizados.

**Como usar**:
```dart
class IMCCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      home: IMCCalculatorPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

## 2. IMCCalculatorPageState

**Descrição**:
É um widget que representa a tela principal da aplicação de cálculo de IMC. Ele é um StatefulWidget, permitindo a interação dinâmica e a criação de estados atualizáveis durante o uso.

**Aplicações**:
Usado para implementar a interface interativa do cálculo de IMC, permitindo que o estado seja gerenciado e atualizado com base nas entradas do usuário.

**Como usar**:
```dart
class IMCCalculatorPage extends StatefulWidget {
  @override
  _IMCCalculatorPageState createState() => _IMCCalculatorPageState();
}

## 3. IMCCalculatorPageState

**Descrição**:
É a classe responsável por gerenciar o estado dinâmico da tela de cálculo de IMC. Ela captura os dados de entrada do usuário, valida-os, realiza o cálculo do IMC, classifica os resultados e exibe mensagens de erro, quando necessário.

**Aplicações**:
Usado para implementar a lógica central do aplicativo de cálculo de IMC, com foco na validação, cálculo e exibição de classificações baseadas no resultado do IMC.

**Como usar**:
```dart
class _IMCCalculatorPageState extends State<IMCCalculatorPage> {
  void _calcularIMC() {
    // Valida as entradas, calcula o IMC e atualiza estado.
  }

  String _classificarIMC(double imc) {
    // Retorna a classificação com base no IMC calculado.
  }
}

## 4. build Scaffold (calculadora de IMC)

**Descrição**:
Define a interface principal da tela da Calculadora de IMC. Ele inclui campos para entrada de altura e peso, um botão para realizar o cálculo, exibição de resultados e mensagens de erro, e uma tabela de classificação do IMC.

**Aplicações**:
class PaymentScreen extends StatelessWidget { final Map<String, dynamic> item;
const PaymentScreen({Key? key, required this.item}) : super(key: key);

**Como usar**:
```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Calculadora de IMC')),
    body: Column(
      children: [
        Row(children: [TextField(controller: _alturaController), TextField(controller: _pesoController)]),
        ElevatedButton(onPressed: _calcularIMC, child: const Text('Calcular IMC')),
        if (_errorMessage.isNotEmpty) Text(_errorMessage),
        if (_imc != null) Text('${_imc!.toStringAsFixed(2)} | $_classificacao'),
        Table(border: TableBorder.all(), children: [/* Linhas da tabela */]),
      ],
    ),
  );
}

## 5. buildTableRow

**Descrição**:
Constrói uma linha personalizada para uma tabela, exibindo dois textos centralizados com estilos distintos. Utiliza padding para espaçamento e configurações de estilo para melhorar a apresentação.

**Aplicações**:
Usado para gerar linhas reutilizáveis em tabelas, como a tabela de classificação do IMC, garantindo uma visualização organizada e estilizada.

**Como usar**:
```dart
TableRow _buildTableRow(String title, String value) {
  return TableRow(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(title, textAlign: TextAlign.center),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(value, textAlign: TextAlign.center),
      ),
    ],
  );
}
