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
      OnAction = WebModule1alertAction
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
      OnAction = WebModule1helpAction
    end
    item
      MethodType = mtPost
      Name = 'renameAction'
      PathInfo = '/rename'
      OnAction = WebModule1renameAction
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
  Height = 506
  Width = 546
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
    object FDTable2COMCNT: TIntegerField
      FieldName = 'COMCNT'
      Origin = 'COMCNT'
    end
  end
  object index: TDataSetPageProducer
    HTMLFile = '.\templates\index.htm'
    DataSet = FDTable1
    OnHTMLTag = indexHTMLTag
    Left = 184
    Top = 176
  end
  object top: TPageProducer
    HTMLFile = '.\templates\top.htm'
    OnHTMLTag = topHTMLTag
    Left = 32
    Top = 152
  end
  object mainLoop: TDataSetPageProducer
    HTMLFile = '.\templates\main.htm'
    DataSet = FDTable2
    OnHTMLTag = mainLoopHTMLTag
    Left = 192
    Top = 232
  end
  object adminTable: TDataSetTableProducer
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
        FieldName = 'NAME'
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
    TableAttributes.Align = haCenter
    TableAttributes.BgColor = 'White'
    TableAttributes.CellSpacing = 10
    TableAttributes.Width = 85
    OnFormatCell = adminTableFormatCell
    Left = 248
    Top = 296
  end
  object admin: TPageProducer
    HTMLFile = '.\templates\admin.htm'
    OnHTMLTag = adminHTMLTag
    Left = 176
    Top = 296
  end
  object alertContent: TDataSetPageProducer
    HTMLFile = '.\templates\alert.htm'
    DataSet = FDTable1
    OnHTMLTag = alertContentHTMLTag
    Left = 120
    Top = 232
  end
  object search: TPageProducer
    HTMLFile = '.\templates\search.htm'
    OnHTMLTag = searchHTMLTag
    Left = 48
    Top = 80
  end
  object mentenance: TPageProducer
    HTMLFile = '.\templates\mentenance.htm'
    Left = 48
    Top = 16
  end
  object help: TPageProducer
    HTMLFile = '.\templates\help.htm'
    OnHTMLTag = helpHTMLTag
    Left = 248
    Top = 176
  end
  object formDesign: TDataSetPageProducer
    HTMLFile = '.\templates\form.htm'
    DataSet = FDTable1
    OnHTMLTag = formDesignHTMLTag
    Left = 128
    Top = 176
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
  object topJQuery: TPageProducer
    HTMLFile = '.\templates\algo.htm'
    OnHTMLTag = topJQueryHTMLTag
    Left = 32
    Top = 208
  end
  object DataSource1: TDataSource
    DataSet = FDTable1
    Left = 328
    Top = 232
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
  object adTable: TDataSetTableProducer
    Columns = <
      item
        FieldName = 'adtext'
      end>
    DataSet = FDMemTable1
    TableAttributes.Align = haCenter
    TableAttributes.Border = 1
    TableAttributes.Width = 50
    OnCreateContent = adTableCreateContent
    Left = 248
    Top = 368
  end
  object master: TPageProducer
    HTMLFile = '.\templates\master.htm'
    OnHTMLTag = masterHTMLTag
    Left = 248
    Top = 104
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
    Left = 440
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
  object members: TDataSetPageProducer
    HTMLFile = '.\templates\members.htm'
    DataSet = FDTable1
    Left = 392
    Top = 384
  end
  object PageProducer9: TPageProducer
    HTMLFile = '.\templates\login.htm'
    OnHTMLTag = PageProducer9HTMLTag
    Left = 168
    Top = 384
  end
  object titleList: TDataSetPageProducer
    HTMLFile = '.\templates\tables.htm'
    DataSet = FDTable1
    OnHTMLTag = titleListHTMLTag
    Left = 312
    Top = 384
  end
  object RESTClient1: TRESTClient
    Authenticator = OAuth2Authenticator1
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'https://dev-8o2u4gngdq53tql7.jp.auth0.com/authorize'
    Params = <>
    SynchronizedEvents = False
    Left = 440
    Top = 128
  end
  object RESTRequest1: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient1
    Params = <
      item
        Name = 'authorization'
        Options = [poDoNotEncode]
        Value = 
          'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IjFkMW5HNXYzMGMwTXd2' +
          'UW85YXllViJ9.eyJpc3MiOiJodHRwczovL2Rldi04bzJ1NGduZ2RxNTN0cWw3Lmp' +
          'wLmF1dGgwLmNvbS8iLCJzdWIiOiIwWU9LNXN6eU5DMzZnT0FpSGhOSlowdjBWbnB' +
          'WTFdTVkBjbGllbnRzIiwiYXVkIjoiaHR0cHM6Ly9kZXYtOG8ydTRnbmdkcTUzdHF' +
          'sNy5qcC5hdXRoMC5jb20vYXBpL3YyLyIsImlhdCI6MTcxMjMxMzIxNCwiZXhwIjo' +
          'xNzEyMzk5NjE0LCJzY29wZSI6InJlYWQ6Y2xpZW50X2dyYW50cyBjcmVhdGU6Y2x' +
          'pZW50X2dyYW50cyBkZWxldGU6Y2xpZW50X2dyYW50cyB1cGRhdGU6Y2xpZW50X2d' +
          'yYW50cyByZWFkOnVzZXJzIHVwZGF0ZTp1c2VycyBkZWxldGU6dXNlcnMgY3JlYXR' +
          'lOnVzZXJzIHJlYWQ6dXNlcnNfYXBwX21ldGFkYXRhIHVwZGF0ZTp1c2Vyc19hcHB' +
          'fbWV0YWRhdGEgZGVsZXRlOnVzZXJzX2FwcF9tZXRhZGF0YSBjcmVhdGU6dXNlcnN' +
          'fYXBwX21ldGFkYXRhIHJlYWQ6dXNlcl9jdXN0b21fYmxvY2tzIGNyZWF0ZTp1c2V' +
          'yX2N1c3RvbV9ibG9ja3MgZGVsZXRlOnVzZXJfY3VzdG9tX2Jsb2NrcyBjcmVhdGU' +
          '6dXNlcl90aWNrZXRzIHJlYWQ6Y2xpZW50cyB1cGRhdGU6Y2xpZW50cyBkZWxldGU' +
          '6Y2xpZW50cyBjcmVhdGU6Y2xpZW50cyByZWFkOmNsaWVudF9rZXlzIHVwZGF0ZTp' +
          'jbGllbnRfa2V5cyBkZWxldGU6Y2xpZW50X2tleXMgY3JlYXRlOmNsaWVudF9rZXl' +
          'zIHJlYWQ6Y29ubmVjdGlvbnMgdXBkYXRlOmNvbm5lY3Rpb25zIGRlbGV0ZTpjb25' +
          'uZWN0aW9ucyBjcmVhdGU6Y29ubmVjdGlvbnMgcmVhZDpyZXNvdXJjZV9zZXJ2ZXJ' +
          'zIHVwZGF0ZTpyZXNvdXJjZV9zZXJ2ZXJzIGRlbGV0ZTpyZXNvdXJjZV9zZXJ2ZXJ' +
          'zIGNyZWF0ZTpyZXNvdXJjZV9zZXJ2ZXJzIHJlYWQ6ZGV2aWNlX2NyZWRlbnRpYWx' +
          'zIHVwZGF0ZTpkZXZpY2VfY3JlZGVudGlhbHMgZGVsZXRlOmRldmljZV9jcmVkZW5' +
          '0aWFscyBjcmVhdGU6ZGV2aWNlX2NyZWRlbnRpYWxzIHJlYWQ6cnVsZXMgdXBkYXR' +
          'lOnJ1bGVzIGRlbGV0ZTpydWxlcyBjcmVhdGU6cnVsZXMgcmVhZDpydWxlc19jb25' +
          'maWdzIHVwZGF0ZTpydWxlc19jb25maWdzIGRlbGV0ZTpydWxlc19jb25maWdzIHJ' +
          'lYWQ6aG9va3MgdXBkYXRlOmhvb2tzIGRlbGV0ZTpob29rcyBjcmVhdGU6aG9va3M' +
          'gcmVhZDphY3Rpb25zIHVwZGF0ZTphY3Rpb25zIGRlbGV0ZTphY3Rpb25zIGNyZWF' +
          '0ZTphY3Rpb25zIHJlYWQ6ZW1haWxfcHJvdmlkZXIgdXBkYXRlOmVtYWlsX3Byb3Z' +
          'pZGVyIGRlbGV0ZTplbWFpbF9wcm92aWRlciBjcmVhdGU6ZW1haWxfcHJvdmlkZXI' +
          'gYmxhY2tsaXN0OnRva2VucyByZWFkOnN0YXRzIHJlYWQ6aW5zaWdodHMgcmVhZDp' +
          '0ZW5hbnRfc2V0dGluZ3MgdXBkYXRlOnRlbmFudF9zZXR0aW5ncyByZWFkOmxvZ3M' +
          'gcmVhZDpsb2dzX3VzZXJzIHJlYWQ6c2hpZWxkcyBjcmVhdGU6c2hpZWxkcyB1cGR' +
          'hdGU6c2hpZWxkcyBkZWxldGU6c2hpZWxkcyByZWFkOmFub21hbHlfYmxvY2tzIGR' +
          'lbGV0ZTphbm9tYWx5X2Jsb2NrcyB1cGRhdGU6dHJpZ2dlcnMgcmVhZDp0cmlnZ2V' +
          'ycyByZWFkOmdyYW50cyBkZWxldGU6Z3JhbnRzIHJlYWQ6Z3VhcmRpYW5fZmFjdG9' +
          'ycyB1cGRhdGU6Z3VhcmRpYW5fZmFjdG9ycyByZWFkOmd1YXJkaWFuX2Vucm9sbG1' +
          'lbnRzIGRlbGV0ZTpndWFyZGlhbl9lbnJvbGxtZW50cyBjcmVhdGU6Z3VhcmRpYW5' +
          'fZW5yb2xsbWVudF90aWNrZXRzIHJlYWQ6dXNlcl9pZHBfdG9rZW5zIGNyZWF0ZTp' +
          'wYXNzd29yZHNfY2hlY2tpbmdfam9iIGRlbGV0ZTpwYXNzd29yZHNfY2hlY2tpbmd' +
          'fam9iIHJlYWQ6Y3VzdG9tX2RvbWFpbnMgZGVsZXRlOmN1c3RvbV9kb21haW5zIGN' +
          'yZWF0ZTpjdXN0b21fZG9tYWlucyB1cGRhdGU6Y3VzdG9tX2RvbWFpbnMgcmVhZDp' +
          'lbWFpbF90ZW1wbGF0ZXMgY3JlYXRlOmVtYWlsX3RlbXBsYXRlcyB1cGRhdGU6ZW1' +
          'haWxfdGVtcGxhdGVzIHJlYWQ6bWZhX3BvbGljaWVzIHVwZGF0ZTptZmFfcG9saWN' +
          'pZXMgcmVhZDpyb2xlcyBjcmVhdGU6cm9sZXMgZGVsZXRlOnJvbGVzIHVwZGF0ZTp' +
          'yb2xlcyByZWFkOnByb21wdHMgdXBkYXRlOnByb21wdHMgcmVhZDpicmFuZGluZyB' +
          '1cGRhdGU6YnJhbmRpbmcgZGVsZXRlOmJyYW5kaW5nIHJlYWQ6bG9nX3N0cmVhbXM' +
          'gY3JlYXRlOmxvZ19zdHJlYW1zIGRlbGV0ZTpsb2dfc3RyZWFtcyB1cGRhdGU6bG9' +
          'nX3N0cmVhbXMgY3JlYXRlOnNpZ25pbmdfa2V5cyByZWFkOnNpZ25pbmdfa2V5cyB' +
          '1cGRhdGU6c2lnbmluZ19rZXlzIHJlYWQ6bGltaXRzIHVwZGF0ZTpsaW1pdHMgY3J' +
          'lYXRlOnJvbGVfbWVtYmVycyByZWFkOnJvbGVfbWVtYmVycyBkZWxldGU6cm9sZV9' +
          'tZW1iZXJzIHJlYWQ6ZW50aXRsZW1lbnRzIHJlYWQ6YXR0YWNrX3Byb3RlY3Rpb24' +
          'gdXBkYXRlOmF0dGFja19wcm90ZWN0aW9uIHJlYWQ6b3JnYW5pemF0aW9uc19zdW1' +
          'tYXJ5IGNyZWF0ZTphdXRoZW50aWNhdGlvbl9tZXRob2RzIHJlYWQ6YXV0aGVudGl' +
          'jYXRpb25fbWV0aG9kcyB1cGRhdGU6YXV0aGVudGljYXRpb25fbWV0aG9kcyBkZWx' +
          'ldGU6YXV0aGVudGljYXRpb25fbWV0aG9kcyByZWFkOm9yZ2FuaXphdGlvbnMgdXB' +
          'kYXRlOm9yZ2FuaXphdGlvbnMgY3JlYXRlOm9yZ2FuaXphdGlvbnMgZGVsZXRlOm9' +
          'yZ2FuaXphdGlvbnMgY3JlYXRlOm9yZ2FuaXphdGlvbl9tZW1iZXJzIHJlYWQ6b3J' +
          'nYW5pemF0aW9uX21lbWJlcnMgZGVsZXRlOm9yZ2FuaXphdGlvbl9tZW1iZXJzIGN' +
          'yZWF0ZTpvcmdhbml6YXRpb25fY29ubmVjdGlvbnMgcmVhZDpvcmdhbml6YXRpb25' +
          'fY29ubmVjdGlvbnMgdXBkYXRlOm9yZ2FuaXphdGlvbl9jb25uZWN0aW9ucyBkZWx' +
          'ldGU6b3JnYW5pemF0aW9uX2Nvbm5lY3Rpb25zIGNyZWF0ZTpvcmdhbml6YXRpb25' +
          'fbWVtYmVyX3JvbGVzIHJlYWQ6b3JnYW5pemF0aW9uX21lbWJlcl9yb2xlcyBkZWx' +
          'ldGU6b3JnYW5pemF0aW9uX21lbWJlcl9yb2xlcyBjcmVhdGU6b3JnYW5pemF0aW9' +
          'uX2ludml0YXRpb25zIHJlYWQ6b3JnYW5pemF0aW9uX2ludml0YXRpb25zIGRlbGV' +
          '0ZTpvcmdhbml6YXRpb25faW52aXRhdGlvbnMgZGVsZXRlOnBob25lX3Byb3ZpZGV' +
          'ycyBjcmVhdGU6cGhvbmVfcHJvdmlkZXJzIHJlYWQ6cGhvbmVfcHJvdmlkZXJzIHV' +
          'wZGF0ZTpwaG9uZV9wcm92aWRlcnMgZGVsZXRlOnBob25lX3RlbXBsYXRlcyBjcmV' +
          'hdGU6cGhvbmVfdGVtcGxhdGVzIHJlYWQ6cGhvbmVfdGVtcGxhdGVzIHVwZGF0ZTp' +
          'waG9uZV90ZW1wbGF0ZXMgY3JlYXRlOmVuY3J5cHRpb25fa2V5cyByZWFkOmVuY3J' +
          '5cHRpb25fa2V5cyB1cGRhdGU6ZW5jcnlwdGlvbl9rZXlzIGRlbGV0ZTplbmNyeXB' +
          '0aW9uX2tleXMgcmVhZDpzZXNzaW9ucyBkZWxldGU6c2Vzc2lvbnMgcmVhZDpyZWZ' +
          'yZXNoX3Rva2VucyBkZWxldGU6cmVmcmVzaF90b2tlbnMgY3JlYXRlOnNlbGZfc2V' +
          'ydmljZV9wcm9maWxlcyByZWFkOnNlbGZfc2VydmljZV9wcm9maWxlcyB1cGRhdGU' +
          '6c2VsZl9zZXJ2aWNlX3Byb2ZpbGVzIGRlbGV0ZTpzZWxmX3NlcnZpY2VfcHJvZml' +
          'sZXMgY3JlYXRlOnNzb19hY2Nlc3NfdGlja2V0cyByZWFkOmNsaWVudF9jcmVkZW5' +
          '0aWFscyBjcmVhdGU6Y2xpZW50X2NyZWRlbnRpYWxzIHVwZGF0ZTpjbGllbnRfY3J' +
          'lZGVudGlhbHMgZGVsZXRlOmNsaWVudF9jcmVkZW50aWFscyIsImd0eSI6ImNsaWV' +
          'udC1jcmVkZW50aWFscyIsImF6cCI6IjBZT0s1c3p5TkMzNmdPQWlIaE5KWjB2MFZ' +
          'ucFZMV1NWIn0.lXYdeQgo2jv366WnR-7Tbq-jgPBghO-wLnXiGhlvoWf18oC5am-' +
          '5ciTO3f-nGI2Q1UbbIr_dh64WAS39JcxGnCC3X9lVEl5GhBQuP4YyvJYRSr0gVFC' +
          'YTfGL97meb44jLBygH7ZHUBPmxiFMfQFamsL4ZoLU7j4vSSyf-s3I1lcV4MvsPUq' +
          'wa5joq0uEG7BhvmWzezBBb0DqAagC4L3g0HoUib5N6kQGm16ebkxS7tjg_s2BrmK' +
          'YDx3VP3_ADsjD0VqLznMfyEVzMuvnkG5vLlvG3r7CNzB8UsToaCw3_2C8cBCBHxB' +
          'oYRF6F2f5rByPyNXLGGmzBSONq2_rEf1u2w'
      end>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 440
    Top = 184
  end
  object RESTResponse1: TRESTResponse
    ContentType = 'text/html'
    Left = 440
    Top = 240
  end
  object OAuth2Authenticator1: TOAuth2Authenticator
    AccessToken = 
      'eyJhbGciOiJkaXIiLCJlbmMiOiJBMjU2R0NNIiwiaXNzIjoiaHR0cHM6Ly9kZXYt' +
      'OG8ydTRnbmdkcTUzdHFsNy5qcC5hdXRoMC5jb20vIn0..7-cIKznFcn5EOCv8.h4' +
      'y7s8DjU0IQh6zR_tfGTFyRE_d5YhG5VLUYugUNyZjXH1Y7PCCdM4avIglgQl6VpT' +
      'zb33bKG9yS6r0ia0FfWmcgfRtG8YvSaEcxTgOc4ZQSgnhxBmdFbRoCPMMngcpShT' +
      '6fYT65SRIdA3aOJIKa0QPJOOKgCV52YTmWt4p3dISIz74O7gY2SRqX35jBQAt-8Q' +
      'GEj4sThwlHeYqRLhYbyNj6BgoQ3OmBd9MJA7JMLmwf8aAMRwK0_DPR4hVCHlG3ch' +
      'jHe_DhnyqkUTL_V2VPRNGFL3ZUasFYD1I3.5Ld0gAT7qcNoktpev7G_fQ'
    AccessTokenEndpoint = 'https://dev-8o2u4gngdq53tql7.jp.auth0.com/oauth/token'
    AuthCode = '03749abacfe48aa937bc'
    AuthorizationEndpoint = 'https://dev-8o2u4gngdq53tql7.jp.auth0.com/authorize'
    ClientID = 'd0rGyVF4M65ESnTPZxFwL40FwcGeoYlt'
    ClientSecret = '-a6zQNwcvRQCPzVRSzks8dEIbWXyXombdCzLRHIdSxULzlS7g5gvu9mP7-t1PlMA'
    RedirectionEndpoint = 'http://localhost:8080/bbs'
    ResponseType = rtTOKEN
    Left = 440
    Top = 64
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Console'
    Left = 48
    Top = 392
  end
end
