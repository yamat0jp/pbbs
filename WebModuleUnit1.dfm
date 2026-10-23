object WebModule1: TWebModule1
  OnCreate = WebModuleCreate
  OnDestroy = WebModuleDestroy
  Actions = <
    item
      Name = 'mainItem'
      PathInfo = '/bbs/*'
      OnAction = WebModule1mainItemAction
    end
    item
      Name = 'alertItem'
      PathInfo = '/alert/*'
      OnAction = WebModule1alertAction
    end
    item
      MethodType = mtGet
      Name = 'showTop'
      PathInfo = '/top'
      OnAction = WebModule1showTopAction
    end
    item
      Name = 'adminPage'
      PathInfo = '/admin/*'
      OnAction = WebModule1adminPageAction
    end
    item
      Name = 'searchItem'
      PathInfo = '/search/*'
      OnAction = WebModule1searchItemAction
    end
    item
      Name = 'helpPage'
      PathInfo = '/help/*'
      OnAction = WebModule1helpAction
    end
    item
      Name = 'members'
      PathInfo = '/members/*'
      OnAction = WebModule1membersAction
    end
    item
      Name = 'login'
      PathInfo = '/login'
      OnAction = WebModule1loginAction
    end
    item
      Name = 'WebActionItem1'
      PathInfo = '/params/*'
      OnAction = WebModule1WebActionItem1Action
    end
    item
      Name = 'WebActionItem2'
      PathInfo = '/super_search'
      OnAction = WebModule1WebActionItem2Action
    end
    item
      MethodType = mtGet
      Name = 'WebActionItem3'
      PathInfo = '/blog/*'
    end
    item
      Name = 'WebActionItem4'
      PathInfo = '/logout'
      OnAction = WebModule1WebActionItem4Action
    end
    item
      Default = True
      MethodType = mtGet
      Name = 'WebActionItem5'
      PathInfo = '/home'
      OnAction = WebModule1WebActionItem5Action
    end
    item
      MethodType = mtPost
      Name = 'WebActionItem6'
      PathInfo = '/register'
      OnAction = WebModule1WebActionItem6Action
    end>
  Height = 556
  Width = 779
  object FDConnection1: TFDConnection
    Params.Strings = (
      'User_Name=postgres'
      'Database=bbs'
      'Password=kainushi'
      'CharacterSet=SJIS'
      'DriverID=PG')
    Connected = True
    LoginPrompt = False
    Left = 160
    Top = 32
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
        Extensions = 'jpg'
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
    Left = 160
    Top = 320
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 160
    Top = 104
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Console'
    Left = 160
    Top = 392
  end
  object WebStencilsProcessor1: TWebStencilsProcessor
    Engine = WebStencilsEngine1
    InputFileName = '.\templates\index.html'
    PathTemplate = '/bbs/{database}/{title}/{page}'
    DataVarDuplicates = ddReplace
    OnValue = WebStencilsProcessor1Value
    Left = 416
    Top = 24
  end
  object WebStencilsProcessor2: TWebStencilsProcessor
    Engine = WebStencilsEngine1
    InputFileName = '.\templates\top.html'
    Left = 416
    Top = 88
  end
  object WebStencilsProcessor3: TWebStencilsProcessor
    Engine = WebStencilsEngine1
    InputFileName = '.\templates\admin.html'
    PathTemplate = '/admin/{database}/{title}/{page}'
    DataVarDuplicates = ddReplace
    OnValue = WebStencilsProcessor3Value
    Left = 416
    Top = 152
  end
  object WebStencilsProcessor4: TWebStencilsProcessor
    Engine = WebStencilsEngine1
    InputFileName = './templates/super_search.html'
    DataVarDuplicates = ddReplace
    Left = 416
    Top = 216
  end
  object WebStencilsProcessor5: TWebStencilsProcessor
    Engine = WebStencilsEngine1
    InputFileName = './templates/help.html'
    OnValue = WebStencilsProcessor5Value
    Left = 416
    Top = 280
  end
  object WebStencilsEngine1: TWebStencilsEngine
    PathTemplates = <>
    Left = 576
    Top = 48
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    VendorLib = 'C:\Program Files\PostgreSQL\18\bin\libpq.dll'
    Left = 160
    Top = 248
  end
  object WebStencilsProcessor6: TWebStencilsProcessor
    Engine = WebStencilsEngine1
    InputFileName = './templates/search.html'
    PathTemplate = '/search/{user}/{title}'
    DataVarDuplicates = ddReplace
    OnValue = WebStencilsProcessor6Value
    Left = 416
    Top = 344
  end
  object WebStencilsProcessor7: TWebStencilsProcessor
    Engine = WebStencilsEngine1
    InputFileName = '.\templates\help.html'
    PathTemplate = '/help/{user}/{title}'
    DataVarDuplicates = ddReplace
    Left = 416
    Top = 408
  end
  object WebStencilsProcessor8: TWebStencilsProcessor
    Engine = WebStencilsEngine1
    InputFileName = './templates/alert.html'
    PathTemplate = '/alert/{user}/{title}/{id}'
    DataVarDuplicates = ddReplace
    Left = 416
    Top = 472
  end
  object FDCommand1: TFDCommand
    Connection = FDConnection1
    Transaction = FDTransaction1
    Left = 272
    Top = 256
  end
  object FDTransaction1: TFDTransaction
    Connection = FDConnection1
    Left = 272
    Top = 320
  end
  object WebStencilsProcessor9: TWebStencilsProcessor
    Engine = WebStencilsEngine1
    InputFileName = '.\templates\members.html'
    PathTemplate = '/members/{Database}'
    DataVarDuplicates = ddReplace
    Left = 576
    Top = 112
  end
  object FDQuery2: TFDQuery
    Connection = FDConnection1
    Left = 160
    Top = 176
  end
  object WebStencilsProcessor10: TWebStencilsProcessor
    Engine = WebStencilsEngine1
    InputFileName = '.\templates\params.html'
    PathTemplate = '/params/{user}/{title}'
    Left = 576
    Top = 176
  end
  object WebStencilsProcessor11: TWebStencilsProcessor
    Engine = WebStencilsEngine1
    InputFileName = '.\templates\maintenance.html'
    PathTemplate = '/bbs/{user}/{title}'
    Left = 576
    Top = 240
  end
  object WebStencilsProcessor12: TWebStencilsProcessor
    Engine = WebStencilsEngine1
    InputFileName = '.\templates\login.html'
    DataVarDuplicates = ddReplace
    Left = 576
    Top = 304
  end
  object WebStencilsProcessor13: TWebStencilsProcessor
    Engine = WebStencilsEngine1
    InputFileName = '.\templates\homepage.html'
    DataVarDuplicates = ddReplace
    Left = 576
    Top = 368
  end
end
