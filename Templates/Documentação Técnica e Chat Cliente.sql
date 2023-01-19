DECLARE @Text AS VARCHAR(MAX) = ''

DECLARE @App TABLE ([Name] VARCHAR(MAX) NOT NULL UNIQUE, [Path] VARCHAR(MAX) NOT NULL)
INSERT INTO @App
VALUES
('OuroWeb', '\\vm-srvfile01\produtos\erp\medicamento\fontes\versão '+ '[version]' +'\scripts\sub versão\' + '[version]' + '.' + '[subversion]' + '')


DECLARE @Type TABLE ([Name] VARCHAR(MAX) NOT NULL UNIQUE, [Message] VARCHAR(MAX) NOT NULL)
INSERT INTO @Type
VALUES
 ('Scripts',           'Rodar os Scripts')
,('Pacote de Scripts', 'Rodar o pacote de Scripts')
,('MDE',               'Atualizar o MDE presente na sua máquina')
,('Setups',            'Atualizar os Setups presentes na sua máquina')

,('Arquivo Compactado',            'Pegar o arquivo compactado')
DECLARE @TypeValue AS VARCHAR(MAX) = ''
SET @TypeValue = @TypeValue + ' pelo presente em:'
