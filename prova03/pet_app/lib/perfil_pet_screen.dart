import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Enum do gênero do pet
enum PetGenero { macho, femea }

class PerfilPetScreen extends StatefulWidget {
  const PerfilPetScreen({super.key});

  @override
  State createState() => _PerfilPetScreenState();
}

class _PerfilPetScreenState extends State<PerfilPetScreen> {
  final _formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final racaController = TextEditingController();
  final idadeController = TextEditingController();
  final observacoesController = TextEditingController();

  PetGenero? _generoSelecionado;
  bool _gostaCriancas = false;
  bool _conviveOutrosAnimais = false;
  bool _disponivelParaAdocao = false;

  @override
  void dispose() {
    nomeController.dispose();
    racaController.dispose();
    idadeController.dispose();
    observacoesController.dispose();
    super.dispose();
  }

  void _clearFields() {
    nomeController.clear();
    racaController.clear();
    idadeController.clear();
    observacoesController.clear();
    setState(() {
      _generoSelecionado = null;
      _gostaCriancas = false;
      _conviveOutrosAnimais = false;
      _disponivelParaAdocao = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        title: const Text('Perfil do Pet'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            tooltip: 'Perfil do Usuário',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Perfil do Usuário não implementado')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Cadastro de Perfil do Pet",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Preencha os dados do seu pet!",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField(nomeController, 'Nome do Pet', Icons.pets),
                  const SizedBox(height: 8),
                  _buildTextField(racaController, 'Raça', Icons.format_list_bulleted),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: idadeController,
                    decoration: InputDecoration(
                      labelText: 'Idade (anos)',
                      prefixIcon: Icon(Icons.cake, color: Theme.of(context).iconTheme.color),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: const Color.fromRGBO(255, 255, 255, 0.9),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe a idade do pet';
                      }
                      final age = int.tryParse(value);
                      if (age == null || age < 0) {
                        return 'A idade não pode ser negativa';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildTextField(observacoesController, 'Observações (Opcional)', Icons.notes, maxLines: 3),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Gênero do Pet'),
                    _buildRadioOption('Macho', PetGenero.macho),
                    _buildRadioOption('Fêmea', PetGenero.femea),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Preferências de Convivência'),
                    CheckboxListTile(
                      title: const Text('Gosta de crianças'),
                      value: _gostaCriancas,
                      onChanged: (bool? valor) {
                        setState(() {
                          _gostaCriancas = valor ?? false;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('Convive bem com outros animais'),
                      value: _conviveOutrosAnimais,
                      onChanged: (bool? valor) {
                        setState(() {
                          _conviveOutrosAnimais = valor ?? false;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SwitchListTile(
                      title: const Text('Disponível para adoção'),
                      value: _disponivelParaAdocao,
                      onChanged: (bool valor) {
                        setState(() {
                          _disponivelParaAdocao = valor;
                        });
                      },
                      activeColor: Colors.green.shade700,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Status: ${_disponivelParaAdocao ? 'Disponível' : 'Indisponível'}',
                      style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Dados salvos com sucesso!')),
                        );
                      }
                    },
                    child: const Text('Salvar', style: TextStyle(fontSize: 16)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red.shade700,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: _clearFields,
                    child: const Text('Limpar', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller,
      String label,
      IconData icon, {
        bool isNumber = false,
        int maxLines = 1,
      }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Theme.of(context).iconTheme.color),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: const Color.fromRGBO(255, 255, 255, 0.9),
      ),
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      inputFormatters: isNumber ? [FilteringTextInputFormatter.digitsOnly] : [],
      //maxLines: maxLines,textInputAction: maxLines > 1 ? TextInputAction.newline : TextInputAction.next,
      validator: (value) {
        if (label.contains('(Opcional)')) return null;
        if (value == null || value.isEmpty) {
          return 'Informe ${label.toLowerCase()}';
        }
        return null;
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).textTheme.titleLarge?.color,
      ),
    );
  }

  Widget _buildRadioOption(String label, PetGenero value) {
    return RadioListTile<PetGenero>(
      title: Text(
        label,
        style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
      ),
      value: value,
      groupValue: _generoSelecionado,
      onChanged: (PetGenero? newValue) {
        setState(() {
          _generoSelecionado = newValue;
        });
      },
    );
  }
}
