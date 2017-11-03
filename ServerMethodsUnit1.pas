unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, System.Json,
  Datasnap.DSServer, Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter,
  FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, Data.DB, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, System.Variants;

type
{$METHODINFO ON}
  TServerMethods1 = class(TDataModule)
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { private êÈåæ }
  public
    { public êÈåæ }
    function Read(const name: string; cm: integer): TJSONArray;
    function List(const name: string): TJSONArray;
  end;
{$METHODINFO OFF}

implementation

{$R *.dfm}

uses System.StrUtils;

procedure TServerMethods1.DataModuleCreate(Sender: TObject);
var
  s: string;
begin
  if (ExtractFileName(ParamStr(0)) = 'pbbs.dll') and
    (FileExists(FDConnection1.Params.Values['database']) = false) then
  begin
    s := ExtractFilePath(GetModuleName(HInstance)) + 'data.fdb';
    FDConnection1.Params.Values['database'] := s;
  end;
end;

function TServerMethods1.List(const name: string): TJSONArray;
var
  jo: TJSONObject;
begin
  result := TJSONArray.Create;
  if name = 'master' then
    Exit;
  FDQuery1.ParamByName('name').AsString := name;
  FDQuery1.Open;
  while FDQuery1.Eof = false do
  begin
    jo := TJSONObject.Create;
    jo.AddPair(FDQuery1.FieldByName('cmnumber').AsString,
      Copy(FDQuery1.FieldByName('raw').AsString, 1, 20) + '...');
    result.Add(jo);
    FDQuery1.Next;
  end;
  FDQuery1.Close;
end;

function TServerMethods1.Read(const name: string; cm: integer): TJSONArray;
var
  jo1, jo2: TJSONObject;
  ja1, ja2: TJSONArray;
begin
  result := TJSONArray.Create;
  if name = 'master' then
    Exit;
  ja1 := TJSONArray.Create;
  FDQuery1.ParamByName('name').AsString := name;
  FDQuery1.Open;
  ja1.Add('number');
  ja1.Add('name');
  ja1.Add('title');
  ja1.Add('comment');
  ja1.Add('datetime');
  jo1 := TJSONObject.Create;
  jo1.AddPair('name', ja1);
  ja2 := TJSONArray.Create;
  if FDQuery1.Locate('cmnumber', cm) = true then
  begin
    ja2.Add(cm);
    ja2.Add(FDQuery1.FieldByName('name').AsString);
    ja2.Add(FDQuery1.FieldByName('title').AsString);
    ja2.Add(FDQuery1.FieldByName('raw').AsString);
    ja2.Add(FDQuery1.FieldByName('datetime').AsString);
  end;
  FDQuery1.Close;
  jo2 := TJSONObject.Create;
  jo2.AddPair('data', ja2);
  result.Add(jo1);
  result.Add(jo2);
end;

end.
