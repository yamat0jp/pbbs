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
    FList: TStringList;
    function checkState(var st: integer; i: integer; const word: string): TFindState;
    function processNormal(id, ln: integer; word: string): integer;
    function processShort(var id, ln: integer; const word: string): Boolean;
    procedure initWordList;
  public
    constructor Create;
    destructor Destroy; override;
    function Execute(var Text: string): Boolean;
    property WordList: string read FWordList write FWordList;
  end;

  TData = class
  private
    FId: integer;
    FName: string;
    FTag: string;
  public
    property id: integer read FId write FId;
    property name: string read FName write FName;
    property tag: string read FTag write FTag;
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
    WebStencilsProcessor8: TWebStencilsProcessor;
    FDCommand1: TFDCommand;
    FDTransaction1: TFDTransaction;
    WebStencilsProcessor9: TWebStencilsProcessor;
    FDQuery2: TFDQuery;
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
    procedure WebStencilsProcessor9Value(Sender: TObject; const AObjectName,
      APropName: string; var AValue: string; var AHandled: Boolean);
  private
    { private 宣言 }
    count: integer;
    pagecount: integer;
    mente: Boolean;
    commentoff: Boolean;
    mysearch: TPageSearch;
    bglist, adlist: TStringList;
    procedure makeFooterNumber(id: integer; out link: TObjectList<TData>);
    function replaceRawData(const Data: string): string;
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

uses System.JSON, System.IOUtils, System.Math;

procedure TWebModule1.makeFooterNumber(id: integer;out link: TObjectList<TData>);
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
end;

function TWebModule1.replaceRawData(const Data: string): string;
const
  ng = '死ね,阿保,馬鹿,殺す,爆破';
begin
  result:=Data.Replace(#0,'',[rfReplaceAll]);
  for var s in ng.Split([',']) do
    result:=result.Replace(s,'*****',[rfReplaceAll,rfIgnoreCase]);
end;

procedure TWebModule1.WebModule1adminPageAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  db, index, page, temp, rec: integer;
  user, title: string;
  params: TArray<string>;
  items: TObjectList<TData>;
  nums: TArray<string>;
  data: TData;
begin
  params:=Request.PathInfo.Split(['/'],TStringSplitOptions.ExcludeLastEmpty);
  try
    user:=params[2];
    title:=params[3];
    page:=if High(params) = 4 then params[4].ToInteger else 0;
  except
    Handled:=false;
    Exit;
  end;
  FDQuery1.SQL.Text:='''
    select dbnumber,id from database ds INNER JOIN titles t ON ds.dbnumber = t.usernum
    where nickname = :user and url = :title;
    ''';
  FDQuery1.ParamByName('user').AsString:=user;
  FDQuery1.ParamByName('title').AsString:=title;
  FDQuery1.Open;
  db:=FDQuery1.FieldByName('dbnumber').AsInteger;
  index:=FDQuery1.FieldByName('id').AsInteger;
  FDQuery1.Close;

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
          'DELETE FROM datatable where dbnumber = :db and dbtitle = :id and titlenum IN (&tnums);';
        FDCommand1.ParamByName('db').AsInteger:=db;
        FDCommand1.ParamByName('id').AsInteger:=index;
        FDCommand1.MacroByName('tnums').AsRaw:=numbers;
        FDCommand1.Execute;

        FDCommand1.CommandText.Text:=
          'DELETE FROM maintable where dbnumber = :db and dbtitle = :id and titlenum IN (&tnums);';
        FDCommand1.ParamByName('db').AsInteger:=db;
        FDCommand1.ParamByName('id').AsInteger:=index;
        FDCommand1.MacroByName('tnums').AsRaw:=numbers;
        FDCommand1.Execute;

        FDTransaction1.Commit;
      except
        FDTransaction1.Rollback;
        raise;
      end;
    end;
  end;
  FDQuery1.SQL.Text:='select COUNT(*) cnt from datatable where dbnumber = :db and dbtitle = :id;';
  FDQuery1.ParamByName('db').AsInteger:=db;
  FDQuery1.ParamByName('id').AsInteger:=index;
  FDQuery1.Open;
  rec:=FDQuery1.FieldByName('cnt').AsInteger;
  FDQuery1.Close;

  FDQuery1.SQL.Text:='''
    select t.name as pagetitle,dt.titlenum,dt.title,dt.name,mt.comment
    from datatable dt INNER JOIN maintable mt ON dt.dbnumber = mt.dbnumber
    and dt.dbtitle = mt.dbtitle and dt.titlenum = mt.titlenum
    INNER JOIN titles t ON dt.dbtitle = t.id
    where dt.dbnumber = :db and t.id = :id
    ORDER BY dt.titlenum LIMIT :cnt OFFSET :st;
    ''';
  if (page = 0)or(page > rec div count+1) then
  begin
    temp:=rec div count+1;
    if page > 0 then
      page:=temp;
  end;
  FDQuery1.ParamByName('db').AsInteger:=db;
  FDQuery1.ParamByName('id').AsInteger:=index;
  FDQuery1.ParamByName('cnt').AsInteger:=count;
  if page = 0 then
    FDQuery1.ParamByName('st').AsInteger:=Max(0,rec-count+1)
  else
    FDQuery1.ParamByName('st').AsInteger:=(page-1)*count;
  FDQuery1.Open;
  WebStencilsProcessor3.AddVar('articles',FDQuery1,false);

  makeFooterNumber(page,items);
  data:=TData.Create;
  data.id:=0;
  data.name:=if page = 0 then 'active' else '';
  WebStencilsProcessor3.AddVar('Items',items);
  WebStencilsProcessor3.AddVar('Info',data);

  Response.ContentType := 'text/html;charset=utf-8;';
  Response.Content:=WebStencilsProcessor3.Content;
  FDQuery1.Close;
end;

procedure TWebModule1.WebModule1mainItemAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  user, raw, code, name, title: string;
  userid, page0, page, temp, rec, tid, dbtitle: integer;
  params: TArray<string>;
  items: TObjectList<TData>;
  data: TData;
  redirect: Boolean;
begin
  params:=Request.PathInfo.Split(['/'],TStringSplitOptions.ExcludeLastEmpty);
  try
    user:=params[2];
    title:=params[3];
    page:=if High(params) = 4 then params[4].ToInteger else 0;
    page0:=page;
  except
    Handled:=false;
    Exit;
  end;
  FDQuery1.SQL.Text:='''
    select COUNT(*) OVER() AS cnt,dt.dbnumber,dt.dbtitle from datatable dt
    INNER JOIN database ds ON dt.dbnumber = ds.dbnumber
    INNER JOIN titles t ON dt.dbnumber = t.usernum and dt.dbtitle = t.id
    where nickname = :user and url = :title;
    ''';
  FDQuery1.ParamByName('user').AsString:=user;
  FDQuery1.ParamByName('title').AsString:=title;
  FDQuery1.Open;
  if FDQuery1.IsEmpty then
  begin
    FDQuery1.Close;
    FDQuery1.SQL.Text:='''
      select * from database ds INNER JOIN titles t ON ds.dbnumber = t.usernum
      where ds.nickname = :user and t.name = :title;
      ''';
    FDQuery1.ParamByName('user').AsString:=user;
    FDQuery1.ParamByName('title').AsString:=title;
    FDQuery1.Open;

    userid:=FDQuery1.FieldByName('dbnumber').AsInteger;
    dbtitle:=FDQuery1.FieldByName('id').AsInteger;
    rec:=0;
  end
  else
  begin
    userid:=FDQuery1.FieldByName('dbnumber').AsInteger;
    dbtitle:=FDQuery1.FieldByName('dbtitle').AsInteger;
    rec:=FDQuery1.FieldByName('cnt').AsInteger;
  end;
  if (page = 0)or(page > rec div count+1) then
  begin
    temp:=rec div count+1;
    if page > 0 then
      page:=temp;
  end;
  FDQuery1.Close;

  FDQuery1.SQL.Text:='''
    select t.name as pagetitle,ds.dbname,dt.titlenum,comment,code,datetime,dt.name,t.url,
    MAX(dt.titlenum) OVER() AS max from datatable dt
    INNER JOIN database ds ON dt.dbnumber = ds.dbnumber
    INNER JOIN titles t ON dt.dbnumber = t.usernum and dt.dbtitle = t.id
    INNER JOIN maintable mt ON dt.dbnumber = mt.dbnumber and dt.titlenum = mt.titlenum and dt.dbtitle = mt.dbtitle
    where dt.dbnumber = :userid and t.id = :dbtitle
    ORDER BY dt.titlenum LIMIT :cnt OFFSET :st;
    ''';
  FDQuery1.ParamByName('userid').AsInteger:=userid;
  FDQuery1.ParamByName('dbtitle').AsInteger:=dbtitle;
  FDQuery1.ParamByName('cnt').AsInteger:=count;
  if page = 0 then
    FDQuery1.ParamByName('st').AsInteger:=Max(0,rec-count+1)
  else
    FDQuery1.ParamByName('st').AsInteger:=(page-1)*count;
  FDQuery1.Open;

  if Request.MethodType = mtPost then
  begin
    tid:=FDQuery1.FieldByName('max').AsInteger+1;
    name := Request.ContentFields.Values['name'];
    raw := replaceRawData(Request.ContentFields.Values['comment']);
    raw := TNetEncoding.HTML.Encode(raw);
    code := Request.ContentFields.Values['code'];
    if FDQuery1.IsEmpty then
    begin
      FDQuery1.Close;
      FDQuery1.SQL.Text:='''
        select dbnumber,id from database
        INNER JOIN titles ON database.dbnumber = titles.usernum
        where nickname = :user and titles.url = :title;
        ''';
      FDQuery1.ParamByName('user').AsString:=user;
      FDQuery1.ParamByName('title').AsString:=title;
      FDQuery1.Open;
      if FDQuery1.IsEmpty then
      begin
        FDQuery1.Close;
        Response.SendRedirect(Request.PathInfo);
      end;
      userid:=FDQuery1.FieldByName('dbnumber').AsInteger;
      dbtitle:=FDQuery1.FieldByName('id').AsInteger;
      tid:=1;
      redirect:=true;
    end;

    FDTransaction1.StartTransaction;
    try
      FDCommand1.CommandText.Text :='''
        INSERT INTO DATATABLE (dbnumber, titlenum, title, name, dbtitle)
        VALUES (:db, :tid, :title, :name, :dbtitle)
        ''';
      FDCommand1.ParamByName('db').AsInteger:=userid;
      FDCommand1.ParamByName('tid').AsInteger:=tid;
      FDCommand1.ParamByName('title').AsString:=title;
      FDCommand1.ParamByName('name').AsString:=name;
      FDCommand1.ParamByName('dbtitle').AsInteger:=dbtitle;
      FDCommand1.Execute;

      FDCommand1.CommandText.Text:='''
        INSERT INTO MAINTABLE (dbnumber, titlenum, comment, datetime, code, dbtitle)
        VALUES (:db, :tid, :comment, :dt, :code, :dbtitle)
        ''';
      FDCommand1.ParamByName('db').AsInteger:=userid;
      FDCommand1.ParamByName('tid').AsInteger:=tid;
      FDCommand1.ParamByName('comment').AsString:=raw;
      FDCommand1.ParamByName('dt').AsDateTime:=Now;
      FDCommand1.ParamByName('code').AsString:=code;
      FDCommand1.ParamByName('dbtitle').AsInteger:=dbtitle;
      FDCommand1.Execute;

      FDTransaction1.Commit;
    except
      FDTransaction1.Rollback;
      raise;
    end;
    if redirect then
    begin
      FDQuery1.Close;
      Response.SendRedirect(Request.PathInfo);
    end
    else
      FDQuery1.Refresh;
  end;

  WebStencilsProcessor1.AddVar('articles',FDQuery1,false);

  makeFooterNumber(page,items);
  data:=TData.Create;
  data.id:=0;
  data.name:=if page = 0 then 'active' else '';
  WebStencilsProcessor1.AddVar('Items',items);
  WebStencilsProcessor1.AddVar('Footer',data);

  data:=TData.Create;
  data.id:=rec div 2;
  WebStencilsProcessor1.AddVar('Count',data);

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
    for var name in ['taro', 'jiro', 'saburo', 'siro', 'gorou'] do
    begin
      FDQuery1.AppendRecord([num,'メンバー'+num.ToString,name]);
      inc(num);
    end;
  end;
  FDQuery1.Close;
end;

procedure TWebModule1.WebModule1membersAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  user, name, title: string;
  id, kind, db: integer;
  params: TArray<string>;
begin
  params:=Request.PathInfo.Split(['/']);
  user:=params[2];
  FDQuery1.SQL.Text:='select * from database where nickname = :name;';
  FDQuery1.ParamByName('name').AsString:=user;
  FDQuery1.Open;
  db:=FDQuery1.FieldByName('dbnumber').AsInteger;
  user:=FDQuery1.FieldByName('dbname').AsString;
  if Request.MethodType = mtPost then
  begin
    name:=Request.ContentFields.Values['name'];
    title := Request.ContentFields.Values['title'];
    kind:=Integer(Request.ContentFields.Values['types'] = 'Blog');

    FDQuery1.Open('select MAX(id) OVER() max from titles;');
    id:=FDQuery1.FieldByName('max').AsInteger+1;
    FDQuery1.Close;

    FDQuery1.SQL.Text:='select * from titles where usernum = :id and url = :title;';
    FDQuery1.ParamByName('id').AsInteger:=db;
    FDQuery1.ParamByName('title').AsString:=title;
    FDQuery1.Open;
    if (name = '') or not FDQuery1.IsEmpty then
    begin
      FDQuery1.Close;
      Response.SendRedirect(Request.PathInfo);
    end;
    FDQuery1.Close;

    FDCommand1.CommandText.Text :='''
    INSERT INTO titles (usernum, name, pagecount, count, mentenance, pagetype, url, id)
    VALUES (:db, :title, :pagecount, :count, :mente, :kind, :url, :id)
    ''';

    FDCommand1.ParamByName('db').AsInteger:=db;
    FDCommand1.ParamByName('title').AsString:=name;
    FDCommand1.ParamByName('pagecount').AsInteger:=pagecount;
    FDCommand1.ParamByName('count').AsInteger:=count;
    FDCommand1.ParamByName('mente').AsBoolean:=mente;
    FDCommand1.ParamByName('kind').AsInteger:=kind;
    FDCommand1.ParamByName('url').AsString:=title;
    FDCommand1.ParamByName('id').AsInteger:=id;
    FDCommand1.Execute;
  end;
  FDQuery1.SQL.Text:='select * from titles where usernum = :num;';
  FDQuery1.ParamByName('num').AsInteger:=db;
  FDQuery1.Open;
  FDQuery2.SQL.Text:='select * from weblog where dbid = :id;';
  FDQuery2.ParamByName('id').AsInteger:=db;
  FDQuery2.Open;

  var data:=TData.Create;
  data.name:=user;

  WebStencilsProcessor9.AddVar('Titles',FDQuery1,false);
  WebStencilsProcessor9.AddVar('Items',FDQuery2,false);
  WebStencilsProcessor9.AddVar('Data',data);
  Response.ContentType := 'text/html;charset=utf8';
  Response.Content:=WebStencilsProcessor9.Content;
  FDQuery1.Close;
  FDQuery2.Close;
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
    INNER JOIN maintable mt ON dt.dbnumber = mt.dbnumber and dt.titlenum = mt.titlenum
    ORDER BY datetime desc;
    ''';
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
  USERName: TData;
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
      USERName:=TData.Create;
      if not FDQuery1.Eof then
      begin
        USERName.id:=FDQuery1.FieldByName('dbnumber').AsInteger;
        USERName.name:=FDQuery1.FieldByName('dbname').AsString;
        USERName.tag:=FDQuery1.FieldByName('nickname').AsString;
        FDQuery1.Next;
      end
      else
      begin
        USERName.id:=0;
        USERName.name:='未開放';
      end;
      slide.Items.Add(USERName);
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
  time: TDate;
  post: Boolean;
  js: TJSONObject;
  params: TArray<string>;
begin
  if Request.MethodType = mtGet then
  begin
    params:=Request.PathInfo.Split(['/']);
    try
      name:=params[1];
      title:=params[2];
    except
      raise;
      Exit;
    end;
    FDQuery1.SQL.Text:='''
      select * from datatable dt
      INNER JOIN titles t ON dt.dbnumber = t.usernum and dt.dbtitle = t.id
      INNER JOIN database ds ON dt.dbnumber = ds.dbnumber
      where ds.dbname = :id and t.url = :title;
      ''';
    FDQuery1.ParamByName('id').AsString:=name;
    FDQuery1.ParamByName('title').AsString:=title;
    FDQuery1.Open;
    id:=FDQuery1.FieldByName('dbnumber').AsInteger;
    tn:=FDQuery1.FieldByName('dbtitle').AsInteger;
    FDQuery1.Close;

    FDQuery1.SQL.Text:='''
      select * from datatable dt
      INNER JOIN maintable mt ON dt.dbnumber = mt.dbnumber and dt.titlenum = mt.titlenum
      INNER JOIN database ds ON dt.dbnumber = ds.dbnumber
      where dt.dbnumber = :id and dt.titlenum = :tn;
      ''';
    FDQuery1.ParamByName('id').AsInteger:=id;
    FDQuery1.ParamByName('tn').AsInteger:=tn;
    FDQuery1.Open;
    did:=FDQuery1.FieldByName('dbtitle').AsInteger;
    time := FDQuery1.FieldByName('datetime').AsDateTime;
    //title:=FDQuery1.FieldByName('title').AsString;
    name:=FDQuery1.FieldByName('name').AsString;
    text:=FDQuery1.FieldByName('comment').AsString;
    WebStencilsProcessor8.AddVar('main',FDQuery1,false);
    FDQuery1.Close;

    {
    bglist.Add('');
    bglist.Add('(*ユーザー様から報告がありました*)');
    bglist.Add('TODAY is ' + DateToStr(Now));
    bglist.Add(log);
    bglist.Add(text);
    bglist.Add('(*報告ここまで*)');
    bglist.Add('');
    log:=bglist.Text;
    bglist.Clear;}

    FDQuery1.Open('select max(id) as maxid from weblog;');
    if FDQuery1.IsEmpty then
      id:=1
    else
      id:=FDQuery1.FieldByName('maxid').AsInteger+1;
    FDQuery1.Close;

    FDCommand1.CommandText.Text:='''
      INSERT INTO weblog (id,time,log,dbid) VALUES (:id,:time,:log,:dbid);
      ''';
    FDCommand1.ParamByName('id').AsInteger:=id;
    FDCommand1.ParamByName('time').AsDate:=time;
    FDCommand1.ParamByName('log').AsString:=log;
    FDCommand1.ParamByName('dbid').AsInteger:=did;
    FDCommand1.Execute;

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
  Randomize;
  FDQuery1.Open('select * from proptable;');
  count:=FDQuery1.FieldByName('count').AsInteger;
  pagecount:=FDQuery1.FieldByName('pagecount').AsInteger;
  mente:=FDQuery1.FieldByName('mentenance').AsBoolean;
  FDQuery1.Close;

  count := if count = 0 then 30 else count;
  pagecount:=if pagecount = 0 then 10 else pagecount;

  adlist:=TStringList.Create;
  FDQuery1.Close;
  FDQuery1.Open('select * from adsense;');
  while not FDQuery1.Eof do
  begin
    adlist.Add(FDQuery1.FieldByName('ad').AsString);
    FDQuery1.Next;
  end;
  FDQuery1.Close;

  bglist := TStringList.Create;
end;

procedure TWebModule1.WebModuleDestroy(Sender: TObject);
begin
  FDQuery1.Open('select * from proptable;');
  FDQuery1.Edit;
  FDQuery1.FieldByName('count').AsInteger:=count;
  FDQuery1.FieldByName('pagecount').AsInteger:=pagecount;
  FDQuery1.FieldByName('mentenance').AsBoolean:=mente;
  FDQuery1.Post;
  FDQuery1.Close;
  adlist.Free;
  bglist.Free;
end;

procedure TWebModule1.WebStencilsProcessor1Value(Sender: TObject;
  const AObjectName, APropName: string; var AValue: string;
  var AHandled: Boolean);
begin
  if AObjectName = 'Ad' then
    AValue:=adlist[Random(adlist.Count)];
  if AObjectName = 'Script' then
    AValue:='bbs';
  if (AObjectName = 'Count')and(APropName = 'half') then
    AValue:=(FDQuery1.RecordCount div 2).ToString;
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
    AValue:=adlist[Random(adlist.Count)];
  if AObjectName = 'word' then
    AValue := mysearch.WordList;
end;

procedure TWebModule1.WebStencilsProcessor9Value(Sender: TObject;
  const AObjectName, APropName: string; var AValue: string;
  var AHandled: Boolean);
begin
end;

{ TPageSearch }

const
  str = '<span style=background-color:yellow>%s</span>';

function TPageSearch.checkState(var st: integer; i: integer; const word: string): TFindState;
var
  s: string;
  index: integer;
begin
  s:=FList[i].Substring(st).ToLower;
  if s.Contains(word) then
  begin
    inc(st,s.IndexOf(word));
    Exit(fdNormal);
  end
  else
  begin
    index:=s.LastIndexOf(word[1]);
    if (index > -1)and word.StartsWith(s.Substring(index)) then
    begin
      result:=fdShort;
      inc(st,index);
    end
    else
      result:=fdNone;
  end;
end;

constructor TPageSearch.Create;
begin
  FList := TStringList.Create;
end;

destructor TPageSearch.Destroy;
begin
  FList.Free;
  inherited;
end;

function TPageSearch.processNormal(id, ln: integer; word: string): integer;
var
  s, t: string;
  index: integer;
  wrd: string;
begin
  s:=FList[ln].Substring(id).ToLower;
  index:=s.IndexOf(word);
  wrd:=FList[ln].Substring(id+index,word.Length);
  t:=String.Format(str,[wrd])+FList[ln].Substring(id+index+word.Length);
  FList[ln]:=FList[ln].Remove(id)+t;
  result:=id+index+str.Length+word.Length;
end;

function TPageSearch.processShort(var id, ln: integer; const word: string): Boolean;
var
  wrd, line, small: string;
  index: integer;
  strings: TArray<string>;
begin
  index:=ln;
  line:=FList[index];
  wrd:=line.Substring(id);
  strings:=[line.Remove(id)+String.Format(str,[wrd])];

  //checking
  if not word.StartsWith(wrd) then
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

  small:=line.ToLower;
  if small.StartsWith(word.Substring(wrd.Length)) then
  begin
    id:=word.Length-wrd.Length;
    wrd:=wrd+line.Remove(id);
    strings:=strings+[String.Format(str,[line.Remove(id)])+line.Substring(id)];
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
  begin
    id:=0;
    ln:=Index+1;
    result:=false;
  end;
end;

function TPageSearch.Execute(var Text: string): Boolean;
var
  i, id: integer;
  state: TFindState;
begin
  initWordList;
  FList.Text := Text;
  result:=false;
  for var word in FBlindStr do
  begin
    i := 0;
    id := 0;
    while i < FList.count do
    begin
      state := checkState(id, i, word);
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
    for var s in FWordList.ToLower.Split([' ', '　']) do
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
