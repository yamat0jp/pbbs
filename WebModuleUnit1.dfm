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
  object PbbsConnection: TFDConnection
    Params.Strings = (
      'Database=C:\Users\yamat\Documents\GitHub\pbbs\DATA.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'CharacterSet=utf8'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 51
    Top = 32
  end
  object dbname: TFDTable
    Active = True
    IndexFieldNames = 'TBNUMBER'
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
    IndexFieldNames = 'TBNUMBER'
    MasterSource = DataSource1
    MasterFields = 'TBNUMBER'
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
    object maintableCMNUMBER: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'CMNUMBER'
      Origin = 'CMNUMBER'
      Required = True
    end
    object maintableDATETIME: TDateField
      FieldName = 'DATETIME'
      Origin = 'DATETIME'
    end
  end
  object raw: TFDTable
    IndexFieldNames = 'CMNUMBER'
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
      FieldKind = fkCalculated
      FieldName = 'RAW'
      BlobType = ftWideMemo
      Calculated = True
    end
  end
  object PageProducer1: TPageProducer
    OnHTMLTag = PageProducer1HTMLTag
    Left = 184
    Top = 64
  end
  object DataSource1: TDataSource
    DataSet = dbname
    Left = 64
    Top = 104
  end
  object indexpage: TPageProducer
    OnHTMLTag = indexpageHTMLTag
    Left = 264
    Top = 64
  end
  object PageProducer4: TPageProducer
    Left = 272
    Top = 320
  end
  object PageProducer5: TPageProducer
    Left = 352
    Top = 320
  end
  object main: TDataSetPageProducer
    HTMLDoc.Strings = (
      '<p><#number><#title>'
      '<p><#name>|<#datetime>'
      '<p><#comment>')
    Left = 264
    Top = 16
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 120
    Top = 48
  end
end
