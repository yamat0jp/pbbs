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
  System.Generics.Collections;

type
  TFindState = (fdShort, fdNormal, fdNone);

  TPageSearch = class
  private
    FWordList: string;
    FBlindStr: TArray<string>;
    FList, FResultLST: TStringList;
    FStBuild: TStringBuilder;
    function checkState(var st: integer; const word, line: string)
      : TFindState;
    function processNormal(id, ln: integer; word: string): integer;
    function processShort(id, ln: integer; const word: string): Boolean;
    procedure initWordList;
    procedure SetWordList(const Value: string);
  public
    constructor Create;
    destructor Destroy; override;
    function Execute(var Text: string): Boolean;
    property WordList: string read FWordList write SetWordList;
  end;

  TData = class
  private
    FId: integer;
    FName: string;
  public
    property id: integer read FId write FId;
    property name: string read FName write FName;
  end;

  TInfo = class
  private
    FId: integer;
    FAd: string;
    FUsername: string;
  public
    property id: integer read FId write FId;
    property username: string read FUsername write FUsername;
    property ad: string read FAd write FAd;
  end;

  TMain = class
  private
    FComment: string;
    FName: string;
    FTitle: string;
    FDatetime: TDatetime;
    FTitlenum: integer;
    FDatabase: string;
  public
    property database: string read FDatabase write FDatabase;
    property titlenum: integer read FTitlenum write FTitlenum;
    property title: string read FTitle write FTitle;
    property name: string read FName write FName;
    property datetime: TDatetime read FDatetime write FDatetime;
    property comment: string read FComment write FComment;
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
    FDCommand1: TFDCommand;
    FDTransaction1: TFDTransaction;
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
    procedure WebStencilsProcessor5Value(Sender: TObject; const AObjectName,
      APropName: string; var AValue: string; var AHandled: Boolean);
    procedure WebStencilsProcessor6Value(Sender: TObject; const AObjectName,
      APropName: string; var AValue: string; var AHandled: Boolean);
    procedure WebModule1linkItemAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1masterAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebStencilsProcessor1Value(Sender: TObject; const AObjectName,
      APropName: string; var AValue: string; var AHandled: Boolean);
    procedure WebStencilsProcessor3Value(Sender: TObject; const AObjectName,
      APropName: string; var AValue: string; var AHandled: Boolean);
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
    procedure makeFooter(id: integer; out link: TObjectList<TData>);
    function replaceRawData(Data: string): string;
    procedure PageIndex(AQuery: TFDQuery; page: integer);
  public
    { public 宣言 }
  end;

  TSlide = class
  private
    FActiveClass: string;
    FIndex: integer;
    FImgname: string;
    FItems: TObjectList<TData>;
  public
    constructor Create;
    destructor Destroy; override;
    property index: integer read FIndex write FIndex;
    property imgname: string read FImgname write FImgname;
    property activeClass: string read FActiveClass write FActiveClass;
    property Items: TObjectList<TData> read FItems;
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

uses System.JSON, System.IOUtils;

const
  nobody = 'no name';

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

procedure TWebModule1.makeFooter(id: integer;out link: TObjectList<TData>);
var
  url: TData;
begin
  link:=TObjectList<TData>.Create;
  for var i := 1 to pagecount do
  begin
    url:=TData.Create;
    url.id:=i;
    url.name:=if id = i then 'active' else '';
    link.Add(url);
  end;
  url:=TData.Create;
  url.id:=id;
  url.name:=if id = 0 then 'active' else '';
  link.Add(url);
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
  db, index, temp, rec: integer;
  params: TArray<string>;
  items: TObjectList<TData>;
  nums: TArray<string>;
  data: TData;
begin
  params:=Request.PathInfo.Split(['/'],TStringSplitOptions.ExcludeLastEmpty);
  try
    db:=params[2].ToInteger;
    index:=if High(params) = 3 then params[3].ToInteger else 0;
  except
    Handled:=false;
    Exit;
  end;
  if Request.MethodType = mtPost then
  begin
    nums:=[];
    for var i := 0 to Request.ContentFields.Count-1 do
      if Request.ContentFields.Names[i] = 'datas[]' then
        nums:=nums+[Request.ContentFields.ValueFromIndex[i]];
    var numbers:=String.Join(',',nums);
    if numbers <> '' then
    begin
      FDTransaction1.StartTransaction;
      try
        FDCommand1.CommandText.Text:=
          'DELETE FROM datatable where dbnumber = :db and titlenum IN (&tnums);';
        FDCommand1.ParamByName('db').AsInteger:=db;
        FDCommand1.MacroByName('tnums').AsRaw:=numbers;
        FDCommand1.Execute;

        FDCommand1.CommandText.Text:=
          'DELETE FROM maintable where dbnumber = :db and titlenum IN (&tnums);';
        FDCommand1.ParamByName('db').AsInteger:=db;
        FDCommand1.MacroByName('tnums').AsRaw:=numbers;
        FDCommand1.Execute;
      except
        FDTransaction1.Rollback;
        raise;
      end;
    end;
  end;
  FDQuery1.SQL.Text:='select COUNT(*) cnt from datatable where dbnumber = :db;';
  FDQuery1.ParamByName('db').AsInteger:=db;
  FDQuery1.Open;
  rec:=FDQuery1.FieldByName('cnt').AsInteger;

  FDQuery1.SQL.Text:='''
    select * from datatable dt INNER JOIN maintable mt ON dt.dbnumber = mt.dbnumber
    and dt.titlenum = mt.titlenum where dt.dbnumber = :db ORDER BY id LIMIT :cnt OFFSET :st;
    ''';
  if (index = 0)or(index > rec div count+1) then
  begin
    temp:=rec div count + 1;
    if index > 0 then
      index:=temp;
  end
  else
    temp:=index;
  FDQuery1.ParamByName('db').AsInteger:=db;
  FDQuery1.ParamByName('cnt').AsInteger:=count;
  FDQuery1.ParamByName('st').AsInteger:=(temp-1)*count;
  FDQuery1.Open;
  makeFooter(index,items);
  data:=TData.Create;
  with items[items.Count-1] do
  begin
    data.id:=id;
    data.name:=name;
  end;
  items.Delete(items.Count-1);
  WebStencilsProcessor3.AddVar('articles',FDQuery1,false);
  WebStencilsProcessor3.AddVar('Items',items);
  WebStencilsProcessor3.AddVar('Info',data);
  Response.ContentType := 'text/html;charset=utf-8;';
  Response.Content:=WebStencilsProcessor3.Content;
  FDQuery1.Close;
end;

procedure TWebModule1.WebModule1mainItemAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  raw, code, name, title: string;
  index, DB, page, temp, rec, tid: integer;
  params: TArray<string>;
  items: TObjectList<TData>;
  data: TData;
begin
  params:=Request.PathInfo.Split(['/'],TStringSplitOptions.ExcludeLastEmpty);
  try
    db:=params[2].ToInteger;
    page:=if High(params) = 3 then params[3].ToInteger else 0;
  except
    Handled:=false;
    Exit;
  end;
  FDQuery1.SQL.Text:='select COUNT(*) cnt from datatable where dbnumber = :db;';
  FDQuery1.ParamByName('db').AsInteger:=db;
  FDQuery1.Open;
  rec:=FDQuery1.FieldByName('cnt').AsInteger;
  FDQuery1.Close;

  FDQuery1.SQL.Text:='''
    select * from DATATABLE dt INNER JOIN maintable mt ON dt.dbnumber = mt.dbnumber
    and dt.titlenum = mt.titlenum
    INNER JOIN database ds ON dt.dbnumber = ds.dbnumber where dt.dbnumber = :db
    ORDER BY id LIMIT :cnt OFFSET :st;
    ''';
  if (page = 0)or(page > rec div count+1) then
  begin
    temp:=rec div count + 1;
    if page > 0 then
      page:=temp;
  end
  else
    temp:=page;
  FDQuery1.ParamByName('db').AsInteger:=db;
  FDQuery1.ParamByName('cnt').AsInteger:=count;
  FDQuery1.ParamByName('st').AsInteger:=(temp-1)*count;
  FDQuery1.Open;

  if Request.MethodType = mtPost then
  begin
    FDQuery1.Last;
    index:=FDQuery1.FieldByName('id').AsInteger+1;
    tid := FDQuery1.FieldByName('titlenum').AsInteger + 1;
    name := Request.ContentFields.Values['name'];
    title:=Request.ContentFields.Values['title'];
    raw := replaceRawData(Request.ContentFields.Values['comment']);
    raw := TNetEncoding.HTML.Encode(raw);
    code := Request.ContentFields.Values['code'];

    FDTransaction1.StartTransaction;
    try
      FDCommand1.CommandText.Text :='''
        INSERT INTO DATATABLE (id, dbnumber, titlenum, title, name)
        VALUES (:id, :db, :tid, :title, :name)
        ''';
      FDCommand1.ParamByName('id').AsInteger:=index;
      FDCommand1.ParamByName('db').AsInteger:=db;
      FDCommand1.ParamByName('tid').AsInteger:=tid;
      FDCommand1.ParamByName('title').AsString:=title;
      FDCommand1.ParamByName('name').AsString:=name;
      FDCommand1.Execute;

      FDCommand1.CommandText.Text:='''
        INSERT INTO MAINTABLE (dbnumber, titlenum, comment, datetime, code)
        VALUES (:db, :tid, :comment, :dt, :code)
        ''';
      FDCommand1.ParamByName('db').AsInteger:=db;
      FDCommand1.ParamByName('tid').AsInteger:=tid;
      FDCommand1.ParamByName('comment').AsString:=raw;
      FDCommand1.ParamByName('dt').AsDateTime:=Now;
      FDCommand1.ParamByName('code').AsString:=code;
      FDCommand1.Execute;

      FDTransaction1.Commit;
    except
      FDTransaction1.Rollback;
      raise;
    end;
  end;
  FDQuery1.Refresh;
  makeFooter(page,items);
  data:=TData.Create;
  with items[items.Count-1] do
  begin
    data.id:=id;
    data.name:=name;
  end;
  items.Delete(items.Count-1);
  WebStencilsProcessor1.AddVar('articles',FDQuery1,false);
  WebStencilsProcessor1.AddVar('Items',items);
  WebStencilsProcessor1.AddVar('Footer',data);
  Response.ContentType := 'text/html;charset=utf-8';
  Response.Content := WebStencilsProcessor1.Content;
  FDQuery1.Close;
end;

procedure TWebModule1.WebModule1masterAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  num: integer;
begin
  FDQuery1.Open('select * from database;');
  if Request.MethodType = mtPost then
  begin
    FDQuery1.Last;
    num:=FDQuery1.FieldByName('dbnumber').AsInteger+1;
    for var i := 1 to 5 do
    begin
      FDQuery1.AppendRecord([num,'掲示板'+i.ToString]);
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
  FDQuery1.SQL.Add('select * from datatable dt INNER JOIN database ds ON dt.dbnumber = ds.dbnumber;');
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
var
  s, words: string;
begin
  words:=Request.ContentFields.Values['word1'];
  FDQuery1.ResourceOptions.MacroCreate:=false;
  FDQuery1.ResourceOptions.MacroExpand:=false;
  FDQuery1.SQL.Text:='''
    select * from datatable dt
    INNER JOIN database ON dt.dbnumber = database.dbnumber
    INNER JOIN maintable mt ON dt.dbnumber = mt.dbnumber and dt.titlenum = mt.titlenum;
    ''';
//  FDQuery1.ParamByName('words').AsString:=words;
  FDQuery1.Open;

  var ls:=TObjectList<TMain>.Create;
  mysearch := TPageSearch.Create;
  try
    mysearch.WordList:=words;
    while not FDQuery1.Eof do
    begin
      s:=FDQuery1.FieldByName('comment').AsString;
      if not mysearch.Execute(s) then
      begin
        FDQuery1.Next;
        continue;
      end;
      var main:=TMain.Create;
      main.database:=FDQuery1.FieldByName('dbname').AsString;
      main.titlenum:=FDQuery1.FieldByName('titlenum').AsInteger;
      main.title:=FDQuery1.FieldByName('title').AsString;
      main.comment:=s;
      main.name:=FDQuery1.FieldByName('name').AsString;
      main.datetime:=FDQuery1.FieldByName('datetime').AsDateTime;
      ls.Add(main);
      FDQuery1.Next;
    end;
  WebStencilsProcessor6.AddVar('Datas',ls);
  Response.ContentType := 'text/html;charset=utf8';
  Response.Content := WebStencilsProcessor6.Content;
  finally
    mysearch.Free;
  end;
  FDQuery1.Close;
end;

procedure TWebModule1.WebModule1showTopAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
const
  cnt = 7;
var
  slide: TSlide;
  BBSName: TData;
begin
  FDQuery1.Open('select * from database;');
  var ls:=TObjectList<TSlide>.Create;
  for var i := 0 to FDQuery1.RecordCount div cnt do
  begin
    slide:=TSlide.Create;
    ls.Add(slide);
    slide.index:=i;
    slide.imgname:=String.Format('/img/slide%d.jpg',[i+1]);
    slide.activeClass:=if i = 0 then 'active' else '';
    for var j := 1 to cnt do
    begin
      BBSName:=TData.Create;
      if not FDQuery1.Eof then
      begin
        BBSName.id:=FDQuery1.FieldByName('dbnumber').AsInteger;
        BBSName.name:=FDQuery1.FieldByName('dbname').AsString;
        FDQuery1.Next;
      end
      else
      begin
        BBSName.id:=0;
        BBSName.name:='未開放';
      end;
      slide.Items.Add(BBSName);
    end;
  end;
  WebStencilsProcessor2.AddVar('Slides',ls);
  Response.ContentType := 'text/html;charset=utf-8';
  Response.Content := WebStencilsProcessor2.Content;
  FDQuery1.Close;
end;

procedure TWebModule1.WebModule1alertAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  id, did, tn: integer;
  log, name, title, text: string;
  time: TDatetime;
  post: Boolean;
  js: TJSONObject;
begin
  if Request.MethodType = mtGet then
  begin
    id:=Request.ContentFields.Values['id'].ToInteger;
    log:=Request.ContentFields.Values['com'];
    FDQuery1.Open('''
      select * from datatable dt INNER JOIN maintable mt ON
      dt.dbnumber = mt.dbnumber and dt.tbnumber = mt.tbnumber
      INNER JOIN database ds ON dt.dbnumber = ds.dbnumber;
      ''');
    if not FDQuery1.Locate('id',id) then
    begin
      FDQuery1.Close;
      Handled:=false;
      Exit;
    end;
    did:=FDQuery1.FieldByName('id').AsInteger;
    tn:=FDQuery1.FieldByName('titlenum').AsInteger;
    time := FDQuery1.FieldByName('datetime').AsDateTime;
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


    var main:=TMain.Create;
    main.title:=title;
    main.name:=name;
    main.datetime:=time;
    main.titlenum:=tn;
    main.comment:=text;
    WebStencilsProcessor8.AddVar('main',main);
    post:=false;
  end
  else
    post:=true;
  js:=TJSONObject.Create;
  js.AddPair('post',post);
  WebStencilsProcessor8.AddVar('Data',js);
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
  FDQuery1.SQL.Add('select * from database where dbnumber = :db;');
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
  FDQuery1.Open('select * from database;');
  FDQuery1.Edit;
  FDQuery1.FieldByName('count').AsInteger:=count;
  FDQuery1.FieldByName('pagecount').AsInteger:=pagecount;
  FDQuery1.FieldByName('mentenance').AsBoolean:=mente;
  FDQuery1.Post;
  FDQuery1.Close;
  bglist.Free;
end;

procedure TWebModule1.WebStencilsProcessor1Value(Sender: TObject;
  const AObjectName, APropName: string; var AValue: string;
  var AHandled: Boolean);
begin
  if AObjectName = 'Ad' then
    AValue:='sanuki_kainushi BBS';
  if AObjectName = 'Script' then
    AValue:='bbs';
end;

procedure TWebModule1.WebStencilsProcessor3Value(Sender: TObject;
  const AObjectName, APropName: string; var AValue: string;
  var AHandled: Boolean);
begin
  if AObjectName = 'Script' then
    AValue:='admin';
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
    AValue := mysearch.WordList;
end;

{ TPageSearch }

const
  str = '<span style=background-color:yellow>%s</span>';

function TPageSearch.checkState(var st: integer; const word, line: string): TFindState;
var
  s: string;
begin
  s:=line.Substring(st);
  if s.Contains(word) then
  begin
    inc(st,s.IndexOf(word,st)+word.Length);
    Exit(fdNormal);
  end
  else
  begin
    st:=line.LastIndexOf(word[1]);
    if (st > -1)and word.StartsWith(line.Substring(st),true) then
      result:=fdShort
    else
      result:=fdNone;
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

function TPageSearch.processNormal(id, ln: integer; word: string): integer;
var
  s, t: string;
begin
  s:=FList[ln];
  t:=String.Format(str,[word])+s.Substring(id+word.Length);
  FList[ln]:=s.Substring(id)+t;
  result:=id+t.Length;
end;

function TPageSearch.processShort(id, ln: integer; const word: string): Boolean;
var
  wrd, line: string;
  index: integer;
  strings: TArray<string>;
begin
  index:=ln;
  line:=FList[index];
  wrd:=line.Substring(id);
  strings:=[line.Remove(id)+String.Format(str,[wrd])];

  //checking
  if not word.StartsWith(wrd,true) then
    Exit(false);

  while FList.Count > ln do
  begin
    line:=FList[ln+1];
    if line.Length+wrd.Length < word.Length then
    begin
      strings:=strings+[String.Format(str,[line])];
      wrd:=wrd+line;
    end
    else
      break;
    inc(ln);
  end;

  if line.StartsWith(word.Substring(wrd.Length),true) then
  begin
    var i:=word.Length-wrd.Length;
    wrd:=wrd+line.Remove(i);
    strings:=strings+[String.Format(str,[line.Remove(i)])+line.Substring(i)];
  end;

  if word = wrd then
  begin
    for var i := 1 to Length(strings) do
      FList.Delete(Index);
    for var i := High(strings) downto 0 do
      FList.Insert(Index,strings[i]);
    result:=true;
  end
  else
    result:=false;
end;

procedure TPageSearch.SetWordList(const Value: string);
begin
  FWordList := Value;
  initWordList;
end;

function TPageSearch.Execute(var Text: string): Boolean;
var
  i, id: integer;
  state: TFindState;
begin
  FList.Text := Text;
  result:=false;
  for var word in FBlindStr do
  begin
    i := 0;
    id := 0;
    while i < FList.count do
    begin
      state := checkState(id, word, FList[i]);
      case state of
        fdShort:
          result:=processShort(id, i, word);
        fdNormal:
          begin
            id:=processNormal(id, i, word);
            result:=true;
          end;
        fdNone:
          begin
            id := 0;
            inc(i);
          end;
      end;
    end;
  end;
  if result then
    Text:=FList.Text;
end;

procedure TPageSearch.initWordList;
var
  lst: TDictionary<string, integer>;
  max: integer;
  tmp: string;
begin
  lst := TDictionary<string, integer>.Create;
  try
    for var s in FWordList.Split([' ', '　']) do
      if s <> '' then
        lst.Add(s, s.Length);
    FBlindStr:=[];
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
      FBlindStr:=FBlindStr+[tmp];
    end;
  finally
    lst.Free;
  end;
end;

{ TSlide }

constructor TSlide.Create;
begin
  FItems:=TObjectList<TData>.Create;
end;

destructor TSlide.Destroy;
begin
  FItems.Free;
  inherited;
end;

end.
