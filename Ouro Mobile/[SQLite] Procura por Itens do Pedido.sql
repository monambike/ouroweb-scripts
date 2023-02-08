/**************************************************************************************

  Pressione "[F5]" para usar o Script abaixo.

  ===================================================================================
   Pequena Descrição do Script
  ===================================================================================

  Esse Script serve como auxílio na procura por itens de pedidos para o aplicativo
  Ouro Mobile.


  ===================================================================================
   Aviso
  ===================================================================================

  Esse Script só pode ser usado em consultas para o SQLite, no qual é pautado o banco
  de dados que é contruído pelo aplicativo Ouro Mobile.

**************************************************************************************/

SELECT
  [PedidoItens].[int_Qtde]                                       AS "Qtde"
, CAST([ProdutoValor].[dbl_Saldo] AS INT)                        AS "Saldo"
, [PedidoItens].[str_Unidade]                                    AS "UN"
, [PedidoItens].[dbl_VlrUnitario]                                AS "Valor Unit."
, [PedidoItens].[dbl_VlrDesconto]                                AS "Valor Desc."
, [PedidoItens].[dbl_PercDesconto]                               AS "% Desc"
, PRINTF("%.2f", [PedidoItens].[dbl_Rentabilidade] * 100) || '%' AS "%Rent"
, [PedidoItens].[dbl_ValorST]                                    AS "Valor ST"
, [PedidoItens].[dbl_VlrUnitario]                                AS "Valor Total"
FROM
  [Pedido]
  INNER JOIN
  [PedidoItens] ON  [PedidoItens].[fk_int_Pedido]    = [Pedido].[pk_int_Pedido]
  INNER JOIN
  [ProdutoValor] ON [ProdutoValor].[fk_int_Produto]  = [PedidoItens].[fk_int_Produto]
WHERE
  1=1
  --AND [Pedido].[int_NumeroOrcamento] = @ID
