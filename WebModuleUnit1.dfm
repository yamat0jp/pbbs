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
      MethodType = mtPost
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
      Name = 'ImageHandler'
      PathInfo = '/img'
      OnAction = WebModule1ImageHandlerAction
    end
    item
      MethodType = mtGet
      Name = 'TitleHandler'
      PathInfo = '/title'
      OnAction = WebModule1TitleHandlerAction
    end
    item
      Name = 'HelpHandler'
      PathInfo = '/help'
      OnAction = WebModule1HelpHandlerAction
    end
    item
      Name = 'AlertHandler'
      PathInfo = '/alert'
      OnAction = WebModule1AlertHandlerAction
    end
    item
      MethodType = mtGet
      Name = 'MasterHandler'
      PathInfo = '/master'
      OnAction = WebModule1MasterHandlerAction
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
    object maintableNAME: TStringField
      FieldName = 'NAME'
      Origin = 'NAME'
      Size = 30
    end
    object maintableTITLE: TStringField
      FieldName = 'TITLE'
      Origin = 'TITLE'
      Size = 80
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
    IndexName = 'RDB$PRIMARY9'
    Connection = PbbsConnection
    UpdateOptions.UpdateTableName = 'RAW'
    TableName = 'RAW'
    Left = 216
    Top = 152
    object rawID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
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
      
        '    <script type=text/javascript src=http://ajax.googleapis.com/' +
        'ajax/libs/jquery/1.8.1/jquery.min.js></script>'
      
        '    <script type=text/javascript src=/css?name=livepreview></scr' +
        'ipt>'
      '    <script type=text/javascript src=/css?name=sub></script>'
      '    <link rel=stylesheet href=/css?name=livepreview_css>'
      '  </head>'
      ''
      '  <body>'
      '    <#title2>'
      '    <p><a id=top></a>'
      '    <p>'
      '    <#form>'
      '    <p>'
      '      <hr size="1" width="100%">'
      
        '      <form action="/user?db=<#tbnumber>" method="post" id=searc' +
        'h>'
      '      <p>'#35352#20107'No.<input name="number">'
      '      <p>Pass<input type="password" name="password">'
      '      <p><input type="submit" value="'#21066#38500'">'
      '      </form>'
      '    <#footer>'
      
        '    <p style=text-align:end><a href=/?db=<#tbnumber>#bottom>'#12506#12540#12472#19979 +
        #37096#12408#31227#21205'</a>'
      '    <#main>'
      
        '    <p style=text-align:end><a href=/?db=<#tbnumber>#top>'#12506#12540#12472#20808#38957#12408#31227 +
        #21205'</a>'
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
  object login: TPageProducer
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
    OnHTMLTag = loginHTMLTag
    Left = 64
    Top = 224
  end
  object main: TDataSetPageProducer
    HTMLDoc.Strings = (
      '<p><a id=<#cmnumber>></a>'
      
        '<section id=number><a href=/user?db=<#tbnumber>&job=<#cmnumber> ' +
        'style=text-decoration:none>[ <#cmnumber> ]</a></section>'
      '<section id=title><#title></section><br>'
      
        '<section id=name><#name></section> | <section id=date><#datetime' +
        '></section>'
      '<section id=comment><#comment></section>'
      
        '<section id=alert><p style=text-align:end><a href=/alert?db=<#tb' +
        'number>&page=<#cmnumber>>'#22577#21578'</a>')
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
    Top = 72
    ParamData = <
      item
        Name = 'PARAM'
        DataType = ftString
        ParamType = ptInput
        Value = '1'
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
      '    <p><input type="radio" name="filter" value="name">'#21517#21069#12363#12425#26908#32034
      
        '     <input type="radio" checked="true" name="filter" value=com>' +
        #26412#25991#12363#12425#26908#32034
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
  object key: TPageProducer
    HTMLDoc.Strings = (
      '<!doctype html>'
      '<html>'
      '<head><meta charset=utf-8><title></title>'
      '<link rel=stylesheet href=/css?name=main_css>'
      '</head>'
      '<body>'
      '<#main>'
      '</body>'
      '</html>')
    OnHTMLTag = keyHTMLTag
    Left = 296
    Top = 224
  end
  object htmlfile: TPageProducer
    HTMLDoc.Strings = (
      '<header>'
      '<form action=/regist?db=<#tbnumber> method="post">'
      '<table><tr><td>'
      '        <p>'#12362#21517#21069'<input name="name" value="<#name>">'
      '        <p>'#12479#12452#12488#12523'<input name="title">'
      '        <input type="submit" value="'#36865#20449'">'
      '</td></tr>'
      '<tr><td>'
      
        '        <p><textarea name="comment" style="HEIGHT: 156px; WIDTH:' +
        ' 633px" rows="1" cols="39"'
      
        '                required placeholder="'#12467#12513#12531#12488#12394#12393#12434#20837#21147#12375#12390#12367#12384#12373#12356'."></textar' +
        'ea>'
      '</td></tr>'
      '<tr><td>'
      '<p>'#12497#12473#12527#12540#12489'<input name="password" type="password">'
      '</td></tr>'
      '<tr><td>'
      '<p>'#21512#35328#33865#12434#24179#20206#21517#12391#20837#21147#12375#12390#12367#12384#12373#12356': gennki'
      '        <input type=text name=aikotoba value=<#aikotoba>>'
      '</td></tr></table>'
      '</form>'
      '<button>open</button>'
      '</header>')
    OnHTMLTag = htmlfileHTMLTag
    Left = 64
    Top = 280
  end
  object title: TPageProducer
    HTMLDoc.Strings = (
      '<!doctype html>'
      '<html>'
      
        '<head><meta charset=UTF-8><meta http-equiv="content-language" co' +
        'ntent="ja">'
      '<title>'#12479#12452#12488#12523#34920#31034'</title>'
      
        '<script type=text/javascript src=http://ajax.googleapis.com/ajax' +
        '/libs/jquery/1.8.1/jquery.min.js></script>'
      '<script type=text/javascript src=/css?name=min></script>'
      '<script type=text/javascript src=/css?name=main></script>'
      '<link rel=stylesheet href=/css?name=top_css>'
      '</head>'
      '<body>'
      '<#main>'
      '<p><a href=/>'#12418#12393#12427'</a>'
      '<footer>PR '#12522#12531#12463
      
        '<p><a href=https://www.amazon.co.jp/%E9%AB%98%E6%A0%A1%E5%8D%92%' +
        'E6%A5%AD%E3%81%BE%E3%81%A7%E3%81%AE%E3%82%B5%E3%83%83%E3%82%AB%E' +
        '3%83%BC%E6%88%A6%E8%A1%93-sanuki_kainushi-ebook/dp/B00AXBM08Q/re' +
        'f=sr_1_7?ie=UTF8&qid=1479369992&sr=8-7&keywords=sanuki_kainushi>' +
        #39640#26657#21330#26989#12414#12391#12398#12469#12483#12459#12540#25126#34899'</a><br>'
      'amazon kindle</p>'
      '<p>'
      
        '<p><a href=https://www.amazon.co.jp/%E4%B8%AD%E5%AD%A6%E5%8D%92%' +
        'E6%A5%AD%E3%81%BE%E3%81%A7%E3%81%AE%E3%82%B5%E3%83%83%E3%82%AB%E' +
        '3%83%BC%E6%88%A6%E8%A1%93-sanuki_kainushi-ebook/dp/B014X0S874/re' +
        'f=sr_1_3?s=digital-text&ie=UTF8&qid=1479370246&sr=1-3>'#20013#23398#21330#26989#12414#12391#12398#12469#12483#12459 +
        #12540#25126#34899'</a><br>'
      'amazon kindle</p>'
      '</footer>'
      '</body>'
      '</html>')
    OnHTMLTag = titleHTMLTag
    Left = 112
    Top = 280
  end
  object help: TPageProducer
    HTMLDoc.Strings = (
      '<!DOCTYPE html>'
      ''
      '<html><head><meta charset=utf-8><title>'#20351#12356#26041'</title></head>'
      '<body>'
      '<P>'#35370#21839#32773#12398#30342#12373#12435'</P>'
      '<form action=/help method=post>'
      #9'<p>'#12362#21839#12356#21512#12431#12379'<'#21066#38500#20381#38972#12394#12393#20309#12391#12418'></p>'
      #9'<textarea name=help style=height:100px;width:250px>'
      #25237#31295#32773#21517#12394#12393#65306
      #30456#35527#20869#23481#65306
      #12381#12398#20182#65306'</textarea><br>'
      #9'<input type=submit value="'#36865#20449'"></form>'
      #9'<p><#message></p><br>'
      '<p>'#38283#30330#32773#12398#30342#12373#12435
      '<p>pybbs'#12398'API'
      '<p>ArticleAPI ... ~/read/api/<b>dbname</b>/<b>number</b>'
      '<p>ListAPI ... ~/list/api/<b>dbname</b>'
      '<p style=text-align:center><a href=/>'#25147#12427'</a>'
      '</body>'
      '</html>')
    OnHTMLTag = helpHTMLTag
    Left = 184
    Top = 280
  end
  object alert: TPageProducer
    HTMLDoc.Strings = (
      '<!doctype html>'
      '<html>'
      '<head><meta charset=utf-8><title>'#22577#21578#30003#35531#30011#38754'</title>'
      '<link rel=stylesheet href=/css?name=main></head>'
      ''
      '<body>'
      '<form action=/alert?db=<#tbnumber>&page=<#cmnumber> method=post>'
      '<p>'#23452#12375#12369#12428#12400#20309#12363#12362#26360#12365#28155#12360#12367#12384#12373#12356
      '<p><textarea name=com></textarea>'
      '<p><#comment>'
      
        '<p style=text-align:center><input name=admit type=submit value=o' +
        'k><input name=cancel type=submit value=cancel>'
      '</form>'
      '</body></html>')
    OnHTMLTag = alertHTMLTag
    Left = 240
    Top = 280
  end
  object alerttable: TFDTable
    IndexName = 'RDB$PRIMARY7'
    Connection = PbbsConnection
    UpdateOptions.UpdateTableName = 'ALERTTABLE'
    TableName = 'ALERTTABLE'
    Left = 344
    Top = 152
    object alerttableID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object alerttableMESSAGE: TStringField
      FieldName = 'MESSAGE'
      Origin = '"MESSAGE"'
      Size = 1000
    end
    object alerttableDATETIME: TStringField
      FieldName = 'DATETIME'
      Origin = 'DATETIME'
    end
  end
  object master: TPageProducer
    HTMLDoc.Strings = (
      '<!doctype html>'
      '<html>'
      '<head><meta charset=utf-8><title>mail</title>'
      '<link rel=stylesheet href=/css?name=main></head>'
      ''
      '<body>'
      '<p>'#22577#21578#19968#35239
      '<#main>'
      ''
      '</body>'
      '</html>')
    OnHTMLTag = masterHTMLTag
    Left = 296
    Top = 280
  end
  object temp: TFDTable
    IndexFieldNames = 'SCORE'
    Connection = PbbsConnection
    UpdateOptions.UpdateTableName = 'TITLE'
    TableName = 'TITLE'
    Left = 352
    Top = 240
    object tempID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object tempDBID: TIntegerField
      FieldName = 'DBID'
      Origin = 'DBID'
    end
    object tempFIRST: TIntegerField
      FieldName = 'FIRST'
      Origin = '"FIRST"'
    end
    object tempLAST: TIntegerField
      FieldName = 'LAST'
      Origin = '"LAST"'
    end
    object tempSCORE: TDateField
      FieldName = 'SCORE'
      Origin = 'SCORE'
    end
  end
  object clean: TFDQuery
    Connection = PbbsConnection
    SQL.Strings = (
      'delete from title;')
    Left = 352
    Top = 296
  end
  object admin: TPageProducer
    HTMLDoc.Strings = (
      '<!doctype html>'
      '<html>'
      '<head><meta charset=utf-8>'
      '<title></title></head>'
      
        '<body><table><tr><td>'#21066#38500'</td><td>'#25237#31295#32773'</td><td>'#12479#12452#12488#12523'</td><td></td><t' +
        'd>'#26085#26178'</td></tr>'
      '<#main>'
      '</table>'
      ''
      '<#footer>'
      '</body></html>')
    OnHTMLTag = adminHTMLTag
    Left = 104
    Top = 112
  end
end
