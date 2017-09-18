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
    footer: TPageProducer;
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
    procedure WebModule1ImageHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure footerHTMLTag(Sender: TObject; Tag: TTag; const TagString: string;
      TagParams: TStrings; var ReplaceText: string);
  private
    { private 宣言 }
    ini: TStringList;
    Tag, page: integer;
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
  i: integer;
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
    ReplaceText := Self.Tag.ToString;
end;

procedure TWebModule1.footerHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  s, t: string;
  i, j: integer;
begin
  if TagParams.Values['admin'] = 'true' then
    s := '/admin?db='
  else
    s := '/?db=';
  s := s + Self.Tag.ToString + '&page=';
  ReplaceText := '<div style=text-align:center><b>[</b>';
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
    t := '<a href=' + s + i.ToString + '><<</a>';
    for j := 1 to 10 do
      if page = j then
        t := t + page.ToString
      else
        t := t + ' <a href=' + s + j.ToString + '>' + j.ToString + '</a> ';
    i := page + 1;
    t := t + '<a href=' + s + i.ToString + '>>></a> <b>]</b>  <a href=' + s +
      '0>recent</a></div>';
  end;
  ReplaceText := ReplaceText + t;
end;

procedure TWebModule1.indexpageHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  i: integer;
begin
  if TagString = 'main' then
  begin
    for i := 1 to ini.Values['count'].ToInteger do
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
    ReplaceText := Self.Tag.ToString
  else if TagString = 'footer' then
    ReplaceText := footer.ContentFromString('<#list admin=false>');
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
    ReplaceText := s;
  end
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
  s, t, Text, word: string;
  i: integer;
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
      x := maintable.FindFirst;
      com := TStringList.Create;
      try
        while x = true do
        begin
          s := maintable.FieldByName('cmnumber').AsString;
          t := maintable.FieldByName('tbnumber').AsString;
          com.Text := raw.Lookup('tbnumber;cmnumber',
            VarArrayOf([t, s]), 'raw');
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
      try
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
          com.Text := raw.Lookup('tbnumber;cmnumber',
            VarArrayOf([t, s]), 'raw');
          x := false;
          for i := 0 to com.Count - 1 do
          begin
            s := com[i];
            if Pos(word, s) > 0 then
            begin
              Text := Text + '<p style=background:yellow>' + s + '</p>';
              if x = false then
                x := true;
            end
            else
              Text := Text + '<p>' + s + '</p>';
          end;
          if x = true then
            ReplaceText := ReplaceText + '<hr>' + Text;
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
  i, j: integer;
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
  else if false or (ini.Values['password'] = Request.ContentFields.Values
    ['password']) then
    Response.SendRedirect('/login?db=' + AnsiString(Tag.ToString))
  else
  begin
    Tag := Request.QueryFields.Values['db'].ToInteger;
    FDQuery1.ParamByName('param').AsInteger := Tag;
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
  s: string;
  i: integer;
begin
  Tag := Request.QueryFields.Values['db'].ToInteger;
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
  Response.SendRedirect('/admin?db=' + AnsiString(Tag.ToString));
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
begin
  Tag := Request.QueryFields.Values['db'].ToInteger;
  Response.ContentType := 'text/html;charset=utf-8';
  Response.Content := admin.Content;
end;

procedure TWebModule1.WebModule1NavHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  s, DB: string;
  i, j: integer;
begin
  DB := Request.QueryFields.Values['db'];
  if DB = '' then
  begin
    Response.ContentType := 'text/html;charset=utf-8';
    Response.Content := PageProducer1.Content;
    Exit;
  end;
  Tag := DB.ToInteger;
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
    page := s.ToInteger;
    i := ini.Values['count'].ToInteger;
    if page = 0 then
      Response.SendRedirect('/?db=' + AnsiString(DB))
    else
    begin
      j := page - 1;
      if i * j < FDQuery1.RecordCount then
      begin
        FDQuery1.First;
        FDQuery1.MoveBy(i * j);
        Tag := DB.ToInteger;
      end
      else
        Response.SendRedirect('/?db=' + AnsiString(DB));
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
  na, sub, com, pass: string;
  i, j, k, ep: integer;
  s: TStringList;
  t: TMatch;
  s1, s2, Text: string;
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
    s.Text := com;
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
      Text := Text + s2 + Copy(com, ep, Length(com));
    end;
    if sub = '' then
      sub := 'タイトルなし.';
    if na = '' then
      na := '誰かさん';
    maintable.AppendRecord([k, d, j, sub, na, Text, DateTimeToStr(Now)]);
    raw.Open;
    raw.AppendRecord([k, d, j, s.Text, pass]);
    raw.Close;
  finally
    s.Free;
  end;
  Response.SendRedirect('/?db=' + AnsiString(d) + '#bottom');
end;

procedure TWebModule1.WebModule1SearchHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.ContentType := 'text/html;charset=utf-8';
  Response.Content := search.Content
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
    full.ParamByName('param').AsString := t;
    full.Open;
    i := full.Fields[0].AsInteger;
    full.Close;
    j := ini.Values['count'].ToInteger;
    if num <> '' then
    begin
      k := num.ToInteger;
      if i - k < j then
        s := ''
      else
        s := '&page=' + (1 + (k - 1) div j).ToString;
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
