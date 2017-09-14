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
      Producer = PageProducer1
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
      MethodType = mtPost
      Name = 'RegistHandler'
      PathInfo = '/regist'
      OnAction = WebModule1RegistHandlerAction
    end>
  Height = 383
  Width = 415
  object dbname: TFDTable
    Active = True
    Connection = PbbsConnection
    UpdateOptions.UpdateTableName = 'dbname'
    TableName = 'dbname'
    Left = 64
    Top = 152
    object dbnameTBNUMBER: TIntegerField
      FieldName = 'TBNUMBER'
      Origin = 'TBNUMBER'
      Required = True
    end
    object dbnameDBNAME: TStringField
      FieldName = 'DBNAME'
      Origin = 'DBNAME'
      Required = True
      Size = 80
    end
  end
  object maintable: TFDTable
    Active = True
    Connection = PbbsConnection
    UpdateOptions.UpdateTableName = 'maintable'
    TableName = 'maintable'
    Left = 136
    Top = 152
    object maintableTBNUMBER: TIntegerField
      FieldName = 'TBNUMBER'
      Origin = 'TBNUMBER'
      Required = True
    end
    object maintableCMNUMBER: TIntegerField
      FieldName = 'CMNUMBER'
      Origin = 'CMNUMBER'
      Required = True
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
    object maintableCOMMENT: TWideMemoField
      FieldName = 'COMMENT'
      Origin = '"COMMENT"'
      BlobType = ftWideMemo
    end
    object maintableDATETIME: TStringField
      FieldName = 'DATETIME'
      Origin = 'DATETIME'
      Size = 30
    end
  end
  object raw: TFDTable
    Connection = PbbsConnection
    UpdateOptions.UpdateTableName = 'raw'
    TableName = 'raw'
    Left = 216
    Top = 152
    object rawCMNUMBER: TIntegerField
      FieldName = 'CMNUMBER'
      Origin = 'CMNUMBER'
      Required = True
    end
    object rawRAW: TWideMemoField
      FieldName = 'RAW'
      Origin = 'RAW'
      BlobType = ftWideMemo
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
      '<p><a href=/user?job=<#cmnumber>>[ <#cmnumber> ]</a>'
      '<a name=<#cmnumber>></a><#title>'
      '<p><#name>|<#datetime>'
      '<p><#com>')
    DataSet = FDQuery1
    OnHTMLTag = mainHTMLTag
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
      'CharacterSet=UTF8'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 62
    Top = 29
  end
  object FDQuery1: TFDQuery
    Connection = PbbsConnection
    SQL.Strings = (
      'select * from maintable where tbnumber = :param;')
    Left = 320
    Top = 64
    ParamData = <
      item
        Name = 'PARAM'
        DataType = ftString
        ParamType = ptInput
        Value = '4'
      end>
  end
end
