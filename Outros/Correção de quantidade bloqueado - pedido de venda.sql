SELECT QuantidadeUsada, PedidoCompra, QuantidadeBloqueada, QuantidadeFaturada, PendenteLiberado, * FROM Mov_Estoque_Detalhes WITH(NOLOCK) WHERE IdMovimento = 11159 AND IdItem = '478'

SELECT cur_Quantidade, cur_QuantidadeBloqueada, cur_QuantidadeFaturada, bit_LoteLiberado, * FROM Mov_Estoque_LotesValidades WITH(NOLOCK) WHERE fk_int_IdMovimento = 11159 AND str_IdItem = '478'

UPDATE Mov_Estoque_LotesValidades SET cur_QuantidadeBloqueada = 0, cur_Quantidade = 1060 WHERE pk_int_Mov_Estoque_LotesValidades = 288696

----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT QuantidadeUsada, PedidoCompra, QuantidadeBloqueada, QuantidadeFaturada, PendenteLiberado, * FROM Mov_Estoque_Detalhes WITH(NOLOCK) WHERE IdMovimento = 5685 AND IdItem = '1534'

SELECT cur_Quantidade, cur_QuantidadeBloqueada, cur_QuantidadeFaturada, bit_LoteLiberado, * FROM Mov_Estoque_LotesValidades WITH(NOLOCK) WHERE fk_int_IdMovimento = 5685 AND str_IdItem = '1534'

UPDATE Mov_Estoque_LotesValidades SET cur_QuantidadeBloqueada = 0, cur_Quantidade = 2880 WHERE pk_int_Mov_Estoque_LotesValidades = 242962

----------------------------------------------------------------------------------------------------------------------------------------------------------------