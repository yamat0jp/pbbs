unit WebModuleUnit1;

interface

uses System.SysUtils, System.Classes, Web.HTTPApp, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Web.HTTPProd, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Web.DBWeb, Web.DSProd, System.Types, RegularExpressions,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, System.Variants;

type
  TWebModule1 = class(TWebModule)
    dbname: TFDTable;
    maintable: TFDTable;
    raw: TFDTable;
    PageProducer1: TPageProducer;
    indexpage: TPageProducer;
    admin: TPageProducer;
    main: TDataSetPageProducer;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    PbbsConnection: TFDConnection;
    FDQuery1: TFDQuery;
    full: TFDQuery;
    maintableID: TIntegerField;
    maintableTBNUMBER: TIntegerField;
    maintableCMNUMBER: TIntegerField;
    maintableNAME: TStringField;
    maintableTITLE: TStringField;
    maintableCOMMENT: TStringField;
    maintableDATETIME: TStringField;
    dbnameID: TIntegerField;
    dbnameTBNUMBER: TIntegerField;
    dbnameDBNAME: TStringField;
    rawID: TIntegerField;
    rawTBNUMBER: TIntegerField;
    rawCMNUMBER: TIntegerField;
    rawRAW: TStringField;
    rawPASSWORD: TStringField;
    admain: TDataSetPageProducer;
    search: TPageProducer;
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
    procedure adminHTMLTag(Sender: TObject; Tag: TTag; const TagString: string;
      TagParams: TStrings; var ReplaceText: string);
    procedure WebModule1DeleteHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1SearchHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure searchHTMLTag(Sender: TObject; Tag: TTag; const TagString: string;
      TagParams: TStrings; var ReplaceText: string);
    procedure WebModule1CssHandlerAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
  private
    { private 宣言 }
    ini: TStringList;
    Tag: Variant;
  public
    { public 宣言 }
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

procedure TWebModule1.adminHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  i: Integer;
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
    ReplaceText := Self.Tag;
end;

procedure TWebModule1.indexpageHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  i: Integer;
begin
  if TagString = 'main' then
  begin
    for i := 1 to ini.Values['Count'].ToInteger do
    begin
      if FDQuery1.Eof = true then
        break;
      ReplaceText := ReplaceText + '<hr>' + main.Content;
      FDQuery1.Next;
    end;
  end
  else if TagString = 'title' then
    ReplaceText := ini.Values['title']
  else if TagString = 'title2' then
    ReplaceText := ini.Values['title2']
  else if TagString = 'tbnumber' then
    ReplaceText := Self.Tag;
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
      s := s + '<div class=slide><img src=slide' + ((k div j) + 1).ToString +
        '.jpg height=465 alt="" style=float:right>';
    inc(k);
    t1 := dbname.FieldByName('tbnumber').AsString;
    t2 := dbname.FieldByName('dbname').AsString;
    full.ParamByName('param').AsString := t1;
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
  if TagString = 'main' then
    ReplaceText := s
  else if TagString = 'script' then
    ReplaceText := '<script src=' + TagParams.Values['src'] + '></script>'
  else if TagString = 'style' then
    ReplaceText := '<link rel=stylesheet href=' + TagParams.Values['href'] + '>'
  else if TagString = 'name' then
    ReplaceText := 'info';
end;

procedure TWebModule1.searchHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  s, t, text, word: string;
  i: Integer;
  x: Boolean;
  com: TStringList;
begin
  if TagString = 'main' then
  begin
    word := Request.ContentFields.Values['word1'];
    if Request.ContentFields.Values['filter'] = 'name' then
    begin
      maintable.Filter := 'NAME = ' + QuotedStr(word);
      maintable.Filtered := true;
      raw.Open;
      com := TStringList.Create;
      try
        if maintable.FindFirst = true then
          repeat
            s := maintable.FieldByName('cmnumber').AsString;
            t := maintable.FieldByName('tbnumber').AsString;
            com.text := raw.Lookup('tbnumber;cmnumber',
              VarArrayOf([t, s]), 'raw');
            text := '<p><a href=/user?db=' + t + '&job=' + s + ' target=_blank>'
              + s + '</a>';
            text := text + '<p style=color:green>' + maintable.FieldByName
              ('title').AsString;
            for i := 0 to com.Count - 1 do
              text := text + '<p>' + com[i] + '</P>';
            ReplaceText := ReplaceText + '<hr' + text;
          until maintable.FindNext = false;
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
      try
        while maintable.Eof = false do
        begin
          s := maintable.FieldByName('cmnumber').AsString;
          t := maintable.FieldByName('tbnumber').AsString;
          text := '<p><a href=/user?db=' + t + '&job=' + s + ' target=_blank>' +
            s + '</a>';
          text := text + '<p style=color:green>' + maintable.FieldByName
            ('title').AsString;
          text := text + '<p style=color:blue>' + maintable.FieldByName
            ('name').AsString;
          com.text := raw.Lookup('tbnumber;cmnumber',
            VarArrayOf([t, s]), 'raw');
          x := false;
          for i := 0 to com.Count - 1 do
          begin
            s := com[i];
            if Pos(word, s) > 0 then
            begin
              text := text + '<p style=background:yellow>' + s + '</p>';
              if x = false then
                x := true;
            end
            else
              text := text + '<p>' + s + '</p>';
          end;
          if x = true then
            ReplaceText := ReplaceText + '<hr>' + text;
          maintable.Next;
        end;
      finally
        com.Free;
        raw.Close;
      end;
    end;
  end;
end;

procedure TWebModule1.WebModule1AdminHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  s: string;
  i, j: Integer;
begin
  s := Request.QueryFields.Values['dbname'];
  if s <> '' then
  begin
    if dbname.Locate('dbname', s) = false then
    begin
      if (dbname.Bof = true) and (dbname.Eof = true) then
      begin
        i := 1;
        j := 1;
      end
      else
      begin
        dbname.Last;
        i := dbname.FieldByName('tbnumber').AsInteger + 1;
        j := dbname.FieldByName('id').AsInteger + 1;
      end;
      dbname.AppendRecord([j, i, s]);
      Response.SendRedirect('/');
    end;
  end
  else if true or (ini.Values['password'] = Request.ContentFields.Values
    ['password']) then
  begin
    Tag := Request.QueryFields.Values['db'];
    FDQuery1.ParamByName('param').AsString := Tag;
    FDQuery1.Open;
    Response.ContentType := 'text/html;charset=utf-8';
    Response.Content := admin.Content;
    FDQuery1.Close;
  end;
end;

procedure TWebModule1.WebModule1CssHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  s: string;
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
    t.Add('top');
    t.Add('sub');
    t.Add('modernizr');
    t.Add('ui_min');
    t.Add('ui_custom');
    t.Add('livepreview');
    if t.IndexOf(s) > -1 then
    begin
      rc := TResourceStream.Create(HInstance, s, RT_RCDATA);
      Response.ContentType := 'text/plain';
      b.LoadFromStream(rc);
      Response.Content := b.text;
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
  s: string;
  i: Integer;
begin
  Tag := Request.QueryFields.Values['db'];
  for i := 0 to Request.ContentFields.Count - 1 do
  begin
    s := Request.ContentFields.ValueFromIndex[i];
    maintable.Locate('tbnumber;cmnumber', VarArrayOf([Tag, s]));
    maintable.Delete;
    raw.Open;
    raw.Locate('cmnumber', s);
    raw.Delete;
    raw.Close;
  end;
  Response.SendRedirect('/admin?db=' + AnsiString(Tag));
end;

procedure TWebModule1.WebModule1LoginHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Tag := Request.QueryFields.Values['db'];
  Response.ContentType := 'text/html;charset=utf-8';
  Response.Content := admin.Content;
end;

procedure TWebModule1.WebModule1NavHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  s, DB: string;
  i, j: Integer;
begin
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
    FDQuery1.Open('select * from maintable where (tbnumber = ' + DB +
      ')and(cmnumber = ' + s + ');');
    Response.ContentType := 'text/html;charset=utf-8';
    Response.Content := main.Content;
    Exit;
  end;
  FDQuery1.ParamByName('param').AsString := DB;
  FDQuery1.Open;
  s := Request.QueryFields.Values['page'];
  if s <> '' then
  begin
    i := ini.Values['count'].ToInteger;
    j := s.ToInteger;
    if i * j < FDQuery1.RecordCount then
    begin
      FDQuery1.First;
      FDQuery1.MoveBy(i * j);
    end;
  end
  else
    FDQuery1.First;
  Tag := DB;
  Response.ContentType := 'text/html;charset=utf-8';
  Response.Content := indexpage.Content;
end;

procedure TWebModule1.WebModule1RegistHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  na, sub, com, pass: string;
  i, j, k, ep: Integer;
  s: TStringList;
  t: TMatch;
  s1, s2, text: string;
  d: Variant;
begin
  d := Request.QueryFields.Values['db'];
  com := Request.ContentFields.Values['comment'];
  na := Request.ContentFields.Values['name'];
  sub := Request.ContentFields.Values['title'];
  pass := Request.ContentFields.Values['password'];
  FDQuery1.ParamByName('param').AsInteger := d;
  FDQuery1.Open;
  if (FDQuery1.Bof = true) and (FDQuery1.Eof = true) then
  begin
    j := 1;
    k := 1;
  end
  else
  begin
    FDQuery1.Last;
    maintable.Last;
    j := FDQuery1.FieldByName('cmnumber').AsInteger + 1;
    k := maintable.FieldByName('id').AsInteger + 1;
  end;
  FDQuery1.Close;
  s := TStringList.Create;
  try
    s.text := com;
    for i := 0 to s.Count - 1 do
    begin
      com := s[i];
      if (Length(com) > 0) and (com[1] = ' ') then
        com := '&nbsp;' + Copy(com, 2, Length(com));
      s2 := '<p>';
      ep := 1;
      t := TRegEx.Match(com, '>>[0-9]+');
      while t.Success = true do
      begin
        s1 := Copy(t.Value, 3, t.Length);
        s2 := s2 + Copy(com, ep, t.Index - ep) +
          '<a class=minpreview data-preview-url=/?db=' + d + '&key=' + s1 +
          ' href=/user?db=' + d + '&job=' + s1 + '>>>' + s1 + '</a>';
        ep := t.Index + t.Length;
        t := t.NextMatch;
      end;
      text := text + s2 + Copy(com, ep, Length(com));
    end;
    if sub = '' then
      sub := 'タイトルなし.';
    if na = '' then
      na := '誰かさん';
    maintable.AppendRecord([k, d, j, sub, na, text, DateTimeToStr(Now)]);
    raw.Open;
    raw.AppendRecord([k, d, j, s.text, pass]);
    raw.Close;
  finally
    s.Free;
  end;
  Response.SendRedirect('/?db=' + AnsiString(d) + '#bottom');
end;

procedure TWebModule1.WebModule1SearchHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  rc: TResourceStream;
begin
  rc := TResourceStream.Create(HInstance, 'search', RT_RCDATA);
  try
    Response.ContentType := 'text/html;charset=utf-8';
    Response.Content := search.ContentFromStream(rc);
  finally
    rc.Free;
  end;
end;

procedure TWebModule1.WebModule1UserHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  num, pass, s, t, time: string;
  i, j: Integer;
begin
  t := Request.QueryFields.Values['db'];
  if Request.MethodType = mtGet then
  begin
    num := Request.QueryFields.Values['job'];
    full.ParamByName('param').AsString := t;
    full.Open;
    i := full.Fields[0].AsInteger;
    full.Close;
    j := ini.Values['count'].ToInteger;
    if num <> '' then
    begin
      if i - num.ToInteger < j then
        s := ''
      else
        s := '&page=' + (1 + i div j).ToString;
      Response.SendRedirect(AnsiString('/?db=' + t + s + '#' + num));
    end;
  end
  else
  begin
    num := Request.ContentFields.Values['number'];
    pass := Request.ContentFields.Values['password'];
    if maintable.Locate('tbnumber;cmnumber', VarArrayOf([t, num])) = true then
    begin
      raw.Open;
      if raw.Locate('tbnumber;cmnumber;password', VarArrayOf([t, num, pass])) = true
      then
      begin
        i := maintable.FieldByName('id').AsInteger;
        time := maintable.FieldByName('datetime').AsString;
        maintable.Delete;
        maintable.InsertRecord([i, t, num, nil, nil,
          '<p><i><b>投稿者により削除されました</b></i>', time]);
        raw.Edit;
        raw.FieldByName('raw').AsString := '';
        raw.Post;
      end;
    end;
    Response.SendRedirect(AnsiString('/?db=' + t + '&job=' + num));
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
