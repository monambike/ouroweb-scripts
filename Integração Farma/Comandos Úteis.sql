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

  -- Processar Orçamento pelo Serviço do Automático
  DECLARE @IdEmpresa AS INT = <(IdEmpresa) Faturar Venda, INT, 2>
  EXEC usp_mng_GerarPedidoOLs_Resposta_Automatico @IdEmpresa
  EXEC usp_mng_Pedido_GerarArquivoRetorno_Automatico

  -- Gerar a Venda automaticamente
  DECLARE @IdEmpresa AS INT = <(IdEmpresa) Faturar Venda, INT, 2>
  EXEC usp_mng_Faturar_Pedido_Automatico @IdEmpresa


  -- Atualiza data dos movimentos de orçamento, pedido de venda e venda
  -- e as define para hoje
  BEGIN TRAN UPDATE Mov_Estoque SET DataMovimento = GETDATE() WHERE ClassificaçãoMovimento IN(2,13,16) AND IdMovimento = @IdMovimento
                              COMMIT             ROLLBACK                              

**************************************************************************************/

-- CONSULTAS À RESPEITO DE ALGUMAS INFORMAÇÕES ÚTEIS
--------------- + --------------- + --------------- + --------------- + ---------------
-- Últimas ações executadas utilizando o serviço
SELECT TOP 1000 str_DescricaoFarmaLayoutFuncoes, Usuário, str_DescricaoFarmaLayouts, int_NroPedidoSite, str_Erro, str_Protocolo, bit_Integrado, str_Arquivo, dte_DataHora FROM Tab_FarmaArquivoFuncoesLayout WITH(NOLOCK) INNER JOIN Tab_Usuários WITH(NOLOCK) ON IdUsuario = int_IdUsuario ORDER BY pk_int_Tab_FarmaArquivoFuncoesLayout DESC;

-- Verificar últimos bloqueios e erros que ocorreram utilizando o serviço
SELECT TOP 1000 str_MessagemErro, int_IdMovimento, dte_DataHoraErro, NomeFantasia, Estado FROM Tab_ErroMovimentoAutomatico WITH(NOLOCK) INNER JOIN Tab_Cadastro ON str_Codinome = Codinome ORDER BY pk_int_Tab_ErroMovimentoAutomatico DESC;

-- Verificar Ultimos itens Integrados
SELECT TOP 1000 * FROM Tab_FarmaPedido WITH(NOLOCK) ORDER BY pk_int_Tab_FarmaPedido DESC;
SELECT TOP 1000 * FROM Tab_FarmaPedidoItens WITH(NOLOCK) ORDER BY pk_int_Tab_FarmaPedidoItens DESC;
