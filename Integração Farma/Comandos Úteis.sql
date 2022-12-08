-- Menu Superior > Tabelas > Cadastro > Controle de Integra��es
-- Desativar Config que utiliza Interop Store, e Unilog

-- CONSULTAS � RESPEITO DE ALGUMAS INFORMA��ES �TEIS
--------------- + --------------- + --------------- + --------------- + ---------------
-- (LOG) �ltimas a��es executadas utilizando o servi�o
SELECT TOP 1000 str_DescricaoFarmaLayoutFuncoes, Usu�rio, str_DescricaoFarmaLayouts, int_NroPedidoSite, str_Erro, str_Protocolo, bit_Integrado, str_Arquivo, dte_DataHora FROM Tab_FarmaArquivoFuncoesLayout WITH(NOLOCK) INNER JOIN Tab_Usu�rios WITH(NOLOCK) ON IdUsuario = int_IdUsuario ORDER BY pk_int_Tab_FarmaArquivoFuncoesLayout DESC;

-- (LOG) Verificar �ltimos bloqueios
SELECT TOP 1000 str_MessagemErro, int_IdMovimento, dte_DataHoraErro, NomeFantasia, Estado FROM Tab_ErroMovimentoAutomatico WITH(NOLOCK) INNER JOIN Tab_Cadastro ON str_Codinome = Codinome ORDER BY pk_int_Tab_ErroMovimentoAutomatico DESC;

-- Verificar Ultimos itens Integrados
SELECT TOP 1000 * FROM Tab_FarmaPedido WITH(NOLOCK) ORDER BY pk_int_Tab_FarmaPedido DESC;
SELECT TOP 1000 * FROM Tab_FarmaPedidoItens WITH(NOLOCK) ORDER BY pk_int_Tab_FarmaPedidoItens DESC;

/**************************************************************************************

-- Procurar na Tab_FarmaPedido pelo N�mero Pedido do Site
SELECT TOP 1000 * FROM Tab_FarmaPedido WITH(NOLOCK) WHERE int_NroPedidoSite LIKE '%<(N�meroPedidoSite) Visualizar Por N�mero Pedido Site, INT, >%'

**************************************************************************************/

/**************************************************************************************

-- EXECU��ES DE PROCESSOS DO AUTOM�TICO
--------------- + --------------- + --------------- + --------------- + ---------------

-- Atualiza data dos movimentos de or�amento, pedido de venda e venda de at� um m�s atr�s,
-- e as define para hoje
BEGIN TRAN UPDATE Mov_Estoque SET DataMovimento = GETDATE() WHERE Classifica��oMovimento IN(2,13,16) AND IdMovimento = <(IdMovimento) Atualizar Movimentos, INT, >
                        COMMIT                       ROLLBACK

-- Processar Or�amento automatico
DECLARE @IdEmpresa AS INT = <(IdEmpresa) Faturar Venda, INT, 2>
EXEC usp_mng_GerarPedidoOLs_Resposta_Automatico @IdEmpresa
EXEC usp_mng_Pedido_GerarArquivoRetorno_Automatico

-- Gera a Venda automaticamente
DECLARE @IdEmpresa AS INT = <(IdEmpresa) Faturar Venda, INT, 2>
EXEC usp_mng_Faturar_Pedido_Automatico @IdEmpresa

**************************************************************************************/