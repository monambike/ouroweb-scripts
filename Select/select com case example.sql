     
		 SELECT
    <campo>,
    case
        when len(<campo>) = 0
            then <faz_uma_ação>
        else ''
    end +
    case
        when len(<campo>) > 0
            then <faz_uma_ação>
        else ''
    end +

FROM
    Boleto
    
    
  
  

