unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.PG, FireDAC.Phys.PGDef,
  System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.EngExt,
  Vcl.Bind.DBEngExt, Vcl.ExtCtrls, Vcl.Buttons, Vcl.DBCtrls,
  Data.Bind.Components, Vcl.StdCtrls, Data.Bind.DBScope, Vcl.Grids, Vcl.DBGrids,
  Vcl.DBCGrids, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    FDConnection1: TFDConnection;
    FDTable1: TFDTable;
    FDTable2: TFDTable;
    DataSource2: TDataSource;
    FDTable4: TFDTable;
    FDTable5: TFDTable;
    Memo1: TMemo;
    Memo2: TMemo;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    DBNavigator1: TDBNavigator;
    FDTable2dbnumber: TIntegerField;
    FDTable2titlenum: TIntegerField;
    FDTable2comment: TMemoField;
    FDTable2datetime: TDateField;
    FDTable2code: TMemoField;
    FDTable2dbtitle: TIntegerField;
    FDTable1dbnumber: TIntegerField;
    FDTable1titlenum: TIntegerField;
    FDTable1name: TMemoField;
    FDTable1dbtitle: TIntegerField;
    FDTable1ip: TMemoField;
    FDTable4dbnumber: TIntegerField;
    FDTable4dbname: TMemoField;
    FDTable4nickname: TMemoField;
    FDTable4password_hash: TMemoField;
    FDTable4email: TMemoField;
    FDTable5usernum: TIntegerField;
    FDTable5name: TMemoField;
    FDTable5pagecount: TIntegerField;
    FDTable5count: TIntegerField;
    FDTable5maintenance: TBooleanField;
    FDTable5pagetype: TIntegerField;
    FDTable5url: TMemoField;
    FDTable5id: TIntegerField;
    FDTable5ip: TMemoField;
    FDTable5time: TTimeField;
    BindSourceDB2: TBindSourceDB;
    ListBox1: TListBox;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    ListBox2: TListBox;
    BindSourceDB3: TBindSourceDB;
    ListBox3: TListBox;
    DataSource4: TDataSource;
    DataSource5: TDataSource;
    LinkListControlToField1: TLinkListControlToField;
    LinkListControlToField2: TLinkListControlToField;
    LinkListControlToField3: TLinkListControlToField;
    Memo3: TMemo;
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    BindSourceDB4: TBindSourceDB;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    FDTable3: TFDTable;
    BindSourceDB5: TBindSourceDB;
    LinkControlToField5: TLinkControlToField;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure FDTable4BeforeScroll(DataSet: TDataSet);
  private
    { Private êÈåæ }
  public
    { Public êÈåæ }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FDTable4BeforeScroll(DataSet: TDataSet);
begin
  ListBox3.Clear;
end;

end.
