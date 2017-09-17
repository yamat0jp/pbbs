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
    end
    item
      MethodType = mtGet
      Name = 'LoginHandler'
      PathInfo = '/login'
      OnAction = WebModule1LoginHandlerAction
    end
    item
      MethodType = mtPost
      Name = 'DeleteHandler'
      PathInfo = '/delete'
      OnAction = WebModule1DeleteHandlerAction
    end
    item
      Name = 'SearchHandler'
      PathInfo = '/search'
      OnAction = WebModule1SearchHandlerAction
    end
    item
      MethodType = mtGet
      Name = 'CssHandler'
      PathInfo = '/css'
      OnAction = WebModule1CssHandlerAction
    end
    item
      Name = 'ScriptHandler'
      PathInfo = '/js'
      OnAction = WebModule1CssHandlerAction
    end
    item
      Name = 'ImageHandler'
      PathInfo = '/img'
      OnAction = WebModule1ImageHandlerAction
    end>
  Height = 383
  Width = 415
  object dbname: TFDTable
    IndexName = 'RDB$PRIMARY1'
    Connection = PbbsConnection
    UpdateOptions.UpdateTableName = 'DBNAME'
    TableName = 'DBNAME'
    Left = 64
    Top = 152
    object dbnameID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
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
    IndexName = 'RDB$PRIMARY2'
    Connection = PbbsConnection
    UpdateOptions.UpdateTableName = 'MAINTABLE'
    TableName = 'MAINTABLE'
    Left = 136
    Top = 152
    object maintableID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
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
    IndexName = 'RDB$PRIMARY3'
    Connection = PbbsConnection
    UpdateOptions.UpdateTableName = 'RAWTABLE'
    TableName = 'RAWTABLE'
    Left = 216
    Top = 152
    object rawID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
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
    HTMLDoc.Strings = (
      '<!doctype html>'
      '<html class="no-js" lang="ja">'
      '<head>'
      
        #9'<meta charset="utf-8" name="google-site-verification"  content=' +
        '"5KOTJTKv1HgTtIt0zVGzuyAkADCwXRme-RiiKJ03l3s">'
      #9'<meta http-equiv="X-UA-Compatible" content="IE=edge">'
      #9'<title>Top Page'
      '</title>'
      '</head>'
      '<body>'
      #9'<#style href="/css?name=top_css">'
      #9'<#style href="/css?name=normalize_css">'
      #9'<#script src="/js?name=min">'
      #9'<#script src="/js?name=top">'
      #9'<#script src="/js?name=modernizr">'
      #9'<#script src="/js?name=ui_custom">'
      '<div id="fb-root"></div>'
      '<script>(function(d, s, id) {'
      '  var js, fjs = d.getElementsByTagName(s)[0];'
      '  if (d.getElementById(id)) return;'
      '  js = d.createElement(s); js.id = id;'
      
        '  js.src = "//connect.facebook.net/ja_JP/sdk.js#xfbml=1&version=' +
        'v2.8";'
      '  fjs.parentNode.insertBefore(js, fjs);'
      '}(document, '#39'script'#39', '#39'facebook-jssdk'#39'));</script>'
      
        '<header><h1 style="text-align: center;">'#28961#26009#38651#23376#25522#31034#26495#12408#12424#12358#12371#12381'</h1></heade' +
        'r>'
      ''
      '<div class="slideshow">'
      '        <div class="slideshow-slides">'
      '    <#main>'
      ''
      '        </div>'
      #9'<div class="slideshow-nav">'
      #9'<a href="#" class="prev">prev</a>'
      #9'<a href="#" class="next">next</a>'
      '        </div>'
      '    <div class="slideshow-indicator"></div>'
      '</div>'
      ''
      '    <p>[ <#name class="info"> ] ='#12362#30693#12425#12379
      '    <p>[ <a href="/master">master</a> ] ='#31649#29702#20154
      
        '<div class="fb-like" data-href="http://pybbs.herokuapp.com" data' +
        '-layout="box_count" data-action="like" data-size="small" data-sh' +
        'ow-faces="true" data-share="false"></div><footer>'
      '<p><br>'
      '<p><a href="/search">'#26908#32034
      '</a>'
      '<p><a href="/title">'#12479#12452#12488#12523#34920#31034
      '</a>'
      '<p><a href="/help">'#20351#12356#26041#26696#20869
      '</a>'
      '<p>PR '#12522#12531#12463'<br>'
      
        '<p><a href="https://www.amazon.co.jp/%E9%AB%98%E6%A0%A1%E5%8D%92' +
        '%E6%A5%AD%E3%81%BE%E3%81%A7%E3%81%AE%E3%82%B5%E3%83%83%E3%82%AB%' +
        'E3%83%BC%E6%88%A6%E8%A1%93-sanuki_kainushi-ebook/dp/B00AXBM08Q/r' +
        'ef=sr_1_7?ie=UTF8&amp;qid=1479369992&amp;sr=8-7&amp;keywords=san' +
        'uki_kainushi">'#39640#26657#21330#26989#12414#12391#12398#12469#12483#12459#12540#25126#34899
      '</a><br>amazon kindle'
      '</p>'
      '<p>'
      
        '<p><a href="https://www.amazon.co.jp/%E4%B8%AD%E5%AD%A6%E5%8D%92' +
        '%E6%A5%AD%E3%81%BE%E3%81%A7%E3%81%AE%E3%82%B5%E3%83%83%E3%82%AB%' +
        'E3%83%BC%E6%88%A6%E8%A1%93-sanuki_kainushi-ebook/dp/B014X0S874/r' +
        'ef=sr_1_3?s=digital-text&amp;ie=UTF8&amp;qid=1479370246&amp;sr=1' +
        '-3">'#20013#23398#21330#26989#12414#12391#12398#12469#12483#12459#12540#25126#34899
      '</a><br>amazon kindle'
      '</p>'
      '</footer>'
      ''
      ''
      '</body>'
      '</html>')
    OnHTMLTag = PageProducer1HTMLTag
    Left = 184
    Top = 64
  end
  object indexpage: TPageProducer
    HTMLDoc.Strings = (
      '<!doctype html>'
      ''
      '<html>'
      '  <head>'
      '    <title><#title></title>'
      
        '    <meta charset="utf-8"><link rel=stylesheet href=/css?name=ma' +
        'in_css>'
      '  </head>'
      ''
      '  <body>'
      '    <#title2>'
      '    <p><a id=top></a>'
      '    <p>'
      '    <form action="/regist?db=<#tbnumber>" method="post">'
      '    <p>'#12362#21517#21069'<input name="name" value="<#username>">'
      '    <p>'#12479#12452#12488#12523'<input name="title">'
      '      <input type="submit" value="'#36865#20449'">'
      '    <p>'
      '    <p>'
      
        '    <p><textarea name="comment" style="HEIGHT: 156px; WIDTH: 633' +
        'px" rows="1" cols="39"></textarea>'
      '    <p>'
      '    <p>'#12497#12473#12527#12540#12489'<input name="password" type="password">'
      '    </form>'
      '    <p>'
      '      <hr size="1" width="100%">'
      '      <form action="/user?db=<#tbnumber>" method="post">'
      '      <p>'#35352#20107'No.<input name="number">'
      
        '      <p>Pass<input type="password" name="password">&nbsp;<input' +
        ' type="submit" value="'#21066#38500'">'
      '    </form>'
      '    <#footer>'
      
        '    <p style=text-align:end><a href=/?db=<#tbnumber>#bottom>'#26368#26032#35352#20107 +
        #12408#31227#21205'</a>'
      '    <#main>'
      
        '    <p style=text-align:end><a href=/?db=<#tbnumber>#top>'#12506#12540#12472#12398'top' +
        #12408#31227#21205'</a>'
      '    <a id=bottom></a>'
      
        '    <p style=text-align:center><a href=/admin?db=<#tbnumber>>'#31649#29702#32773 +
        #29992#12525#12464#12452#12531'</a>'
      '    <#footer>'
      '  </body>'
      '</html>')
    OnHTMLTag = indexpageHTMLTag
    Left = 264
    Top = 64
  end
  object admin: TPageProducer
    HTMLDoc.Strings = (
      '<!doctype html>'
      ''
      '<html>'
      '  <head><meta charset=utf-8>'
      '    <title>Login</title>'
      '  </head>'
      ''
      '  <body>'
      '    <p>'
      '    <p align="center">'#31649#29702#32773#29992#12525#12464#12452#12531#30011#38754
      '    <p>'
      '    <form action="/admin?db=<#tbnumber>" method="post">'
      '    <p align="center"><input type="password" name="password">'
      '      <input type="submit" value="'#12525#12464#12452#12531'">'
      '    </form>'
      '  </body>'
      '</html>')
    OnHTMLTag = adminHTMLTag
    Left = 64
    Top = 224
  end
  object main: TDataSetPageProducer
    HTMLDoc.Strings = (
      '<p><a name=<#cmnumber>></a>'
      
        '<section id=number><a href=/user?db=<#tbnumber>&job=<#cmnumber> ' +
        'style=text-decoration:none>[ <#cmnumber> ]</a></section>'
      '<section id=title><#title></section><br>'
      
        '<section id=name><#name></section> | <section id=date><#datetime' +
        '></section>'
      '<section id=comment><#comment></section>')
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
  object admain: TDataSetPageProducer
    HTMLDoc.Strings = (
      '<tr><td><input type=checkbox name=delete value=<#cmnumber>></td>'
      ' <td><#cmnumber></td> <td><#datetime></td>'
      ' <td><#name></td><td><#title></td></tr>')
    DataSet = FDQuery1
    Left = 112
    Top = 224
  end
  object search: TPageProducer
    HTMLDoc.Strings = (
      '<!doctype html>'
      ''
      '<html>'
      '  <head><meta charset=utf-8>'
      '    <title>Search</title>'
      '  </head>'
      ''
      '  <body>'
      '    <form action="/search" method="post">'
      '    <p style=text-align:center><strong>'#25237#31295#26908#32034'</strong>'
      '    <p>'
      '    <p>'
      '      <p style:text-align:center>AND'#26908#32034#12290#21322#35282#12459#12531#12510'(,)'#12391#21306#20999#12387#12390#12367#12384#12373#12356#12290
      '      <p>'#26908#32034#12527#12540#12489
      ''
      '      <p><input name="word1">'
      
        '    <p><input type="radio" name="filter" value="name">'#21517#21069#12363#12425#26908#32034' <in' +
        'put type="radio" checked="true" name="filter" value=com>'#26412#25991#12363#12425#26908#32034
      '    <p>'
      '    <input type="submit" value="'#26908#32034'">'
      '    </form>'
      '      <p><a href="/">'#25522#31034#26495#12408#25147#12427'</a>'
      '    <#main>'
      '  </body>'
      '</html>')
    OnHTMLTag = searchHTMLTag
    Left = 184
    Top = 224
  end
  object footer: TPageProducer
    OnHTMLTag = footerHTMLTag
    Left = 240
    Top = 224
  end
end
