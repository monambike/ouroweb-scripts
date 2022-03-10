IF NOT EXISTS(SELECT * FROM Tab_RelatoriosGrupo where Descricao = 'Cota��es Eletr�nicas') 
	BEGIN
		INSERT INTO Tab_RelatoriosGrupo (Descricao, bit_Ativo)
		VALUES ('Cota��es Eletr�nicas',1)
	END
GO

DECLARE @IdRelatorioGrupo int

SET @IdRelatorioGrupo = (SELECT IdRelatorioGrupo FROM Tab_RelatoriosGrupo where Descricao = 'Cota��es Eletr�nicas') 
IF NOT EXISTS(SELECT * FROM Permissao_Grupos_Relatorios where IdRelatorioGrupo = @IdRelatorioGrupo)
	BEGIN
		INSERT INTO Permissao_Grupos_Relatorios ( IdGrupo, idRelatorioGrupo)
		VALUES  (1,@IdRelatorioGrupo)
	END
GO

-- SELECT * FROM Permissao_Grupos_Relatorios;


