unit WebModuleUnit2;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Web.Stencils;

type
  TWebModule1 = class(TWebModule)
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    WebStencilsEngine1: TWebStencilsEngine;
    WebStencilsProcessor1: TWebStencilsProcessor;
    WebFileDispatcher1: TWebFileDispatcher;
    WebStencilsProcessor2: TWebStencilsProcessor;
    WebStencilsProcessor3: TWebStencilsProcessor;
    FDQuery2: TFDQuery;
    FDQuery3: TFDQuery;
    FDQuery4: TFDQuery;
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1WebActionItem2Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1WebActionItem3Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebStencilsProcessor2Value(Sender: TObject; const AObjectName,
      APropName: string; var AValue: string; var AHandled: Boolean);
    procedure WebStencilsProcessor2BeforeProduce(Sender: TObject);
    procedure WebStencilsProcessor2AfterProduce(Sender: TObject);
    procedure WebModule1WebActionItem8Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1WebActionItem9Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    { Private declarations }
    jsonstr: string;
  public
    { Public declarations }
  end;

  TVar = class
  private
    Fhas_prev: Boolean;
    Fhas_next: Boolean;
    Ftotal_pages: integer;
    Fprev: integer;
    Fnext: integer;
  public
    property has_prev: Boolean read Fhas_prev write Fhas_prev;
    property has_next: Boolean read Fhas_next write Fhas_next;
    property next: integer read Fnext write Fnext;
    property prev: integer read Fprev write Fprev;
    property total_pages: integer read Ftotal_pages write Ftotal_pages;
  end;

  TModel = class
  private
    FActiveView: string;
  public
    property ActiveView: string read FActiveView write FActiveView;
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses System.JSON, System.StrUtils,System.NetEncoding,
  System.Generics.Collections;

procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  params: TArray<string>;
  category: string;
begin
  params:=Request.PathInfo.Split(['/']);
  if High(params) >= 2 then
  begin
    category:=params[2];
    FDQuery1.SQL.Text:='select * from items where category = :c;';
    FDQuery1.ParamByName('c').AsString:=category;
    FDQuery1.Open;
  end
  else
    FDQuery1.Open('select * from items;');
  FDQuery2.Open('select DISTINCT category from items ORDER BY category;');
  WebStencilsProcessor1.AddVar('Items',FDQuery1,false);
  WebStencilsProcessor1.AddVar('Categories',FDQuery2,false);
  Response.Content := WebStencilsProcessor1.Content;
  FDQuery1.Close;
  FDQuery2.Close;
end;

procedure TWebModule1.WebModule1WebActionItem2Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  title, slug, status, text: string;
  tagstr, thumbnailpath, base64str: string;
  bytes: TBytes;
  id: integer;
  js: TJSONObject;
  ja: TJSONArray;
begin
  Response.ContentType:='application/json;charset=utf-8';
  js:=TJSONObject.ParseJSONValue(Request.Content) as TJSONObject;
  if not Assigned(js) then
  begin
    Response.StatusCode := 400;
    Response.Content := '{"success": false, "message": "Invalid JSON"}';
    Exit;
  end;
  try
    tagstr:='';
    if js.TryGetValue<TJSONArray>('tags',ja) then
    begin
      for var i := 0 to ja.Count-1 do
      begin
        if tagstr <> '' then tagstr:=tagstr+',';
        tagstr:=tagstr+ja.Items[i].Value;
      end;
    end;
    // 3. Base64文字列から画像ファイルを復元してローカル保存
    ThumbnailPath := '';
    if JS.TryGetValue<string>('thumbnail_base64', Base64Str) and (Base64Str <> '') then
    begin
      // "data:image/png;base64," のようなメタ情報ヘッダを切り落とす
      var i:=Base64Str.IndexOf('base64');
      if i > -1 then Base64Str:=Base64Str.Substring(i+7);

      // デコードしてファイルとして保存
      Bytes := TNetEncoding.Base64.DecodeStringToBytes(Base64Str);
      ThumbnailPath := '/uploads/thumb_' + FormatDateTime('yyyymmdd_hhnnss', Now) + '.jpg';

      var ImageStream := TBytesStream.Create(Bytes);
      try
        // 実行ファイルの配置フォルダ基準で保存先を指定（あらかじめ uploads フォルダを作成しておく）
        var s:=ExtractFilePath(ParamStr(0)) + 'public' + ThumbnailPath.Replace('/','\',[rfReplaceAll]);
        ForceDirectories(ExtractFileDir(s));
        ImageStream.SaveToFile(s);
      finally
        ImageStream.Free;
      end;
    end;
    FDQuery1.Open('select MAX(id) as max from items;');
    id:=FDQuery1.FieldByName('max').AsInteger+1;
    FDQuery1.Close;

    title:=js.GetValue<string>('title');
    slug:=js.GetValue<string>('category');
    status:=js.GetValue<string>('status');
    text:=js.GetValue<string>('content');
    FDQuery1.SQL.Text:='''
      INSERT INTO items (id,title,category,text,thumbnail_url,status,tags)
      VALUES (:i, :t, :c, :tx, :th, :s, :ta);
      ''';
    FDQuery1.ParamByName('i').AsInteger:=id;
    FDQuery1.ParamByName('t').AsString:=title;
    FDQuery1.ParamByName('c').AsString:=slug;
    FDQuery1.ParamByName('s').AsString:=status;
    FDQuery1.ParamByName('ta').AsString:=tagstr;
    FDQuery1.ParamByName('tx').AsString:=text;
    FDQuery1.ParamByName('th').AsString:=ThumbnailPath;
    FDQuery1.ExecSQL;
    Response.StatusCode:=200;
    Response.Content:='{"success": true}';
  except
    on E: Exception do
    begin
      Response.StatusCode:=500;
      Response.Content := '{"success": false, "message": "' + E.Message + '"}';
    end;
  end;
  js.Free;
end;

procedure TWebModule1.WebModule1WebActionItem3Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  params: TArray<string>;
  id: integer;
begin
  params:=Request.PathInfo.Split(['/']);
  id:=if High(params) >= 2 then params[2].ToInteger else 0;
  FDQuery1.Open('select COUNT(id) OVER() as cnt, id from items;');
  var obj:=TVar.Create;
  obj.total_pages:=FDQuery1.FieldByName('cnt').AsInteger;

  FDQuery1.Locate('id',id);
  FDQuery1.Prior;
  if FDQuery1.Bof then
    obj.has_prev:=false
  else
  begin
    obj.has_prev:=true;
    obj.prev:=FDQuery1.FieldByName('id').AsInteger;
  end;

  FDQuery1.Locate('id',id);
  FDQuery1.Next;
  if FDQuery1.Eof then
    obj.has_next:=false
  else
  begin
    obj.has_next:=true;
    obj.next:=FDQuery1.FieldByName('id').AsInteger;
  end;

  FDQuery1.Close;
  FDQuery1.Open('select * from items;');
  WebStencilsProcessor3.AddVar('obj',obj);
  WebStencilsProcessor3.AddVar('articles',FDQuery1,false);
  Response.Content:=WebStencilsProcessor3.Content;
  FDQuery1.Close;
end;

procedure TWebModule1.WebModule1WebActionItem8Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  FDQuery1.Open('select * from params;');
  if FDQuery1.IsEmpty then
  begin
    FDQuery1.Close;
    FDQuery1.ExecSQL('INSERT INTO params VALUES ('''', 3, '''', true, 1);');
    FDQuery1.Open('select * from params;');
  end;
  WebStencilsProcessor2.AddVar('Settings',FDQuery1,false);
  Response.Content:=WebStencilsProcessor2.Content;
  FDQuery1.Close;
end;

procedure TWebModule1.WebModule1WebActionItem9Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  FDQuery1.SQL.Text:='''
    UPDATE params SET
      "SiteTitle" = :t,
      "ItemsPerPage" = :p,
      "SiteDescription" = :d,
      "AllowIndexing" = :a where id = 1;
    ''';
  FDQuery1.ParamByName('t').AsString:=Request.ContentFields.Values['site_title'];
  FDQuery1.ParamByName('d').AsString:=Request.ContentFields.Values['site_description'];
  FDQuery1.ParamByName('p').AsInteger:=Request.ContentFields.Values['items_per_page'].ToInteger;
  FDQuery1.ParamByName('a').AsBoolean:=Request.ContentFields.Values['allow_indexing']='true';
  FDQuery1.ExecSQL;
  Response.SendRedirect('/settings');
end;

procedure TWebModule1.WebStencilsProcessor2AfterProduce(Sender: TObject);
begin
  FDQuery1.Close;
  FDQuery2.Close;
  FDQuery3.Close;
  FDQuery4.Close;
end;

procedure TWebModule1.WebStencilsProcessor2BeforeProduce(Sender: TObject);
var
  JSONObj: TJSONObject;
  TargetSlug: string;
begin
  var model:=TModel.Create;
  if Request.PathInfo = '/dashboard' then
    model.ActiveView:='dashboard'
  else if Request.PathInfo = '/posts' then
    model.ActiveView:='all-posts'
  else if Request.PathInfo = '/posts/new' then
    model.ActiveView:='new-post'
  else if Request.PathInfo = '/categories' then
    model.ActiveView:='categories'
  else if Request.PathInfo = '/settings' then
    model.ActiveView:='settings';
  WebStencilsProcessor2.AddVar('Model',model);
  if Request.PathInfo = '/dashboard' then
  begin
    FDQuery1.Open('select * from items;');
    FDQuery2.Open('select DISTINCT category from items ORDER BY category;');
    WebStencilsProcessor2.AddVar('Posts',FDQuery1,false);
    WebStencilsProcessor2.AddVar('Categories',FDQuery2,false);
    FDQuery3.Open('select COUNT(id) as published from items where status = ''published'';');
    FDQuery4.Open('select COUNT(id) as draft from items where status = ''draft'';');
  end;


  TargetSlug := Request.QueryFields.Values['slug'];

  if TargetSlug <> '' then
  begin
    FDQuery3.SQL.Text := 'SELECT * FROM articles WHERE slug = :slug';
    FDQuery3.ParamByName('slug').AsString := TargetSlug;
    FDQuery3.Open;

    if not FDQuery3.IsEmpty then
    begin
      JSONObj := TJSONObject.Create;
      try
        JSONObj.AddPair('id', TJSONNumber.Create(FDQuery3.FieldByName('id').AsInteger));
        JSONObj.AddPair('title', FDQuery3.FieldByName('title').AsString);
        JSONObj.AddPair('slug', FDQuery3.FieldByName('slug').AsString);
        JSONObj.AddPair('category', FDQuery3.FieldByName('category').AsString);
        JSONObj.AddPair('tags', FDQuery3.FieldByName('tags').AsString);
        JSONObj.AddPair('status', FDQuery3.FieldByName('status').AsString);
        JSONObj.AddPair('content', FDQuery3.FieldByName('content').AsString);
        JSONObj.AddPair('thumbnail_url', FDQuery3.FieldByName('thumbnail_url').AsString);
        JSONStr := JSONObj.ToString;
      finally
        JSONObj.Free;
      end;
    end
    else
      JSONStr := 'null';

    FDQuery3.Close;
  end
  else
    JSONStr := 'null';
end;

procedure TWebModule1.WebStencilsProcessor2Value(Sender: TObject;
  const AObjectName, APropName: string; var AValue: string;
  var AHandled: Boolean);
begin
  if AObjectName = 'Stats' then
  begin
    if APropName = 'TotalPosts' then
      AValue:=(FDQuery3.FieldByName('published').AsInteger+FDQuery4.FieldByName('draft').AsInteger).ToString
    else if APropName = 'TotalViews' then
      AValue:='??'
    else if APropName = 'PublishedCount' then
      AValue:=FDQuery3.FieldByName('published').AsString
    else if APropName = 'DraftCount' then
      AValue:=FDQuery4.FieldByName('draft').AsString;
  end;
end;

end.
