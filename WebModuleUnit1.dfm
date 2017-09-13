object WebModule1: TWebModule1
  OldCreateOrder = False
  OnCreate = WebModuleCreate
  OnDestroy = WebModuleDestroy
  Actions = <
    item
      Default = True
      Enabled = False
      Name = 'index'
      PathInfo = '/index'
      OnAction = WebModule1DefaultHandlerAction
    end
    item
      MethodType = mtPost
      Name = 'regist'
      PathInfo = '/regist'
      OnAction = WebModule1registAction
    end
    item
      Name = 'admin'
      PathInfo = '/admin'
      OnAction = WebModule1adminAction
    end
    item
      Name = 'userdel'
      PathInfo = '/userdel'
      OnAction = WebModule1userdelAction
    end
    item
      MethodType = mtPost
      Name = 'admindel'
      PathInfo = '/admindel'
      OnAction = WebModule1admindelAction
    end
    item
      Name = 'login'
      PathInfo = '/login'
      OnAction = WebModule1loginAction
    end
    item
      MethodType = mtPost
      Name = 'setup'
      PathInfo = '/setup'
      OnAction = WebModule1setupAction
    end
    item
      Name = 'search'
      PathInfo = '/search'
      OnAction = WebModule1searchAction
    end>
  BeforeDispatch = WebModuleBeforeDispatch
  Height = 230
  Width = 415
  object FDTable1: TFDTable
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'pbbs'
    TableName = 'pbbs'
    Left = 56
    Top = 144
    object FDTable1name: TWideMemoField
      FieldName = 'name'
      Origin = 'name'
      BlobType = ftWideMemo
    end
    object FDTable1no: TIntegerField
      FieldName = 'no'
      Origin = 'no'
    end
    object FDTable1date: TWideMemoField
      FieldName = 'date'
      Origin = 'date'
      BlobType = ftWideMemo
    end
    object FDTable1sub: TWideMemoField
      FieldName = 'sub'
      Origin = 'sub'
      BlobType = ftWideMemo
    end
    object FDTable1com: TWideMemoField
      FieldName = 'com'
      Origin = 'com'
      BlobType = ftWideMemo
    end
    object FDTable1pass: TWideMemoField
      FieldName = 'pass'
      Origin = 'pass'
      BlobType = ftWideMemo
    end
    object FDTable1line: TIntegerField
      FieldName = 'line'
      Origin = 'line'
    end
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'Database=C:\Users\yamat\Documents\GitHub\pbbs\DATA.FDB'
      'CharacterSet=UTF8'
      'ConnectionDef=pbbs')
    Connected = True
    Left = 56
    Top = 80
  end
  object FDTable2: TFDTable
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'information'
    TableName = 'information'
    Left = 120
    Top = 144
    object FDTable2home: TWideMemoField
      FieldName = 'home'
      Origin = 'home'
      BlobType = ftWideMemo
    end
    object FDTable2title: TWideMemoField
      FieldName = 'title'
      Origin = 'title'
      BlobType = ftWideMemo
    end
    object FDTable2title2: TWideMemoField
      FieldName = 'title2'
      Origin = 'title2'
      BlobType = ftWideMemo
    end
    object FDTable2pass: TWideMemoField
      FieldName = 'pass'
      Origin = 'pass'
      BlobType = ftWideMemo
    end
    object FDTable2ngwords: TWideMemoField
      FieldName = 'ngwords'
      Origin = 'ngwords'
      BlobType = ftWideMemo
    end
  end
  object PageProducer1: TPageProducer
    OnHTMLTag = PageProducer1HTMLTag
    Left = 200
    Top = 24
  end
  object DataSetPageProducer2: TDataSetPageProducer
    HTMLDoc.Strings = (
      '<hr size=1>[<#no>]'
      '<font size="+1" color="#D01166"><b><#sub></b></font><br>'
      
        '  Name:<font color="#007000"><b><#name></b></font><font size="-1' +
        '">  Date:<#date></font>'
      '<p><tt><#com><br></tt></p>')
    DataSet = FDTable1
    OnHTMLTag = DataSetPageProducer2HTMLTag
    Left = 312
    Top = 104
  end
  object adminDS: TDataSetPageProducer
    HTMLDoc.Strings = (
      '<tr>'
      '<th><input type=checkbox name="<#no>" value="<#no>"></th>'
      '<th><#no></th>'
      '<th><font size="-1"><#date></font></th>'
      '<th><font size="+1" color="#D01166"><b><#sub></b></font></th>'
      '<th><font color="#007000"><b><#name></b></font></th>'
      '</tr>')
    DataSet = FDTable1
    OnHTMLTag = DataSetPageProducer2HTMLTag
    Left = 312
    Top = 168
  end
  object FDTable3: TFDTable
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'setting'
    TableName = 'setting'
    Left = 184
    Top = 144
    object FDTable3link: TIntegerField
      FieldName = 'link'
      Origin = 'link'
    end
    object FDTable3count: TIntegerField
      FieldName = 'count'
      Origin = 'count'
    end
    object FDTable3line: TIntegerField
      FieldName = 'line'
      Origin = 'line'
    end
  end
end
