object WebModule1: TWebModule1
  Actions = <
    item
      Default = True
      Name = 'WebActionItem12'
      PathInfo = '/'
      OnAction = WebModule1WebActionItem12Action
    end
    item
      MethodType = mtGet
      Name = 'DefaultHandler'
      PathInfo = '/blog*'
      OnAction = WebModule1DefaultHandlerAction
    end
    item
      MethodType = mtGet
      Name = 'WebActionItem1'
      PathInfo = '/dashboard'
      Producer = WebStencilsProcessor2
    end
    item
      Enabled = False
      MethodType = mtPost
      Name = 'WebActionItem2'
      PathInfo = '/admin/article/save'
      OnAction = WebModule1WebActionItem2Action
    end
    item
      MethodType = mtGet
      Name = 'WebActionItem3'
      PathInfo = '/page*'
      OnAction = WebModule1WebActionItem3Action
    end
    item
      MethodType = mtGet
      Name = 'WebActionItem5'
      PathInfo = '/posts'
      Producer = WebStencilsProcessor2
    end
    item
      MethodType = mtGet
      Name = 'WebActionItem6'
      PathInfo = '/posts/new'
      Producer = WebStencilsProcessor2
    end
    item
      MethodType = mtPost
      Name = 'WebActionItem10'
      PathInfo = '/posts/save*'
      OnAction = WebModule1WebActionItem10Action
    end
    item
      MethodType = mtGet
      Name = 'WebActionItem4'
      PathInfo = '/posts/delete/*'
      OnAction = WebModule1WebActionItem4Action
    end
    item
      MethodType = mtGet
      Name = 'WebActionItem11'
      PathInfo = '/posts/edit/*'
      Producer = WebStencilsProcessor2
    end
    item
      MethodType = mtGet
      Name = 'WebActionItem7'
      PathInfo = '/categories'
      Producer = WebStencilsProcessor2
    end
    item
      MethodType = mtGet
      Name = 'WebActionItem8'
      PathInfo = '/settings'
      Producer = WebStencilsProcessor2
    end
    item
      MethodType = mtPost
      Name = 'WebActionItem9'
      PathInfo = '/settings/save'
      OnAction = WebModule1WebActionItem9Action
    end
    item
      Name = 'WebActionItem13'
      PathInfo = '/login'
      OnAction = WebModule1WebActionItem13Action
    end
    item
      Name = 'WebActionItem14'
      PathInfo = '/logout'
    end>
  Height = 427
  Width = 536
  object FDConnection1: TFDConnection
    Params.Strings = (
      'User_Name=postgres'
      'Database=blog'
      'Password=kainushi'
      'CharacterSet=SJIS'
      'DriverID=PG')
    Left = 72
    Top = 24
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 184
    Top = 24
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    VendorLib = 'C:\Program Files\PostgreSQL\18\bin\libpq.dll'
    Left = 72
    Top = 104
  end
  object WebStencilsEngine1: TWebStencilsEngine
    Dispatcher = WebFileDispatcher1
    PathTemplates = <>
    RootDirectory = '.\templates\'
    Left = 80
    Top = 264
  end
  object WebStencilsProcessor1: TWebStencilsProcessor
    Engine = WebStencilsEngine1
    InputFileName = '.\templates\cms_view.html'
    Left = 320
    Top = 24
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
      end>
    WebDirectories = <
      item
        DirectoryAction = dirInclude
        DirectoryMask = '*'
      end
      item
        DirectoryAction = dirExclude
        DirectoryMask = '\templates\*'
      end>
    RootDirectory = '.'
    VirtualPath = '/'
    Left = 80
    Top = 184
  end
  object WebStencilsProcessor2: TWebStencilsProcessor
    Engine = WebStencilsEngine1
    InputFileName = '.\templates\cms_entry_editor.html'
    DataVarDuplicates = ddReplace
    OnValue = WebStencilsProcessor2Value
    BeforeProduce = WebStencilsProcessor2BeforeProduce
    AfterProduce = WebStencilsProcessor2AfterProduce
    Left = 320
    Top = 112
  end
  object WebStencilsProcessor3: TWebStencilsProcessor
    Engine = WebStencilsEngine1
    InputFileName = '.\templates\cms_pagenation.html'
    PathTemplate = '/page/{index}'
    DataVarDuplicates = ddReplace
    Left = 320
    Top = 192
  end
  object FDQuery2: TFDQuery
    Connection = FDConnection1
    Left = 184
    Top = 104
  end
  object FDQuery3: TFDQuery
    Connection = FDConnection1
    Left = 184
    Top = 184
  end
  object FDQuery4: TFDQuery
    Connection = FDConnection1
    Left = 184
    Top = 264
  end
  object WebStencilsProcessor4: TWebStencilsProcessor
    Engine = WebStencilsEngine1
    InputFileName = '.\templates\cms_login.html'
    DataVarDuplicates = ddReplace
    Left = 320
    Top = 272
  end
end
