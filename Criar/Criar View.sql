/*************************************************************************************
		Descrição: 
			
			
		Chamada por:
            select * from vw_FinanceiroDataPagamento
			
		DataBase: 
		OBS:
			
		 
**************************************************************************************/

if exists (select * from sysobjects where type = 'V' and name = 'vw_FinanceiroDataPagamento')
	begin
		print 'Removendo View vw_FinanceiroDataPagamento'
	    drop view vw_FinanceiroDataPagamento
	end
go

print 'Criando View vw_FinanceiroDataPagamento'

go

Create View vw_FinanceiroDataPagamento   
As
SELECT
  CASE
    WHEN ISNULL(Mov_Financeiro.DataPagamento, '') = '' THEN CONVERT(int, DATEDIFF(DAY, Mov_Financeiro.DataVencimento, GETDATE()))
    ELSE CONVERT(int, DATEDIFF(DAY, Mov_Financeiro.DataVencimento, Mov_Financeiro.DataPagamento))
  END AS atraso,
  Tab_Cadastro.NomeEmpresa AS NomeEmpresa,
  Tab_Contas.Descrição AS Descrição,
  Tab_Empresa.Empresa AS Empresa,
  Mov_Financeiro.*,
  Mov_Financeiro.IdBanco AS IdBanco_Filtro,
  Mov_Financeiro.IdCadastro AS IdCadastro_Filtro,
  Mov_Financeiro.DataEmissão AS DataEmissão_Filtro,
  Mov_Financeiro.IdEmpresa AS IdEmpresa_Filtro,
  Mov_Financeiro.IdCentroAcumulação AS IdCentroAcumulação_Filtro,
  Mov_Financeiro.IdConta AS CódigoConta_Filtro,
  Tab_Contas.IdCentroCusto AS IdCentroCusto_Filtro,
  Mov_Financeiro.DataEmissão AS DataMov_Filtro,
  Mov_Financeiro.IdBancoPortador AS TipoCobrança_Filtro,
  Tab_CadGrupo.IdGrupoCad AS GrupoCad_Filtro,
  Tab_CadSubGrupo.IdSubCadGrupo AS SubGrupoCad_Filtro,
  ((Mov_Financeiro.ValorDocumento - (CASE
    WHEN Mov_Financeiro.ValorDesconto IS NULL THEN 0
    ELSE Mov_Financeiro.ValorDesconto
  END)) + (CASE
    WHEN Mov_Financeiro.ValorJuros IS NULL THEN 0
    ELSE Mov_Financeiro.ValorJuros
  END)) AS ValorVencimento,
  Mov_Financeiro.IdVendedor AS IdFuncionário_Filtro
FROM Mov_Financeiro
LEFT OUTER JOIN Tab_Cadastro
  ON Mov_Financeiro.IdCadastro = Tab_Cadastro.Codinome
LEFT OUTER JOIN Tab_Contas
  ON Mov_Financeiro.IdConta = Tab_Contas.Código
LEFT OUTER JOIN Tab_Empresa
  ON Mov_Financeiro.IdEmpresa = Tab_Empresa.IdEmpresa
LEFT OUTER JOIN Tab_CadGrupo
  ON Tab_Cadastro.IdGrupoCad = Tab_CadGrupo.IdGrupoCad
LEFT OUTER JOIN Tab_CadSubGrupo
  ON Tab_CadGrupo.IdGrupoCad = Tab_CadSubGrupo.IdSubCadGrupo
WHERE (Mov_Financeiro.ContasPagarReceber = 1)

go

    grant select on vw_FinanceiroDataPagamento to public

go


