unit Unit1;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, Datasnap.DSAuth, System.JSON;

type
  TDSServerModule1 = class(TDSServerModule)
  private
    { private êÈåæ }
  public
    { public êÈåæ }
    function Read(db, cm: integer): string;
    function List(db: integer): TJSONArray;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses WebModuleUnit1;

{$R *.dfm}

{ TDSServerModule1 }

function TDSServerModule1.List(db: integer): TJSONArray;
begin
  WebModuleUnit1
end;

function TDSServerModule1.Read(db, cm: integer): string;
begin

end;

end.

