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
    FCode: string;
  public
    property database: string read FDatabase write FDatabase;
    property titlenum: integer read FTitlenum write FTitlenum;
    property title: string read FTitle write FTitle;
    property name: string read FName write FName;
    property datetime: TDatetime read FDatetime write FDatetime;
    property comment: string read FComment write FComment;
    property code: string read FCode write FCode;
  end;

  TWebModule1 = class(TWebModule)
    FDConnection1: TFDConnection;
    WebFileDispatcher1: TWebFileDispatcher;
    FDQuery1: TFDQuery;
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
    WebStencilsProcessor13: TWebStencilsProcessor;
    WebStencilsProcessor14: TWebStencilsProcessor;
    WebStencilsProcessor15: TWebStencilsProcessor;
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
    procedure WebModule1WebActionItem6Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1WebActionItem5Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1WebActionItem7Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1WebActionItem8Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1WebActionItem9Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleBeforeDispatch(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleAfterDispatch(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
  private
    { private 宣言 }
    mysearch: TPageSearch;
    bglist, adlist: TStringList;
    userdata: TData;
    procedure makeFooterNumber(id, max: integer; out link: TObjectList<TData>);
    function replaceRawData(const Data: string): string;
    function readRecNo(index,userid,titleid: integer; Query: TFDQuery): integer;
    procedure AddCookie(const name: string; auto: Boolean);
    function HashValidator(const Validator: string): string;
    function GenerateSelector: string;
    function GenerateValidator: string;
    function VerifyRememberMe(const CookieValue: string): Boolean;
    function IsLogin(const CookieValue, url: string): Boolean;
  public
    { public 宣言 }
    function VerifyLogin(const Username,InputPassword: string): Boolean;
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

uses System.IOUtils, System.Math, Bcrypt, System.Hash, System.DateUtils;

function TWebModule1.VerifyLogin(const Username, InputPassword: string): Boolean;
var
  StoredHash: string;
  rehash: Boolean;
begin
  // 1. データベースから該当ユーザーのハッシュ値を取得
  FDQuery1.SQL.Text:='SELECT password_hash,dbnumber,nickname FROM database WHERE dbname = :U;';
  FDQuery1.ParamByName('U').AsString:=Username;
  FDQuery1.Open;
  StoredHash:=FDQuery1.FieldByName('password_hash').AsString;
  userdata.id:=FDQuery1.FieldByName('dbnumber').AsInteger;
  userdata.name:=username;
  userdata.tag:=FDQuery1.FieldByName('nickname').AsString;
  FDQuery1.Close;

  if StoredHash = '' then
    Exit(False); // ユーザーが存在しない場合

  // 2. 入力パスワードと保存済みハッシュを照合
  // 内部でStoredHashからソルトとワークファクターを自動抽出し、同じ条件でハッシュ化して比較します
  Result := TBcrypt.CheckPassword(InputPassword, StoredHash, rehash);
  if rehash then
  begin
    FDCommand1.CommandText.Text:=
      'UPDATE database SET password_hash = :hash where dbname = :U;';
    FDCommand1.ParamByName('hash').AsString:=TBcrypt.HashPassword(inputpassword);
    FDCommand1.ParamByName('U').AsString:=username;
    FDCommand1.Execute;
  end;
end;

function TWebModule1.VerifyRememberMe(const CookieValue: string): Boolean;
begin
  if IsLogin(CookieValue,userdata.tag) then
  begin
    FDQuery1.SQL.Text:='select authtype,auto from token where number = :n;';
    FDQuery1.ParamByName('n').AsInteger:=userdata.id;
    FDQuery1.Open;
    result:= (FDQuery1.FieldByName('authtype').AsString = 'PASSWORD')
      or FDQuery1.FieldByName('auto').AsBoolean;
    FDQuery1.Close;
  end
  else
    result:=false;
  FDCommand1.CommandText.Text:=
    'UPDATE token SET authtype = ''REMEMBER'' where number = :n;';
  FDCommand1.ParamByName('n').AsInteger:=userdata.id;
  FDCommand1.Execute;
end;

procedure TWebModule1.AddCookie(const name: string; auto: Boolean);
var
  SessionToken, selector, validator, validatorhash: string;
begin
  selector:=GenerateSelector;
  validator:=GenerateValidator;
  validatorhash:=HashValidator(validator);

  FDCommand1.CommandText.Text:='''
    INSERT INTO token (selector,validatorhash,expiresAt,number,authtype,auto)
    VALUES (:s,:vh,:exp,:num,:a,:au)
    ON CONFLICT (number)
    DO UPDATE SET selector = :s, validatorhash = :vh, ExpiresAt = :exp,
    authtype = :a, auto = :au;
    ''';
  FDCommand1.ParamByName('s').AsString:=selector;
  FDCommand1.ParamByName('vh').AsString:=validatorhash;
  FDCommand1.ParamByName('exp').AsDate:=Now+3;
  FDCommand1.ParamByName('num').AsInteger:=userdata.id;
  FDCommand1.ParamByName('a').AsString:='PASSWORD';
  FDCommand1.ParamByName('au').AsBoolean:=auto;
  FDCommand1.Execute;

  SessionToken:=selector+'-'+validator;
  with Response.Cookies.Add do
  begin
    Name := 'AuthToken';
    Value := SessionToken;
    Path := '/';
    HttpOnly := True; // JavaScriptからの不正アクセス(XSS)を防止
    Secure := true;  // 実運用でHTTPS(SSL)を使用する場合は True に変更します
    SameSite := 'strict';
    Expires:=Now+3;
  end;
end;

function TWebModule1.GenerateSelector: string;
begin
  result:=TGUID.NewGuid.ToString.Replace('{','').Replace('}','').Replace('-','').ToLower;
end;

function TWebModule1.GenerateValidator: string;
begin
  result:=GenerateSelector+GenerateSelector;
end;

function TWebModule1.HashValidator(const Validator: string): string;
begin
  // System.Hash.THashSHA2 を使用
  Result := THashSHA2.GetHashString(Validator, THashSHA2.TSHA2Version.SHA256).ToLower;
end;

function TWebModule1.IsLogin(const CookieValue, url: string): Boolean;
var
  clientselector, clientvalidator, dbvalidator: string;
  params: TArray<string>;
begin
  FDQuery1.SQL.Text:='''
    select validatorhash from token INNRE JOIN database ds
    ON number = dbnumber where ds.nickname = :u;
    ''';
  FDQuery1.ParamByName('u').AsString:=url;
  FDQuery1.Open;
  dbvalidator:=FDQuery1.FieldByName('validatorhash').AsString;
  FDQuery1.Close;

  params := CookieValue.Split(['-']);
  if Length(params) <> 2 then
    Exit(false);
  clientselector:=params[0];
  clientvalidator:=params[1];
  result:=HashValidator(clientvalidator)=dbvalidator;
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
  result:=TNetEncoding.HTML.Encode(Data);
  for var s in ng.Split([',']) do
    result:=result.Replace(s,'*****',[rfReplaceAll,rfIgnoreCase]);
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
    Response.SendRedirect(String.Join('/',['/admin',user,title,page]));
    Exit;
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
  user, title, dbname: string;
  userid, page, temp, rec, dbtitle: integer;
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
  except
    Handled:=false;
    Exit;
  end;
  FDQuery1.SQL.Text:='''
    select usernum,id,name,maintenance,pagecount,count from titles t
    INNER JOIN database ds ON t.usernum = ds.dbnumber
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
    'select COUNT(titlenum) as cnt from datatable where dbnumber = :userid and dbtitle = :dbtitle;';
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
    select t.name as pagetitle,ds.dbname,ds.nickname,dt.titlenum,comment,code,
    datetime,dt.name,t.url from datatable dt
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
  title, url: string;
  count, pagecount: integer;
  mainte: Boolean;
  id: integer;
begin
  if Request.MethodType = mtPost then
  begin
    title:=Request.ContentFields.Values['name'];
    url := Request.ContentFields.Values['title'];
    mainte:=false;
    pagecount:=10;
    count:=30;

    FDQuery1.Open('select MAX(id) as max from titles;');
    id:=FDQuery1.FieldByName('max').AsInteger+1;
    FDQuery1.Close;

    FDQuery1.SQL.Text:='select id from titles where usernum = :id and (name = :title or url = :url);';
    FDQuery1.ParamByName('id').AsInteger:=userdata.id;
    FDQuery1.ParamByName('title').AsString:=title;
    FDQuery1.ParamByName('url').AsString:=url;
    FDQuery1.Open;
    if (title = '')or(url = '') or not FDQuery1.IsEmpty then
    begin
      FDQuery1.Close;
      Response.SendRedirect(Request.PathInfo);
      Exit;
    end;
    FDQuery1.Close;

    FDCommand1.CommandText.Text :='''
    INSERT INTO titles (usernum, name, pagecount, count, maintenance, url, id)
    VALUES (:db, :title, :pagecount, :count, :mainte, :url, :id)
    ''';

    FDCommand1.ParamByName('db').AsInteger:=userdata.id;
    FDCommand1.ParamByName('title').AsString:=title;
    FDCommand1.ParamByName('pagecount').AsInteger:=pagecount;
    FDCommand1.ParamByName('count').AsInteger:=count;
    FDCommand1.ParamByName('mainte').AsBoolean:=mainte;
    FDCommand1.ParamByName('url').AsString:=userdata.tag;
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
  FDQuery1.ParamByName('num').AsInteger:=userdata.id;
  FDQuery1.Open;
  FDQuery2.SQL.Text:='select * from weblog where dbid = :id ORDER BY id asc;';
  FDQuery2.ParamByName('id').AsInteger:=userdata.id;
  FDQuery2.Open;

  var data:=TData.Create;
  data.name:=userdata.name;

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
    select usernum,id from database ds INNER JOIN titles t
    ON ds.dbnumber = t.usernum where ds.nickname = :user and t.url = :title;
    ''';
  FDQuery1.ParamByName('user').AsString:=user;
  FDQuery1.ParamByName('title').AsString:=title;
  FDQuery1.Open;
  userid:=FDQuery1.FieldByName('usernum').AsInteger;
  titleid:=FDQuery1.FieldByName('id').AsInteger;
  FDQuery1.Close;
  words:=Request.ContentFields.Values['word1'].Trim;
  FDQuery1.SQL.Text:='''
    select dbname,dt.titlenum,name,datetime,comment,code from datatable dt
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
        main.code:=FDQuery1.FieldByName('code').AsString;
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
  token: string;
begin
  token:=Request.CookieFields.Values['AuthToken'];
  if VerifyRememberMe(token) then
  begin
    FDQuery1.SQL.Text:='select super_master from token where number = :n;';
    FDQuery1.ParamByName('n').AsInteger:=userdata.id;
    FDQuery1.Open;
    if FDQUery1.FieldByName('super_master').AsBoolean = false then
    begin
      FDQuery1.Close;
      Response.SendRedirect('/masters/'+userdata.tag);
      Exit;
    end;
  end
  else
  begin
    FDQuery1.Close;
    REsponse.SendRedirect('/masters');
    Exit;
  end;
  FDQuery1.Close;

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
    select id,usernum from titles t INNER JOIN database ds ON t.usernum = ds.dbnumber
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
      SELECT dt.titlenum, mt.comment, mt.code, mt.datetime, dt.name, ds.dbname
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
    FDQuery1.ParamByName('search').AsString:=data.name.Trim;
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
var
  params: TArray<string>;
begin
  params:=Request.PathInfo.Split(['/']);
  if not IsLogin(Request.CookieFields.Values['AuthToken'],params[2]) then
    Exit;
  with Response.Cookies.Add do
  begin
    name:='AuthToken';
    value:='';
    Expires:=0;
    Path:='/';
    HttpOnly:=true;
    Secure:=true;
  end;
  FDCommand1.CommandText.Text:=
    'DELETE FROM token where number = :num;';
  FDCommand1.ParamByName('num').AsInteger:=userdata.id;
  FDCommand1.Execute;
  Response.SendRedirect('/home');
end;

procedure TWebModule1.WebModule1WebActionItem5Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  data, data2: TData;
begin
  data:=TData.Create;
  data2:=TData.Create;
  data.name:='';
  data.tag:='';
  data2.name:='';
  data2.tag:='';
  WebStencilsProcessor13.AddVar('Msg',data);
  WebStencilsProcessor13.AddVar('Name',data2);
  Response.ContentType:='text/html;charset=utf8';
  Response.Content:=WebStencilsProcessor13.Content;
end;

procedure TWebModule1.WebModule1WebActionItem6Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  nickname, username, email, password: string;
  max: integer;
begin
  username:=Request.ContentFields.Values['username'];
  nickname:=Request.ContentFields.Values['nickname'];
  email:=Request.ContentFields.Values['email'];
  password:=Request.ContentFields.Values['password'];
  FDQuery1.SQL.Text:=
    'select dbname from database where dbname = :n or nickname = :nn;';
  FDQuery1.ParamByName('n').AsString:=username;
  FDQuery1.ParamByName('nn').AsString:=nickname;
  FDQuery1.Open;
  if FDQuery1.IsEmpty then
  begin
    FDQuery1.Close;
    FDQuery1.Open('select MAX(dbnumber) AS max from database;');
    max:=FDQuery1.FieldByName('max').AsInteger+1;
    FDCommand1.CommandText.Text:='''
      INSERT INTO database (dbnumber,dbname,nickname,password_hash,email)
      VALUES (:id,:U,:N,:P,:E);
      ''';
    FDCommand1.ParamByName('id').AsInteger:=max;
    FDCommand1.ParamByName('U').AsString:=username;
    FDCommand1.ParamByName('N').AsString:=nickname;
    FDCommand1.ParamByName('P').AsString:=TBcrypt.HashPassword(password);
    FDCommand1.ParamByName('E').AsString:=email;
    FDCommand1.Execute;
    var s: string;
    AddCookie(username,true);
    Response.SendRedirect('/members/'+nickname);
  end
  else
  begin
    var data:=TData.Create;
    if FDQuery1.FieldByName('dbname').AsString = username then
      data.name:='そのお名前は登録できません'
    else
      data.tag:='ニックネームが重複しています';
    var data2:=TData.Create;
    data2.name:=username;
    data2.tag:=nickname;
    WebStencilsProcessor13.AddVar('Msg',data);
    WebStencilsProcessor13.AddVar('Name',data2);
    Response.ContentType:='text/html;charset=utf8';
    Response.Content:=WebStencilsProcessor13.Content;
  end;
  FDQuery1.Close;
end;

procedure TWebModule1.WebModule1WebActionItem7Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  token: string;
begin
  var data:=TData.Create;
  token:=Request.CookieFields.Values['AuthToken'];
  if not VerifyRememberMe(token) then
  begin
    Response.SendRedirect('/login');
    Exit;
  end;
  if Request.MethodType = mtPost then
  begin
    if Request.ContentFields.Values['check'] <> 'yes' then
    begin
      Response.SendRedirect('/exit');
      Exit;
    end;
    if VerifyLogin(userdata.name,Request.ContentFields.Values['password']) then
    begin
      FDTransaction1.StartTransaction;
      try
        FDCommand1.CommandText.Text:='DELETE FROM database where dbnumber = :n;';
        FDCommand1.ParamByName('n').AsInteger:=userdata.id;
        FDCommand1.Execute;

        FDCommand1.CommandText.Text:='DELETE FROM token where number = :n;';
        FDCommand1.ParamByName('n').AsInteger:=userdata.id;
        FDCommand1.Execute;

        FDCommand1.CommandText.Text:='DELETE FROM datatable where dbnumber = :n;';
        FDCommand1.ParamByName('n').AsInteger:=userdata.id;
        FDCommand1.Execute;

        FDCommand1.CommandText.Text:='DELETE FROM maintable where dbnumber = :n;';
        FDCommand1.ParamByName('n').AsInteger:=userdata.id;
        FDCommand1.Execute;

        FDCommand1.CommandText.Text:='DELETE FROM titles where usernum = :n;';
        FDCommand1.ParamByName('n').AsInteger:=userdata.id;
        FDCommand1.Execute;

        FDCommand1.CommandText.Text:='DELETE FROM weblog where dbid = :d;';
        FDCommand1.ParamByName('d').AsInteger:=userdata.id;
        FDCommand1.Execute;

        FDTransaction1.Commit;
      except
        FDTransaction1.Rollback;
        raise;
      end;
      data.bool:=false;
    end;
  end
  else
    data.bool:=true;
  data.name:=userdata.name;
  WebStencilsProcessor14.AddVar('Data',data);
  Response.ContentType:='text/html;charset=utf8';
  Response.Content:=WebStencilsProcessor14.Content;
end;

procedure TWebModule1.WebModule1WebActionItem8Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  inputname, inputpass: string;
begin
  var data:=TData.Create;
  data.name:='';
  if Request.MethodType = mtPost then
  begin
    inputname:=Request.ContentFields.Values['username'];
    inputpass:=Request.ContentFields.Values['password'];
    if VerifyLogin(inputname,inputpass) then
    begin
      AddCookie(inputname,Request.ContentFields.Values['auto']='yes');
      Response.SendRedirect('/top/'+userdata.tag);
      Exit;
    end;
    data.name:='ユーザー名またはパスワードがまちがっています。';
  end;
  WebStencilsProcessor15.AddVar('Msg',data);
  Response.ContentType:='text/html;charset=utf8';
  Response.Content:=WebStencilsProcessor15.Content;
end;

procedure TWebModule1.WebModule1WebActionItem9Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  userid, dbtitle, tid: integer;
  user, title, name, raw, code, ip: string;
  timenow: TDateTime;
  params: TArray<string>;
begin
  if (Request.UserAgent = '')or(Request.Referer.ToLower.IndexOf('curl') > -1)
    or(Request.ContentFields.Values['honey_pot'] <> '') then
  begin
    Response.StatusCode:=403;
    Exit;
  end;
  params:=Request.PathInfo.Split(['/']);
  try
    user:=params[2];
    title:=params[3];
  except
    Handled:=false;
    Exit;
  end;
  FDQuery1.SQL.Text:='''
    select usernum,id,t.ip,time,MAX(titlenum) OVER() as max
    from titles t
    INNER JOIN database ds ON t.usernum = ds.dbnumber
    INNER JOIN datatable dt ON t.usernum = dt.dbnumber
    where ds.nickname = :user and t.url = :title;
    ''';
  FDQuery1.ParamByName('user').AsString:=user;
  FDQuery1.ParamByName('title').AsString:=title;
  FDQuery1.Open;

  userid:=FDQuery1.FieldByName('usernum').AsInteger;
  dbtitle:=FDQuery1.FieldByName('id').AsInteger;
  tid:=FDQuery1.FieldByName('max').AsInteger+1;
  name:=replaceRawData(Request.ContentFields.Values['name'].Trim);
  raw:=replaceRawData(Request.ContentFields.Values['comment']);
  code:=replaceRawData(Request.ContentFields.Values['code']);
  ip:=Request.RemoteAddr;
  timenow:=Now-Today;
  var limit:=SecondsBetween(timenow,FDQuery1.FieldByName('time').AsDateTime);
  if (ip = FDQuery1.FieldByName('ip').AsString)and(limit < 10) then
  begin
    Response.StatusCode:=403;
    Exit;
  end;
  FDQuery1.Close;

  FDTransaction1.StartTransaction;
  try
    FDCommand1.CommandText.Text :='''
      INSERT INTO DATATABLE (dbnumber, titlenum, name, dbtitle, ip)
      VALUES (:db, :tid, :name, :dbtitle, :ip)
      ''';
    FDCommand1.ParamByName('db').AsInteger:=userid;
    FDCommand1.ParamByName('tid').AsInteger:=tid;
    FDCommand1.ParamByName('name').AsString:=name;
    FDCommand1.ParamByName('dbtitle').AsInteger:=dbtitle;
    FDCommand1.ParamByName('ip').AsString:=ip;
    FDCommand1.Execute;

    FDCommand1.CommandText.Text:='''
      INSERT INTO MAINTABLE (dbnumber, titlenum, comment, datetime, code, dbtitle)
      VALUES (:db, :tid, :comment, :dt, :code, :dbtitle)
      ''';
    FDCommand1.ParamByName('db').AsInteger:=userid;
    FDCommand1.ParamByName('tid').AsInteger:=tid;
    FDCommand1.ParamByName('comment').AsString:=raw;
    FDCommand1.ParamByName('dt').AsDateTime:=timenow;
    FDCommand1.ParamByName('code').AsString:=code;
    FDCommand1.ParamByName('dbtitle').AsInteger:=dbtitle;
    FDCommand1.Execute;

    FDCommand1.CommandText.Text:=
      'UPDATE titles SET ip = :ip, time = :t where usernum = :u and id = :id;';
    FDCommand1.ParamByName('ip').AsString:=ip;
    FDCommand1.ParamByName('t').AsTime:=timenow;
    FDCommand1.ParamByName('u').AsInteger:=userid;
    FDCommand1.ParamByName('id').AsInteger:=dbtitle;
    FDCommand1.Execute;

    FDTransaction1.Commit;
  except
    FDTransaction1.Rollback;
    raise;
  end;
  Response.SendRedirect(String.Join('/',['/bbs',user,title]));
end;

procedure TWebModule1.WebModuleAfterDispatch(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  userdata.Free;
end;

procedure TWebModule1.WebModuleBeforeDispatch(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  params: TArray<string>;
  cookie: string;
begin
  userdata:=TData.Create;
  if Request.MethodType <> mtGet then
    Exit;
  for var data in ['/members','/admin','/params','/exit','/top'] do
    if Request.PathInfo.StartsWith(data,true) then
    begin
      params:=Request.PathInfo.Split(['/']);
      if High(params) >= 2 then
      begin
        userdata.tag:=params[2];
        FDQuery1.SQL.Text:='''
          select dbnumber,dbname from database
          INNER JOIN token ON dbnumber = number
          where nickname = :n;
          ''';
        FDQuery1.ParamByName('n').AsString:=userdata.tag;
        FDQuery1.Open;
        userdata.id:=FDQuery1.FieldByName('dbnumber').AsInteger;
        userdata.name:=FDQuery1.FieldByName('dbname').AsString;
      end;
      cookie:=Request.CookieFields.Values['AuthToken'];
      if not IsLogin(cookie,userdata.tag) and not VerifyRememberMe(cookie) then
      begin
        if data = '/top' then
          Response.SendRedirect('/masters')
        else
          Response.SendRedirect('/login');
        Handled:=true;
        Exit;
      end;
      break;
    end;
end;

procedure TWebModule1.WebModule1alertAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  id, did, tn: integer;
  log, name, username, dbtitle, text, msg: string;
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
    select datetime,dt.name,comment,dt.dbnumber from datatable dt
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
  var data:=TData.Create;
  data.name:='';
  if Request.MethodType = mtPost then
  begin
    inputname:=Request.ContentFields.Values['username'];
    inputpass:=Request.ContentFields.Values['password'];
    if VerifyLogin(inputname,inputpass) then
    begin
      AddCookie(inputname,Request.ContentFields.Values['auto']='yes');
      Response.SendRedirect('/members/'+userdata.tag);
      Exit;
    end;
    data.name:='ユーザー名またはパスワードがまちがっています。';
  end;
  WebStencilsProcessor12.AddVar('Msg',data);
  Response.ContentType:='text/html;charset=utf8';
  Response.Content:=WebStencilsProcessor12.Content;
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
  result:=id+index+word.Length+2;
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
