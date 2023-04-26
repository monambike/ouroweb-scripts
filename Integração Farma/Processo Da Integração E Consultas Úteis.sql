/**************************************************************************************

  Pressione "[F5]" para usar o Script abaixo.

  ===================================================================================
   Pequena Descri��o do Script
  ===================================================================================

  Esse Script serve como aux�lio no desenvolvimento, teste e compreens�o da
  "Integra��o Farma".

  Talvez seja necess�rio desativar a configura��o que utiliza Interop Store e Unilog.
  Menu Superior > Tabelas > Cadastro > Controle de Integra��es


  ===================================================================================
   Comandos Auxiliares
  ===================================================================================

  /* Processar Or�amento Para o Servi�o do Autom�tico (Transformar o or�amento
  criado na leitura do arquivo em pedido de venda) */
  DECLARE @IdEmpresa AS INT = <(IdEmpresa) Faturar Venda, INT, 2>
  EXEC usp_mng_GerarPedidoOLs_Resposta_Automatico @IdEmpresa
  EXEC usp_mng_Pedido_GerarArquivoRetorno_Automatico

  /* Gerar a Venda Automaticamente */
  DECLARE @IdEmpresa AS INT = <(IdEmpresa) Faturar Venda, INT, 2>
  EXEC usp_mng_Faturar_Pedido_Automatico @IdEmpresa


  /* Atualiza data dos movimentos de or�amento, pedido de venda e venda
  e as define para hoje */
  BEGIN TRAN UPDATE Mov_Estoque SET DataMovimento = GETDATE() WHERE Classifica��oMovimento IN(2,13,16) AND IdMovimento = @IdMovimento
                              COMMIT             ROLLBACK                              

**************************************************************************************/

/* �ltimas 3 a��es executadas utilizando o servi�o */
SELECT TOP 3 dte_DataHora, bit_Integrado, str_DescricaoFarmaLayoutFuncoes, Usu�rio, str_DescricaoFarmaLayouts, int_NroPedidoSite,
str_Erro, str_Protocolo, str_Arquivo FROM Tab_FarmaArquivoFuncoesLayout WITH(NOLOCK) INNER JOIN Tab_Usu�rios WITH(NOLOCK)
ON IdUsuario = int_IdUsuario ORDER BY pk_int_Tab_FarmaArquivoFuncoesLayout DESC
/* Verificar �ltimos bloqueios e erros que ocorreram utilizando o servi�o */
SELECT TOP 5 str_MessagemErro, int_IdMovimento, dte_DataHoraErro, NomeFantasia, Estado FROM Tab_ErroMovimentoAutomatico WITH(NOLOCK)
INNER JOIN Tab_Cadastro ON str_Codinome = Codinome ORDER BY pk_int_Tab_ErroMovimentoAutomatico DESC

/* Verificar os �ltimos 10 pedidos integrados */
SELECT TOP 10 * FROM Tab_FarmaPedido WITH(NOLOCK) ORDER BY pk_int_Tab_FarmaPedido DESC

/* Verifica o �ltimo pedido integrado e seus itens */
DECLARE @PedidoId AS INT = (SELECT MAX(pk_int_Tab_FarmaPedido) FROM Tab_FarmaPedido)
SELECT * FROM Tab_FarmaPedido WITH(NOLOCK) WHERE pk_int_Tab_FarmaPedido = @PedidoId
SELECT * FROM Tab_FarmaPedidoItens AS a WITH(NOLOCK) WHERE a.fk_int_Tab_FarmaPedido = @PedidoId
