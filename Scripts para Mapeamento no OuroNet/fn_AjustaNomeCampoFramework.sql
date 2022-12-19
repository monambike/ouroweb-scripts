/******************************************************************************
		Descrição: AjustaNomeCampoFramework
*******************************************************************************/

if exists (select * from sysobjects where type = 'FN' and name = 'AjustaNomeCampoFramework')
	begin
		print 'Removendo Function AjustaNomeCampoFramework'
		drop function AjustaNomeCampoFramework
	end
go

print 'Criando Function AjustaNomeCampoFramework'
go

create function AjustaNomeCampoFramework
																			(
																				@campo varchar(8000),
																				@bit_Field bit = 0
																			) returns varchar(8000)
as
begin
	declare @retornar varchar(8000)
	
	set @retornar = dbo.RemoveAcentos(@campo)

	set @retornar = (case substring(@retornar, 1, 4)
										 when 'bit_' then replace(@retornar,'bit_', '')
										 when 'cur_' then replace(@retornar,'cur_', '')
										 when 'dbl_' then replace(@retornar,'dbl_', '')
										 when 'dte_' then replace(@retornar,'dte_', '')
										 when 'int_' then replace(@retornar,'int_', '')
										 when 'str_' then replace(@retornar,'str_', '')
										 when 'img_' then replace(@retornar,'img_', '')
										 else @retornar
									 end)
	
	set @retornar = replace(@retornar,'_', '')
	set @retornar = replace(@retornar,'fkint', 'FkInt')
	set @retornar = replace(@retornar,'pkint', 'PkInt')
	
	if (@bit_Field = 1)
		begin
			set @retornar = '_' + lower(left(@retornar, 1)) + substring(@retornar, 2, len(@retornar))
		end

	return @retornar
end
go