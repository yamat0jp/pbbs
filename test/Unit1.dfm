object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 16
    Top = 120
    Width = 601
    Height = 120
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBNavigator1: TDBNavigator
    Left = 75
    Top = 25
    Width = 240
    Height = 25
    DataSource = DataSource1
    TabOrder = 1
  end
  object DBMemo1: TDBMemo
    Left = 416
    Top = 8
    Width = 185
    Height = 89
    DataSource = DataSource1
    TabOrder = 2
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=C:\Users\yamat\Documents\GitHub\pbbs\DATA.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=FB')
    Connected = True
    Left = 176
    Top = 24
  end
  object DataSource1: TDataSource
    DataSet = FDTable1
    Left = 344
    Top = 24
  end
  object FDTable1: TFDTable
    Active = True
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'maintable'
    TableName = 'maintable'
    Left = 264
    Top = 24
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 344
    Top = 80
  end
end
