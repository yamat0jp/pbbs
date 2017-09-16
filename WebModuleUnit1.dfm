object WebModule1: TWebModule1
  OldCreateOrder = False
  OnCreate = WebModuleCreate
  OnDestroy = WebModuleDestroy
  Actions = <
    item
      Default = True
      MethodType = mtGet
      Name = 'NavHandler'
      PathInfo = '/'
      OnAction = WebModule1NavHandlerAction
    end
    item
      Name = 'UserHandler'
      PathInfo = '/user'
      OnAction = WebModule1UserHandlerAction
    end
    item
      Name = 'AdminHandler'
      PathInfo = '/admin'
      OnAction = WebModule1AdminHandlerAction
    end
    item
      Name = 'RegistHandler'
      PathInfo = '/regist'
      OnAction = WebModule1RegistHandlerAction
    end>
  Height = 383
  Width = 415
  object dbname: TFDTable
    IndexFieldNames = 'ID'
    Connection = PbbsConnection
    UpdateOptions.UpdateTableName = 'dbname'
    TableName = 'dbname'
    Left = 64
    Top = 152
    object dbnameID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
    end
    object dbnameTBNUMBER: TIntegerField
      FieldName = 'TBNUMBER'
      Origin = 'TBNUMBER'
    end
    object dbnameDBNAME: TStringField
      FieldName = 'DBNAME'
      Origin = 'DBNAME'
      Size = 30
    end
  end
  object maintable: TFDTable
    IndexFieldNames = 'ID'
    Connection = PbbsConnection
    UpdateOptions.UpdateTableName = 'maintable'
    TableName = 'maintable'
    Left = 136
    Top = 152
    object maintableID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
    end
    object maintableTBNUMBER: TIntegerField
      FieldName = 'TBNUMBER'
      Origin = 'TBNUMBER'
    end
    object maintableCMNUMBER: TIntegerField
      FieldName = 'CMNUMBER'
      Origin = 'CMNUMBER'
    end
    object maintableTITLE: TStringField
      FieldName = 'TITLE'
      Origin = 'TITLE'
      Size = 80
    end
    object maintableNAME: TStringField
      FieldName = 'NAME'
      Origin = 'NAME'
      Size = 30
    end
    object maintableCOMMENT: TStringField
      FieldName = 'COMMENT'
      Origin = '"COMMENT"'
      Size = 32765
    end
    object maintableDATETIME: TStringField
      FieldName = 'DATETIME'
      Origin = 'DATETIME'
      Size = 30
    end
  end
  object raw: TFDTable
    IndexFieldNames = 'ID'
    Connection = PbbsConnection
    UpdateOptions.UpdateTableName = 'RAWTABLE'
    TableName = 'RAWTABLE'
    Left = 216
    Top = 152
    object rawID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
    end
    object rawTBNUMBER: TIntegerField
      FieldName = 'TBNUMBER'
      Origin = 'TBNUMBER'
    end
    object rawCMNUMBER: TIntegerField
      FieldName = 'CMNUMBER'
      Origin = 'CMNUMBER'
    end
    object rawRAW: TStringField
      FieldName = 'RAW'
      Origin = 'RAW'
      Size = 32765
    end
    object rawPASSWORD: TStringField
      FieldName = 'PASSWORD'
      Origin = '"PASSWORD"'
      Size = 8
    end
  end
  object PageProducer1: TPageProducer
    OnHTMLTag = PageProducer1HTMLTag
    Left = 184
    Top = 64
  end
  object indexpage: TPageProducer
    OnHTMLTag = indexpageHTMLTag
    Left = 264
    Top = 64
  end
  object top: TPageProducer
    HTMLDoc.Strings = (
      '<#img><#full></div>')
    Left = 312
    Top = 16
  end
  object PageProducer5: TPageProducer
    Left = 352
    Top = 320
  end
  object main: TDataSetPageProducer
    HTMLDoc.Strings = (
      
        '<p><a href=/user?db=<#tbnumber>&job=<#cmnumber>>[ <#cmnumber> ]<' +
        '/a>'
      '<a name=<#cmnumber>></a><#title>'
      '<p><#name>|<#datetime>'
      '<p><#comment>')
    DataSet = FDQuery1
    Left = 264
    Top = 16
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 120
    Top = 48
  end
  object PbbsConnection: TFDConnection
    Params.Strings = (
      'Database=C:\Users\yamat\Documents\GitHub\pbbs\DATA.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=FB')
    LoginPrompt = False
    Left = 62
    Top = 29
  end
  object FDQuery1: TFDQuery
    Connection = PbbsConnection
    SQL.Strings = (
      'select * from maintable where tbnumber = :param;')
    Left = 320
    Top = 72
    ParamData = <
      item
        Name = 'PARAM'
        ParamType = ptInput
      end>
  end
  object full: TFDQuery
    Connection = PbbsConnection
    SQL.Strings = (
      'select count(*) from maintable where tbnumber = :param;')
    Left = 280
    Top = 152
    ParamData = <
      item
        Name = 'PARAM'
        DataType = ftString
        ParamType = ptInput
        Value = '1'
      end>
  end
end
