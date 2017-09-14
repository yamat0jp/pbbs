unit WebModuleUnit1;

interface

uses System.SysUtils, System.Classes, Web.HTTPApp, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Web.HTTPProd, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Web.DBWeb, Web.DSProd, System.Types, RegularExpressions,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

type
  TWebModule1 = class(TWebModule)
    dbname: TFDTable;
    maintable: TFDTable;
    raw: TFDTable;
    PageProducer1: TPageProducer;
    DataSource1: TDataSource;
    dbnameTBNUMBER: TIntegerField;
    dbnameDBNAME: TStringField;
    maintableTITLE: TStringField;
    maintableNAME: TStringField;
    maintableCOMMENT: TWideMemoField;
    indexpage: TPageProducer;
    top: TPageProducer;
    PageProducer5: TPageProducer;
    main: TDataSetPageProducer;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    PbbsConnection: TFDConnection;
    maintableDATETIME: TStringField;
    rawRAW: TWideMemoField;
    rawPASSWORD: TStringField;
    maintableTBNUMBER: TIntegerField;
    maintableCMNUMBER: TIntegerField;
    rawCMNUMBER: TIntegerField;
    DataSource2: TDataSource;
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
    procedure mainHTMLTag(Sender: TObject; Tag: TTag; const TagString: string;
      TagParams: TStrings; var ReplaceText: string);
  private
    { private êÈåæ }
    ini: TStringList;
  public
    { public êÈåæ }
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

procedure TWebModule1.indexpageHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  i: Integer;
begin
  if TagString = 'main' then
  begin
    for i := 1 to ini.Values['Count'].ToInteger do
    begin
      if maintable.Bof = true then
        break;
      ReplaceText := main.Content + '<hr>' + ReplaceText;
      maintable.Prior;
    end;
  end
  else if TagString = 'title' then
    ReplaceText := ini.Values['title']
  else if TagString = 'title2' then
    ReplaceText := ini.Values['title2']
  else if TagString = 'tbnumber' then
    ReplaceText := dbname.FieldByName('tbnumber').AsString;
end;

procedure TWebModule1.mainHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  s: TStream;
  t: TStringList;
begin
  if TagString = 'com' then
  begin
    s := maintable.CreateBlobStream(maintable.FieldByName('comment'), bmRead);
    t := TStringList.Create;
    try
      t.LoadFromStream(s);
      ReplaceText := t.Text;
    finally
      s.Free;
      t.Free;
    end;
  end;
end;

procedure TWebModule1.PageProducer1HTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  i, j, k: Integer;
  s, t1, t2: string;
begin
  i := ini.Values['Count'].ToInteger;
  j := ini.Values['titlecount'].ToInteger;
  k := 1;
  s := '';
  dbname.First;
  while dbname.Eof = false do
  begin
    if k mod j = 1 then
      s := s + '<img src=slide' + ((k div j) + 1).ToString +
        '.jpg height=465 alt="" style=float:right>';
    inc(k);
    t1 := dbname.FieldByName('tbnumber').AsString;
    t2 := dbname.FieldByName('dbname').AsString;
    if maintable.RecordCount < i then
      s := s + '<p><a href=/?db=' + t1 + '>' + t2 + '</a>'
    else
      s := s + '<p style=color:red><a href=/?db=' + t1 + '>' + t2 + '</a>';
    dbname.Next;
  end;
  if TagString = 'main' then
    ReplaceText := s
  else if TagString = 'script' then
    ReplaceText := '<script src=' + TagParams.Values['src'] + '></script>'
  else if TagString = 'style' then
    ReplaceText := '<link rel=stylesheet href=' + TagParams.Values['href'] + '>'
  else if TagString = 'name' then
    ReplaceText := 'info';
end;

procedure TWebModule1.WebModule1AdminHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  s: string;
  i: Integer;
  rc: TResourceStream;
begin
  s := Request.QueryFields.Values['dbname'];
  if s <> '' then
    if dbname.Locate('dbname', s) = false then
    begin
      if (dbname.Bof = true) and (dbname.Eof = true) then
        i := 1
      else
      begin
        dbname.Last;
        i := dbname.FieldByName('tbnumber').AsInteger + 1;
      end;
      dbname.AppendRecord([i, s]);
      Response.SendRedirect('/');
    end
    else
    begin
      Response.ContentType := 'text/html;charset=utf-8';
      rc := TResourceStream.Create(HInstance, 'admin', RT_RCDATA);
      try
        Response.Content := indexpage.ContentFromStream(rc);
      finally
        rc.Free;
      end;
    end;
end;

procedure TWebModule1.WebModule1NavHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  s: string;
  i, j: Integer;
  rc: TResourceStream;
begin
  s := Request.QueryFields.Values['db'];
  if s = '' then
  begin
    Response.ContentType := 'text/html;charset=utf-8';
    rc := TResourceStream.Create(HInstance, 'top', RT_RCDATA);
    try
      Response.Content := PageProducer1.ContentFromStream(rc);
    finally
      rc.Free;
    end;
  end
  else if dbname.Locate('tbnumber', s) = true then
  begin
    s := Request.QueryFields.Values['key'];
    if (s <> '') and (maintable.Locate('cmnumber', s) = true) then
    begin
      Response.ContentType := 'text/plain';
      Response.Content := main.Content;
      Exit;
    end;
    s := Request.QueryFields.Values['page'];
    if s <> '' then
    begin
      i := ini.Values['count'].ToInteger;
      j := s.ToInteger;
      if i * j < maintable.RecordCount then
      begin
        maintable.First;
        maintable.MoveBy(i * j);
      end;
    end
    else
      maintable.Last;
    Response.ContentType := 'text/html;charset=utf-8';
    rc := TResourceStream.Create(HInstance, 'index', RT_RCDATA);
    try
      Response.Content := indexpage.ContentFromStream(rc);
    finally
      rc.Free;
    end;
  end
  else
    Response.SendRedirect('/');
end;

procedure TWebModule1.WebModule1RegistHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  na, sub, com, pass: string;
  i, j: Integer;
  s: TStringList;
  t: TMatch;
  s1, s2: string;
begin
  com := Request.ContentFields.Values['comment'];
  na := Request.ContentFields.Values['name'];
  sub := Request.ContentFields.Values['title'];
  pass := Request.ContentFields.Values['password'];
  i := Request.QueryFields.Values['db'].ToInteger;
  if (maintable.Bof = true) and (maintable.Eof = true) then
    j := 1
  else
  begin
    maintable.Last;
    j := maintable.FieldByName('cmnumber').AsInteger + 1;
  end;
  s := TStringList.Create;
  try
    s.Text := com;
    for i := 0 to s.Count - 1 do
    begin
      com := s[i];
      s2 := '<p>';
      t := TRegEx.Match(com, '>>[0-9]+');
      while t.Success = true do
      begin
        s1 := Copy(t.Value, 3, t.Length);
        s2 := s2 + Copy(com, 1, t.Index) +
          '<a class=minpreview data-preview-url=/?key=' + s1 +
          ' href=/user?job=' + s1 + '>>>' + s1 + '</a>';
        t := t.NextMatch;
      end;
      s[i] := s2 + Copy(com, t.Index + t.Length, Length(com));
    end;
    maintable.AppendRecord([i, j, sub, na, s.Text, DateTimeToStr(Now)]);
  finally
    s.Free;
  end;
  raw.Open;
  raw.AppendRecord([j, com, pass]);
  Response.SendRedirect('/?db=' + dbname.FieldByName('tbnumber').AsAnsiString);
end;

procedure TWebModule1.WebModule1UserHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  num, pass, s: string;
  i, j: Integer;
begin
  if Request.MethodType = mtGet then
  begin
    num := Request.QueryFields.Values['job'];
    i := maintable.RecordCount;
    j := ini.Values['count'].ToInteger;
    if num <> '' then
    begin
      if i - num.ToInteger < j then
        s := ''
      else
        s := '&page=' + (1 + i div j).ToString;
      Response.SendRedirect(AnsiString('/?db=' + dbname.FieldByName('tbnumber')
        .AsString + s + '#' + num));
    end;
  end
  else
  begin
    num := Request.ContentFields.Values['number'];
    pass := Request.ContentFields.Values['password'];
    if maintable.Locate('cmnumber', num) = true then
    begin
      raw.Open;
      if raw.FieldByName('password').AsString = pass then
        maintable.Delete;
    end;
  end;
end;

procedure TWebModule1.WebModuleCreate(Sender: TObject);
var
  s: TResourceStream;
begin
  ini := TStringList.Create;
  s := TResourceStream.Create(HInstance, 'setting', RT_RCDATA);
  try
    ini.LoadFromStream(s);
  finally
    s.Free;
  end;
end;

procedure TWebModule1.WebModuleDestroy(Sender: TObject);
begin
  ini.Free;
end;

end.
