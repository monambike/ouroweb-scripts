SELECT
  a.IdEmpresa,
  a.Empresa,
  b.IdLocal,
  b.DescriçãoLocal,
  a.IdLocalEstoquePadrão,
  a.Estado,
  c.Cidade,
  a.País,
  a.Endereço,
  a.Bairro,
  a.str_complemento
FROM
  Tab_Empresa AS a
    INNER JOIN
  Tab_LocaisEstoque AS b
      ON a.IdEmpresa = b.IDEmpresa
    INNER JOIN
  Tab_Cidades AS c
      ON a.IdCidade = c.IdCidade
ORDER BY a.IdEmpresa, b.IdLocal