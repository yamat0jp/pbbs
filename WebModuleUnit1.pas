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
    FBool: Boolean;
  public
    property id: integer read FId write FId;
    property name: string read FName write FName;
    property tag: string read FTag write FTag;
    property bool: Boolean read FBool write FBool;
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
    WebStencilsProcessor10: TWebStencilsProcessor;
    WebStencilsProcessor11: TWebStencilsProcessor;
    WebStencilsProcessor12: TWebStencilsProcessor;
    procedure WebModuleCreate(Sender: TObject);
    procedure WebModule1alertAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1helpAction(Sender: TObject; Request: TWebRequest;
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
    procedure WebStencilsProcessor1Value(Sender: TObject; const AObjectName,
      APropName: string; var AValue: string; var AHandled: Boolean);
    procedure WebStencilsProcessor3Value(Sender: TObject; const AObjectName,
      APropName: string; var AValue: string; var AHandled: Boolean);
    procedure WebModule1WebActionItem1Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1WebActionItem2Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1WebActionItem4Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1loginAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
  private
    { private 宣言 }
    mysearch: TPageSearch;
    bglist, adlist: TStringList;
    procedure makeFooterNumber(id, max: integer; out link: TObjectList<TData>);
    function replaceRawData(const Data: string): string;
    function readRecNo(index,userid,titleid: integer; Query: TFDQuery): integer;
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

uses System.IOUtils, System.Math;

// Request.ContentFields の代わりに使用する安全な関数
function GetSafePostValue(Request: TWebRequest; const FieldName: string): string;
var
  RawBytes: TBytes;
  RawStr: string;
  Params, Pair: TArray<string>;
  P: string;
begin
  Result := '';

  // 1. 生のバイトデータを取得（OSの文字コード干渉を完全に防ぐ）
  RawBytes := Request.RawContent;

  // ※もしISAPIなどで長文が切れる（RawContentが空、またはサイズ不足）場合のフェイルセーフ
  if (Length(RawBytes) = 0) and (Request.ContentLength > 0) then
  begin
    RawStr := Request.ReadString(Request.ContentLength);
  end
  else
  begin
    // URLエンコードされたデータはASCIIのみで構成されるため、ASCIIとして文字列化
    RawStr := TEncoding.ASCII.GetString(RawBytes);
  end;

  if RawStr = '' then Exit;

  // 2. TStringList のバグを避けるため、String.Split で安全に '&' を分割
  Params := RawStr.Split(['&']);

  for P in Params do
  begin
    // 3. '=' で名前と値に分割
    Pair := P.Split(['=']);
    if (Length(Pair) = 2) and SameText(Pair[0], FieldName) then
    begin
      try
        // 4. 空白の処理と、UTF-8としてのURLデコード
        Result := TNetEncoding.URL.Decode(Pair[1].Replace('+', ' '))
          .Replace(#0,'',[rfReplaceAll]).Replace(#1,#2,[rfReplaceAll]);
      except
        // 万が一、ユーザーが不正なパーセントエンコードを送ってきた場合のエラー回避
        on E: Exception do
          Result := ''; // またはエラーログを出力
      end;
      Break;
    end;
  end;
end;

procedure TWebModule1.makeFooterNumber(id, max: integer;out link: TObjectList<TData>);
var
  url: TData;
begin
  link:=TObjectList<TData>.Create;
  for var i := 1 to max do
  begin
    url:=TData.Create;
    url.id:=i;
    url.name:=if id = i then 'active' else '';
    link.Add(url);
  end;
end;

function TWebModule1.readRecNo(index, userid, titleid: integer;
  Query: TFDQuery): integer;
begin
  Query.SQL.Text:='''
    select titlenum from datatable where dbnumber = :userid and dbtitle = :dbtitle
    ORDER BY titlenum;
    ''';
  Query.ParamByName('userid').AsInteger:=userid;
  Query.ParamByName('dbtitle').AsInteger:=titleid;
  Query.Open;
  if Query.Locate('titlenum',index) then
    result:=Query.RecNo
  else
    result:=0;
  Query.Close;
end;

function TWebModule1.replaceRawData(const Data: string): string;
const
  ng = '死ね,阿保,馬鹿,殺す,爆破';
begin
  for var s in ng.Split([',']) do
    result:=TNetEncoding.HTML.Encode(Data.Replace(s,'*****',[rfReplaceAll,rfIgnoreCase]));
end;

procedure TWebModule1.WebModule1adminPageAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  db, index, page, temp, rec: integer;
  count, pagecount: integer;
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
  pagecount:=25;
  count:=30;
  FDQuery1.Close;

  if Request.MethodType = mtPost then
  begin
    nums:=[];
    for var i := 0 to Request.ContentFields.Count-1 do
      if Request.ContentFields.Names[i] = 'datas[]' then
      begin
        var val: integer;
        if TryStrToInt(Request.ContentFields.ValueFromIndex[i],val) then
          nums:=nums+[val.ToString];
      end;
    var numbers:=String.Join(',',nums);
    if numbers <> '' then
    begin
      FDTransaction1.StartTransaction;
      try
        FDCommand1.CommandText.Text:=
          'UPDATE datatable SET name='''' where dbnumber = :db and dbtitle = :id and titlenum IN (&tnums);';
        FDCommand1.ParamByName('db').AsInteger:=db;
        FDCommand1.ParamByName('id').AsInteger:=index;
        FDCommand1.MacroByName('tnums').AsRaw:=numbers;
        FDCommand1.Execute;

        FDCommand1.CommandText.Text:=
          'UPDATE maintable SET comment='''',code='''' where dbnumber = :db and dbtitle = :id and titlenum IN (&tnums);';
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
    select t.name as pagetitle,dt.titlenum,dt.name,mt.comment
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

  makeFooterNumber(page,pagecount,items);
  data:=TData.Create;
  data.id:=0;
  data.name:=if page = 0 then 'active' else '';
  WebStencilsProcessor3.AddVar('Items',items);
  WebStencilsProcessor3.AddVar('Info',data);

  Response.ContentType := 'text/html;charset=utf8;';
  Response.Content:=WebStencilsProcessor3.Content;
  FDQuery1.Close;
end;

procedure TWebModule1.WebModule1mainItemAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  user, raw, code, name, title, dbname: string;
  userid, page0, page, temp, rec, tid, dbtitle: integer;
  count, pagecount: integer;
  params: TArray<string>;
  items: TObjectList<TData>;
  data: TData;
  mainte: Boolean;
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
    select * from titles t INNER JOIN database ds ON t.usernum = ds.dbnumber
    where ds.nickname = :user and t.url = :title;
    ''';
  FDQuery1.ParamByName('user').AsString:=user;
  FDQuery1.ParamByName('title').AsString:=title;
  FDQuery1.Open;
  userid:=FDQuery1.FieldByName('usernum').AsInteger;
  dbtitle:=FDQuery1.FieldByName('id').AsInteger;
  dbname:=FDQuery1.FieldByName('name').AsString;
  mainte:=FDQuery1.FieldByName('maintenance').AsBoolean;
  pagecount:=FDQuery1.FieldByName('pagecount').AsInteger;
  count:=FDQuery1.FieldByName('count').AsInteger;
  FDQuery1.Close;
  if mainte then
  begin
    Response.ContentType := 'text/html;charset=utf8';
    Response.Content := WebStencilsProcessor11.Content;
    Exit;
  end;
  FDQuery1.SQL.Text:=
    'select COUNT(titlenum) cnt from datatable where dbnumber = :userid and dbtitle = :dbtitle;';
  FDQuery1.ParamByName('userid').AsInteger:=userid;
  FDQuery1.ParamByName('dbtitle').AsInteger:=dbtitle;
  FDQuery1.Open;
  if (page = 0)and(Request.QueryFields.Values['recno'] <> '') then
  begin
    temp:=Request.QueryFields.Values['recno'].ToInteger;
    rec:=readRecNo(temp,userid,dbtitle,FDQuery2);
  end
  else
    rec:=FDQuery1.FieldByName('cnt').AsInteger;
  if (page = 0)or(page > rec div count+1) then
  begin
    temp:=rec div count+1;
    if page > 0 then
      page:=temp;
  end;
  FDQuery1.Close;

  FDQuery1.SQL.Text:='''
    select t.name as pagetitle,ds.dbname,ds.nickname,dt.titlenum,
    comment,code,datetime,dt.name,t.url,MAX(dt.titlenum) OVER() AS max from datatable dt
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
    name:=replaceRawData(Request.ContentFields.Values['name']);
    raw:=replaceRawData(Request.ContentFields.Values['comment']);
    code:=replaceRawData(Request.ContentFields.Values['code']);

    FDTransaction1.StartTransaction;
    try
      FDCommand1.CommandText.Text :='''
        INSERT INTO DATATABLE (dbnumber, titlenum, name, dbtitle)
        VALUES (:db, :tid, :name, :dbtitle)
        ''';
      FDCommand1.ParamByName('db').AsInteger:=userid;
      FDCommand1.ParamByName('tid').AsInteger:=tid;
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
    FDQuery1.Refresh;
  end;

  WebStencilsProcessor1.AddVar('MainItems',FDQuery1,false);

  makeFooterNumber(page,pagecount,items);
  data:=TData.Create;
  data.id:=0;
  data.name:=if page = 0 then 'active' else '';
  data.bool:=true;
  WebStencilsProcessor1.AddVar('Items',items);
  WebStencilsProcessor1.AddVar('Footer',data);

  data:=TData.Create;
  data.id:=rec div 2;
  data.name:=dbname;
  WebStencilsProcessor1.AddVar('Count',data);

  Response.ContentType := 'text/html;charset=utf8';
  Response.Content := WebStencilsProcessor1.Content;
  FDQuery1.Close;
end;

procedure TWebModule1.WebModule1membersAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  user, name, title: string;
  count, pagecount: integer;
  mainte: Boolean;
  id, kind, db: integer;
  params: TArray<string>;
begin
// クライアントから送信されたCookieを取得
  var AuthToken := Request.CookieFields.Values['AuthToken'];

  // トークンの検証（簡易的なチェック）
  if not AuthToken.StartsWith('valid_session_') then
  begin
    // 未認証の場合はログイン画面へリダイレクト
    Response.SendRedirect('/login');
    Exit;
  end;

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
    mainte:=false;
    count:=0;
    pagecount:=0;
    case kind of
      0:
        begin
          pagecount:=10;
          count:=30;
        end;
      1:
        begin
          pagecount:=20;
          count:=8;
        end;
    end;

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
    INSERT INTO titles (usernum, name, pagecount, count, maintenance, pagetype, url, id)
    VALUES (:db, :title, :pagecount, :count, :mainte, :kind, :url, :id)
    ''';

    FDCommand1.ParamByName('db').AsInteger:=db;
    FDCommand1.ParamByName('title').AsString:=name;
    FDCommand1.ParamByName('pagecount').AsInteger:=pagecount;
    FDCommand1.ParamByName('count').AsInteger:=count;
    FDCommand1.ParamByName('mainte').AsBoolean:=mainte;
    FDCommand1.ParamByName('kind').AsInteger:=kind;
    FDCommand1.ParamByName('url').AsString:=title;
    FDCommand1.ParamByName('id').AsInteger:=id;
    FDCommand1.Execute;
  end
  else if Request.QueryFields.Count > 0 then
  begin
    id:=Request.QueryFields.Values['del'].ToInteger;
    FDCommand1.CommandText.Text:='DELETE FROM weblog where id = :id;';
    FDCommand1.ParamByName('id').AsInteger:=id;
    FDCommand1.Execute;
  end;
  FDQuery1.SQL.Text:='select * from titles where usernum = :num ORDER BY id;';
  FDQuery1.ParamByName('num').AsInteger:=db;
  FDQuery1.Open;
  FDQuery2.SQL.Text:='select * from weblog where dbid = :id ORDER BY id asc;';
  FDQuery2.ParamByName('id').AsInteger:=db;
  FDQuery2.Open;

  var data:=TData.Create;
  data.name:=user;

  WebStencilsProcessor9.AddVar('Titles',FDQuery1,false);
  WebStencilsProcessor9.AddVar('Logs',FDQuery2,false);
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
  params: TArray<string>;
  user, title: string;
  userid, titleid: integer;
begin
  params:=Request.PathInfo.Split(['/']);
  user:=params[2];
  title:=params[3];
  FDQuery1.SQL.Text:='''
    select * from database ds INNER JOIN titles t ON ds.dbnumber = t.usernum
    where ds.nickname = :user and t.url = :title;
    ''';
  FDQuery1.ParamByName('user').AsString:=user;
  FDQuery1.ParamByName('title').AsString:=title;
  FDQuery1.Open;
  userid:=FDQuery1.FieldByName('usernum').AsInteger;
  titleid:=FDQuery1.FieldByName('id').AsInteger;
  FDQuery1.Close;
  words:=Request.ContentFields.Values['word1'];
  FDQuery1.SQL.Text:='''
    select * from datatable dt
    INNER JOIN database ON dt.dbnumber = database.dbnumber
    INNER JOIN maintable mt ON dt.dbnumber = mt.dbnumber
    and dt.titlenum = mt.titlenum and dt.dbtitle = mt.dbtitle
    where dt.dbnumber = :userid and dt.dbtitle = :titleid
    ''';
  var bool:=Request.ContentFields.Values['filter'] = 'name';
  if bool then
  begin
    FDQuery1.SQL.Add('and dt.name = :name');
    FDQuery1.SQL.Add('ORDER BY datetime desc;');
    FDQuery1.ParamByName('name').AsString:=words;
  end
  else
    FDQuery1.SQL.Add('ORDER BY datetime desc;');
  FDQuery1.ParamByName('userid').AsInteger:=userid;
  FDQuery1.ParamByName('titleid').AsInteger:=titleid;
  FDQuery1.Open;
  var data:=TData.Create;
  data.name:=words;
  data.bool:=false;
  if not bool then
  begin
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
        main.comment:=s;
        main.name:=FDQuery1.FieldByName('name').AsString;
        main.datetime:=FDQuery1.FieldByName('datetime').AsDateTime;
        ls.Add(main);
        FDQuery1.Next;
      end;
      words:=mysearch.WordList;
    finally
      mysearch.Free;
    end;
    WebStencilsProcessor6.AddVar('Datas',ls);
  end
  else
    WebStencilsProcessor6.AddVar('Datas',FDQuery1,false);
  WebStencilsProcessor6.AddVar('Bool',data);
  Response.ContentType := 'text/html;charset=utf8';
  Response.Content := WebStencilsProcessor6.Content;
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
        USERName.name:='未加入';
      end;
      slide.Items.Add(USERName);
    end;
  end;
  WebStencilsProcessor2.AddVar('Slides',ls);
  Response.ContentType := 'text/html;charset=utf8';
  Response.Content := WebStencilsProcessor2.Content;
  FDQuery1.Close;
end;

procedure TWebModule1.WebModule1WebActionItem1Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  params: TArray<string>;
  user, title: string;
begin
  params:=Request.PathInfo.Split(['/']);
  if High(params) < 3 then
    Exit;
  user:=params[2];
  title:=params[3];
  FDQuery1.SQL.Text:='''
    select * from titles t INNER JOIN database ds ON t.usernum = ds.dbnumber
    where t.url = :title and ds.nickname = :user;
    ''';
  FDQuery1.ParamByName('user').AsString:=user;
  FDQuery1.ParamByName('title').AsString:=title;
  FDQuery1.Open;
  if Request.MethodType = mtPost then
  begin
    FDCommand1.CommandText.Text:='''
      UPDATE titles SET pagecount = :pcnt,count = :cnt,maintenance = :mainte
      where id = :id and usernum = :userid;
      ''';
    FDCommand1.ParamByName('pcnt').AsInteger:=Request.ContentFields.Values['pagecount'].ToInteger;
    FDCommand1.ParamByName('cnt').AsInteger:=Request.ContentFields.Values['count'].ToInteger;
    FDCommand1.ParamByName('mainte').AsBoolean:=Request.ContentFields.Values['maintenance'] = 'on';
    FDCommand1.ParamByName('id').AsInteger:=FDQuery1.FieldByName('id').AsInteger;
    FDCommand1.ParamByName('userid').AsInteger:=FDQuery1.FieldByName('usernum').AsInteger;
    FDCommand1.Execute;
    FDQuery1.Refresh;
  end;
  WebStencilsProcessor10.AddVar('Datas',FDQuery1,false);
  Response.ContentType:='text/html;charset=utf-8';
  Response.Content:=WebStencilsProcessor10.Content;
  FDQuery1.Close;
end;

procedure TWebModule1.WebModule1WebActionItem2Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  filter: string;
begin
  var data:=TData.Create;
  data.name:=Request.ContentFields.Values['word1'];
  filter:=Request.ContentFields.Values['filter'];
  if Request.MethodType = mtPost then
  begin
    {FDCommand1.CommandText.Text:='''
        -- PGroonga エクステンションの有効化
      CREATE EXTENSION IF NOT EXISTS pgroonga;

      -- 全文検索用インデックスの作成
      CREATE INDEX IF NOT EXISTS idx_maintable_comment_pgroonga
      ON maintable
      USING pgroonga (comment);
      ''';
    FDCommand1.Execute;}
    FDQuery1.SQL.Text:='''
      SELECT dt.titlenum, mt.comment, mt.datetime, dt.name, ds.dbname
      FROM datatable dt
      INNER JOIN database ds
      ON dt.dbnumber = ds.dbnumber
      INNER JOIN maintable mt
      ON dt.dbnumber = mt.dbnumber AND dt.titlenum = mt.titlenum AND dt.dbtitle = mt.dbtitle
      ''';
    if filter = 'name' then
      FDQuery1.SQL.Add('WHERE dt.name &@~ :search')
    else
      FDQuery1.SQL.Add('WHERE mt.comment &@~ :search');
    FDQuery1.SQL.Add('ORDER BY mt.datetime DESC;');
    FDQuery1.ParamByName('search').AsString:=data.name;
    FDQuery1.Open;
    WebStencilsProcessor4.AddVar('Supers',FDQuery1,false);
  end;
  WebStencilsProcessor4.AddVar('Word',data);
  Response.ContentType:='text/html;charset=utf8';
  Response.Content:=WebStencilsProcessor4.Content;
  FDQuery1.Close;
end;

procedure TWebModule1.WebModule1WebActionItem4Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.CustomHeaders.Add('Set-Cookie: AuthToken=; Expires=Thu, 01 Jan 1970 00:00:00 GMT; Path=/; HttpOnly');
  Response.SendRedirect('/login');
end;

procedure TWebModule1.WebModule1alertAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  id, did, tn: integer;
  log, name, title, username, dbtitle, text, msg: string;
  time: TDate;
  data: TData;
  params: TArray<string>;
begin
  data:=TData.Create;
  params:=Request.PathInfo.Split(['/']);
  try
    username:=params[2];
    dbtitle:=params[3];
    tn:=params[4].ToInteger;
  except
    raise;
    Exit;
  end;
  FDQuery1.SQL.Text:='''
    select * from datatable dt
    INNER JOIN maintable mt ON dt.dbnumber = mt.dbnumber and dt.titlenum = mt.titlenum
    INNER JOIN database ds ON dt.dbnumber = ds.dbnumber
    INNER JOIN titles t ON dt.dbtitle = t.id
    where dt.titlenum = :tn and ds.nickname = :user and t.url = :title;
    ''';
  FDQuery1.ParamByName('user').AsString:=username;
  FDQuery1.ParamByName('title').AsString:=dbtitle;
  FDQuery1.ParamByName('tn').AsInteger:=tn;
  FDQuery1.Open;
  if Request.MethodType = mtGet then
  begin
    data.bool:=false;
    WebStencilsProcessor8.AddVar('main',FDQuery1,false);
  end
  else
  begin
    time := FDQuery1.FieldByName('datetime').AsDateTime;
    title:=FDQuery1.FieldByName('title').AsString;
    name:=FDQuery1.FieldByName('name').AsString;
    text:=FDQuery1.FieldByName('comment').AsString;
    msg:=Request.ContentFields.Values['com'];
    log:=String.Format('''
      <pre>

      (*ユーザー様から報告がありました*)
      TODAY is %s
      <a href="/bbs/%s/%s?recno=%d">[%s - %d]</a>
      %s

      %s
      </pre>
      ''',[DateToStr(Now),username,dbtitle,tn,dbtitle,tn,text,msg]);
    did:=FDQuery1.FieldByName('dbnumber').AsInteger;

    FDQuery1.Open('select max(id) as maxid from weblog;');
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

    data.bool:=true;
  end;
  WebStencilsProcessor8.AddVar('Post',data);
  Response.ContentType:='text/html;charset=utf8';
  Response.Content:=WebStencilsProcessor8.Content;
  FDQuery1.Close;
end;

procedure TWebModule1.WebModule1helpAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  id, userid: integer;
  params: TArray<string>;
  user, title, text: string;
  data: TData;
begin
  data:=TData.Create;
  if Request.MethodType = mtPost then
  begin
    params:=Request.PathInfo.Split(['/']);
    user:=params[2];
    title:=params[3];
    FDQuery1.SQL.Text:=
      'select * from database where nickname = :user';
    FDQuery1.ParamByName('user').AsString:=user;
    FDQuery1.Open;
    userid:=FDQuery1.FieldByName('dbnumber').AsInteger;
    FDQuery1.Close;
    text:=String.Format('''
      <pre>

      (*%sにてユーザー様から報告がありました*)
      %s
      (*報告ここまで*)
      </pre>
      ''',[title,Request.ContentFields.Values['help']]);
    FDQuery1.Open('select max(id) as maxid from weblog;');
    id:=FDQuery1.FieldByName('maxid').AsInteger+1;
    FDQuery1.Close;
    FDCommand1.CommandText.Text:=
      'INSERT INTO weblog (id,time,log,dbid) VALUES (:id,:time,:log,:dbid);';
    FDCommand1.ParamByName('id').AsInteger:=id;
    FDCommand1.ParamByName('time').AsDate:=Now;
    FDCommand1.ParamByName('log').AsString:=text;
    FDCommand1.ParamByName('dbid').AsInteger:=userid;
    FDCommand1.Execute;
    data.bool:=true;
  end
  else
    data.bool:=false;
  WebStencilsProcessor7.AddVar('Help',data);
  Response.ContentType := 'text/html;charset=utf8';
  Response.Content := WebStencilsProcessor7.Content;
end;

procedure TWebModule1.WebModule1loginAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  inputpass, inputname: string;
begin
  if Request.MethodType = mtPost then
  begin
    inputname:=Request.ContentFields.Values['username'];
    inputpass:=Request.ContentFields.Values['password'];
    FDQuery1.SQL.Text:=
      'select dbnumber,nickname from database where dbname = :u and password_hash = :p';
    FDQuery1.ParamByName('u').AsString:=inputname;
    FDQuery1.ParamByName('p').AsString:=inputpass;
    FDQuery1.Open;
    if not FDQuery1.IsEmpty then
    begin
      with Response.Cookies.Add do
      begin
        Name := 'AuthToken';
        Value := 'valid_session_' + Inputname;
        Path := '/';
        HttpOnly := True; // JavaScriptからの不正アクセス(XSS)を防止
        Secure := False;  // 実運用でHTTPS(SSL)を使用する場合は True に変更します
      end;
      Response.SendRedirect('/members/'+FDQuery1.FieldByName('nickname').AsString);
      FDQuery1.Close;
      Exit;
    end;
    var data:=TData.Create;
    data.name:='ユーザー名またはパスワードがまちがっています。';
    WebStencilsProcessor12.AddVar('Msg',data);
  end;
  Response.ContentType:='text/html;charset=utf8';
  Response.Content:=WebStencilsProcessor12.Content;
  FDQuery1.Close;
end;

procedure TWebModule1.WebModuleCreate(Sender: TObject);
begin
  Randomize;
  adlist:=TStringList.Create;
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
end;

{ TPageSearch }

function TPageSearch.checkState(var st: integer; i: integer; const word: string): TFindState;
var
  s: string;
  index: integer;
begin
  s:=FList[i].Substring(st).ToLower;
  if s.Contains(word) then
    Exit(fdNormal)
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
  t:=#1+wrd+#2+FList[ln].Substring(id+index+word.Length);
  FList[ln]:=FList[ln].Remove(id+index)+t;
  result:=id+index+4+word.Length;
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
  strings:=[line.Remove(id)+#1+wrd+#2];

  //checking
  if not word.StartsWith(wrd) then
    Exit(false);

  while FList.Count-1 > ln do
  begin
    line:=FList[ln+1];
    if line.Length+wrd.Length < word.Length then
    begin
      strings:=strings+[#1+line+#2];
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
    inc(ln);
    wrd:=wrd+line.Remove(id);
    small:=#1+line.Remove(id)+#2;
    strings:=strings+[small+line.Substring(id)];
    inc(id,small.Length);
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
          if processShort(id, i, word) then
            result:=true;
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
    Text:=FList.Text.Replace(#1,'<span style="background-color:yellow">').Replace(#2,'</span>');
end;

procedure TPageSearch.initWordList;
var
  lst: TDictionary<string, integer>;
  max: integer;
  tmp: string;
begin
  lst := TDictionary<string, integer>.Create;
  try
    for var s in TNetEncoding.HTML.Encode(FWordList.ToLower).Split([' ', '　']) do
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
