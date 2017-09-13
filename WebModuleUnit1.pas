unit WebModuleUnit1;

interface

uses System.SysUtils, System.Classes, Web.HTTPApp, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Web.HTTPProd, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Web.DBWeb, Web.DSProd, System.Types,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

type
  TWebModule1 = class(TWebModule)
    PbbsConnection: TFDConnection;
    dbname: TFDTable;
    maintable: TFDTable;
    raw: TFDTable;
    PageProducer1: TPageProducer;
    DataSource1: TDataSource;
    dbnameTBNUMBER: TIntegerField;
    dbnameDBNAME: TStringField;
    maintableTBNUMBER: TIntegerField;
    maintableTITLE: TStringField;
    maintableNAME: TStringField;
    maintableCOMMENT: TWideMemoField;
    maintableCMNUMBER: TIntegerField;
    maintableDATETIME: TDateField;
    rawCMNUMBER: TIntegerField;
    rawRAW: TWideMemoField;
    indexpage: TPageProducer;
    PageProducer4: TPageProducer;
    PageProducer5: TPageProducer;
    main: TDataSetPageProducer;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
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
    maintable.Last;
    for i := 1 to ini.Values['Count'].ToInteger do
    begin
      ReplaceText := ReplaceText + main.Content;
      maintable.Prior;
    end;
  end
  else if TagString = 'title' then
    ReplaceText := ini.Values['title']
  else if TagString = 'title2' then
    ReplaceText := ini.Values['title2'];
end;

procedure TWebModule1.PageProducer1HTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  i: Integer;
  s, t: string;
begin
  i := ini.Values['Count'].ToInteger;
  s := '';
  dbname.First;
  while dbname.Eof = false do
  begin
    t := dbname.FieldByName('dbname').AsString;
    if maintable.Fields.Count < i then
      s := s + '<p><a href=/?dbname=' + t + '>' + t + '</a>'
    else
      s := s + '<p style=text-color:red><a href=' + t + '>' + t + '</a>';
    dbname.Next;
  end;
  if TagString = 'full' then
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
      if dbname.Fields.Count = 0 then
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
  rc: TResourceStream;
begin
  s := Request.QueryFields.Values['dbname'];
  if s = '' then
  begin
    rc := TResourceStream.Create(HInstance, 'top', RT_RCDATA);
    try
      Response.Content := PageProducer1.ContentFromStream(rc);
    finally
      rc.Free;
    end;
  end
  else if dbname.Locate('dbname', s) = true then
  begin
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
begin
  //
end;

procedure TWebModule1.WebModule1UserHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  if Request.MethodType = mtGet then
  begin

  end
  else
  begin

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
