object WebModule1: TWebModule1
  OnCreate = WebModuleCreate
  OnDestroy = WebModuleDestroy
  Actions = <
    item
      Name = 'mainItem'
      PathInfo = '/bbs'
      OnAction = WebModule1mainItemAction
    end
    item
      Name = 'alertItem'
      PathInfo = '/alert'
      OnAction = WebModule1WebActionItem2Action
    end
    item
      Default = True
      Name = 'showTop'
      PathInfo = '/top'
      OnAction = WebModule1showTopAction
    end
    item
      Name = 'adminPage'
      PathInfo = '/admin'
      OnAction = WebModule1adminPageAction
    end
    item
      Name = 'searchItem'
      PathInfo = '/search'
      OnAction = WebModule1searchItemAction
    end
    item
      Name = 'helpPage'
      PathInfo = '/help'
      OnAction = WebModule1WebActionItem6Action
    end
    item
      MethodType = mtPost
      Name = 'renameAction'
      PathInfo = '/rename'
      OnAction = WebModule1WebActionItem7Action
    end
    item
      Name = 'master'
      PathInfo = '/master'
      OnAction = WebModule1masterAction
    end
    item
      Name = 'linkItem'
      PathInfo = '/link'
      Producer = PageProducer6
    end
    item
      Name = 'members'
      PathInfo = '/members'
      OnAction = WebModule1membersAction
    end
    item
      Name = 'titlelist'
      PathInfo = '/list'
      OnAction = WebModule1membersAction
    end
    item
      MethodType = mtGet
      Name = 'login'
      PathInfo = '/login'
      Producer = PageProducer9
    end>
  BeforeDispatch = WebModuleBeforeDispatch
  Height = 497
  Width = 614
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\yamat\Documents\GitHub\2023\My BBS\rebbs\data\' +
        'IBDATA.IB'
      'User_Name=sysdba'
      'Password=masterkey'
      'CharacterSet=utF8'
      'OpenMode=OpenOrCreate'
      'DriverID=IB')
    Connected = True
    LoginPrompt = False
    Left = 328
    Top = 24
  end
  object FDTable1: TFDTable
    Active = True
    FilterOptions = [foCaseInsensitive]
    IndexFieldNames = 'ID;DBNUMBER;TITLENUM'
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'NAMETABLE'
    Left = 328
    Top = 104
    object FDTable1ID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      Required = True
    end
    object FDTable1DBNUMBER: TIntegerField
      FieldName = 'DBNUMBER'
      Origin = 'DBNUMBER'
      Required = True
    end
    object FDTable1DBNAME: TWideStringField
      FieldName = 'DBNAME'
      Origin = 'DBNAME'
      Required = True
      Size = 512
    end
    object FDTable1TITLENUM: TIntegerField
      FieldName = 'TITLENUM'
      Origin = 'TITLENUM'
      Required = True
    end
    object FDTable1TITLE: TWideStringField
      FieldName = 'TITLE'
      Origin = 'TITLE'
      Required = True
      Size = 512
    end
  end
  object FDTable2: TFDTable
    Active = True
    Filtered = True
    IndexFieldNames = 'DBNUMBER;TITLENUM;CMNUMBER'
    MasterSource = DataSource1
    MasterFields = 'dbnumber;TITLENUM'
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    UpdateOptions.UpdateTableName = 'maintable'
    TableName = 'maintable'
    Left = 328
    Top = 160
    object FDTable2DBNUMBER: TIntegerField
      FieldName = 'DBNUMBER'
      Origin = 'DBNUMBER'
      Required = True
    end
    object FDTable2CMNUMBER: TIntegerField
      FieldName = 'CMNUMBER'
      Origin = 'CMNUMBER'
      Required = True
    end
    object FDTable2TITLENUM: TIntegerField
      FieldName = 'TITLENUM'
      Origin = 'TITLENUM'
      Required = True
    end
    object FDTable2NAME: TWideStringField
      FieldName = 'NAME'
      Origin = 'NAME'
      Size = 512
    end
    object FDTable2COMMENT: TWideMemoField
      FieldName = 'COMMENT'
      Origin = 'COMMENT'
      BlobType = ftWideMemo
    end
    object FDTable2DATETIME: TDateField
      FieldName = 'DATETIME'
      Origin = 'DATETIME'
      Required = True
    end
    object FDTable2comcnt: TIntegerField
      FieldName = 'comcnt'
    end
  end
  object DataSetPageProducer1: TDataSetPageProducer
    HTMLFile = '.\templates\index.htm'
    DataSet = FDTable1
    OnHTMLTag = DataSetPageProducer1HTMLTag
    Left = 48
    Top = 24
  end
  object PageProducer1: TPageProducer
    HTMLFile = '.\templates\top.htm'
    OnHTMLTag = PageProducer1HTMLTag
    Left = 48
    Top = 152
  end
  object DataSetPageProducer2: TDataSetPageProducer
    HTMLFile = '.\templates\main.htm'
    DataSet = FDTable2
    OnHTMLTag = DataSetPageProducer2HTMLTag
    Left = 48
    Top = 88
  end
  object DataSetTableProducer1: TDataSetTableProducer
    Columns = <
      item
        BgColor = 'White'
        Title.Custom = 'width=5%'
        Title.BgColor = 'Aqua'
        Title.Caption = 'CHECK'
      end
      item
        FieldName = 'CMNUMBER'
        Title.Custom = 'width=5%'
        Title.BgColor = 'Aqua'
        Title.Caption = 'NUMBER'
      end
      item
        FieldName = 'TITLE'
        Title.BgColor = 'Aqua'
      end
      item
        FieldName = 'name'
        Title.BgColor = 'Aqua'
      end
      item
        BgColor = 'White'
        Title.Custom = 'width=5%'
        Title.BgColor = 'Aqua'
        Title.Caption = 'LINK'
      end>
    MaxRows = 0
    DataSet = FDTable2
    TableAttributes.BgColor = 'White'
    OnFormatCell = DataSetTableProducer1FormatCell
    Left = 328
    Top = 216
  end
  object PageProducer2: TPageProducer
    HTMLFile = '.\templates\admin.htm'
    OnHTMLTag = PageProducer2HTMLTag
    Left = 160
    Top = 160
  end
  object DataSetPageProducer3: TDataSetPageProducer
    HTMLFile = '.\templates\alert.htm'
    DataSet = FDTable1
    OnHTMLTag = DataSetPageProducer3HTMLTag
    Left = 48
    Top = 264
  end
  object PageProducer3: TPageProducer
    HTMLFile = '.\templates\search.htm'
    OnHTMLTag = PageProducer3HTMLTag
    Left = 248
    Top = 104
  end
  object PageProducer4: TPageProducer
    HTMLFile = '.\templates\mentenance.htm'
    Left = 248
    Top = 160
  end
  object PageProducer5: TPageProducer
    HTMLFile = '.\templates\help.htm'
    OnHTMLTag = PageProducer5HTMLTag
    Left = 248
    Top = 264
  end
  object DataSetPageProducer4: TDataSetPageProducer
    HTMLFile = '.\templates\form.htm'
    DataSet = FDTable1
    Left = 160
    Top = 232
  end
  object WebFileDispatcher1: TWebFileDispatcher
    WebFileExtensions = <
      item
        MimeType = 'text/css'
        Extensions = 'css'
      end
      item
        MimeType = 'text/html'
        Extensions = 'html;htm'
      end
      item
        MimeType = 'application/javascript'
        Extensions = 'js'
      end
      item
        MimeType = 'image/jpeg'
        Extensions = 'jpeg;jpg'
      end
      item
        MimeType = 'image/png'
        Extensions = 'png'
      end
      item
        MimeType = 'image/x-icon'
        Extensions = 'ico'
      end>
    WebDirectories = <
      item
        DirectoryAction = dirInclude
        DirectoryMask = '*'
      end
      item
        DirectoryAction = dirExclude
        DirectoryMask = '\data\*'
      end
      item
        DirectoryAction = dirExclude
        DirectoryMask = '\templates\*'
      end>
    RootDirectory = '.'
    VirtualPath = '/'
    Left = 152
    Top = 24
  end
  object PageProducer7: TPageProducer
    HTMLFile = '.\templates\algo.htm'
    OnHTMLTag = PageProducer7HTMLTag
    Left = 48
    Top = 208
  end
  object DataSource1: TDataSource
    DataSet = FDTable1
    Left = 248
    Top = 24
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'CREATE TABLE NAMETABLE '
      '('
      '        ID'#9'INTEGER NOT NULL,'
      '        DBNUMBER'#9'INTEGER NOT NULL,'
      '        DBNAME'#9'VARCHAR(128) NOT NULL,'
      '        TITLENUM'#9'INTEGER NOT NULL,'
      '        TITLE'#9'VARCHAR(128) NOT NULL,'
      ' PRIMARY KEY (ID)'
      ');'
      'CREATE TABLE MAINTABLE '
      '('
      '        DBNUMBER'#9'INTEGER NOT NULL,'
      '        CMNUMBER'#9'INTEGER NOT NULL,'
      '        TITLENUM'#9'INTEGER NOT NULL,'
      '        NAME    VARCHAR(128),'
      '        COMMENT'#9'BLOB SUB_TYPE TEXT SEGMENT SIZE 80,'
      '        DATETIME'#9'DATE NOT NULL,'
      '        COMCNT'#9'INTEGER'
      ');')
    Left = 48
    Top = 320
  end
  object FDQuery2: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'create table adlist(id integer not null, rank integer not null, '
      '  adtext varchar(255) not null, company varchar(255) not null, '
      '  enabled boolean not null, primary key (id));')
    Left = 120
    Top = 320
  end
  object PageProducer6: TPageProducer
    HTMLFile = '.\templates\link.htm'
    OnHTMLTag = PageProducer6HTMLTag
    Left = 160
    Top = 104
  end
  object DataSetTableProducer2: TDataSetTableProducer
    Columns = <
      item
        FieldName = 'adtext'
      end>
    DataSet = FDMemTable1
    TableAttributes.Align = haCenter
    TableAttributes.Border = 1
    TableAttributes.Width = 50
    OnCreateContent = DataSetTableProducer2CreateContent
    Left = 224
    Top = 320
  end
  object PageProducer8: TPageProducer
    HTMLFile = '.\templates\master.htm'
    OnHTMLTag = PageProducer8HTMLTag
    Left = 336
    Top = 320
  end
  object FDMemTable1: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    IndexFieldNames = 'rank'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 432
    Top = 296
    object FDMemTable1id: TIntegerField
      FieldName = 'id'
    end
    object FDMemTable1rank: TIntegerField
      FieldName = 'rank'
    end
    object FDMemTable1adtext: TWideStringField
      FieldName = 'adtext'
      Size = 350
    end
    object FDMemTable1company: TWideStringField
      FieldName = 'company'
      Size = 8
    end
    object FDMemTable1enabled: TBooleanField
      FieldName = 'enabled'
    end
  end
  object DataSetPageProducer5: TDataSetPageProducer
    HTMLFile = '.\templates\members.htm'
    DataSet = FDTable1
    Left = 432
    Top = 352
  end
  object PageProducer9: TPageProducer
    HTMLFile = '.\templates\login.htm'
    OnHTMLTag = PageProducer9HTMLTag
    Left = 168
    Top = 384
  end
  object DataSetPageProducer6: TDataSetPageProducer
    HTMLFile = '.\templates\tables.htm'
    DataSet = FDTable1
    OnHTMLTag = DataSetPageProducer6HTMLTag
    Left = 432
    Top = 96
  end
  object OAuth2Authenticator1: TOAuth2Authenticator
    ClientID = 'nGSunByAX9RUHrCpJJNfTOViG7f1wGdx'
    Left = 432
    Top = 168
  end
end
