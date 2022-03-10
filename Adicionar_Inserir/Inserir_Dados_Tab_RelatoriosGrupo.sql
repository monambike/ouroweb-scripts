IF NOT EXISTS(SELECT * FROM Tab_RelatoriosGrupo where Descricao = 'Cotações Eletrônicas') 
	BEGIN
		INSERT INTO Tab_RelatoriosGrupo (Descricao, bit_Ativo)
		VALUES ('Cotações Eletrônicas',1)
	END
GO

DECLARE @IdRelatorioGrupo int

SET @IdRelatorioGrupo = (SELECT IdRelatorioGrupo FROM Tab_RelatoriosGrupo where Descricao = 'Cotações Eletrônicas') 
IF NOT EXISTS(SELECT * FROM Permissao_Grupos_Relatorios where IdRelatorioGrupo = @IdRelatorioGrupo)
	BEGIN
		INSERT INTO Permissao_Grupos_Relatorios ( IdGrupo, idRelatorioGrupo)
		VALUES  (1,@IdRelatorioGrupo)
	END
GO

-- SELECT * FROM Permissao_Grupos_Relatorios;


