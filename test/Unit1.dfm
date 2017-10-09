object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 585
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
    Left = 8
    Top = 72
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
  object DBGrid2: TDBGrid
    Left = 8
    Top = 203
    Width = 320
    Height = 88
    DataSource = DataSource2
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBNavigator2: TDBNavigator
    Left = 369
    Top = 25
    Width = 240
    Height = 25
    DataSource = DataSource2
    TabOrder = 3
  end
  object DBGrid3: TDBGrid
    Left = 347
    Top = 198
    Width = 262
    Height = 80
    DataSource = DataSource3
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBNavigator3: TDBNavigator
    Left = 8
    Top = 297
    Width = 240
    Height = 25
    DataSource = DataSource3
    TabOrder = 5
  end
  object DBNavigator4: TDBNavigator
    Left = 320
    Top = 297
    Width = 240
    Height = 25
    DataSource = DataSource4
    TabOrder = 6
  end
  object DBGrid4: TDBGrid
    Left = 303
    Top = 344
    Width = 297
    Height = 97
    DataSource = DataSource4
    TabOrder = 7
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBGrid5: TDBGrid
    Left = 8
    Top = 344
    Width = 289
    Height = 97
    DataSource = DataSource5
    TabOrder = 8
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBGrid6: TDBGrid
    Left = 144
    Top = 447
    Width = 320
    Height = 120
    DataSource = DataSource6
    TabOrder = 9
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\yamat\Documents\GitHub\pbbs\Win64\Debug\DATA.F' +
        'DB'
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
    IndexFieldNames = 'ID'
    MasterSource = DataSource5
    MasterFields = 'ID'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'MAINTABLE'
    TableName = 'MAINTABLE'
    Left = 264
    Top = 24
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 344
    Top = 80
  end
  object FDTable2: TFDTable
    Active = True
    IndexFieldNames = 'ID'
    MasterSource = DataSource1
    MasterFields = 'ID'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'RAW'
    TableName = 'RAW'
    Left = 472
    Top = 240
  end
  object DataSource2: TDataSource
    DataSet = FDTable2
    Left = 536
    Top = 240
  end
  object FDTable3: TFDTable
    Active = True
    IndexFieldNames = 'ID'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'ALERTTABLE'
    TableName = 'ALERTTABLE'
    Left = 472
    Top = 200
  end
  object DataSource3: TDataSource
    DataSet = FDTable3
    Left = 536
    Top = 200
  end
  object DataSource4: TDataSource
    DataSet = FDTable4
    Left = 560
    Top = 352
  end
  object FDTable4: TFDTable
    Active = True
    IndexFieldNames = 'SCORE'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'TITLE'
    TableName = 'TITLE'
    Left = 504
    Top = 352
  end
  object FDTable5: TFDTable
    Active = True
    IndexFieldNames = 'ID'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'DBNAME'
    TableName = 'DBNAME'
    Left = 136
    Top = 344
  end
  object DataSource5: TDataSource
    DataSet = FDTable5
    Left = 200
    Top = 344
  end
  object FDTable6: TFDTable
    Active = True
    IndexFieldNames = 'TBNUMBER'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'NAMETABLE'
    TableName = 'NAMETABLE'
    Left = 504
    Top = 448
  end
  object DataSource6: TDataSource
    DataSet = FDTable6
    Left = 440
    Top = 448
  end
end
