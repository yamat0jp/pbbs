unit WebModuleUnit1;

interface

uses System.SysUtils, System.Classes, Web.HTTPApp, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Web.HTTPProd, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Web.DBWeb, Web.DSProd, System.Types, RegularExpressions,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, System.Variants, System.NetEncoding,
  IdHashMessageDigest, FireDAC.Phys.IBBase, FireDAC.Comp.ScriptCommands,
  FireDAC.Stan.Util, FireDAC.Comp.Script;

type
  TWebModule1 = class(TWebModule)
    dbname: TFDTable;
    maintable: TFDTable;
    raw: TFDTable;
    PageProducer1: TPageProducer;
    indexpage: TPageProducer;
    login: TPageProducer;
    main: TDataSetPageProducer;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    PbbsConnection: TFDConnection;
    FDQuery1: TFDQuery;
    full: TFDQuery;
    dbnameID: TIntegerField;
    dbnameTBNUMBER: TIntegerField;
    dbnameDBNAME: TStringField;
    admain: TDataSetPageProducer;
    search: TPageProducer;
    footer: TPageProducer;
    key: TPageProducer;
    htmlfile: TPageProducer;
    title: TPageProducer;
    help: TPageProducer;
    alert: TPageProducer;
    alerttable: TFDTable;
    master: TPageProducer;
    maintableID: TIntegerField;
    maintableTBNUMBER: TIntegerField;
    maintableCMNUMBER: TIntegerField;
    maintableNAME: TStringField;
    maintableTITLE: TStringField;
    maintableCOMMENT: TStringField;
    maintableDATETIME: TStringField;
    rawID: TIntegerField;
    rawRAW: TStringField;
    rawPASSWORD: TStringField;
    alerttableID: TIntegerField;
    alerttableMESSAGE: TStringField;
    alerttableDATETIME: TStringField;
    temp: TFDTable;
    tempID: TIntegerField;
    tempDBID: TIntegerField;
    tempFIRST: TIntegerField;
    tempLAST: TIntegerField;
    tempSCORE: TDateField;
    clean: TFDQuery;
    admin: TPageProducer;
    FDScript1: TFDScript;
    maintenance: TPageProducer;
    procedure WebModule1RegistHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1UserHandlerAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1NavHandlerAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure PageProducer1HTMLTag(Sender: TObject; Tag: TTag;
      const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure indexpageHTMLTag(Sender: TObject; Tag: TTag;
      const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure WebModuleCreate(Sender: TObject);
    procedure WebModuleDestroy(Sender: TObject);
    procedure WebModule1AdminHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1LoginHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure loginHTMLTag(Sender: TObject; Tag: TTag; const TagString: string;
      TagParams: TStrings; var ReplaceText: string);
    procedure WebModule1DeleteHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1SearchHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure searchHTMLTag(Sender: TObject; Tag: TTag; const TagString: string;
      TagParams: TStrings; var ReplaceText: string);
    procedure WebModule1CssHandlerAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1ImageHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure footerHTMLTag(Sender: TObject; Tag: TTag; const TagString: string;
      TagParams: TStrings; var ReplaceText: string);
    procedure keyHTMLTag(Sender: TObject; Tag: TTag; const TagString: string;
      TagParams: TStrings; var ReplaceText: string);
    procedure htmlfileHTMLTag(Sender: TObject; Tag: TTag;
      const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure WebModule1TitleHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure titleHTMLTag(Sender: TObject; Tag: TTag; const TagString: string;
      TagParams: TStrings; var ReplaceText: string);
    procedure WebModule1HelpHandlerAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure helpHTMLTag(Sender: TObject; Tag: TTag; const TagString: string;
      TagParams: TStrings; var ReplaceText: string);
    procedure WebModule1AlertHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure alertHTMLTag(Sender: TObject; Tag: TTag; const TagString: string;
      TagParams: TStrings; var ReplaceText: string);
    procedure WebModule1MasterHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure masterHTMLTag(Sender: TObject; Tag: TTag; const TagString: string;
      TagParams: TStrings; var ReplaceText: string);
    procedure adminHTMLTag(Sender: TObject; Tag: TTag; const TagString: string;
      TagParams: TStrings; var ReplaceText: string);
    procedure WebModule1LogoutHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    { private 宣言 }
    ini: TStringList;
    function CheckWords(comment: TStringList): Boolean;
  public
    { public 宣言 }
    function LinkCreator(const line: string; index: integer): string;
    function LoginCheck: Boolean;
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

procedure TWebModule1.loginHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  s: string;
begin
  if TagString = 'option' then
  begin
    dbname.First;
    while dbname.Eof = false do
    begin
      s := dbname.FieldByName('dbname').AsString;
      ReplaceText := ReplaceText + '<option value=' + s + '>' + s + '</option>';
      dbname.Next;
    end;
    ReplaceText := ReplaceText + '<option value=master>master</option>';
  end;
end;

procedure TWebModule1.adminHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  i: integer;
  s: string;
begin
  if TagString = 'main' then
  begin
    for i := 1 to ini.Values['count'].ToInteger do
    begin
      if FDQuery1.Eof = true then
        break;
      ReplaceText := ReplaceText + admain.Content;
      FDQuery1.Next;
    end;
  end
  else if TagString = 'tbnumber' then
    ReplaceText := Request.QueryFields.Values['db']
  else if TagString = 'page' then
  begin
    s := Request.QueryFields.Values['page'];
    if (s <> '') or (s <> '0') then
      ReplaceText := '&page=' + s;
  end
  else if TagString = 'password' then
    ReplaceText := ini.Values['password']
  else if TagString = 'check' then
  begin
    if ini.Values['maintenance'] = 'on' then
      ReplaceText := 'checked';
  end
  else if TagString = 'footer' then
    ReplaceText := footer.ContentFromString('<#list admin=true>');
end;

procedure TWebModule1.alertHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  i: integer;
begin
  if TagString = 'comment' then
  begin
    i := maintable.Lookup('tbnumber;cmnumber',
      VarArrayOf([Request.QueryFields.Values['db'].ToInteger,
      Request.QueryFields.Values['page'].ToInteger]), 'id');
    raw.Open;
    ReplaceText := Copy(raw.Lookup('id', i, 'raw'), 1, 50) + ' ...';
    raw.Close;
  end
  else if TagString = 'tbnumber' then
    ReplaceText := Request.QueryFields.Values['db']
  else if TagString = 'cmnumber' then
    ReplaceText := Request.QueryFields.Values['page'];
end;

function TWebModule1.CheckWords(comment: TStringList): Boolean;
var
  t: TStringList;
  function sub: Boolean;
  var
    i: integer;
    j: integer;
  begin
    result := true;
    for i := 0 to comment.Count - 1 do
      for j := 0 to t.Count - 1 do
        if Pos(t[j], comment[i]) > 0 then
        begin
          result := false;
          Exit;
        end;
  end;

begin
  t := TStringList.Create;
  try
    t.DelimitedText := ini.Values['tags'];
    if sub = true then
    begin
      t.DelimitedText := ini.Values['words'];
      result := sub;
    end
    else
      result := false;
  finally
    t.Free;
  end;
end;

procedure TWebModule1.footerHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  s, t, x: string;
  i, j, page: integer;
begin
  if TagParams.Values['admin'] = 'true' then
    x := '/admin?db=' + Request.QueryFields.Values['db']
  else
    x := '/?db=' + Request.QueryFields.Values['db'];
  s := x + '&page=';
  ReplaceText := '<div style=text-align:center><b>[</b>';
  t := Request.QueryFields.Values['page'];
  if t <> '' then
    page := t.ToInteger
  else
    page := 0;
  if page = 0 then
  begin
    t := '<<';
    for j := 1 to 10 do
      t := t + ' <a href=' + s + j.ToString + '>' + j.ToString + '</a> ';
    t := t + '>> <b>]</b>  recent</div>';
  end
  else
  begin
    i := page - 1;
    t := '<a href=' + s + i.ToString + ' style=text-decoration:none><< </a>';
    for j := 1 to 10 do
      if page = j then
        t := t + Request.QueryFields.Values['page']
      else
        t := t + ' <a href=' + s + j.ToString + '>' + j.ToString + '</a> ';
    i := page + 1;
    t := t + '<a href=' + s + i.ToString +
      ' style=text-decoration:none> >></a> <b>]</b>  <a href=' + x +
      '>recent</a></div>';
  end;
  ReplaceText := ReplaceText + t;
end;

procedure TWebModule1.helpHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
begin
  if (TagString = 'message')and(Request.MethodType = mtPost) then
    ReplaceText := '送信しました.';
end;

procedure TWebModule1.htmlfileHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
begin
  if TagString = 'tbnumber' then
    ReplaceText := Request.QueryFields.Values['db']
  else if TagString = 'name' then
    ReplaceText := TNetEncoding.URL.Decode(Request.CookieFields.Values['name'])
  else if TagString = 'aikotoba' then
    ReplaceText := TNetEncoding.URL.Decode(Request.CookieFields.Values
      ['aikotoba']);
end;

procedure TWebModule1.indexpageHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  i: integer;
begin
  if TagString = 'form' then
  begin
    i := Request.QueryFields.Values['db'].ToInteger;
    if (ini.Values['info'] = dbname.Lookup('tbnumber', i, 'dbname')) and
      (LoginCheck = false) then
    begin
      ReplaceText := '<h1 style=text-align:center>管理人から皆様にお知らせがあります</h1>';
      Exit;
    end;
    full.ParamByName('param').AsInteger := i;
    full.Open;
    if full.Fields[0].AsInteger >= ini.Values['count'].ToInteger * 10 then
      ReplaceText := '<p style=font-size:2.5em>申し訳ありません これ以上の投稿はできません（容量制限）'
    else
      ReplaceText := htmlfile.Content;
    full.Close;
  end
  else if TagString = 'main' then
  begin
    for i := 1 to ini.Values['count'].ToInteger do
    begin
      if FDQuery1.Eof = true then
        break;
      ReplaceText := ReplaceText + '<hr>' + main.Content;
      FDQuery1.Next;
    end;
    FDQuery1.IndexFieldNames := '';
  end
  else if TagString = 'title' then
    ReplaceText := ini.Values['title']
  else if TagString = 'title2' then
    ReplaceText := ini.Values['title2']
  else if TagString = 'tbnumber' then
    ReplaceText := Request.QueryFields.Values['db']
  else if TagString = 'footer' then
    ReplaceText := footer.ContentFromString('<#list>')
  else if TagString = 'dbname' then
    ReplaceText := dbname.Lookup('tbnumber', Request.QueryFields.Values['db']
      .ToInteger, 'dbname');
end;

procedure TWebModule1.keyHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
begin
  ReplaceText := main.Content;
end;

function TWebModule1.LinkCreator(const line: string; index: integer): string;
var
  s1, s2, p: string;
  ep: integer;
  t: TMatch;
begin
  ep := 1;
  if index = 1 then
    t := TRegEx.Match(line, '>>[0-9]+')
  else
    t := TRegEx.Match(line,
      'http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\(\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+');
  while t.Success = true do
  begin
    if index = 1 then
    begin
      p := Request.QueryFields.Values['db'];
      s1 := Copy(t.Value, 3, t.Length);
      s2 := s2 + Copy(line, ep, t.index - ep) +
        '<a class=minpreview data-preview-url=/?db=' + p + '&key=' + s1 +
        ' href=/user?db=' + p + '&job=' + s1 + '>>>' + s1 + '</a>';
    end
    else
    begin
      s1 := t.Value;
      s2 := s2 + Copy(line, ep, t.index - ep) +
        '<a class=minpreview data-preview-url=' + s1 + ' href=' + s1 + '>' +
        s1 + '</a>'
    end;
    ep := t.index + t.Length;
    t := t.NextMatch;
  end;
  result := s2 + Copy(line, ep, Length(line));
end;

function TWebModule1.LoginCheck: Boolean;
var
  t1, t2: string;
  m5: TIdHashMessageDigest5;
begin
  t1 := Request.CookieFields.Values['password'];
  m5 := TIdHashMessageDigest5.Create;
  try
    t2 := m5.HashStringAsHex(ini.Values['password']);
  finally
    m5.Free;
  end;
  result := t1 = t2;
end;

procedure TWebModule1.masterHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
begin
  alerttable.Open;
  while alerttable.Eof = false do
  begin
    ReplaceText := ReplaceText + '<hr>' + alerttable.FieldByName('message')
      .AsString + '<p>' + alerttable.FieldByName('datetime').AsString;
    alerttable.Next;
  end;
  alerttable.Close;
end;

procedure TWebModule1.PageProducer1HTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  i, j, k: integer;
  s, t1, t2: string;
begin
  if TagString = 'main' then
  begin
    i := ini.Values['Count'].ToInteger;
    j := ini.Values['titlecount'].ToInteger;
    k := 1;
    s := '';
    dbname.First;
    while dbname.Eof = false do
    begin
      if k mod j = 1 then
        s := s + '<div class=slide><img src=/img?name=slide' + ((k div j) + 1)
          .ToString + ' height=465 alt="" style=float:right>';
      inc(k);
      t1 := dbname.FieldByName('tbnumber').AsString;
      t2 := dbname.FieldByName('dbname').AsString;
      if t2 = ini.Values['info'] then
      begin
        dbname.Next;
        continue;
      end;
      full.ParamByName('param').AsInteger := t1.ToInteger;
      full.Open;
      if full.Fields[0].AsInteger < i then
        s := s + '<p><a href=/?db=' + t1 + '>' + t2 + '</a>'
      else
        s := s + '<p style=color:red><a href=/?db=' + t1 + '>' + t2 + '</a>';
      full.Close;
      if k mod j = 1 then
        s := s + '</div>';
      dbname.Next;
    end;
    if k mod j <> 1 then
      s := s + '</div>';
    ReplaceText := s;
  end
  else if TagString = 'script' then
    ReplaceText := '<script src=' + TagParams.Values['src'] + '></script>'
  else if TagString = 'style' then
    ReplaceText := '<link rel=stylesheet href=' + TagParams.Values['href'] + '>'
  else if TagString = 'name' then
  begin
    s := ini.Values['info'];
    if dbname.Locate('dbname', s) = true then
      ReplaceText := '<a href=/?db=' + dbname.FieldByName('tbnumber').AsString +
        '>' + s + '</a>'
    else
      ReplaceText := 'info';
  end;
end;

procedure TWebModule1.searchHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  s, t, Text, word: string;
  i, j: integer;
  x, y, w, p, q: Boolean;
  com, temp: TStringList;
  bool: array of Boolean;
begin
  if (TagString = 'main') and (Request.MethodType = mtPost) then
  begin
    word := Request.ContentFields.Values['word1'];
    if Request.ContentFields.Values['filter'] = 'name' then
    begin
      maintable.Filter := 'NAME = ' + QuotedStr(word);
      maintable.Filtered := true;
      raw.Open;
      x := maintable.FindFirst;
      com := TStringList.Create;
      try
        while x = true do
        begin
          s := maintable.FieldByName('cmnumber').AsString;
          t := maintable.FieldByName('tbnumber').AsString;
          com.Text := raw.Lookup('id', maintable.FieldByName('id')
            .AsInteger, 'raw');
          Text := '<p stype=display:inline><a href=/user?db=' + t + '&job=' + s
            + ' target=_blank>[ ' + t + '-' + s + ' ]</a>';
          Text := Text + '<p id=title style=color:green;display:inline>' +
            maintable.FieldByName('title').AsString;
          for i := 0 to com.Count - 1 do
            Text := Text + '<p>' + com[i] + '</p>';
          ReplaceText := ReplaceText + '<hr>' + Text;
          x := maintable.FindNext;
        end;
      finally
        maintable.Filtered := false;
        raw.Close;
        com.Free;
      end;
    end
    else
    begin
      maintable.First;
      raw.Open;
      com := TStringList.Create;
      temp := TStringList.Create;
      try
        temp.DelimitedText := word;
        x := Request.ContentFields.Values['type'] = 'OR';
        SetLength(bool, temp.Count);
        while maintable.Eof = false do
        begin
          s := maintable.FieldByName('cmnumber').AsString;
          t := maintable.FieldByName('tbnumber').AsString;
          Text := '<p style=display:inline><a href=/user?db=' + t + '&job=' + s
            + ' target=_blank>[ ' + t + '-' + s + ' ]</a>';
          Text := Text + '<p style=color:green;display:inline>' +
            maintable.FieldByName('title').AsString;
          Text := Text + '<p style=color:blue;display:inline>' +
            maintable.FieldByName('name').AsString;
          com.Text := raw.Lookup('id', maintable.FieldByName('id')
            .AsInteger, 'raw');
          for j := 0 to High(bool) do
            bool[j] := false;
          q := false;
          for i := 0 to com.Count - 1 do
          begin
            s := com[i];
            p := false;
            for j := 0 to temp.Count - 1 do
              if Pos(temp[j], s) > 0 then
              begin
                if p = false then
                begin
                  if x = true then
                    Text := Text + '<p style=background:yellow>' + s
                  else
                    Text := Text + '<p style=background:aqua>' + s;
                  p := true;
                  q := true;
                end;
                bool[j] := true;
              end;
            if p = false then
              Text := Text + '<p>' + s;
          end;
          y := true;
          for w in bool do
            if w = false then
            begin
              y := false;
              break;
            end;
          if ((x = true) and (q = true)) or ((x = false) and (y = true)) then
            ReplaceText := ReplaceText + '<hr>' + Text;
          maintable.Next;
        end;
      finally
        com.Free;
        temp.Free;
        raw.Close;
        Finalize(bool);
      end;
    end;
  end;
end;

procedure TWebModule1.titleHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  i, j: integer;
  s: string;
begin
  temp.First;
  while temp.Eof = false do
  begin
    dbname.Locate('id', temp.FieldByName('dbid').AsInteger);
    j := dbname.FieldByName('tbnumber').AsInteger;
    full.ParamByName('param').AsInteger := j;
    full.Open;
    i := full.Fields[0].AsInteger;
    full.Close;
    if i = ini.Values['count'].ToInteger then
      s := ' style=color:red'
    else if i = 0 then
    begin
      temp.Next;
      continue;
    end
    else
      s := '';
    ReplaceText := ReplaceText + '<a href=/?db=' + j.ToString + s + '>' +
      dbname.FieldByName('dbname').AsString + '</a>↓<div>タイトル:' +
      maintable.Lookup('id', temp.FieldByName('first').AsInteger, 'title');
    ReplaceText := ReplaceText + '記事数:' + i.ToString + '更新日:' +
      DateToStr(temp.FieldByName('score').AsDateTime) + '</div>';
    temp.Next;
  end;
  temp.Close;
  clean.ExecSQL;
end;

procedure TWebModule1.WebModule1AdminHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  s: string;
  i, j, k, page: integer;
begin
  if (Request.MethodType = mtPost) and
    (Request.ContentFields.Values['setting'] = 'true') then
  begin
    ini.Values['password'] := Request.ContentFields.Values['pass'];
    if Request.ContentFields.Values['maintenance'] = 'on' then
      ini.Values['maintenance'] := 'on'
    else
      ini.Values['maintenance'] := 'off';
    ini.SaveToFile('setting.ini');
  end;
  if LoginCheck = false then
    Response.SendRedirect('/login')
  else
  begin
    FDQuery1.Close;
    k := Request.QueryFields.Values['db'].ToInteger;
    FDQuery1.ParamByName('param').AsInteger := k;
    FDQuery1.Open;
    j := ini.Values['count'].ToInteger;
    s := Request.QueryFields.Values['page'];
    if s <> '' then
    begin
      page := s.ToInteger;
      i := page - 1;
      full.ParamByName('param').AsInteger := k;
      full.Open;
      k := full.Fields[0].AsInteger;
      full.Close;
      if (i * j < k) and (page > 0) then
      begin
        FDQuery1.First;
        FDQuery1.MoveBy(i * j)
      end
      else
      begin
        Request.QueryFields.Delete(Request.QueryFields.IndexOfName('page'));
        FDQuery1.Last;
        FDQuery1.MoveBy(-j + 1);
      end;
    end
    else
    begin
      FDQuery1.Last;
      FDQuery1.MoveBy(-j + 1);
    end;
    Response.ContentType := 'text/html;charset=utf-8';
    Response.Content := admin.Content;
    FDQuery1.Close;
  end;
end;

procedure TWebModule1.WebModule1AlertHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  s, t, com, time: string;
  i, j, page: integer;
begin
  s := Request.QueryFields.Values['db'];
  t := Request.QueryFields.Values['page'];
  if (s <> '') and (t <> '') then
  begin
    page := t.ToInteger;
    Response.ContentType := 'text/html;charset=utf-8';
    if Request.MethodType = mtGet then
      Response.Content := alert.Content
    else
    begin
      if Request.ContentFields.Values['admit'] = 'ok' then
      begin
        j := maintable.Lookup('tbnumber;cmnumber',
          VarArrayOf([s.ToInteger, t.ToInteger]), 'id');
        alerttable.Open;
        alerttable.Last;
        if alerttable.Bof = true then
          i := 1
        else
          i := alerttable.FieldByName('id').AsInteger + 1;
        time := DateTimeToStr(Now);
        raw.Open;
        raw.Locate('id', i);
        com := '<p style=font-weight:bold>' + Request.ContentFields.Values
          ['com'] + '<p><a href=/user?db=' + s + '&job=' + t +
          ' style=text-decoration:none>[' + s + '-' + t + ']</a> ' +
          Copy(raw.FieldByName('raw').AsString, 1, 100) + ' ...<p>';
        raw.Close;
        alerttable.AppendRecord([i, com, time]);
        alerttable.Close;
      end;
      Response.SendRedirect(AnsiString('/user?db=' + s + '&job=' + t));
    end;
  end
  else
    Handled := false;
end;

procedure TWebModule1.WebModule1CssHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  s: string;
  i: integer;
  t, b: TStringList;
  rc: TResourceStream;
begin
  s := Request.QueryFields.Values['name'];
  t := TStringList.Create;
  b := TStringList.Create;
  try
    t.Add('top_css');
    t.Add('main_css');
    t.Add('livepreview_css');
    t.Add('normalize_css');
    t.Add('min');
    t.Add('main');
    t.Add('top');
    t.Add('sub');
    t.Add('modernizr');
    t.Add('ui_min');
    t.Add('ui_custom');
    t.Add('livepreview');
    i := t.IndexOf(s);
    if i > -1 then
    begin
      rc := TResourceStream.Create(HInstance, s, RT_RCDATA);
      if i < 4 then
        Response.ContentType := 'text/css'
      else
        Response.ContentType := 'text/javascript';
      b.LoadFromStream(rc);
      Response.Content := b.Text;
    end;
  finally
    rc.Free;
    t.Free;
    b.Free;
  end;
end;

procedure TWebModule1.WebModule1DeleteHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  s, t: string;
  i, j: integer;
begin
  t := Request.QueryFields.Values['db'];
  for i := 0 to Request.ContentFields.Count - 1 do
  begin
    if Request.ContentFields.Names[i] <> 'item' then
      continue;
    s := Request.ContentFields.ValueFromIndex[i];
    maintable.Locate('tbnumber;cmnumber',
      VarArrayOf([t.ToInteger, s.ToInteger]));
    j := maintable.FieldByName('id').AsInteger;
    maintable.Delete;
    raw.Open;
    raw.Locate('id', j);
    raw.Delete;
    raw.Close;
  end;
  s := Request.QueryFields.Values['page'];
  if s <> '' then
    Response.SendRedirect(AnsiString('/admin?db=' + t + '&page=' + s))
  else
    Response.SendRedirect('/admin?db=' + AnsiString(t));
end;

procedure TWebModule1.WebModule1HelpHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  i: integer;
  s: TStringList;
begin
  if Request.MethodType = mtPost then
  begin
    s := TStringList.Create;
    try
      s.Text := Request.ContentFields.Values['help'];
      for i := 0 to s.Count - 1 do
        s[i] := '<p>' + s[i];
      alerttable.Open;
      alerttable.Last;
      i := alerttable.FieldByName('id').AsInteger + 1;
      alerttable.AppendRecord([i, s.Text, DateTimeToStr(Now)]);
      alerttable.Close;
    finally
      s.Free;
    end;
  end;
  Response.ContentType := 'text/html;charset=utf-8';
  Response.Content := help.Content;
end;

procedure TWebModule1.WebModule1ImageHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  s: string;
begin
  s := Request.QueryFields.Values['name'];
  if s = 'splites' then
    Response.ContentType := 'image/png'
  else
    Response.ContentType := 'image/jpeg';
  Response.ContentStream := TResourceStream.Create(HInstance, s, RT_RCDATA);
  Response.SendResponse;
end;

procedure TWebModule1.WebModule1LoginHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  s: string;
  m5: TIdHashMessageDigest5;
begin
  if Request.MethodType = mtPost then
  begin
    if ini.Values['password'] = Request.ContentFields.Values['password'] then
    begin
      m5 := TIdHashMessageDigest5.Create;
      try
        s := m5.HashStringAsHex(ini.Values['password']);
      finally
        m5.Free;
      end;
      with Response.Cookies.Add do
      begin
        Domain := Request.Host;
        Expires := Now + 7;
        Path := '/';
        Secure := false;
        Name := 'password';
        Value := AnsiString(s);
      end;
      if dbname.Locate('dbname', Request.ContentFields.Values['dbname']) = true
      then
        Response.SendRedirect('/admin?db=' + dbname.FieldByName('tbnumber')
          .AsAnsiString)
      else
        Response.SendRedirect('/master');
      Exit;
    end;
  end;
  Response.ContentType := 'text/html;charset=utf-8';
  Response.Content := login.Content;
end;

procedure TWebModule1.WebModule1LogoutHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  with Response.Cookies.Add do
  begin
    Domain := Request.Host;
    Expires := Now - 1;
    Name := 'password';
    Path := '/';
    Secure := false;
  end;
  Response.SendRedirect('/?db=' + AnsiString(Request.QueryFields.Values['db']));
end;

procedure TWebModule1.WebModule1MasterHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  if LoginCheck = true then
  begin
    Response.ContentType := 'text/html;charset=utf-8';
    Response.Content := master.Content;
  end
  else
    Response.SendRedirect('/login');
end;

procedure TWebModule1.WebModule1NavHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  s, t, DB: string;
  i, j, k, page: integer;
begin
  if ini.Values['maintenance'] = 'on' then
  begin
    Response.ContentType := 'text/html;charset=utf-8';
    Response.Content := maintenance.Content;
    Exit;
  end;
  DB := Request.QueryFields.Values['db'];
  if DB = '' then
  begin
    Response.ContentType := 'text/html;charset=utf-8';
    Response.Content := PageProducer1.Content;
    Exit;
  end;
  s := Request.QueryFields.Values['key'];
  if s <> '' then
  begin
    FDQuery1.Close;
    t := FDQuery1.SQL.Text;
    FDQuery1.Open('select * from maintable where (tbnumber = ' + DB +
      ')and(cmnumber = ' + s + ');');
    if FDQuery1.RecordCount > 0 then
    begin
      Response.ContentType := 'text/html;charset=utf-8';
      Response.Content := key.Content;
    end;
    FDQuery1.Close;
    FDQuery1.SQL.Text := t;
    Exit;
  end;
  k := DB.ToInteger;
  FDQuery1.Close;
  FDQuery1.ParamByName('param').AsInteger := k;
  if dbname.Lookup('tbnumber', k, 'dbname') = ini.Values['info'] then
    FDQuery1.IndexFieldNames := 'cmnumber:D'
  else
    FDQuery1.IndexFieldNames := '';
  FDQuery1.Open;
  s := Request.QueryFields.Values['page'];
  if s <> '' then
  begin
    page := s.ToInteger;
    i := ini.Values['count'].ToInteger;
    if page = 0 then
    begin
      Response.SendRedirect('/?db=' + AnsiString(DB));
      Exit;
    end
    else
    begin
      j := page - 1;
      full.ParamByName('param').AsInteger := k;
      full.Open;
      if i * j < full.Fields[0].AsInteger then
        FDQuery1.MoveBy(i * j)
      else
      begin
        Response.SendRedirect('/?db=' + AnsiString(DB));
        full.Close;
        Exit;
      end;
      full.Close;
    end;
  end
  else
  begin
    page := 0;
    FDQuery1.Last;
    FDQuery1.MoveBy(-ini.Values['count'].ToInteger + 1);
  end;
  Response.ContentType := 'text/html;charset=utf-8';
  Response.Content := indexpage.Content;
end;

procedure TWebModule1.WebModule1RegistHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  na, sub, com, pass, Text: string;
  i, j, k, p: integer;
  s: TStringList;
  x: Boolean;
begin
  if Request.ContentFields.Values['aikotoba'] <> 'げんき' then
  begin
    Response.ContentType := 'text/plain;charset=utf-8';
    Response.Content := '合言葉を入力してください!';
    Exit;
  end;
  p := Request.QueryFields.Values['db'].ToInteger;
  com := Request.ContentFields.Values['comment'];
  na := Request.ContentFields.Values['name'];
  sub := Request.ContentFields.Values['title'];
  pass := Request.ContentFields.Values['password'];
  FDQuery1.Close;
  FDQuery1.ParamByName('param').AsInteger := p;
  FDQuery1.Open;
  if maintable.RecordCount = 0 then
    k := 1
  else
  begin
    maintable.Last;
    k := maintable.FieldByName('id').AsInteger + 1;
  end;
  if FDQuery1.RecordCount = 0 then
    j := 1
  else
  begin
    FDQuery1.Last;
    j := FDQuery1.FieldByName('cmnumber').AsInteger + 1;
  end;
  FDQuery1.Close;
  s := TStringList.Create;
  try
    s.Text := com;
    com := '';
    if CheckWords(s) = true then
    begin
      Text := '';
      for i := 0 to s.Count - 1 do
      begin
        com := s[i];
        if (Length(com) > 0) and (com[1] = ' ') then
          com := '&nbsp;' + Copy(com, 2, Length(com));
        Text := Text + LinkCreator(LinkCreator('<p>' + com + '<br>', 1), 2);
      end;
      if sub = '' then
        sub := 'タイトルなし.';
      if na = '' then
        na := '誰かさん';
      maintable.AppendRecord([k, p, j, na, sub, Text, DateTimeToStr(Now)]);
      raw.Open;
      raw.AppendRecord([k, s.Text, pass]);
      raw.Close;
      x := true;
    end
    else
      x := false;
    s.Clear;
    s.Add('name=' + na);
    s.Add('aikotoba=げんき');
    Response.SetCookieField(s, Request.Host, '/', Now + 7, false);
  finally
    s.Free;
  end;
  if x = true then
    Response.SendRedirect('/?db=' + AnsiString(Request.QueryFields.Values['db'])
      + '#bottom')
  else
  begin
    Response.ContentType := 'text/plain;charset=utf-8';
    Response.Content := '禁止語句を含めないでください.:' + ini.Values['tags'] + ';' +
      ini.Values['words'];
  end;
end;

procedure TWebModule1.WebModule1SearchHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.ContentType := 'text/html;charset=utf-8';
  Response.Content := search.Content
end;

procedure TWebModule1.WebModule1TitleHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  i, j, k, id: integer;
  s: TDateTime;
  t: string;
begin
  clean.ExecSQL;
  temp.Open;
  id := 1;
  dbname.First;
  while dbname.Eof = false do
  begin
    i := dbname.FieldByName('id').AsInteger;
    j := dbname.FieldByName('tbnumber').AsInteger;
    full.ParamByName('param').AsInteger := j;
    full.Open;
    k := full.Fields[0].AsInteger;
    full.Close;
    if k = 0 then
    begin
      dbname.Next;
      continue;
    end;
    FDQuery1.ParamByName('param').AsInteger := j;
    FDQuery1.Open;
    j := FDQuery1.FieldByName('id').AsInteger;
    FDQuery1.Last;
    k := FDQuery1.FieldByName('id').AsInteger;
    s := StrToDateTime(FDQuery1.FieldByName('datetime').AsString);
    t := FormatDateTime('yyyy/mm/dd', s);
    temp.AppendRecord([id, i, j, k, StrToDate(t)]);
    inc(id);
    FDQuery1.Close;
    dbname.Next;
  end;
  Response.ContentType := 'text/html;charset=utf-8';
  Response.Content := title.Content;
end;

procedure TWebModule1.WebModule1UserHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  num, pass, s, t, time: string;
  i, j, k: integer;
begin
  t := Request.QueryFields.Values['db'];
  if Request.MethodType = mtGet then
  begin
    num := Request.QueryFields.Values['job'];
    full.ParamByName('param').AsInteger := t.ToInteger;
    full.Open;
    i := full.Fields[0].AsInteger;
    full.Close;
    j := ini.Values['count'].ToInteger;
    if num <> '' then
    begin
      full.SQL.Text :=
        'select count(*) from maintable where cmnumber <= :param';
      full.ParamByName('param').AsInteger := num.ToInteger;
      full.Open;
      k := full.Fields[0].AsInteger;
      full.Close;
      if i - k < j then
        s := ''
      else
        s := '&page=' + (1 + k div j).ToString;
      Response.SendRedirect(AnsiString('/?db=' + t + s + '#' + num));
    end;
  end
  else
  begin
    num := Request.ContentFields.Values['number'];
    pass := Request.ContentFields.Values['password'];
    if maintable.Locate('tbnumber;cmnumber',
      VarArrayOf([t.ToInteger, num.ToInteger])) = true then
    begin
      i := maintable.FieldByName('id').AsInteger;
      raw.Open;
      if raw.Locate('id;password', VarArrayOf([i, pass])) = true then
      begin
        time := maintable.FieldByName('datetime').AsString;
        maintable.Delete;
        maintable.InsertRecord([i, t, num, nil, nil,
          '<p><i><b>投稿者により削除されました</b></i>', time]);
        raw.Edit;
        raw.FieldByName('raw').AsString := '';
        raw.Post;
      end;
      raw.Close;
    end;
    Response.SendRedirect(AnsiString('/user?db=' + t + '&job=' + num));
  end;
end;

procedure TWebModule1.WebModuleCreate(Sender: TObject);
var
  s: TResourceStream;
begin
  ini := TStringList.Create;
  if FileExists('setting.ini') = false then
  begin
    s := TResourceStream.Create(HInstance, 'setting', RT_RCDATA);
    try
      ini.LoadFromStream(s);
      ini.SaveToFile('setting.ini');
    finally
      s.Free;
    end;
  end
  else
    ini.LoadFromFile('setting.ini');
  if dbname.Exists = false then
  begin
    dbname.CreateTable(false);
    maintable.CreateTable(false);
    raw.CreateTable(false);
    alerttable.CreateTable(false);
    temp.CreateTable(false);
    FDScript1.ExecuteAll;
  end;
  PbbsConnection.Open;
  dbname.Open;
  maintable.Open;
end;

procedure TWebModule1.WebModuleDestroy(Sender: TObject);
begin
  ini.Free;
  dbname.Close;
  maintable.Close;
end;

end.
