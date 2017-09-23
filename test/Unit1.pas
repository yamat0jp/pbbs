unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.DBCtrls;

type
  TForm1 = class(TForm)
    FDConnection1: TFDConnection;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    FDTable1: TFDTable;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    DBNavigator1: TDBNavigator;
    DBGrid2: TDBGrid;
    FDTable2: TFDTable;
    DataSource2: TDataSource;
    DBNavigator2: TDBNavigator;
    FDTable3: TFDTable;
    DBGrid3: TDBGrid;
    DataSource3: TDataSource;
    DBNavigator3: TDBNavigator;
    DBNavigator4: TDBNavigator;
    DBGrid4: TDBGrid;
    DataSource4: TDataSource;
    FDTable4: TFDTable;
    DBGrid5: TDBGrid;
    FDTable5: TFDTable;
    DataSource5: TDataSource;
  private
    { Private êÈåæ }
  public
    { Public êÈåæ }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
