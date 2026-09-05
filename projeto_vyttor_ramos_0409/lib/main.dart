import 'package:flutter/material.dart'; //importa o pacote do flutter que tras os widgets 

void main() {
  //ponto de entrada do programa dart, primeira função executada
  runApp(const CrachaApp());
}

class CrachaApp extends StatelessWidget{
  //extends StatelessWidget a classe herda o comportamento de um widget 'sem memoria', ele descreve a tela, mas não guarda nenhum dado que muda sozinho. Porque nome e cargo não são fixos durante o uso do app
  const CrachaApp({super.key});

  @override
  //avisa p/ o compilador que esse metodo já existe na classe pai (StateWidget) e estou reescrevendo o comportamento dele.
  Widget build(BuildContext context){
    //build é o metodo obrigatorio chamado para desenhar a interface. Recebe um build context (o endereço deste widget na arvore e deve retornar o widgwt pronto)
    return MaterialApp(
      //Widget raiz que configura o app inteiro: tema, titulo, tela inicial e o
      title: 'Crachá Digital',
      //Titulo interno do APP. Não aparece na tela
      home: Scaffold(
        //home define a tela real do app, o Scaffold cria o esqueleto padrão que já reserva espaço para appbar e corpo, por exemplo
        appBar: AppBar(
          //AppBar é uma região fixa no topo da tela
          title: const Text('Crachá Digital'),
          //texto exibido dentro da app dar, const por que nunca vai mudar, então Flutter pode reaproveitar esse widget sem criar o titulo a cada redesenho 
        ),
        body: Padding(
          //body é a região principal da pagina, abaixo de AppBar, padding cria espaço interno ao redor do seu conteudo
          padding: const EdgeInsets.all(24),
          //24px de respiro nnos quatro lados entre a borda da tela e o conteudo
          child: Column(
            //Colum empilha seus filhos verticalmente: primeiro o cartão do crachá, depois o cartão
            crossAxisAlignment: CrossAxisAlignment.stretch,
            //Crontola o eixo cruzado da coluna (horizontal) 'stretch' faz cada filho ocupar toda a largura diponivel horizontalmente, é por isso que o cartão e o botão vão preencher a largura da tela, em vez de ficarem do tamanho especifico do seu conteudo.
            children: [
              //fazendo a lista de filhos da coluna
              Container(
                //container é a caixa que dará a aparencia de cartão ao conjunto de textos
                padding: const EdgeInsets.all(16),
                //espaço interno do container, distancia entre a porta do cartão e o conteudo dentro
                decoration: BoxDecoration(
                  //cuida da aparencia da caixa (cor de fundo, bordas, cantos, etc)
                  color: const Color.fromARGB(255, 132, 0, 255),
                  //cor do fundo do container
                  borderRadius: BorderRadius.circular(12),
                  //arredonda os cantos do container
                  border: Border.all(color: Colors.blue.shade50),
                  //desenha um contorno fino ao redor do container
                ),
                child: const Column(
                  //o contaniner tambem só acieta um filho , aqui uma coluna propria local a este cartão. Ocnst pois nd vai mudar no tempo da conexão
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //dentro do cartao o alinhamento a esquerda, uma colum diferente pode ter config diferente da colum externa
                  children: [
                    //faremos a lista de filhos da coluna
                    Text('@vyttorz',
                    style: TextStyle(
                    fontSize: 28, //tamanho da fonte em px - bem grande
                    fontWeight: FontWeight.bold //fonte em bold
                    ),
                    ),
                    SizedBox(
                      height: 4,
                    ), //Widget "invisivel" que adiciona um espaço vertical, de 4 px entre o nome (acima) e o cargo (abaixo)
                    Text(
                      'Lider de suporte',
                      style: TextStyle(
                        fontSize: 16, color: Colors.amber //fonte menor, cor amber
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                    //row organiza seu filinhos lado a lado, na horizontal, diferente da colum
                    children: [
                      Icon(Icons.factory, color: Colors.amber,),
                      //icon é apenas um desenho vetorial da biblioteca material, puramente visual
                      SizedBox(width: 8,),
                      Text('Setor: Suporte')
                      //tetxo final da ROW
                    ],
                    )
                    //nome do colab
                  ],
                ),
              ),
              const SizedBox(height: 24,),
              FilledButton.icon(
              //tipo de botão que ja esta preenchido com icone e texto, lado a lado, sem precisar montar uma row manual pra ele
                onPressed: (){
                  //essa função é executada toda vez que ele é tocado, aqui usamos uma func anonima (){}
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      //Snackbar é o aviso que desliza na parte inferior. Mostra a msg por alguns segundos
                      content: Text('Acesso Liberado!!'),
                      //conteudo do snackbar
                    ),
                  );
                },
                icon: const Icon(Icons.lock_open),
                //icone exibido a direita do botão, nesse caso, um cadeado
                label: const Text('Liberado!'),
              )

            ],
          ),
        )
      ),
    );
  }
}