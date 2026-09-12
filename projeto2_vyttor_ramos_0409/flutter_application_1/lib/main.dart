import 'package:flutter/material.dart';

void main() {
  runApp(const ContadorApp());
  // liga o motor do flutter e entrega o widget raiz (ContadorApp)
}

class ContadorApp extends StatelessWidget {
  // essa classe é só uma casca de configuração do App, ela não guarda nenhum //dado, por isso é StatelessWidget

  const ContadorApp({super.key});
  // construtor, repassando a key para o widget pai identifica-la

  @override
  Widget build(BuildContext context) {
    // monta e devolve a configuração geral do aplicativo
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contador de Inspeção',
      // titulo interno do App
      home: const TelaContador(),
      // A tela inicial do App é o widget TelaContador, definido logo abaixo
    );
  }
}

class TelaContador extends StatefulWidget {
  // isso é novo em realação ao projeto 1 (cracha)
  // Agora, a tela precisa lembrar de dados qeue mudam (a contagem, o nome, o historico.) Esta classe ainda não esta guardadno nada sozinha,mas ela já declara que existe um state associado a ela.

  const TelaContador({super.key});

  @override
  State<TelaContador> createState() => _TelaContadorState();
  //createstate é o metodo que o Flutter chama para criar o objeto de estado (tela contador state) ligado a este widget.
}

class _TelaContadorState extends State<TelaContador> {
  // esta é a classe que efetivamente gurda os dados qeu podem mudar durante o uso do app. Funciona como um cop e sobrevive entre uma recosntrução e outra das telas

  int _pecasAprovadas = 0;
  // variavel qeu gurada a contagem atual de peças aprovadas, começando com 0

  final _nomeController = TextEditingController();
  // TexteditingController é a ponte entre o que aparece na tela (Textfild)
  // e o nosso codigo dart. Guarda o texto digitado e o permite le-lo a qualquer momento em '_nomeController'. o final é pq o Controller em si nunca muda. ( sempre aponta para o mesmo objeto), quem muda é o texto dentro dele.

  final List<String> _registros = [];
  //lista vazia de textos que vai guardar o historico de registros de inspeção fechados no turno

  void _aprovarPeca() {
    //Funação chamada toda vez que o botão "+1 peça" é tocado pelo usuario
    setState(() {
      //smp que um dado do state muda, essa alteração precisa ocorrer dentro do setState, para que o fluter saiba que precisa redesenhar a tela com um novo valor
      _pecasAprovadas += 1;
      //incrementa a contagem de peças em 1
    });
  }

  void _registrarEZerar() {
    //Função chamada quando o botão "registrar e zerar" é tocado pelo user.
    final nome = _nomeController.text.trim().isEmpty
        ? 'Sem nome'
        : _nomeController.text.trim();

    //operador ternario (condição?valor verdadeiro : valorFalso)
    //.trim() remove espaços em branco do texto, se depois disso, o texto estiver vazio usamos "não informado"; senão usamos o nome digitado

    setState(() {
      //de novo, toda mudança do State entra no setState
      _registros.add('$nome - $_pecasAprovadas peças(s)');
      //monta um texto combinando o nome e contagem atual(interpolação de string) adiciona esse texto montado no final da lista de registros

      _pecasAprovadas = 0;
      //zera o contador, para o inspetor começar a contar o proximo lote de peças
    });
  }

  @override
  void dispose() {
    //dispose é chamado pelo flutter qnd a tela é removida da arvore de widgets, ou seja, qnd o usuario sai da tela
    _nomeController.dispose();
    //libera os recursos do controller(evita deixar memoria alocada/em uso)

    super.dispose();
    //chama a implementação original, nativa do dispose, da classe pai
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //esqueleto padrçao de uma tela do flutter
      appBar: AppBar(
        //titulo fixo na barra do topo da tela
      ),
      body: Padding(
        //corpo da tela com espaçamento interno ao redor de todos os elementos
        padding: const EdgeInsets.all(16.0),
        child: Column(
          //organiza todo o conteudo da tela verticalmente
          children: [
            TextField(
              //campo de texto onde o inspetor digita o texto
              controller: _nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome do inspetor do turno',
                border: OutlineInputBorder(),
              ),
              onChanged: (texto) {
                //onchanged é chamado pelo flutter toda vez que  o usuario digita ou apaga um caracter
                setState(() {
                  //chamamos o setState com um bloco vazio só para forçar o projeto para assim redesenhar. o nome em si (_nomeCOntroller) já foi atualizado pelo controller, só precisamos avisar o flutter para reler esse valor no text logo abaixo
                });
              },
            ),
            const SizedBox(height: 16),
            Text(
              _nomeController.text.trim().isEmpty
                  ? 'Responsável: Não informado'
                  : 'Responsável: ${_nomeController.text.trim()}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '$_pecasAprovadas',
              style: const TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),
              //fonte big para destacar a contagem de peças
            ),
            Row(
              //linha horizontal com os botoes
              mainAxisAlignment: MainAxisAlignment.center,
              //centraliza os botoes no eixo principal da row(horizontal)
              children: [
                FilledButton.icon(
                  // esse é um estilo de botão ja preenchido. será usado para aprovar a peça
                  onPressed: _aprovarPeca,
                  // quando tocado o botão chama a função aprovar peça. essa é uma forma curta/abrevidada de escrever
                  // onPressed: (){_aprovarPeca();}
                  icon: const Icon(Icons.add),
                  label: const Text('+1 Peça'),
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  onPressed: _registrarEZerar,
                  icon: const Icon(Icons.save_alt),
                  label: const Text('Registrar e Zerar'),
                ),
                const SizedBox(width: 12),
              ],
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Historico do Turno',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _registros.isEmpty
                  ? const Center(
                      child: Text('Nenhum Registro ainda'),
                    )
                  : ListView.builder(
                      itemCount: _registros.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.history),
                            title: Text(_registros[index]),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}