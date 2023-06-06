Valida��es gerais da tela:
1. Validar a atualiza��o e a inclus�o de um novo registro;
2. Validar a dele��o de um registro;
3. Validar o bot�o cancelar;
4. Validar o pressionar da tecla ESC;
5. Validar a responsividade da tela, tando ao diminuir quanto ao aumentar;
6. Validar o nome do t�tulo da tela.

Implementa��o dos filtros:
1. Validar nome e o texto dos controles da aba de filtro;
2. Validar a tabula��o de todos os controles (via de regra, de cima para baixo da esquerda para a direita);
3. Validar se todos os filtros est�o trazendo registros, e validar o aparecimento da mensagem para quando o filtro n�o deveria trazer registros.

Implementa��o do gerenciamento dos dados:
1. Validar nome e o texto dos controles da aba dados;
2. Validar se todos os campos da tela est�o trazendo os valores do banco;
3. Validar se todos os campos da tela est�o salvando os valores no banco;
4. Validar a tabula��o de todos os controles (via de regra, de cima para baixo da esquerda para a direita).

Grid da aba dados:
1. Validar inser��o direta de texto na caixa de pesquisa;
2. Validar se ao clicar com o bot�o direito e clicar em filtrar nas colunas est� trazendo o valor na caixa de pesquisa.

Criar as procedures do CRUD, segue sugest�es de nome:
usp_lst_Tab_<Nome da Tela, , CadastroConcorrente>
usp_mng_Insert_Tab_<Nome da Tela, , CadastroConcorrente>
usp_mng_Update_Tab_<Nome da Tela, , CadastroConcorrente>
usp_mng_Delete_Tab_<Nome da Tela, , CadastroConcorrente>

Fazer as implementa��es na camada de servidor para o canal de cadastro, segue sugest�es de nome:
02 - Services
03 - ServiceInterfaces
04 - Business
05 - DataAccess
06 - Entities

Realizar a chamada da tela no OuroWeb.
Verificar se a tela ainda est� no OuroWeb, se ainda estiver, perguntar se pode apagar a tela do fonte.

Realizar a leitura completa com aten��o do projeto e verificar incongru�ncias para evitar sanar futuros poss�vel problemas.