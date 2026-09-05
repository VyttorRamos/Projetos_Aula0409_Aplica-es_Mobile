import 'package:flutter/material.dart';

void main() {
  runApp(const ContadorApp());
  //liga o motor do flutter e entrega o widget raiz(ContadorApp())
}

class ContadorApp extends StatelessWidget {
  //essa classe é só uma casca de configuração do App, não guarda nenhum dado, pois isso é stateless
  const ContadorApp({super.key});
  //construtor repassando a key para o widget pai identifica-la

  @override
  Widget build(BuildContext context) {
    //conta e devolve a config geral do aplicativo
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contador de Inspeção',
      //titulo interno do app (no chrome fica no inicio da pagina)
      home: const TelaContador(),
      //A tela inicial do app é o widget TelaContador, definido logo abaixo. 
    );
  }
}

class TelaContador extends StatefulWidget {
  const TelaContador({super.key});

  @override
  State<TelaContador> createState() => _TelaContadorState();
}

class _TelaContadorState extends State<TelaContador> {
  int _pecAprovados = 0;

  final _nomeController = TextEditingController();

  //essa classe é a que definitivamente guarda os dados que podem mudar durante o uso do app. Funciona como um "cofre" que sobrevive entre uma recontrução e outra das telas
}