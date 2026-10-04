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
      PathInfo = '/alert/{id}'
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
      PathInfo = '/admin/*'
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
      PathInfo = '/rename/*'
      OnAction = WebModule1renameAction
    end
    item
      Name = 'master'
      PathInfo = '/master'
      Producer = master
      OnAction = WebModule1masterAction
    end
    item
      Name = 'linkItem'
      PathInfo = '/link'
      OnAction = WebModule1linkItemAction
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
    end>
  BeforeDispatch = WebModuleBeforeDispatch
  Height = 556
  Width = 779
  object FDConnection1: TFDConnection
    Params.Strings = (
      'User_Name=postgres'
      'Database=bbs'
      'CharacterSet=UTF8'
      'Password=kainushi'
      'DriverID=PG')
    Connected = True
    LoginPrompt = False
    Left = 160
    Top = 32
  end
  object mentenance: TPageProducer
    HTMLFile = '.\templates\mentenance.htm'
    Left = 272
    Top = 384
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
  object master: TPageProducer
    HTMLFile = '.\templates\master.html'
    Left = 272
    Top = 456
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Console'
    Left = 160
    Top = 392
  end
  object WebStencilsProcessor1: TWebStencilsProcessor
    Engine = WebStencilsEngine1
    InputFileName = '.\templates\index.html'
    PathTemplate = '/bbs/{database}/{page}'
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
    PathTemplate = '/admin/{database}/{page}'
    Left = 416
    Top = 152
  end
  object WebStencilsProcessor4: TWebStencilsProcessor
    Engine = WebStencilsEngine1
    InputFileName = './templates/link.html'
    PathTemplate = '/link/{url}'
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
    Top = 240
  end
  object WebStencilsProcessor6: TWebStencilsProcessor
    Engine = WebStencilsEngine1
    InputFileName = './templates/search.html'
    OnValue = WebStencilsProcessor6Value
    Left = 416
    Top = 344
  end
  object WebStencilsProcessor7: TWebStencilsProcessor
    Engine = WebStencilsEngine1
    InputFileName = '.\templates\help.html'
    Left = 416
    Top = 408
  end
  object FDQuery2: TFDQuery
    Connection = FDConnection1
    Left = 160
    Top = 176
  end
  object WebStencilsProcessor8: TWebStencilsProcessor
    Engine = WebStencilsEngine1
    InputFileName = './templates/alert.html'
    PathTemplate = '/alert/{id}'
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
end
