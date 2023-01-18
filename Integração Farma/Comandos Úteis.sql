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

  -- Processar Or�amento pelo Servi�o do Autom�tico
  DECLARE @IdEmpresa AS INT = <(IdEmpresa) Faturar Venda, INT, 2>
  EXEC usp_mng_GerarPedidoOLs_Resposta_Automatico @IdEmpresa
  EXEC usp_mng_Pedido_GerarArquivoRetorno_Automatico

  -- Gerar a Venda automaticamente
  DECLARE @IdEmpresa AS INT = <(IdEmpresa) Faturar Venda, INT, 2>
  EXEC usp_mng_Faturar_Pedido_Automatico @IdEmpresa


  -- Atualiza data dos movimentos de or�amento, pedido de venda e venda
  -- e as define para hoje
  BEGIN TRAN UPDATE Mov_Estoque SET DataMovimento = GETDATE() WHERE Classifica��oMovimento IN(2,13,16) AND IdMovimento = @IdMovimento
                              COMMIT             ROLLBACK                              

**************************************************************************************/

-- CONSULTAS � RESPEITO DE ALGUMAS INFORMA��ES �TEIS
--------------- + --------------- + --------------- + --------------- + ---------------
-- �ltimas a��es executadas utilizando o servi�o
SELECT TOP 1000 str_DescricaoFarmaLayoutFuncoes, Usu�rio, str_DescricaoFarmaLayouts, int_NroPedidoSite, str_Erro, str_Protocolo, bit_Integrado, str_Arquivo, dte_DataHora FROM Tab_FarmaArquivoFuncoesLayout WITH(NOLOCK) INNER JOIN Tab_Usu�rios WITH(NOLOCK) ON IdUsuario = int_IdUsuario ORDER BY pk_int_Tab_FarmaArquivoFuncoesLayout DESC;

-- Verificar �ltimos bloqueios e erros que ocorreram utilizando o servi�o
SELECT TOP 1000 str_MessagemErro, int_IdMovimento, dte_DataHoraErro, NomeFantasia, Estado FROM Tab_ErroMovimentoAutomatico WITH(NOLOCK) INNER JOIN Tab_Cadastro ON str_Codinome = Codinome ORDER BY pk_int_Tab_ErroMovimentoAutomatico DESC;

-- Verificar Ultimos itens Integrados
SELECT TOP 1000 * FROM Tab_FarmaPedido WITH(NOLOCK) ORDER BY pk_int_Tab_FarmaPedido DESC;
SELECT TOP 1000 * FROM Tab_FarmaPedidoItens WITH(NOLOCK) ORDER BY pk_int_Tab_FarmaPedidoItens DESC;
