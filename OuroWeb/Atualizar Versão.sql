Declare @str_NomeBase Varchar(200)
Declare @int_Version int
Declare @int_Application int
Declare @str_Version Varchar(30)

Select @str_NomeBase = Db_Name()
Set @str_Version = '<Número da Versão Gerada, , 10.1.7.3>'

Select
  @int_Application = Isnull(c.pk_int_Application,0),
  @int_Version = Isnull(d.pk_int_version,0)
From
  OuroUpdate..[Product] a With(Nolock) 
    Inner Join
  OuroUpdate..[DataBase] b With(Nolock) 
      On a.pk_int_Product = b.fk_int_Product
    Inner Join
  OuroUpdate..[Application] c With(Nolock) 
      On b.pk_int_DataBase = c.fk_int_DataBase
    Left Join
  OuroUpdate..[Version] d With(Nolock) 
      On c.pk_int_Application = d.fk_int_Application
Where
  a.int_ProductNumber = 1 And
  b.str_DataBase = @str_NomeBase And
  c.int_ApplicationNumber = 1
  
If Isnull(@int_Version,0) = 0  And Isnull(@int_Application,0) <> 0  
  Begin
    Insert Into
      OuroUpdate..[Version](
        int_Major,
        int_MajorRevision,
        int_Minor,
        int_MinorRevision,
        bit_Active,
        fk_int_Application,
        dte_Release,
        int_VersionFollow)
      Values(
        cast(parsename(@str_Version, 4) as int),
        cast(parsename(@str_Version, 3) as int),
        cast(parsename(@str_Version, 2) as int),
        cast(parsename(@str_Version, 1) as int),
        1,
        @int_Application,
        getdate(),
        0)        
  End
  
If Isnull(@int_Version,0) <> 0  And Isnull(@int_Application,0) <> 0  
  Begin
    Update
      OuroUpdate..[Version]
    Set
      int_Major = cast(parsename(@str_Version, 4) as int),
      int_MajorRevision = cast(parsename(@str_Version, 3) as int),
      int_Minor = cast(parsename(@str_Version, 2) as int),
      int_MinorRevision = cast(parsename(@str_Version, 1) as int),
      dte_Release = getdate(),
      int_VersionFollow = 0
    Where
      pk_int_Version = @int_Version And
      bit_Active = 1
  End
