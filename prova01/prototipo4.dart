import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Widget raiz do aplicativo, define estrutura básica.
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

// Tela principal do cardápio (com estado)
class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

// Tela de pagamento (sem estado)
class PaymentScreen extends StatelessWidget {
  final Map<String, dynamic> item;

  const PaymentScreen({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagamento'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Você selecionou:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Image.network(
                  item['imageUrl'],
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'],
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      item['promotionalPrice'] ?? item['originalPrice'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (item.containsKey('nutrition')) ...[
              const Text(
                'Tabela Nutricional:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Table(
                border: TableBorder.all(),
                children: [
                  TableRow(children: [
                    const Padding(padding: EdgeInsets.all(4), child: Text('Calorias')),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text('${item['nutrition']['calories']} kcal'),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(padding: EdgeInsets.all(4), child: Text('Proteínas')),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text('${item['nutrition']['protein']} g'),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(padding: EdgeInsets.all(4), child: Text('Carboidratos')),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text('${item['nutrition']['carbs']} g'),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(padding: EdgeInsets.all(4), child: Text('Gorduras')),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text('${item['nutrition']['fat']} g'),
                    ),
                  ]),
                ],
              ),
            ],
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Pedido realizado com sucesso e vinculado à sua mesa, para pagar ao sair do restaurante!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              child: const Text(
                'Finalizar Compra',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuScreenState extends State<MenuScreen> {
  String selectedCategory = 'Promoção do dia';
  String searchQuery = '';
  List<Map<String, dynamic>> filteredMenuItems = [];

  final List<Map<String, dynamic>> allMenuItems = [
    {
      'category': 'Promoção do dia',
      'name': '8 Sashimi de Salmão Selado no Gergelim',
      'description': '8 Fatias de Salmão Seladas no Gergelim em temperatura correta.',
      'originalPrice': 'R\$ 55,90',
      'promotionalPrice': 'R\$ 49,90',
      'discount': '-11%',
      'imageUrl': 'https://media-cdn.tripadvisor.com/media/photo-s/16/26/04/20/salmao-selado-com-crosta.jpg',
      'nutrition': {
        'calories': 320,
        'protein': 26,
        'carbs': 2,
        'fat': 20,
      }
    },
    {
      'category': 'Promoção do dia',
      'name': '8 Sashimi de Salmão Maçaricado ao molho de Maracujá',
      'description': '8 Fatias de Salmão Maçaricado servidas ao Molho de Maracujá.',
      'originalPrice': 'R\$ 55,90',
      'promotionalPrice': 'R\$ 49,90',
      'discount': '-11%',
      'imageUrl': 'https://p2.trrsf.com/image/fget/cf/774/0/images.terra.com/2023/11/19/893007908-salmao-grelhado-ao-molho-de-maracuja.jpg',
      'nutrition': {
        'calories': 340,
        'protein': 25,
        'carbs': 5,
        'fat': 21,
      }
    },
    {
      'category': 'Promoção do dia',
      'name': '8 Sashimi de Salmão',
      'description': '8 Fatias de Salmão acompanhado de Wasabi e Gengibre com molho Shoyu.',
      'originalPrice': 'R\$ 55,90',
      'promotionalPrice': 'R\$ 44,90',
      'discount': '-20%',
      'imageUrl': 'https://swiftbr.vteximg.com.br/arquivos/ids/203266-1500-1000/622637-lombo-de-salmao-para-sashimi_1.jpg?v=638684190874330000',
      'nutrition': {
        'calories': 320,
        'protein': 26,
        'carbs': 2,
        'fat': 20,
      }
    },
    {
      'category': 'Promoção do dia',
      'name': '8 Hot Filadélfia',
      'description': '8 Unidades do nosso especial hot-filadelfia.',
      'originalPrice': 'R\$ 35,90',
      'promotionalPrice': 'R\$ 29,79',
      'discount': '-17%',
      'imageUrl': 'https://storage.deliveryvip.com.br/t3NoyWB_4Q9yBmxeTVGKTiIFFJIitPYrq96tUwv224Y/s:400:0/Z3M6Ly9kZWxpdmVy/eXZpcC84azM4Mzll/cDh3azc5czNsYWV5/cG55OGpvMDZv',
      'nutrition': {
        'calories': 188,
        'protein': 6,
        'carbs': 29,
        'fat': 5,
      }
    },
    {
      'category': 'Promoção do dia',
      'name': 'Yakissoba + Coca',
      'description': '1 Yakissoba maravilhoso, acompanhado de uma coquinha gelada.',
      'originalPrice': 'R\$ 51,90',
      'promotionalPrice': 'R\$ 45,90',
      'discount': '-12%',
      'imageUrl': 'https://static.ifood-static.com.br/image/upload/t_medium/pratos/ffd54179-7581-42d0-9585-77a3dc36d168/202104051908_CIXo_f.png',
      'nutrition': {
        'calories': 678,
        'protein': 24,
        'carbs': 129,
        'fat': 17,
      }
    },
    {
      'category': 'Promoção do dia',
      'name': '5 Gyozas Crocantes',
      'description': 'Gyozas recheados com carne e vegetais, servidos com molho especial.',
      'originalPrice': 'R\$ 32,90',
      'promotionalPrice': 'R\$ 27,90',
      'discount': '-15%',
      'imageUrl': 'https://i0.wp.com/pratofundo.com/wp-content/uploads/gyozapastel.jpg?w=800&quality=85&strip=all&ssl=1',
      'nutrition': {
        'calories': 385,
        'protein': 23,
        'carbs': 38,
        'fat': 15,
      }
    },
    {
      'category': 'Promoção do dia',
      'name': '10 Harumakis de Queijo',
      'description': 'Deliciosos rolinhos primavera crocantes recheados com queijo.',
      'originalPrice': 'R\$ 39,90',
      'promotionalPrice': 'R\$ 34,90',
      'discount': '-13%',
      'imageUrl': 'https://res.cloudinary.com/doa3wisuw/image/upload/c_fit,h_1515,q_60,w_2048/bew5jggoolurt14smcjj.webP',
      'nutrition': {
        'calories': 1030,
        'protein': 57,
        'carbs': 75,
        'fat': 56,
      }
    },
    {
      'category': 'Promoção do dia',
      'name': 'Temaki Filadélfia + 8 Uramaki Filadélfia',
      'description': '1 Temaki Filadélfia + 8 maravilhosos Uramakis.',
      'originalPrice': 'R\$ 79,90',
      'promotionalPrice': 'R\$ 71,90',
      'discount': '-10%',
      'imageUrl': 'https://media-cdn.tripadvisor.com/media/photo-s/05/b7/3e/80/goen-temaki-lounge.jpg',
      'nutrition': {
        'calories': 868,
        'protein': 30,
        'carbs': 156,
        'fat': 17,
      }
    },
    {
      'category': 'Sushi',
      'name': 'Combinado Especial de Sushi e Sashimi',
      'description': 'Uma combinação incrível de 10 sushis variados e 8 sashimis frescos.',
      'originalPrice': 'R\$ 99,90',
      'imageUrl': 'https://media-cdn.tripadvisor.com/media/photo-s/09/a3/35/cb/wikimaki.jpg',
      'nutrition': {
        'calories': 480,
        'protein': 35,
        'carbs': 50,
        'fat': 15,
      }
    },
    {
      'category': 'Ramen',
      'name': 'Yakissoba Tradicional',
      'description': 'Um prato especial de Yakissoba Tradicional.',
      'originalPrice': 'R\$ 51,90',
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyQWyBXQEjNr4x4EWJ4ZzEr7lkgfm3G4_t-A&s',
      'nutrition': {
        'calories': 426,
        'protein': 24,
        'carbs': 66,
        'fat': 17,
      }
    },
    {
  'category': 'Monte seu poke',
  'name': 'Poke Salmão + 4 Ingredientes',
  'description': 'Monte seu poke especial com ingredientes frescos e salmão.',
  'originalPrice': 'R\$ 64,90',
  'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLAXdiiqZ2BM5Axk5OUFaObMfnLitafxyFtw&s',
  'nutrition': {
    'calories': 450,
    'protein': 35,
    'carbs': 40,
    'fat': 15,
  }
},
{
  'category': 'Combinados',
  'name': 'Combinado do Chef',
  'description': 'Uma seleção especial do chef com 20 peças.',
  'originalPrice': 'R\$ 119,90',
  'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9wuMqfKJ90CaTlhDEN9a1FDCwjpGK1PP_Fw&s',
  'nutrition': {
    'calories': 600,
    'protein': 40,
    'carbs': 50,
    'fat': 20,
  }
},
{
  'category': 'Sobremesas',
  'name': 'Mochi',
  'description': 'Delicioso mochi recheado com sorvete.',
  'originalPrice': 'R\$ 19,90',
  'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIv2_BBo06umwd2-3_oq2DDskYcqm50sXQKw&s',
  'nutrition': {
    'calories': 180,
    'protein': 3,
    'carbs': 35,
    'fat': 6,
  }
},
{
  'category': 'Bebidas',
  'name': 'Coca-cola 600ml',
  'description': 'Coquinha gelada.',
  'originalPrice': 'R\$ 6,99',
  'imageUrl': 'https://carrefourbrfood.vtexassets.com/arquivos/ids/18900724/coca-cola-600ml-1.jpg?v=637590176325700000',
  'nutrition': {
    'calories': 252,
    'protein': 0,
    'carbs': 63,
    'fat': 0,
  }
},
{
  'category': 'Bebidas',
  'name': 'Suco Natural de Laranja 300ml',
  'description': 'Suco de Laranja feito na hora.',
  'originalPrice': 'R\$ 9,90',
  'imageUrl': 'https://i0.wp.com/e-cafeecachaca.com.br/wp-content/uploads/2024/07/15288526073_SUCO20NATURAL20DE20LARANJA20COPO20300ML8.png?fit=600%2C600&ssl=1',
  'nutrition': {
    'calories': 150,
    'protein': 2,
    'carbs': 35,
    'fat': 0,
  }
},
{
  'category': 'Bebidas',
  'name': 'Água 600ml',
  'description': 'Água com e sem gás, escolha na hora da retirada.',
  'originalPrice': 'R\$ 5,20',
  'imageUrl': 'https://prezunic.vtexassets.com/arquivos/ids/209116-800-auto?v=638478581259070000&width=800&height=auto&aspect=true',
  'nutrition': {
    'calories': 0,
    'protein': 0,
    'carbs': 0,
    'fat': 0,
  }
}
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cardápio Sushi da Tuiuti'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Buscar item',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                searchQuery = value;
                filterMenuItems();
              },
            ),
          ),
          Wrap(
            spacing: 8.0,
            children: [
              'Promoção do dia',
              'Sushi',
              'Ramen',
              'Monte seu poke',
              'Combinados',
              'Sobremesas',
              'Bebidas',
            ].map((category) {
              final isSelected = selectedCategory == category;
              return ChoiceChip(
                label: Text(category),
                selected: isSelected,
                onSelected: (_) {
                  setState(() {
                    selectedCategory = category;
                    filterMenuItems();
                  });
                },
                selectedColor: Colors.green,
                backgroundColor: Colors.grey[300],
              );
            }).toList(),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: filteredMenuItems.length,
              itemBuilder: (context, index) {
                final item = filteredMenuItems[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        // Imagem do prato com selo de desconto
                        Stack(
                          children: [
                            Image.network(
                              item['imageUrl']!,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                            if (item.containsKey('discount'))
                              Positioned(
                                top: 0,
                                left: 0,
                                child: Container(
                                  color: Colors.redAccent,
                                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                  child: Text(
                                    item['discount']!,
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(width: 8),

                        // Detalhes do prato
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name']!,
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(item['description']!),
                              const SizedBox(height: 4),

                              // Exibição dos preços (original e promocional lado a lado)
                              Row(
                                children: [
                                  if (item.containsKey('promotionalPrice')) ...[
                                    Text(
                                      item['originalPrice']!,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      item['promotionalPrice']!,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ] else
                                    Text(
                                      item['originalPrice']!,
                                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Botão de pedido
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentScreen(item: item),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4CAF50),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          ),
                          child: const Text(
                            'Pedir',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
