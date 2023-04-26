/**************************************************************************************

  Pressione "[F5]" para usar o Script abaixo.

  ===================================================================================
   Pequena Descrição do Script
  ===================================================================================

  Esse Script serve como auxílio no desenvolvimento, teste e compreensão da
  "Integração Farma".

  Talvez seja necessário desativar a configuração que utiliza Interop Store e Unilog.
  Menu Superior > Tabelas > Cadastro > Controle de Integrações


  ===================================================================================
   Comandos Auxiliares
  ===================================================================================

  /* Processar Orçamento Para o Serviço do Automático (Transformar o orçamento
  criado na leitura do arquivo em pedido de venda) */
  DECLARE @IdEmpresa AS INT = <(IdEmpresa) Faturar Venda, INT, 2>
  EXEC usp_mng_GerarPedidoOLs_Resposta_Automatico @IdEmpresa
  EXEC usp_mng_Pedido_GerarArquivoRetorno_Automatico

  /* Gerar a Venda Automaticamente */
  DECLARE @IdEmpresa AS INT = <(IdEmpresa) Faturar Venda, INT, 2>
  EXEC usp_mng_Faturar_Pedido_Automatico @IdEmpresa


  /* Atualiza data dos movimentos de orçamento, pedido de venda e venda
  e as define para hoje */
  BEGIN TRAN UPDATE Mov_Estoque SET DataMovimento = GETDATE() WHERE ClassificaçãoMovimento IN(2,13,16) AND IdMovimento = @IdMovimento
                              COMMIT             ROLLBACK                              

**************************************************************************************/

/* Últimas 3 ações executadas utilizando o serviço */
SELECT TOP 3 dte_DataHora, bit_Integrado, str_DescricaoFarmaLayoutFuncoes, Usuário, str_DescricaoFarmaLayouts, int_NroPedidoSite,
str_Erro, str_Protocolo, str_Arquivo FROM Tab_FarmaArquivoFuncoesLayout WITH(NOLOCK) INNER JOIN Tab_Usuários WITH(NOLOCK)
ON IdUsuario = int_IdUsuario ORDER BY pk_int_Tab_FarmaArquivoFuncoesLayout DESC
/* Verificar últimos bloqueios e erros que ocorreram utilizando o serviço */
SELECT TOP 5 str_MessagemErro, int_IdMovimento, dte_DataHoraErro, NomeFantasia, Estado FROM Tab_ErroMovimentoAutomatico WITH(NOLOCK)
INNER JOIN Tab_Cadastro ON str_Codinome = Codinome ORDER BY pk_int_Tab_ErroMovimentoAutomatico DESC

/* Verificar os últimos 10 pedidos integrados */
SELECT TOP 10 * FROM Tab_FarmaPedido WITH(NOLOCK) ORDER BY pk_int_Tab_FarmaPedido DESC

/* Verifica o último pedido integrado e seus itens */
DECLARE @PedidoId AS INT = (SELECT MAX(pk_int_Tab_FarmaPedido) FROM Tab_FarmaPedido)
SELECT * FROM Tab_FarmaPedido WITH(NOLOCK) WHERE pk_int_Tab_FarmaPedido = @PedidoId
SELECT * FROM Tab_FarmaPedidoItens AS a WITH(NOLOCK) WHERE a.fk_int_Tab_FarmaPedido = @PedidoId
