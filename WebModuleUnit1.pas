unit WebModuleUnit1;

interface

uses System.SysUtils, System.Classes, Web.HTTPApp, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, Data.DB,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, Web.HTTPProd, Web.DSProd,
  AnsiStrings, System.DateUtils;

type
  TWebModule1 = class(TWebModule)
    FDTable1: TFDTable;
    FDConnection1: TFDConnection;
    FDTable2: TFDTable;
    FDTable2home: TWideMemoField;
    FDTable2title: TWideMemoField;
    FDTable2title2: TWideMemoField;
    FDTable2pass: TWideMemoField;
    PageProducer1: TPageProducer;
    DataSetPageProducer2: TDataSetPageProducer;
    FDTable1name: TWideMemoField;
    FDTable1no: TIntegerField;
    FDTable1date: TWideMemoField;
    FDTable1sub: TWideMemoField;
    FDTable1com: TWideMemoField;
    FDTable1pass: TWideMemoField;
    adminDS: TDataSetPageProducer;
    FDTable2ngwords: TWideMemoField;
    FDTable3: TFDTable;
    FDTable3link: TIntegerField;
    FDTable3count: TIntegerField;
    FDTable1line: TIntegerField;
    FDTable3line: TIntegerField;
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure PageProducer1HTMLTag(Sender: TObject; Tag: TTag;
      const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure WebModule1registAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure DataSetPageProducer2HTMLTag(Sender: TObject; Tag: TTag;
      const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure WebModule1userdelAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1adminAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1admindelAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1loginAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleBeforeDispatch(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1setupAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1searchAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleCreate(Sender: TObject);
    procedure WebModuleDestroy(Sender: TObject);
  private
    { private 宣言 }
  public
    { public 宣言 }
    user: string;
    time: Int64;
    words: TStringList;
    position: integer;
    foo: string;
    function footer(const path: string): string;
    function regist(var com: string): integer;
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

const
  path = '';// 'C:\Users\fuke masasi\Documents\Embarcadero\Studio\Projects\pbbs\';

procedure TWebModule1.DataSetPageProducer2HTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
begin
  ReplaceText := FDTable1.FieldByName(TagString).AsString;
end;

function TWebModule1.footer(const path: string): string;
var
  s1, s2, t1, t2: string;
  home: string;
  i, k, count: integer;
  function linkcontent: string;
  var
    j, link: integer;
  begin
    result := '';
    link := FDTable3.FieldByName('link').AsInteger;
    if position > link div 2 then
    begin
      if (FDTable1.RecordCount - 1) div count < position + link div 2 then
      begin
        i := FDTable1.RecordCount div count - link - position;
      end
      else
      begin
        i := -(link div 2);
      end;
    end
    else if position = -1 then
    begin
      i := -position + FDTable1.RecordCount div count - link;
    end
    else
    begin
      i := -position;
    end;
    for j := 0 to link do
    begin
      if FDTable1.RecordCount <= (position + i + j) * count then
        break;
      if position + i + j < 0 then
        continue;
      if i + j = 0 then
      begin
        result := result + '  ' + IntToStr(position + 1) + '  ';
      end
      else
      begin
        result := result + Format('  <a href="' + home + path +
          '?pos=%d">%d</a>  ', [position + i + j, position + 1 + i + j]);
      end;
    end;
  end;

begin
  count := FDTable3.FieldByName('count').AsInteger;
  if path = 'admin' then
  begin
    home := String(ReplaceText(FDTable2.FieldByName('home').AsAnsiString,
      'http', 'https'));
  end
  else
  begin
    home := FDTable2.FieldByName('home').AsString;
  end;
  if position <= -1 then
  begin
    s1 := '最新%d件の記事を表示<br><center>Pages : [<b>';
    s2 := '<<' + linkcontent + '>>]  最新</b><br></center>';
    result := Format(s1, [count]) + s2;
  end
  else
  begin
    if position = 0 then
    begin
      t1 := '?pos=0';
    end
    else
    begin
      t1 := '?pos=' + IntToStr(position - 1);
    end;
    i := (FDTable1.RecordCount - 1) div count;
    if position > i then
      position := i;
    if position = i then
    begin
      t2 := '?pos=' + IntToStr(position);
      k := FDTable1.RecordCount;
    end
    else
    begin
      t2 := '?pos=' + IntToStr(position + 1);
      k := (position + 1) * count;
    end;
    s1 := '%d 件中 %d 件から %d 件まで表示<br><center>Page : [<b>';
    s2 := '<a href="' + home + path + t1 + '"><<</a>' + linkcontent +
      '<a href="' + home + path + t2 + '">>></a>]  <a href="' + home + path +
      '">最新</a></b></center>';
    result := Format(s1, [FDTable1.RecordCount, position * count + 1, k]) + s2;
  end;
end;

procedure TWebModule1.PageProducer1HTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  i, j, count: integer;
  s: TDataSetPageProducer;
  t: string;
begin
  if TagString = 'home' then
  begin
    t := ExtractFileName(PageProducer1.HTMLFile);
    if (t = 'admin.htm') or (t = 'login.htm') then
    begin
      ReplaceText := String(AnsiReplaceText(FDTable2.FieldByName('home')
        .AsAnsiString, 'http', 'https'));
    end
    else
    begin
      ReplaceText := FDTable2.FieldByName('home').AsString;
    end;
  end;
  if (TagString = 'title') or (TagString = 'title2') then
    ReplaceText := FDTable2.FieldByName(TagString).AsString;
  if TagString = 'username' then
    ReplaceText := user;
  if TagString = 'main' then
  begin
    t := ExtractFileName(PageProducer1.HTMLFile);
    if FDTable1.RecordCount = 0 then
    begin
      if t = 'index.htm' then
        ReplaceText := 'まだ投稿がありません.';
    end
    else
    begin
      count := FDTable3.FieldByName('count').AsInteger;
      if t = 'admin.htm' then
      begin
        s := adminDS;
      end
      else
      begin
        s := DataSetPageProducer2;
      end;
      if position < -1 then
        position := -1;
      if (position + 1) * count > FDTable1.RecordCount then
        position := (FDTable1.RecordCount - 1) div count;
      if position = -1 then
      begin
        if FDTable1.RecordCount < count then
        begin
          j := FDTable1.RecordCount mod count;
        end
        else
        begin
          j := count;
        end;
      end
      else if FDTable1.RecordCount < (position + 1) * count then
      begin
        j := FDTable1.RecordCount - position * count;
      end
      else
      begin
        j := count;
      end;
      if position = -1 then
      begin
        FDTable1.Last;
      end
      else
      begin
        FDTable1.RecNo := (position + 1) * count;
      end;
      for i := 1 to j do
      begin
        ReplaceText := ReplaceText + s.Content;
        FDTable1.Prior;
      end;
    end;
  end;
  if TagString = 'footer' then
    if TagParams.Values['refer'] = 'true' then
    begin
      ReplaceText := foo;
    end
    else
    begin
      t := ExtractFileName(PageProducer1.HTMLFile);
      foo := footer(ChangeFileExt(t, ''));
      ReplaceText := foo;
    end;
  if TagString = 'text' then
    if FDTable1.Filtered = false then
    begin
      ReplaceText := '検索します';
    end
    else
    begin
      ReplaceText := '該当結果 ' + IntToStr(FDTable1.RecordCount) + ' 件' +
        '<br><#main>';
    end;
end;

function TWebModule1.regist(var com: string): integer;
var
  i: integer;
begin
  result := 1;
  i := 1;
  while True do
  begin
    i := Pos(#$D#$A, com, i);
    if i = 0 then
      break;
    Delete(com, i, Length(#$D#$A));
    Insert('<br>', com, i);
    inc(i, 4);
    inc(result);
  end;
end;

procedure TWebModule1.WebModule1adminAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  s: string;
  x: Boolean;
  procedure something;
  begin
    x := false;
    PageProducer1.HTMLFile := path + 'admin.htm';
    Response.ContentType := 'text/html; charset=utf-8;';
    Response.Content := PageProducer1.Content;
  end;

begin
  x := True;
  s := Request.ContentFields.Values['password'];
  position := StrToIntDef(Request.QueryFields.Values['pos'], -1);
  if s <> '' then
  begin
    with Response.Cookies.Add do
    begin
      path := FDTable2.FieldByName('home').AsAnsiString + 'admin';
      Expires := Now + 1;
      Name := 'psw';
      Value := AnsiString(s);
      Secure := True;
    end;
    if s = FDTable2.FieldByName('pass').AsString then
      something;
  end
  else if Request.CookieFields.Values['psw'] = FDTable2.FieldByName('pass').AsString
  then
    something;
  if x = True then
    Response.SendRedirect(FDTable2.FieldByName('home').AsAnsiString + 'login');
end;

procedure TWebModule1.WebModule1admindelAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  i: integer;
begin
  for i := 0 to Request.ContentFields.count - 1 do
    if FDTable1.Locate('no', Request.ContentFields.ValueFromIndex[i], []) = True
    then
      FDTable1.Delete;
  Response.SendRedirect(ReplaceText(FDTable2.FieldByName('home').AsAnsiString +
    'admin', 'http', 'https'));
end;

procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  position := StrToIntDef(Request.QueryFields.Values['pos'], -1);
  user := Request.CookieFields.Values['UID'];
  PageProducer1.HTMLFile := path + 'index.htm';
  Response.ContentType := 'text/html; charset=utf-8;';
  Response.Content := PageProducer1.Content;
end;

procedure TWebModule1.WebModule1loginAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  PageProducer1.HTMLFile := path + 'login.htm';
  Response.ContentType := 'text/html; charset=utf-8;';
  Response.Content := PageProducer1.Content;
end;

procedure TWebModule1.WebModule1registAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  na, sub, com, pass: string;
  no, line: integer;
  i: integer;
begin
  with Request.ContentFields do
  begin
    na := Values['name'];
    sub := Values['title'];
    com := Values['comment'];
    pass := Values['password'];
  end;
  if na = '' then
    na := '誰かさん';
  if sub = '' then
    sub := 'タイトルなし';
  if com = '' then
  begin
    Response.Content := '本文がありません.'#$D#$A;
  end
  else
  begin
    line := regist(com);
  end;
  for i := 0 to words.count - 1 do
    if ContainsText(AnsiString(com), AnsiString(words[i])) = True then
    begin
      Response.Content := Response.Content + '禁止語句が含まれます.';
      break;
    end;
  if FDTable1.RecordCount = 0 then
  begin
    no := 1;
  end
  else
  begin
    FDTable1.Last;
    no := FDTable1.FieldByName('no').AsInteger + 1;
    if SecondsBetween(Now, StrToDateTime(FDTable1.FieldByName('date').AsString))
      < time then
      Response.Content := '混み合っています.';
  end;
  if Response.Content <> '' then
  begin
    Response.ContentType := 'text/plain;';
    Exit;
  end;
  FDTable1.AppendRecord([na, no, DateTimeToStr(Now), sub, com, pass, line]);
  with Response.Cookies.Add do
  begin
    path := FDTable2.FieldByName('home').AsAnsiString;
    Name := 'UID';
    Value := AnsiString(na);
    Expires := Now + 1;
  end;
  Response.SendRedirect(FDTable2.FieldByName('home').AsAnsiString);
end;

procedure TWebModule1.WebModule1searchAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  s: TStringList;
  t1, t2, t3: string;
  i, j: integer;
begin
  t1 := Request.ContentFields.Values['filter'];
  t3 := '';
  s := TStringList.Create;
  try
    s.DelimitedText := Request.ContentFields.Values['word1'];
    for i := 0 to s.count - 1 do
    begin
      t2 := Trim(s[i]);
      if t2 = '' then
        continue;
      if t3 <> '' then
        t3 := t3 + ' and ';
      t3 := t3 + t1 + ' LIKE ''%' + t2 + '%''';
    end;
  finally
    s.Free;
  end;
  if t3 = '' then
  begin
    PageProducer1.HTMLFile:=path+'search.htm';
    Response.ContentType:='text/html; charset=utf-8;';
    Response.Content:=PageProducer1.Content;
    Exit;
  end;
  FDTable1.Filter := t3;
  FDTable1.Filtered := True;
  try
    j := 0;
    for i := 1 to FDTable1.RecordCount - 1 do
    begin
      inc(j, FDTable1.FieldByName('line').AsInteger);
      FDTable1.Next;
    end;
    PageProducer1.HTMLFile := path + 'search.htm';
    Response.ContentType := 'text/html; charset=utf-8;';
    if (t3 <> '') and (j > FDTable3.FieldByName('line').AsInteger) then
    begin
      t1 := PageProducer1.Content;
      i := Pos('<#main>', t1);
      Delete(t1, i, Length('<#main>'));
      Response.Content := t1 + Format('表示行数が%d行を超えています.',
        [FDTable3.FieldByName('line').AsInteger]);
    end
    else
    begin
      Response.Content := PageProducer1.ContentFromString(PageProducer1.Content);
    end;
  finally
    FDTable1.Filtered:=false;
  end;
end;

procedure TWebModule1.WebModule1setupAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  i: integer;
  s: string;
begin
  for i := 0 to Request.ContentFields.count - 1 do
  begin
    s := Request.ContentFields.Names[i];
    if s <> 'home' then
      FDTable2.FieldByName(s).AsString :=
        Request.ContentFields.ValueFromIndex[i];
  end;
  Handled := false;
end;

procedure TWebModule1.WebModule1userdelAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  s: string;
  i: integer;
begin
  i := StrToIntDef(Request.ContentFields.Values['number'], 0);
  if (i > 0) and (FDTable1.Locate('no', i, []) = True) then
  begin
    s := FDTable1.FieldByName('pass').AsString;
    if (s <> '') and (s = Request.ContentFields.Values['password']) then
      FDTable1.Delete;
  end;
  Handled := false;
end;

procedure TWebModule1.WebModuleBeforeDispatch(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  s: string;
begin
  if FDTable1.Exists = false then
    FDTable1.CreateTable(false, [tpTable]);
  if FDTable2.Exists = false then
  begin
    FDTable2.CreateTable(false, [tpTable]);
    FDTable2.Active := True;
    if (Request.ServerPort = 80) or (Request.ServerPort = 443) then
    begin
      s := 'http://' + String(Request.Host);
    end
    else
    begin
      s := 'http://' + String(Request.Host) + ':' +
        IntToStr(Request.ServerPort);
    end;
    if Request.ScriptName <> '' then
    begin
      s := s + String(Request.ScriptName) + '/';
    end
    else
    begin
      s := s + '/';
    end;
    FDTable2.AppendRecord([s, 'pbbs clone',
      '<center><font size=5 face=Verdana color=gray><b>P-BBS CLONE</b></font></center>',
      'admin', 'あほ,ばか,死ね']);
    PageProducer1.HTMLFile := path + 'setup.htm';
    Response.ContentType := 'text/html; charset=utf-8;';
    Response.Content := PageProducer1.Content;
    Handled := True;
  end
  else
  begin
    FDTable2.Active := True;
  end;
  if FDTable3.Exists = false then
  begin
    FDTable3.CreateTable(false, [tpTable]);
    FDTable3.Active := True;
    FDTable3.AppendRecord([5, 20, 500]);
  end
  else
  begin
    FDTable3.Active := True;
  end;
  words.DelimitedText := FDTable2.FieldByName('ngwords').AsString;
  FDTable1.Active := True;
  if FileExists(path + 'maintenance.htm') = True then
  begin
    PageProducer1.HTMLFile := path + 'maintenance.htm';
    Response.ContentType := 'text/html; charset=utf-8;';
    Response.Content := PageProducer1.Content;
    Handled := True;
  end;
end;

procedure TWebModule1.WebModuleCreate(Sender: TObject);
begin
  time := 1;
  words := TStringList.Create;
end;

procedure TWebModule1.WebModuleDestroy(Sender: TObject);
begin
  words.Free;
end;

end.
