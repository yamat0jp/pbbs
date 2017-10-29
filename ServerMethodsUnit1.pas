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
    FDTable1: TFDTable;
  private
    { private êÈåæ }
  public
    { public êÈåæ }
    function Read(const name: string; cm: integer): string;
    function List(const name: string): TJSONArray;
  end;
{$METHODINFO OFF}

implementation

{$R *.dfm}

uses System.StrUtils;

function TServerMethods1.List(const name: string): TJSONArray;
var
  jo1, jo2: TJSONObject;
  ja1, ja2: TJSONArray;
  DB: integer;
begin
  ja1 := TJSONArray.Create;
  ja2 := TJSONArray.Create;
  FDTable1.TableName := 'nametable';
  FDTable1.Open;
  DB := FDTable1.Lookup('tbname', name, 'tbnumber');
  FDTable1.Close;
  FDTable1.TableName := 'maintable';
  FDTable1.Open;
  if FDTable1.Locate('id', DB) = true then
  begin
    ja1.Add('id');
    ja2.Add(FDTable1.FieldByName('id').AsInteger);
    ja1.Add('name');
    ja2.Add(FDTable1.FieldByName('name').AsString);
    ja1.Add('title');
    ja2.Add(FDTable1.FieldByName('title').AsString);
    ja1.Add('comment');
    ja2.Add(Copy(FDTable1.FieldByName('comment').AsString, 1, 10));
    ja1.Add('datetime');
    ja2.Add(FDTable1.FieldByName('datetime').AsDateTime);
    jo1 := TJSONObject.Create;
    jo1.AddPair('name', ja1);
    jo2 := TJSONObject.Create;
    jo2.AddPair('data', ja2);
    result := TJSONArray.Create(jo1, jo2);
  end;
  FDTable1.Close;
end;

function TServerMethods1.Read(const name: string; cm: integer): string;
var
  s: Variant;
  DB: integer;
begin
  FDTable1.TableName := 'nametable';
  FDTable1.Open;
  DB := FDTable1.Lookup('tbname', name, 'tbnumber');
  FDTable1.Close;
  FDTable1.TableName := 'dbname';
  FDTable1.Open;
  s := FDTable1.Lookup('tbnumber;cmnumber', VarArrayOf([DB, cm]), 'id');
  FDTable1.Close;
  FDTable1.TableName := 'raw';
  FDTable1.Open;
  result := FDTable1.Lookup('id', s, 'raw');
  FDTable1.Close;
end;

end.
