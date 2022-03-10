SELECT * FROM Tab_EstoqueEmpresaLocal WITH(NOLOCK) WHERE IdItem = '478'

SELECT * FROM Tab_EstoqueLotesValidades WITH(NOLOCK) WHERE IdItem = '478'


SELECT QuantidadeUsada, PedidoCompra, QuantidadeBloqueada, QuantidadeFaturada, * FROM Mov_Estoque_Detalhes WITH(NOLOCK) WHERE IdMovimento = 10757 AND IdItem = '478'

SELECT QuantidadeUsada, PedidoCompra, QuantidadeBloqueada, QuantidadeFaturada, * FROM Mov_Estoque_Detalhes WITH(NOLOCK) WHERE IdMovimento = 11159 AND IdItem = '478'


SELECT DataMovimento, NúmeroDocumento, * FROM Mov_Estoque WHERE IdMovimento = 11159

SELECT * FROM Mov_Estoque_LotesValidades WITH(NOLOCK) WHERE fk_int_IdMovimento = 11159 AND str_IdItem = '478'