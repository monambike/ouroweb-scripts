/**************************************************************************************

  Pressione "[F5]" para usar o Script abaixo.

  ===================================================================================
   Pequena Descrição do Script
  ===================================================================================

  Esse Script serve como auxílio na procura por pedidos para o aplicativo Ouro
  Mobile.


  ===================================================================================
   Aviso
  ===================================================================================

  Esse Script só pode ser usado em consultas para o SQLite, no qual é pautado o banco
  de dados do Ouro Mobile..

**************************************************************************************/

SELECT
  [Pedido].[int_NumeroOrcamento]               AS "Nº Doc"
, SUBSTR([Pedido].[int_Data], 7, 2) || '/' || SUBSTR([Pedido].[int_Data], 5, 2) || '/' || SUBSTR([Pedido].[int_Data], 1, 4) AS "Data"
, SUBSTR([Pedido].[int_Data], 9, 2) || ':' || SUBSTR([Pedido].[int_Data], 11, 2) AS "Hora"
, [Cliente].[str_NomeEmpresa]                  AS "Cliente"
, [Pedido].[dbl_TotalPedido]                   AS "Total Doc. (Total do Pedido)"
, [Pedido].[dbl_Rentabilidade]                 AS "Rentabilidade"
, [Pedido].[int_PedidoStatus] || ' - ' || CASE [Pedido].[int_PedidoStatus]
                                            WHEN 1 THEN 'Enviado' 
                                            WHEN 2 THEN 'Envio Pendente'
                                            WHEN 3 THEN 'Cancelado'
                                            WHEN 4 THEN 'Erro'
                                            WHEN 5 THEN 'Atendido Pracialmente'
                                            WHEN 6 THEN 'Atendido'
                                            WHEN 7 THEN 'Recusado'
                                            ELSE NULL
                                          END  AS "Status do Pedido"
, [Pedido].[dbl_TotalItens]                    AS "Total dos Itens"
, [Pedido].[pk_int_Pedido]                     AS "PK (Pedido)"
, [Pedido].[int_IdPedido]                      AS "ID (Pedido)"
, [Pedido].[int_IdEmpresa]                     AS "ID (Empresa)"
, [Pedido].[str_IdFuncionario]                 AS "ID (Funcionário)"
, [Pedido].[fk_int_Cliente]                    AS "FK (Cliente)"
, [Cliente].[int_cliente]                      AS "ID (Cliente)"
, [TipoFaturamento].[int_Codigo]               AS "Tipo de Faturamento"
, [Pedido].[str_Observacao]                    AS "Observação"
, [Pedido].[str_MensagemDocumento]             AS "Mensagem do Documento"
, [Pedido].[dbl_Desconto]                      AS "Desconto"
, [Pedido].[int_DataAtualizacao]               AS "DataAtualizacao"
, [Pedido].[dbl_ValorST]                       AS "Valor da ST"
, [Cliente].[int_CobrarSubstTributariaCliente] AS "Cobrar ST do Cliente"
FROM
  [Pedido]
  INNER JOIN
  [Cliente]         ON [Cliente].[pk_int_Cliente]                 = [Pedido].[fk_int_Cliente]
  LEFT JOIN
  [TipoFaturamento] ON [TipoFaturamento].[pk_int_TipoFaturamento] = [Pedido].[fk_int_TipoFaturamento]
WHERE
  ([Pedido].[int_PedidoStatus]  = 2  /* Envio Pendente */ OR [Pedido].[int_PedidoStatus]  = 4 /*Erro*/)
  AND [Pedido].[str_IdFuncionario] = 'sis'
  AND [Pedido].[int_IdEmpresa]     = 1
ORDER BY
  [Nº Doc] DESC
