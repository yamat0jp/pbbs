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
  FireDAC.ConsoleUI.Wait, REST.Authenticator.OAuth.WebForm.Win;

type
  TFindState = (fdShort, fdNormal, fdNone);

  TPageSearch = class
  private
    FText, FWordList: string;
    FList, FResultLST: TStringList;
    function checkState(var st: integer; var bool: Boolean; word, line: string)
      : TFindState;
    procedure processNormal(var id: integer; word, line: string);
    procedure processShort(var id, ln: integer; var bool: Boolean; word: string;
      var line: string);
  public
    constructor Create;
    destructor Destroy; override;
    function Execute(const Text: string): string; virtual;
    property WordList: string read FWordList write FWordList;
  end;

  TWebModule1 = class(TWebModule)
    FDConnection1: TFDConnection;
    FDTable1: TFDTable;
    FDTable2: TFDTable;
    index: TDataSetPageProducer;
    top: TPageProducer;
    mainLoop: TDataSetPageProducer;
    adminTable: TDataSetTableProducer;
    admin: TPageProducer;
    alertContent: TDataSetPageProducer;
    search: TPageProducer;
    mentenance: TPageProducer;
    help: TPageProducer;
    formDesign: TDataSetPageProducer;
    WebFileDispatcher1: TWebFileDispatcher;
    topJQuery: TPageProducer;
    DataSource1: TDataSource;
    FDQuery1: TFDQuery;
    FDQuery2: TFDQuery;
    PageProducer6: TPageProducer;
    adTable: TDataSetTableProducer;
    master: TPageProducer;
    FDMemTable1: TFDMemTable;
    FDMemTable1adtext: TWideStringField;
    FDMemTable1company: TWideStringField;
    FDTable2DBNUMBER: TIntegerField;
    FDTable2CMNUMBER: TIntegerField;
    FDTable2TITLENUM: TIntegerField;
    FDTable2COMMENT: TWideMemoField;
    FDTable2DATETIME: TDateField;
    members: TDataSetPageProducer;
    PageProducer9: TPageProducer;
    FDMemTable1id: TIntegerField;
    FDMemTable1rank: TIntegerField;
    FDTable1DBNUMBER: TIntegerField;
    FDTable1DBNAME: TWideStringField;
    FDTable1TITLENUM: TIntegerField;
    FDTable1TITLE: TWideStringField;
    FDMemTable1enabled: TBooleanField;
    FDTable1ID: TIntegerField;
    titleList: TDataSetPageProducer;
    FDTable2NAME: TWideStringField;
    FDTable2COMCNT: TIntegerField;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    OAuth2Authenticator1: TOAuth2Authenticator;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    procedure indexHTMLTag(Sender: TObject; Tag: TTag; const TagString: string;
      TagParams: TStrings; var ReplaceText: string);
    procedure adminTableFormatCell(Sender: TObject;
      CellRow, CellColumn: integer; var BgColor: THTMLBgColor;
      var Align: THTMLAlign; var VAlign: THTMLVAlign;
      var CustomAttrs, CellData: string);
    procedure WebModuleCreate(Sender: TObject);
    procedure adminHTMLTag(Sender: TObject; Tag: TTag; const TagString: string;
      TagParams: TStrings; var ReplaceText: string);
    procedure WebModule1alertAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure alertContentHTMLTag(Sender: TObject; Tag: TTag;
      const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure searchHTMLTag(Sender: TObject; Tag: TTag; const TagString: string;
      TagParams: TStrings; var ReplaceText: string);
    procedure WebModuleBeforeDispatch(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1helpAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1renameAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure mainLoopHTMLTag(Sender: TObject; Tag: TTag;
      const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure WebModuleDestroy(Sender: TObject);
    procedure helpHTMLTag(Sender: TObject; Tag: TTag; const TagString: string;
      TagParams: TStrings; var ReplaceText: string);
    procedure WebModule1searchItemAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1mainItemAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure topJQueryHTMLTag(Sender: TObject; Tag: TTag;
      const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure topHTMLTag(Sender: TObject; Tag: TTag; const TagString: string;
      TagParams: TStrings; var ReplaceText: string);
    procedure WebModule1adminPageAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1showTopAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1masterAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure PageProducer6HTMLTag(Sender: TObject; Tag: TTag;
      const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure adTableCreateContent(Sender: TObject; var Continue: Boolean);
    procedure masterHTMLTag(Sender: TObject; Tag: TTag; const TagString: string;
      TagParams: TStrings; var ReplaceText: string);
    procedure WebModule1membersAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure PageProducer9HTMLTag(Sender: TObject; Tag: TTag;
      const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure titleListHTMLTag(Sender: TObject; Tag: TTag;
      const TagString: string; TagParams: TStrings; var ReplaceText: string);
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
    function makeFooter(script: string; id: integer): string;
    function ActiveRecordisNew: Boolean;
    function replaceRawData(Data: string): string;
    function islastproc: integer;
    function txtForSearch(const bbsname, jump, Text: string): string;
    function nameForSearch(const bbsname, jump, Text: string): string;
    function nameTableLocate(var bbsname, jump, Text: string): Boolean;
  public
    { public 宣言 }
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

const
  fname = 'data/voice.txt';
  nobody = 'no name';

function TWebModule1.ActiveRecordisNew: Boolean;
var
  day: TDateTime;
begin
  FDQuery2.SQL.Text :=
    'select max(datetime) as large from maintable where dbnumber = :db;';
  FDQuery2.ParamByName('db').AsInteger := FDQuery1.FieldByName('dbnumber')
    .AsInteger;
  FDQuery2.Open;
  day := Now - FDQuery2.FieldByName('large').AsDateTime;
  FDQuery2.Close;
  result := day < 1;
end;

function TWebModule1.islastproc: integer;
var
  i: integer;
begin
  i := StrToIntDef(Request.QueryFields.Values['page'], 0);
  if (i = 0) or ((i - 1) * count >= FDTable2.RecordCount) then
  begin
    result := 0;
    FDTable2.Last;
    FDTable2.MoveBy(-count + 1);
  end
  else
  begin
    result := i;
    FDTable2.First;
    FDTable2.MoveBy((result - 1) * count);
  end;
end;

procedure TWebModule1.indexHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  id, DB, cnt, com: integer;
begin
  id := islastproc;
  if TagString = 'form' then
  begin
    if count * pagecount > FDTable2.RecordCount then
      ReplaceText := formDesign.Content
    else
      ReplaceText := '<h1>書き込み最大数に達しました。これ以上書き込めません。</h1>';
  end
  else if TagString = 'main' then
  begin
    cnt := count;
    com := 3;
    DB := FDTable1.FieldByName('dbnumber').AsInteger;
    while not FDTable2.Eof and (cnt > 0) do
    begin
      if com = 0 then
      begin
        ReplaceText := ReplaceText +
          Format('<hr><p>広告</p><div align="center">%s</div><hr>',
          [FDMemTable1.FieldByName('adtext').AsString]);
        FDMemTable1.Next;
        if FDMemTable1.Eof then
          FDMemTable1.First;
        com := 5;
      end;
      ReplaceText := ReplaceText + mainLoop.Content +
        Format('<p style="text-align:end"><a href="/alert?db=%d&tn=%d&page=%d">報告</a></p>',
        [DB, FDTable1.FieldByName('titlenum').AsInteger,
        FDTable2.FieldByName('cmnumber').AsInteger]);
      FDTable2.Next;
      dec(cnt);
      dec(com);
    end;
  end
  else if TagString = 'footer' then
    ReplaceText := makeFooter('bbs', id);
end;

procedure TWebModule1.mainLoopHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  Text: string;
  cnt: integer;
  DataSet: TDataSet;
begin
  if TagString = 'comment' then
  begin
    if commentoff then
      ReplaceText := ''
    else
    begin
      DataSet := mainLoop.DataSet;
      cnt := DataSet.FieldByName('comcnt').AsInteger;
      Text := DataSet.FieldByName('comment').AsString;
      ReplaceText := makeComment(Text, cnt);
    end;
  end
  else if TagString = 'username' then
  begin
    Text := mainLoop.DataSet.FieldByName('name').AsString;
    if Text = '' then
      ReplaceText := nobody
    else
      ReplaceText := Text;
  end;
end;

procedure TWebModule1.alertContentHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
begin
  if TagString = 'article' then
  begin
    if Request.MethodType = mtGet then
      ReplaceText := mainLoop.Content;
  end
  else if TagString = 'message' then
  begin
    if Request.MethodType = mtGet then
      ReplaceText :=
        '<textarea name=com></textarea><p style=text-align:center><input name=admit type=submit value="送信">'
    else
      ReplaceText := 'ご協力ありがとうございました';
  end
  else if TagString = 'query' then
    ReplaceText := Request.Query;
end;

procedure TWebModule1.titleListHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  str: string;
  DB, num, cnt: integer;
begin
  if (TagString = 'form') and (Request.PathInfo = '/members') then
    ReplaceText := members.Content
  else if TagString = 'table' then
  begin
    DB := FDTable1.FieldByName('dbnumber').AsInteger;
    cnt := 1;
    while not FDTable1.Eof do
    begin
      str := FDTable1.FieldByName('title').AsString;
      num := FDTable1.FieldByName('titlenum').AsInteger;
      if FDTable1.RecordCount = 1 then
        ReplaceText := Format('<p align=center>%s</p>', [str])
      else if num > 1 then
      begin
        ReplaceText := ReplaceText +
          Format('<p align="center"><a href="/bbs?db=%d&tn=%d" style="text-decoration:none">[ %d ] %s</a> 投稿数:%d</p>',
          [DB, num, cnt, str, FDTable2.RecordCount]);
        inc(cnt);
      end;
      FDTable1.Next;
    end;
  end;
end;

procedure TWebModule1.adminTableFormatCell(Sender: TObject;
  CellRow, CellColumn: integer; var BgColor: THTMLBgColor;
  var Align: THTMLAlign; var VAlign: THTMLVAlign;
  var CustomAttrs, CellData: string);
var
  s: string;
begin
  if CellRow > 0 then
    case CellColumn of
      0:
        CellData := Format('<input type=checkbox name=check value=%d>',
          [FDTable2.FieldByName('cmnumber').AsInteger]);
      4:
        begin
          s := Request.QueryFields.Values['page'];
          if s <> '' then
            s := '&page=' + s;
          CellData := Format('<a href="/admin?db=%s&tn=%s%s&link=%d">go</a>',
            [Request.QueryFields.Values['db'], Request.QueryFields.Values['tn'],
            s, FDTable2.FieldByName('cmnumber').AsInteger]);
        end;
    end;
  if (CellRow > 1) and (CellRow mod 2 = 0) then
    BgColor := 'Silver';
end;

procedure TWebModule1.adTableCreateContent(Sender: TObject;
  var Continue: Boolean);
begin
  adTable.Header.Text := master.Content;
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

function TWebModule1.makeFooter(script: string; id: integer): string;
var
  t: string;
  DB, tn: integer;
begin
  if id = 0 then
    t := ' active'
  else
    t := '';
  bglist.Clear;
  bglist.Add
    ('<nav aria-label="Page navigation"><ul class="pagination pagination-sm justify-content-center">');
  DB := Request.QueryFields.Values['db'].ToInteger;
  tn := Request.QueryFields.Values['tn'].ToInteger;
  for var i := 1 to pagecount do
  begin
    if i = id then
      bglist.Add('<li class="page-item active">')
    else
      bglist.Add('<li class="page-item">');
    bglist.Add
      (Format('<a class="page-link" href="/%s?db=%d&tn=%d&page=%d">%d</a></li>',
      [script, DB, tn, i, i]));
  end;
  bglist.Add
    (Format('<li class="page-item%s"><a class="page-link" href="/%s?db=%d&tn=%d">さいご</a></li></ul></nav>',
    [t, script, DB, tn]));
  result := bglist.Text;
end;

procedure TWebModule1.topHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
begin
  if TagString = 'main' then
    ReplaceText := topJQuery.Content;
end;

procedure TWebModule1.adminHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  id: integer;
begin
  id := islastproc;
  if TagString = 'table' then
    ReplaceText := adminTable.Content
  else if TagString = 'dbnumber' then
    ReplaceText := Request.QueryFields.Values['db']
  else if TagString = 'titlenum' then
    ReplaceText := Request.QueryFields.Values['tn']
  else if TagString = 'footer' then
    ReplaceText := makeFooter('admin', id)
  else if TagString = 'section' then
  begin
    id := StrToIntDef(Request.QueryFields.Values['link'], 0);
    if FDTable2.Locate('cmnumber', id) then
      ReplaceText := mainLoop.Content;
  end;
end;

procedure TWebModule1.searchHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  Text, bbsname, jump: string;
  bool: Boolean;
begin
  if TagString = 'adtext' then
  begin
    ReplaceText := '<p>' + FDMemTable1.FieldByName('adtext').AsString + '</p>';
    if FDMemTable1.Eof then
      FDMemTable1.First
    else
      FDMemTable1.Next;
  end
  else if (TagString = 'main') and (Request.MethodType = mtPost) then
  begin
    if Request.ContentFields.Values['filter'] = 'com' then
    begin
      commentoff := true;
      bool := true;
    end
    else
      bool := false;
    FDQuery1.Open('select * from maintable order by datetime desc;');
    FDQuery2.Open('select * from nametable;');
    mainLoop.DataSet := FDQuery1;
    try
      while not FDQuery1.Eof do
      begin
        if not nameTableLocate(bbsname, jump, Text) then
        begin
          FDQuery1.Next;
          Continue;
        end;
        if bool then
          ReplaceText := ReplaceText + txtForSearch(bbsname, jump, Text)
        else
          ReplaceText := ReplaceText + nameForSearch(bbsname, jump, Text);
        FDQuery1.Next;
      end;
    finally
      mainLoop.DataSet := FDTable2;
      FDQuery1.Close;
      FDQuery2.Close;
      commentoff := false;
    end;
    if ReplaceText = '' then
      ReplaceText := '見つかりませんでした';
    ReplaceText := '<hr>' + ReplaceText;
  end
  else if TagString = 'word' then
    ReplaceText := '"' + mysearch.WordList + '"';
end;

procedure TWebModule1.helpHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
begin
  if TagString = 'code' then
  begin
    if Request.MethodType = mtGet then
      ReplaceText := '<input type=submit value="送信">'
    else
      ReplaceText := 'ありがとうございました';
  end;
end;

procedure TWebModule1.PageProducer6HTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
begin
  if TagString = 'link' then
    ReplaceText := '';
end;

procedure TWebModule1.topJQueryHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
const
  conf = 7;
var
  s, t: string;
  num: integer;
begin
  FDQuery1.Open('select * from nametable where titlenum = 1;');
  if TagString = 'first' then
  begin
    for var i := 0 to (FDQuery1.RecordCount - 1) div conf do
      if i = 0 then
        ReplaceText :=
          '<li data-target="#slide-1" data-slide-to="0" class="active"></li>'
      else
        ReplaceText := ReplaceText +
          Format('<li data-target="#slide-1" data-slide-to=%d></li>', [i]);
  end
  else if TagString = 'second' then
  begin
    bglist.Clear;
    for var i := 0 to (FDQuery1.RecordCount - 1) div conf do
    begin
      if i = 0 then
        bglist.Add('<div class="carousel-item active">')
      else
        bglist.Add('<div class="carousel-item">');
      bglist.Add
        (Format('<img class="d-sm-block d-none" src="img/slide%d.jpg" style="float:right;height:465px">',
        [i + 1]));
      bglist.Add('<div style="height:465px"></div>');
      bglist.Add
        ('<div class="carousel-caption text-left" style="font-size:1.5rem;">');
      for var j := 1 to conf do
      begin
        if FDQuery1.Eof then
          break;
        t := FDQuery1.FieldByName('dbname').AsString;
        num := FDQuery1.FieldByName('dbnumber').AsInteger;
        if ActiveRecordisNew then
          s := ' style="background-color:aqua;"'
        else
          s := '';
        FDQuery1.Next;
        bglist.Add(Format('<p><a href="/list?db=%d"%s>%s</a></p>',
          [num, s, t]));
      end;
      bglist.Add('</div></div>');
    end;
    ReplaceText := bglist.Text;
    FDQuery1.Close;
  end;
end;

function TWebModule1.txtForSearch(const bbsname, jump, Text: string): string;
var
  cnt: integer;
  temp, code: string;
begin
  cnt := FDQuery1.FieldByName('comcnt').AsInteger;
  temp := mysearch.Execute(readComment(Text, 0, cnt));
  if temp <> '' then
  begin
    code := readComment(Text, cnt, -1);
    if code <> '' then
      code := '<pre><code>' + code + '</code></pre>';
    result := bbsname + jump + mainLoop.Content + makeComment(temp) +
      code + '<hr>';
  end
  else
    result := '';
end;

procedure TWebModule1.masterHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
begin
  if (TagString = 'checked') and mente then
    ReplaceText := 'checked';
end;

function TWebModule1.nameForSearch(const bbsname, jump, Text: string): string;
var
  name: string;
begin
  name := Request.ContentFields.Values['word1'];
  if name = '' then
    Exit('')
  else if Name = nobody then
    name := '';
  if name = FDQuery1.FieldByName('name').AsString then
    result := bbsname + jump + mainLoop.Content + '<hr>'
  else
    result := '';
end;

function TWebModule1.nameTableLocate(var bbsname, jump, Text: string): Boolean;
var
  DB, tn, cn: integer;
begin
  DB := FDQuery1.FieldByName('dbnumber').AsInteger;
  tn := FDQuery1.FieldByName('titlenum').AsInteger;
  cn := FDQuery1.FieldByName('cmnumber').AsInteger;
  if not FDQuery2.Locate('dbnumber;titlenum', VarArrayOf([DB, tn])) then
    Exit(false)
  else
    result := true;
  bbsname := Format('(%s:%s)', [FDQuery2.FieldByName('dbname').AsString,
    FDQuery2.FieldByName('title').AsString]);
  jump := Format(' <a href="/bbs?db=%d&tn=%d&page=%d">jump</a>', [DB, tn, cn]);
  Text := FDQuery1.FieldByName('comment').AsString;
end;

procedure TWebModule1.PageProducer9HTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  ls: TStringList;
begin
  ls := TStringList.Create;
  try
    ls.LoadFromFile('.\js\login.js');
    ReplaceText := ls.Text;
  finally
    ls.Free;
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
    result := String(ReplaceText(AnsiString(result), AnsiString(s),
      AnsiString('*****')));
end;

procedure TWebModule1.WebModule1adminPageAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  DB, tn: integer;
begin
  DB := Request.QueryFields.Values['db'].ToInteger;
  tn := Request.QueryFields.Values['tn'].ToInteger;
  if not FDTable1.Locate('dbnumber;titlenum', VarArrayOf([DB, tn])) then
  begin
    Handled := false;
    Exit;
  end;
  if Request.MethodType = mtPost then
    for var i := 0 to Request.ContentFields.count - 1 do
      if Request.ContentFields.Names[i] = 'check' then
      begin
        FDTable2.First;
        while FDTable2.Locate('cmnumber',
          Request.ContentFields.ValueFromIndex[i]) do
          FDTable2.Delete;
        if FDTable2.RecordCount = 0 then
          FDTable1.Delete;
      end;
  Response.ContentType := 'text/html;charset=utf-8;';
  Response.Content := admin.Content;
end;

procedure TWebModule1.WebModule1mainItemAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  raw, name: string;
  j, cnt: integer;
  DB, tid: integer;
begin
  tid := Request.QueryFields.Values['tn'].ToInteger;
  DB := Request.QueryFields.Values['db'].ToInteger;
  if not FDTable1.Locate('dbnumber;titlenum', VarArrayOf([DB, tid])) then
  begin
    Handled := false;
    Exit;
  end;
  if Request.MethodType = mtPost then
  begin
    raw := replaceRawData(Request.ContentFields.Values['comment']);
    name := Request.ContentFields.Values['name'];
    FDTable2.Last;
    j := FDTable2.FieldByName('cmnumber').AsInteger + 1;
    bglist.Text := TNetEncoding.HTML.Encode(raw);
    raw := Request.ContentFields.Values['code'];
    cnt := -1;
    if raw <> '' then
    begin
      cnt := bglist.count;
      bglist.Add(raw);
    end;
    FDTable2.AppendRecord([DB, j, tid, name, bglist.Text, Now, cnt]);
  end;
  Response.ContentType := 'text/html;charset=utf-8';
  Response.Content := index.Content;
end;

procedure TWebModule1.WebModule1masterAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  cnt, id: integer;
  s: string;
begin
  if Request.MethodType = mtPost then
  begin
    mente := Request.ContentFields.Values['switch'] = 'mente';
    bglist.Text := Request.ContentFields.Values['subjects'];
    FDQuery1.Open('select max(dbnumber) as large from nametable;');
    cnt := FDQuery1.FieldByName('large').AsInteger + 1;
    FDQuery1.Open('select max(id) as large from nametable;');
    id := FDQuery1.FieldByName('large').AsInteger + 1;
    FDQuery1.Close;
    for var i := 0 to bglist.count - 1 do
    begin
      s := bglist[i];
      if (s <> '') and not FDTable1.Locate('dbname', s) then
      begin
        FDTable1.AppendRecord([id, cnt, s, 1, 'New Space!!']);
        inc(id);
        inc(cnt);
      end;
    end;
  end;
  FDMemTable1.First;
  Response.ContentType := 'text/html;charset=utf8';
  Response.Content := adTable.Content;
end;

procedure TWebModule1.WebModule1membersAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  name, title, code: string;
  j, k, cnt, DB: integer;
begin
  DB := Request.QueryFields.Values['db'].ToInteger;
  FDTable1.Filter := Format('dbnumber = ''%d''', [DB]);
  FDTable1.Filtered := true;
  if FDTable1.RecordCount = 0 then
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
    name := FDTable1.FieldByName('dbname').AsString;
    FDQuery1.Open('select max(id) as large from nametable;');
    FDQuery2.Open('select max(titlenum) as large from nametable;');
    k := FDQuery1.FieldByName('large').AsInteger + 1;
    j := FDQuery2.FieldByName('large').AsInteger + 1;
    FDQuery1.Close;
    FDQuery2.Close;
    FDTable1.AppendRecord([k, DB, name, j, title]);
    name := FDTable2.FieldByName('name').AsString;
    FDTable2.AppendRecord([DB, 1, j, name, bglist.Text, Now, cnt]);
  end;
  FDTable1.First;
  Response.ContentType := 'text/html;charset=utf8';
  Response.Content := titleList.Content;
end;

procedure TWebModule1.WebModule1searchItemAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  mysearch := TPageSearch.Create;
  try
    mysearch.WordList := Request.ContentFields.Values['word1'];
    Response.ContentType := 'text/html;charset=utf8';
    Response.Content := search.Content;
  finally
    mysearch.Free;
  end;
end;

procedure TWebModule1.WebModule1showTopAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  DB, tn: Variant;
begin
  if Request.MethodType = mtPost then
  begin
    DB := Request.QueryFields.Values['db'];
    tn := Request.QueryFields.Values['tn'];
    if FDTable1.Locate('dbnumber;titlenum', VarArrayOf([DB, tn])) then
    begin
      FDTable2.First;
      while not FDTable2.Eof do
        FDTable2.Delete;
      FDTable1.Delete;
    end;
  end;
  Response.ContentType := 'text/html;charset=utf-8';
  Response.Content := top.Content;
end;

procedure TWebModule1.WebModule1alertAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  fs: TFileStream;
  DB, tn, PG: integer;
  str: string;
begin
  DB := Request.QueryFields.Values['db'].ToInteger;
  tn := Request.QueryFields.Values['tn'].ToInteger;
  PG := Request.QueryFields.Values['page'].ToInteger;
  if not(FDTable1.Locate('dbnumber;titlenum', VarArrayOf([DB, tn])) and
    FDTable2.Locate('cmnumber', PG)) then
  begin
    Handled := false;
    Exit;
  end;
  if Request.MethodType = mtPost then
  begin
    if FileExists(fname) then
      fs := TFileStream.Create(fname, fmOpenReadWrite)
    else
      fs := TFileStream.Create(fname, fmCreate);
    try
      fs.Position := fs.Size;
      str := '(' + FDTable1.FieldByName('dbname').AsString + ':';
      str := str + FDTable1.FieldByName('title').AsString + ')';
      str := str + '【' + FDTable2.FieldByName('cmnumber').AsString + '】';
      str := str + FDTable2.FieldByName('datetime').AsString;
      bglist.Clear;
      bglist.Add('');
      bglist.Add('(*ユーザー様から報告がありました*)');
      bglist.Add('TODAY is ' + DateToStr(Now));
      bglist.Add(str);
      bglist.Add(FDTable2.FieldByName('comment').AsString);
      bglist.Add('(*報告ここまで*)');
      bglist.Add('');
      bglist.SaveToStream(fs);
    finally
      fs.Free;
    end;
  end;
  Response.ContentType := 'text/html;charset=utf-8';
  Response.Content := alertContent.Content;
end;

procedure TWebModule1.WebModule1helpAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  fs: TFileStream;
begin
  if Request.MethodType = mtPost then
  begin
    if FileExists(fname) then
      fs := TFileStream.Create(fname, fmOpenReadWrite)
    else
      fs := TFileStream.Create(fname, fmCreate);
    try
      fs.Position := fs.Size;
      bglist.Clear;
      bglist.Add('');
      bglist.Add('(*ユーザー様から報告がありました*)');
      bglist.Add(DateToStr(Now));
      bglist.Add(Request.ContentFields.Values['help']);
      bglist.Add('(*報告ここまで*)');
      bglist.Add('');
      bglist.SaveToStream(fs);
    finally
      fs.Free;
    end;
  end;
  Response.ContentType := 'text/html;charset=utf-8';
  Response.Content := help.Content;
end;

procedure TWebModule1.WebModule1renameAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  DB: integer;
  name: string;
begin
  DB := Request.QueryFields.Values['db'].ToInteger;
  if FDTable1.Locate('dbnumber', DB) then
  begin
    FDTable1.Edit;
    name := Request.ContentFields.Values['text'];
    FDTable1.FieldByName('dbname').AsString := name;
    FDTable1.Post;
  end;
  Response.SendRedirect(Format('/admin?db=%d', [DB]));
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
var
  ini: TIniFile;
begin
  ini := TIniFile.Create('data/setting.ini');
  try
    count := ini.ReadInteger('data', 'count', 10);
    pagecount := ini.ReadInteger('data', 'pagecount', 10);
    mente := ini.ReadBool('data', 'mentenance', false);
  finally
    ini.Free;
  end;
  adminTable.MaxRows := count;
  bglist := TStringList.Create;
  FDQuery1.Open('select * from adlist;');
  FDMemTable1.Data := FDQuery1.Data;
  FDQuery1.Close;
end;

procedure TWebModule1.WebModuleDestroy(Sender: TObject);
var
  ini: TIniFile;
begin
  ini := TIniFile.Create('data/setting.ini');
  try
    ini.WriteInteger('data', 'count', count);
    ini.WriteInteger('data', 'pagecount', pagecount);
    ini.WriteBool('data', 'mentenance', mente);
  finally
    ini.Free;
  end;
  bglist.Free;
end;

{ TPageSearch }

const
  str = '<span style=background-color:yellow>%s</span>';

function TPageSearch.checkState(var st: integer; var bool: Boolean;
  word, line: string): TFindState;
begin
  result := fdNone;
  for var id := st to Length(line) do
  begin
    if line[id] <> word[1] then
      Continue;
    FText := FText + Copy(line, st, id - st);
    st := id;
    if Copy(line, id, Length(word)) = word then
    begin
      result := fdNormal;
      bool := true;
      break;
    end
    else if Pos(Copy(line, id, Length(line)), word) > 0 then
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
  FText := FText + Format(str, [word]);
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
  wrd := Copy(line, id, Length(word));
  FText := FText + Format(str, [wrd]);
  dec(cnt, Length(wrd));
  while state = fdShort do
  begin
    wrd := Copy(word, Length(wrd) + 1, Length(line));
    FText := FText + #13#10 + Format(str, [wrd]);
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

function TPageSearch.Execute(const Text: string): string;
var
  i, id: integer;
  state: TFindState;
  s: string;
  bool: Boolean;
begin
  FList.Text := Text;
  bool := false;
  for var str in WordList.Split([' ']) do
  begin
    FText := '';
    i := 0;
    id := 1;
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
            FText := FText + Copy(s, id, Length(s)) + #13#10;
            id := 1;
            inc(i);
          end;
      end;
    end;
    FList.Text := FText;
  end;
  if bool then
    result := FList.Text
  else
    result := '';
end;

end.
