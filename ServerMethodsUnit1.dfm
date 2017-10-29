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
end
