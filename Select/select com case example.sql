     
		 SELECT
    <campo>,
    case
        when len(<campo>) = 0
            then <faz_uma_a��o>
        else ''
    end +
    case
        when len(<campo>) > 0
            then <faz_uma_a��o>
        else ''
    end +

FROM
    Boleto
    
    
  
  

