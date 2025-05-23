import 'package:flutter/material.dart';

class _PerfilPetScreenState extends State<PerfilPetScreen> {
  // Definições de estado, variáveis e lógica vão aqui

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do Pet'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            tooltip: 'Perfil do Usuário',
            onPressed: () {
                // Ações serão inseridas aqui
            },
          ),
        ],
      ),
      body: Center() // tela do app será inserida aqui
    );
  }
  
}
