unit WebModuleUnit1;

interface

uses System.SysUtils, System.Classes, Web.HTTPApp, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Web.HTTPProd,
  Web.DBWeb, FireDAC.Stan.ExprFuncs, IniFiles, FireDAC.Phys.IB,
  FireDAC.Phys.IBDef, System.AnsiStrings, System.NetEncoding, System.Variants,
  Web.DSProd, FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.Phys.IBLiteDef, FireDAC.Phys.FB, FireDAC.Phys.FBDef, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, REST.Types,
  REST.Response.Adapter, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope,
  REST.Authenticator.OAuth, FireDAC.Comp.UI,
  FireDAC.ConsoleUI.Wait, REST.Authenticator.OAuth.WebForm.Win, Web.Stencils,
  System.JSON;

type
  TFindState = (fdShort, fdNormal, fdNone);

  TPageSearch = class
  private
    FWordList, FBlindStr: string;
    FList, FResultLST: TStringList;
    FStBuild: TStringBuilder;
    function checkState(var st: integer; var bool: Boolean; word, line: string)
      : TFindState;
    procedure processNormal(var id: integer; word, line: string);
    procedure processShort(var id, ln: integer; var bool: Boolean; word: string;
      var line: string);
    procedure initWordList;
    procedure SetWordList(const Value: string);
  public
    constructor Create;
    destructor Destroy; override;
    function Execute(const Text: string): string; virtual;
    property WordList: string read FWordList write SetWordList;
  end;

  TWebModule1 = class(TWebModule)
    FDConnection1: TFDConnection;
    mentenance: TPageProducer;
    WebFileDispatcher1: TWebFileDispatcher;
    FDQuery1: TFDQuery;
    master: TPageProducer;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    WebStencilsProcessor1: TWebStencilsProcessor;
    WebStencilsProcessor2: TWebStencilsProcessor;
    WebStencilsProcessor3: TWebStencilsProcessor;
    WebStencilsProcessor4: TWebStencilsProcessor;
    WebStencilsProcessor5: TWebStencilsProcessor;
    WebStencilsEngine1: TWebStencilsEngine;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    WebStencilsProcessor6: TWebStencilsProcessor;
    WebStencilsProcessor7: TWebStencilsProcessor;
    FDQuery2: TFDQuery;
    WebStencilsProcessor8: TWebStencilsProcessor;
    procedure WebModuleCreate(Sender: TObject);
    procedure WebModule1alertAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleBeforeDispatch(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1helpAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1renameAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleDestroy(Sender: TObject);
    procedure WebModule1searchItemAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1mainItemAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1adminPageAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1showTopAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1membersAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure FDQuery1FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure WebStencilsProcessor5Value(Sender: TObject; const AObjectName,
      APropName: string; var AValue: string; var AHandled: Boolean);
    procedure WebStencilsProcessor6Value(Sender: TObject; const AObjectName,
      APropName: string; var AValue: string; var AHandled: Boolean);
    procedure WebModule1linkItemAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1masterAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
  private
    { private 宣言 }
    count: integer;
    pagecount: integer;
    mente: Boolean;
    commentoff: Boolean;
    mysearch: TPageSearch;
    bglist: TStringList;
    function readComment(const Text: string; st, cnt: integer): string;
    function makeComment(const Text: string; cnt: integer = -1): string;
    function makeFooter(script: string; db, id: integer): TJSONObject;
    function replaceRawData(Data: string): string;
    procedure PageIndex(AQuery: TFDQuery; page: integer);
  public
    { public 宣言 }
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

uses System.Generics.Collections;

const
  fname = 'data/voice.txt';
  nobody = 'no name';

procedure TWebModule1.FDQuery1FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  for var i := 0 to Request.ContentFields.Count-1 do
    Accept := Request.ContentFields.Names[i] = 'check';
end;

function TWebModule1.makeComment(const Text: string; cnt: integer = -1): string;
var
  s, t: string;
  ls: TStringList;
begin
  ls := TStringList.Create;
  try
    ls.Text := Text;
    if cnt = -1 then
      cnt := ls.count;
    for var i := 0 to cnt - 1 do
    begin
      s := ls[i];
      t := '';
      if s = '' then
        s := '<br>'
      else
        for var j := 1 to Length(s) do
          if s[j] = ' ' then
            t := t + '&nbsp;'
          else
          begin
            s := t + Copy(s, j - 1, Length(s));
            break;
          end;
      ls[i] := '<p>' + s + '</p>';
    end;
    if cnt < ls.count then
    begin
      ls.Insert(cnt, '<pre><code>');
      ls.Add('</code></pre>');
    end;
    result := ls.Text;
  finally
    ls.Free;
  end;
end;

function TWebModule1.makeFooter(script: string; db, id: integer): TJSONObject;
var
  js, jsItem: TJSONObject;
  jaItem: TJSONArray;
  num: integer;
begin
  FDQuery1.Open('select * from datatable;');
  if not FDQuery1.Locate('dbnumber,tablenum',VarArrayOf([db,id])) then
    Exit(nil);
  num:=FDQuery1.RecordCount div count +1;
  js:=TJSONObject.Create;
  js.AddPair('path',Format('/%s/%d',[script,db]));
  js.AddPair('count',TJSONNumber.Create(num));
  jaItem:=TJSONArray.Create;
  js.AddPair('items',jaItem);
  for var i := 1 to pagecount do
  begin
    jsItem:=TJSONObject.Create;
    js.AddPair('index',TJSONNumber.Create(id));
    jaItem.AddElement(jsItem);
  end;
  result := js;
end;

procedure TWebModule1.PageIndex(AQuery: TFDQuery; page: integer);
begin
  AQuery.Open('select count(*) as cnt from maintable;');
  if (page = 0) or ((page - 1) * count >= AQuery.FieldByName('cnt').AsInteger) then
  begin
    AQuery.Last;
    AQuery.MoveBy(-count + 1);
  end
  else
  begin
    AQuery.First;
    AQuery.MoveBy((page - 1) * count);
  end;
end;

function TWebModule1.readComment(const Text: string; st, cnt: integer): string;
var
  ls1, ls2: TStringList;
  num: integer;
begin
  if (st = -1) or (Text = '') then
    Exit('');
  ls1 := TStringList.Create;
  ls2 := TStringList.Create;
  try
    ls1.Text := Text;
    if cnt = -1 then
      num := ls1.count - 1
    else
      num := st + cnt - 1;
    for var i := st to num do
      ls2.Add(ls1[i]);
    result := ls2.Text;
  finally
    ls1.Free;
    ls2.Free;
  end;
end;

function TWebModule1.replaceRawData(Data: string): string;
const
  ng = '死ね,阿保,馬鹿,殺す,爆破';
var
  s: string;
begin
  result := Data;
  for s in ng.Split([',']) do
    result.Replace(s,'*****');
end;

procedure TWebModule1.WebModule1adminPageAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  DB, id: integer;
  params: TArray<string>;
begin
  params:=Request.PathInfo.Split(['/']);
  try
    db:=params[2].ToInteger;
    id:=params[3].ToInteger;
  except
    Handled:=false;
    Exit;
  end;
  FDQuery1.Open('select * from maintable;');
  if not FDQuery1.Locate('dbnumber',db) then
  begin
    Handled:=false;
    FDQuery1.Close;
    Exit;
  end;
  if Request.MethodType = mtPost then
  begin
    FDQuery1.Filtered:=true;
    FDQuery1.EmptyView;
    FDQuery1.Filtered:=false;
    if FDQuery1.IsEmpty then
    begin
      FDQuery1.Close;
      FDQuery1.SQL.Text:='select * from datatable where dbnumber = :db;';
      FDQuery1.Params.ParamByName('db').AsInteger:=db;
      FDQuery1.Open;
      FDQuery1.EmptyView;
    end;
  end;
  FDQuery1.Close;
  FDQuery1.SQL.Text:='select * from datatable dt INNER JOIN maintable mt ON dt.dbnumber = mt.dbnumber;';
  FDQuery1.Open;
  WebStencilsProcessor3.AddVar('Items',FDQuery1,false);
  WebStencilsProcessor3.AddVar('Info',makeFooter('admin',db,id));
  Response.ContentType := 'text/html;charset=utf-8;';
  Response.Content:=WebStencilsProcessor3.Content;
  FDQuery1.Close;
end;

procedure TWebModule1.WebModule1mainItemAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  raw, code, name, title: string;
  id, DB, page, tid: integer;
  params: TArray<string>;
begin
  params:=Request.PathInfo.Split(['/']);
  try
    db:=params[2].ToInteger;
    page:=StrToIntDef(params[3],0);
  except
    Handled:=false;
    Exit;
  end;
  FDQuery1.Open('''
    select * from DATATABLE dt INNER JOIN maintable mt ON dt.dbnumber = mt.dbnumber
    INNER JOIN datas ON dt.dbnumber = datas.dbnumber;
    ''');
  if not FDQuery1.Locate('dbnumber',db) then
  begin
    FDQuery1.Close;
    Handled:=false;
    Exit;
  end;
  if Request.MethodType = mtPost then
  begin
    name := Request.ContentFields.Values['name'];
    title:=Request.ContentFields.Values['title'];
    raw := replaceRawData(Request.ContentFields.Values['comment']);
    raw := TNetEncoding.HTML.Encode(raw);
    code := Request.ContentFields.Values['code'];

    FDQuery1.Last;
    id:=FDQuery1.FieldByName('id').AsInteger+1;
    tid := FDQuery1.FieldByName('titlenum').AsInteger + 1;

    FDQuery1.Append;
    FDQuery1.FieldByName('id').AsInteger:=id;
    FDQuery1.FieldByName('dbnumber').AsInteger:=db;
    FDQuery1.FieldByName('titlenum').AsInteger:=tid;
    FDQuery1.FieldByName('name').AsString:=name;
    FDQuery1.FieldByName('comment').AsString:=raw;
    FDQuery1.FieldByName('datetime').AsDateTime:=Now;
    FDQuery1.FieldByName('code').AsString:=code;
    FDQuery1.Post;
  end;
  WebStencilsProcessor1.AddVar('Datas',FDQuery1,false);
  WebStencilsProcessor1.AddVar('Info',makeFooter('bbs',db,page));
  Response.ContentType := 'text/html;charset=utf-8';
  Response.Content := WebStencilsProcessor1.Content;
  FDQuery1.Close;
end;

procedure TWebModule1.WebModule1masterAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  id,num: integer;
begin
  FDQuery1.Open('select * from datas;');
  if Request.MethodType = mtPost then
  begin
    FDQuery1.Last;
    id:=FDQuery1.FieldByName('id').AsInteger+1;
    num:=FDQuery1.FieldByName('dbnumber').AsInteger+1;
    for var i := 1 to 5 do
    begin
      FDQuery1.AppendRecord([id,num,'掲示板'+i.ToString]);
      inc(id);
      inc(num);
    end;
  end;
  FDQuery1.Close;
end;

procedure TWebModule1.WebModule1membersAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  name, title, code: string;
  id, db, tb, cnt: integer;
  params: TArray<string>;
begin
  params:=Request.PathInfo.Split(['/']);
  db:=params[2].ToInteger;
  FDQuery1.SQL.Add('select * from datatable dt INNER JOIN datas ON dt.dbnumber = datas.dbnumber;');
  if not FDQuery1.Locate('dbnumber',db) then
  begin
    Handled := false;
    Exit;
  end;
  if Request.MethodType = mtPost then
  begin
    title := Request.ContentFields.Values['title'];
    bglist.Text := Request.ContentFields.Values['comment'];
    code := Request.ContentFields.Values['code'];
    cnt := -1;
    if code <> '' then
    begin
      cnt := bglist.count;
      bglist.Add(Format('<pre><code>%s</code></pre>', [code]));
    end;
    name := FDQuery1.FieldByName('name').AsString;
    id:=FDQuery1.FieldByName('id').AsInteger+1;
    tb:=FDQuery1.FieldByName('tablenum').AsInteger+1;
    FDQuery1.Close;
    FDQuery1.Open('select * from maintable;');
    FDQuery1.AppendRecord([DB, tb, bglist.Text, Now, cnt]);
    FDQuery1.Close;
    FDQuery1.Open('select * from datatable;');
    FDQuery1.AppendRecord([id,db,tb,title, name]);
  end;
  Response.ContentType := 'text/html;charset=utf8';
//  Response.Content := titleList.Content;
end;

procedure TWebModule1.WebModule1searchItemAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  mysearch := TPageSearch.Create;
  try
    mysearch.WordList := Request.ContentFields.Values['word1'];
    FDQuery1.Open('''
      select ds.dbname,dt.name,dt.titlenum,mt.title,mt.datetime from datas ds
      INNER JOIN datatable dt ON ds.dbnumber = dt.dbnumber
      INNER JOIN maintable mt ON ds.dbnumber = mt.dbnumber
      order by mt.datetime desc;
      ''');
    WebStencilsProcessor6.AddVar('Users',FDQuery1,false);
    Response.ContentType := 'text/html;charset=utf8';
    Response.Content := WebStencilsProcessor6.Content;
    FDQuery1.Close;
  finally
    mysearch.Free;
  end;
end;

procedure TWebModule1.WebModule1showTopAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  jsItem, jsSlide, jsRoot: TJSONObject;
  jaItem, jaSlide: TJSONArray;
  sIndex, iIndex, i: integer;
begin
  FDQuery1.Open('select * from datas');
  jsRoot:=TJSONObject.Create;
  jaSlide:=TJSONArray.Create;
  jsRoot.AddPair('slides',jaSlide);
  sIndex:=0;
  iIndex:=1;
  while not FDQuery1.Eof do
  begin
    jsSlide:=TJSONObject.Create;
    jsSlide.AddPair('index',TJSONNumber.Create(sIndex));
    jsSlide.AddPair('imgnum',TJSONNumber.Create(sIndex+1));
    jsSlide.AddPair('activeClass',if sIndex = 0 then 'active' else '');
    jaItem:=TJSONArray.Create;
    i:=0;
    while not FDQuery1.Eof and (i < count) do
    begin
      jsItem:=TJSONObject.Create;
      jsItem.AddPair('id',TJSONNumber.Create(iIndex));
      jsItem.AddPair('name',FDQuery1.FieldByName('name').AsString);
      jaItem.AddElement(jsItem);

      FDQuery1.Next;
      inc(i);
      inc(iIndex);
    end;
    jsSlide.AddPair('items',jaItem);
    jaSlide.AddElement(jsSlide);
    inc(sIndex);
  end;
  WebStencilsProcessor2.AddVar('Data',jsRoot);
  Response.ContentType := 'text/html;charset=utf-8';
  Response.Content := WebStencilsProcessor2.Content;
  FDQuery1.Close;
end;

procedure TWebModule1.WebModule1alertAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  id, did, tn: integer;
  log, time, name, title, text: string;
  js: TJSONObject;
  bool: Boolean;
begin
  if Request.MethodType = mtGet then
  begin
    id:=Request.ContentFields.Values['id'].ToInteger;
    log:=Request.ContentFields.Values['com'];
    FDQuery1.Open('''
      select * from datatable dt INNER JOIN maintable mt ON
      dt.dbnumber = mt.dbnumber and dt.tbnumber = mt.tbnumber
      INNER JOIN datas ON dt.dbnumber = datas.dbnumber;
      ''');
    if not FDQuery1.Locate('id',id) then
    begin
      FDQuery1.Close;
      Handled:=false;
      Exit;
    end;
    did:=FDQuery1.FieldByName('id').AsInteger;
    tn:=FDQuery1.FieldByName('titlenum').AsInteger;
    time := FDQuery1.FieldByName('datetime').AsString;
    title:=FDQuery1.FieldByName('title').AsString;
    name:=FDQuery1.FieldByName('name').AsString;
    text:=FDQuery1.FieldByName('com').AsString;
    FDQuery1.Close;

    bglist.Add('');
    bglist.Add('(*ユーザー様から報告がありました*)');
    bglist.Add('TODAY is ' + DateToStr(Now));
    bglist.Add(log);
    bglist.Add(FDQuery1.FieldByName('comment').AsString);
    bglist.Add('(*報告ここまで*)');
    bglist.Add('');
    log:=bglist.Text;
    bglist.Clear;

    FDQuery1.Open('select max(id) as maxid from weblog;');
    id:=FDQuery1.FieldByName('maxid').AsInteger+1;
    FDQuery1.Close;

    FDQuery1.Open('select * from proptable;');
    FDQuery1.AppendRecord([id,time,log,did]);
    FDQuery1.Close;
    bool:=false;

    js:=TJSONObject.Create;
    js.AddPair('datetime',time);
    js.AddPair('post',TJSONBool.Create(bool));
    js.AddPair('tablenum',TJSONNumber.Create(tn));
    js.AddPair('title',title);
    js.AddPair('name',name);
    js.AddPair('comment',text);
  end
  else
    bool:=true;
  WebStencilsProcessor8.AddVar('Json',js);
  Response.ContentType := 'text/html;charset=utf-8';
  Response.Content := WebStencilsProcessor8.Content;
end;

procedure TWebModule1.WebModule1helpAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  id: integer;
  post: Boolean;
  js: TJSONObject;
begin
  if Request.MethodType = mtPost then
  begin
    bglist.Clear;
    bglist.Add('');
    bglist.Add('(*ユーザー様から報告がありました*)');
    bglist.Add(DateToStr(Now));
    bglist.Add(Request.ContentFields.Values['help']);
    bglist.Add('(*報告ここまで*)');
    bglist.Add('');
    FDQuery1.Open('select max(id) as maxid from weblog;');
    id:=FDQuery1.FieldByName('maxid').AsInteger;
    FDQuery1.Close;
    FDQuery1.Open('select * from weblog;');
    FDQuery1.AppendRecord([id,Now,bglist.Text,0]);
    FDQuery1.Close;
    post:=true;
  end
  else
    post:=false;
  js:=TJSONObject.Create;
  js.AddPair('post',TJSONBool.Create(post));
  WebStencilsProcessor7.AddVar('Data',js);
  Response.ContentType := 'text/html;charset=utf-8';
  Response.Content := WebStencilsProcessor7.Content;
end;

procedure TWebModule1.WebModule1linkItemAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.ContentType:='text/html;charset=utf-8';
  Response.Content:=WebStencilsProcessor4.Content;
end;

procedure TWebModule1.WebModule1renameAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  DB: string;
  name: string;
  params: TArray<string>;
begin
  params:=Request.PathInfo.Split(['/']);
  db:=params[2];
  FDQuery1.SQL.Add('select * from datas where dbnumber = :db;');
  FDQuery1.Params.ParamByName('db').AsInteger:=DB.ToInteger;
  FDQuery1.Open;
  name:=Request.ContentFields.Values['text'];
  FDQuery1.Edit;
  FDQuery1.FieldByName('dbname').AsString:=name;
  FDQuery1.Post;
  Response.SendRedirect('/admin/'+DB);
end;

procedure TWebModule1.WebModuleBeforeDispatch(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  if mente and (Request.PathInfo <> '/master') then
  begin
    Response.ContentType := 'text/html;charset=utf-8';
    Response.Content := mentenance.Content;
    Handled := true;
  end;
end;

procedure TWebModule1.WebModuleCreate(Sender: TObject);
begin
  FDQuery1.Open('select * from proptable;');
  count:=FDQuery1.FieldByName('count').AsInteger;
  pagecount:=FDQuery1.FieldByName('pagecount').AsInteger;
  mente:=FDQuery1.FieldByName('mentenance').AsBoolean;
  FDQuery1.Close;

  count := if count = 0 then 30 else count;
  pagecount:=if pagecount = 0 then 10 else pagecount;

  bglist := TStringList.Create;
 // FDQuery1.Open('select * from adlist;');
 // FDQuery1.Close;
end;

procedure TWebModule1.WebModuleDestroy(Sender: TObject);
begin
  FDQuery1.Open('select * from datas;');
  FDQuery1.Edit;
  FDQuery1.FieldByName('count').AsInteger:=count;
  FDQuery1.FieldByName('pagecount').AsInteger:=pagecount;
  FDQuery1.FieldByName('mentenance').AsBoolean:=mente;
  FDQuery1.Post;
  FDQuery1.Close;
  bglist.Free;
end;

procedure TWebModule1.WebStencilsProcessor5Value(Sender: TObject;
  const AObjectName, APropName: string; var AValue: string;
  var AHandled: Boolean);
begin
  if AObjectName = 'Code' then
  begin
    if Request.MethodType = mtGet then
      AValue := '<input type=submit value="送信">'
    else
      AValue := 'ありがとうございました';
  end;
end;

procedure TWebModule1.WebStencilsProcessor6Value(Sender: TObject;
  const AObjectName, APropName: string; var AValue: string;
  var AHandled: Boolean);
begin
  if AObjectName = 'adtext' then
  begin
    AValue:=FDQuery1.FieldByName('adtext').AsString;
    FDQuery1.Next;
  end;
  if AObjectName = 'word' then
    AValue := '"' + mysearch.WordList + '"';
end;

{ TPageSearch }

const
  str = '<span style=background-color:yellow>%s</span>';

function TPageSearch.checkState(var st: integer; var bool: Boolean;
  word, line: string): TFindState;
begin
  result := fdNone;
  for var id := st to High(line) do
  begin
    if line[id] <> word[1] then
      Continue;
    FStBuild.Append(line.Substring(st, id - st));
    st := id;
    if line.Substring(id, Length(word)) = word then
    begin
      result := fdNormal;
      bool := true;
      break;
    end
    else if Pos(line.Substring(id, Length(line)), word) > 0 then
      result := fdShort;
  end;
end;

constructor TPageSearch.Create;
begin
  FList := TStringList.Create;
  FResultLST := TStringList.Create;
end;

destructor TPageSearch.Destroy;
begin
  FList.Free;
  FResultLST.Free;
  inherited;
end;

procedure TPageSearch.processNormal(var id: integer; word, line: string);
begin
  FStBuild.Append(Format(str,[word]));
  inc(id, Length(word));
end;

procedure TPageSearch.processShort(var id, ln: integer; var bool: Boolean;
  word: string; var line: string);
var
  wrd: string;
  cnt: integer;
  state: TFindState;
begin
  state := fdShort;
  cnt := Length(word);
  wrd := line.Substring(id, Length(word));
  FStBuild.Append(Format(str,[wrd]));
  dec(cnt, Length(wrd));
  while state = fdShort do
  begin
    wrd := Copy(word, Length(wrd) + 1, Length(line));
    FStBuild.Append(#13#10 + Format(str, [wrd]));
    dec(cnt, Length(wrd));
    inc(ln);
    if FList.count = ln then
    begin
      bool := false;
      Exit;
    end;
    line := FList[ln];
    id := 1;
    state := checkState(id, bool, wrd, line);
    inc(id, Length(wrd));
  end;
  bool := cnt = 0;
end;

procedure TPageSearch.SetWordList(const Value: string);
begin
  FWordList := Value;
  initWordList;
end;

function TPageSearch.Execute(const Text: string): string;
var
  i, id: integer;
  state: TFindState;
  s: string;
  bool: Boolean;
begin
  var stbuild:=TStringBuilder.Create;
  FList.Text := Text;
  bool := false;
  for var str in FBlindStr.Split([' ']) do
  begin
    if str = '' then
      Continue;
    i := 0;
    id := 0;
    while i < FList.count do
    begin
      s := FList[i];
      state := checkState(id, bool, str, s);
      case state of
        fdShort:
          processShort(id, i, bool, str, s);
        fdNormal:
          processNormal(id, str, s);
        fdNone:
          begin
            stbuild.Append(s.Substring(id, Length(s)));
            id := 0;
            inc(i);
          end;
      end;
    end;
    if bool then
      Exit(FStBuild.ToString);
  end;
  result := '';
end;

procedure TPageSearch.initWordList;
var
  lst: TDictionary<string, integer>;
  max: integer;
  tmp: string;
begin
  lst := TDictionary<string, integer>.Create;
  try
    for var str in FWordList.Split([' ', '　']) do
      if str <> '' then
        lst.Add(str, Length(str));
    FBlindStr := '';
    while lst.count > 0 do
    begin
      max := 0;
      for var pair in lst do
        if max < pair.Value then
        begin
          tmp := pair.Key;
          max := pair.Value;
        end;
      lst.Remove(tmp);
      FBlindStr := FBlindStr + ' ' + tmp;
    end;
  finally
    lst.Free;
  end;
end;

end.
