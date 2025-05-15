# Prova 02 - The Jogo

# Equipe:
- Antônio Lopes de Freitas Neto
- Gabriel do Nascimento
- Isabella Caetano Spier
---
# Requisitos Técnicos

## 1. Utilização de widgets StatefulWidget e setState para controle de estado.

**Descrição**:  
A classe `JogoDoTesouro` é um `StatefulWidget`, o que permite manter estado entre as atualizações da interface. 
Sua classe de estado `_JogoDoTesouroState` contém variáveis que armazenam o estado do jogo, como a posição dos elementos (tesouro, bomba e monstro), 
o texto e habilitação dos botões, e a mensagem do jogo.  

O `setState` é usado sempre que há alteração nas variáveis que impactam a interface, ou seja, garante que as mudanças sejam refletidas na tela.

**Aplicações**:
```dart
class JogoDoTesouro extends StatefulWidget {
  @override
  _JogoDoTesouroState createState() => _JogoDoTesouroState();
}

class _JogoDoTesouroState extends State<JogoDoTesouro> {
  // variáveis de estado
  void _onButtonPressed(int index) {
    setState(() {
      // lógica do jogo
    });
  }
}
```
---
## 2. Implementação da lógica de sorteio:

**Descrição**:  
Ao iniciar o jogo, são sorteadas três posições distintas para o tesouro, bomba e monstro. 
Isso é feito embaralhando uma lista de índices de 0 a 19 e selecionando os três primeiros, o que garante que não haverá repetição de posições.

**Aplicações**:
```dart
void iniciarJogo() {
  Random random = Random();
  List<int> posicoes = List.generate(20, (i) => i)..shuffle(random);
  posicaoTesouro = posicoes[0];
  posicaoBomba = posicoes[1];
  posicaoMonstro = posicoes[2];
}
```
---
## 3. Alteração dinâmica da interface com base nas interações do usuário.

**Descrição**:  
Quando o usuário clica em um botão, a posição é comparada com as posições sorteadas. A interface é atualizada dinamicamente com base no resultado (tesouro, bomba, monstro ou nada). O texto do botão muda, a mensagem é atualizada, e o botão é desabilitado.

**Aplicações**:
```dart
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
      if (index < posicaoTesouro!) {
        mensagem = 'O tesouro está em um número maior!';
      } else {
        mensagem = 'O tesouro está em um número menor!';
      }
    }
    buttonEnabled[index] = false;
  });
}
```
---
## 4. Uso de ícones ou emojis para representar tesouro, bomba, monstro e vazio.

**Descrição**:  
Foram utilizados emojis para representar os eventos no jogo:
- 💰: Tesouro
- 💣: Bomba
- 👹: Monstro
- ❌: Local vazio

**Aplicações**:
Os ícones tornam o jogo mais intuitivo e visualmente atrativo.
```dart
buttonText[index] = '💰'; // exemplo para tesouro
```
---
