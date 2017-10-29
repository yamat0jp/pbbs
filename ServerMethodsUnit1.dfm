object ServerMethods1: TServerMethods1
  OldCreateOrder = False
  Height = 150
  Width = 203
  object FDConnection1: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'Database=DATA.FDB'
      'DriverID=FB')
    Connected = True
    Left = 48
    Top = 32
  end
  object FDTable1: TFDTable
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'DBNAME'
    TableName = 'DBNAME'
    Left = 48
    Top = 88
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select raw.id,raw,title,name,datetime from'
      ' dbname,maintable,raw'
      ' where (tbnumber = :id)and(dbname.id = raw.id)and'
      ' (maintable.id = raw.id);')
    Left = 136
    Top = 32
    ParamData = <
      item
        Name = 'ID'
        DataType = ftString
        ParamType = ptInput
        Value = '1'
      end>
  end
end
