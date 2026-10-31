object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'DBTool'
  ClientHeight = 609
  ClientWidth = 873
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Label1: TLabel
    Left = 624
    Top = 80
    Width = 56
    Height = 15
    Caption = #12480#12452#12472#12455#12473#12488
  end
  object Memo1: TMemo
    Left = 352
    Top = 128
    Width = 185
    Height = 89
    ReadOnly = True
    TabOrder = 0
  end
  object Memo2: TMemo
    Left = 352
    Top = 232
    Width = 185
    Height = 89
    ReadOnly = True
    TabOrder = 1
  end
  object DBNavigator1: TDBNavigator
    Left = 352
    Top = 360
    Width = 222
    Height = 25
    DataSource = DataSource2
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbDelete, nbRefresh]
    TabOrder = 2
  end
  object ListBox1: TListBox
    Left = 624
    Top = 112
    Width = 177
    Height = 209
    ItemHeight = 15
    TabOrder = 3
  end
  object ListBox2: TListBox
    Left = 160
    Top = 80
    Width = 121
    Height = 137
    ItemHeight = 15
    Items.Strings = (
      'master_a'
      #12414#12354#12375#12356)
    TabOrder = 4
  end
  object ListBox3: TListBox
    Left = 160
    Top = 256
    Width = 121
    Height = 97
    ItemHeight = 15
    TabOrder = 5
  end
  object Memo3: TMemo
    Left = 264
    Top = 416
    Width = 185
    Height = 89
    ReadOnly = True
    TabOrder = 6
  end
  object Edit1: TEdit
    Left = 472
    Top = 77
    Width = 121
    Height = 23
    TabOrder = 7
  end
  object Edit2: TEdit
    Left = 328
    Top = 77
    Width = 121
    Height = 23
    TabOrder = 8
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=bbs'
      'User_Name=postgres'
      'Password=kainushi'
      'CharacterSet=SJIS'
      'DriverID=PG')
    Connected = True
    Left = 56
    Top = 88
  end
  object FDTable1: TFDTable
    Active = True
    IndexFieldNames = 'dbnumber;dbtitle;titlenum'
    MasterSource = DataSource5
    MasterFields = 'usernum;id'
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'datatable'
    Left = 400
    Top = 56
    object FDTable1dbnumber: TIntegerField
      FieldName = 'dbnumber'
      Origin = 'dbnumber'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object FDTable1titlenum: TIntegerField
      FieldName = 'titlenum'
      Origin = 'titlenum'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object FDTable1name: TMemoField
      FieldName = 'name'
      Origin = 'name'
      BlobType = ftMemo
    end
    object FDTable1dbtitle: TIntegerField
      FieldName = 'dbtitle'
      Origin = 'dbtitle'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object FDTable1ip: TMemoField
      FieldName = 'ip'
      Origin = 'ip'
      BlobType = ftMemo
    end
  end
  object FDTable2: TFDTable
    Active = True
    IndexFieldNames = 'dbnumber;dbtitle'
    MasterSource = DataSource5
    MasterFields = 'usernum;id'
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'maintable'
    Left = 384
    Top = 168
    object FDTable2dbnumber: TIntegerField
      FieldName = 'dbnumber'
      Origin = 'dbnumber'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object FDTable2titlenum: TIntegerField
      FieldName = 'titlenum'
      Origin = 'titlenum'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object FDTable2comment: TMemoField
      FieldName = 'comment'
      Origin = '"comment"'
      BlobType = ftMemo
    end
    object FDTable2datetime: TDateField
      FieldName = 'datetime'
      Origin = 'datetime'
    end
    object FDTable2code: TMemoField
      FieldName = 'code'
      Origin = 'code'
      BlobType = ftMemo
    end
    object FDTable2dbtitle: TIntegerField
      FieldName = 'dbtitle'
      Origin = 'dbtitle'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
  end
  object DataSource2: TDataSource
    DataSet = FDTable2
    Left = 384
    Top = 232
  end
  object FDTable4: TFDTable
    Active = True
    BeforeScroll = FDTable4BeforeScroll
    IndexFieldNames = 'dbnumber'
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = '"database"'
    Left = 176
    Top = 120
    object FDTable4dbnumber: TIntegerField
      FieldName = 'dbnumber'
      Origin = 'dbnumber'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object FDTable4dbname: TMemoField
      FieldName = 'dbname'
      Origin = 'dbname'
      BlobType = ftMemo
    end
    object FDTable4nickname: TMemoField
      FieldName = 'nickname'
      Origin = 'nickname'
      BlobType = ftMemo
    end
    object FDTable4password_hash: TMemoField
      FieldName = 'password_hash'
      Origin = 'password_hash'
      BlobType = ftMemo
    end
    object FDTable4email: TMemoField
      FieldName = 'email'
      Origin = 'email'
      BlobType = ftMemo
    end
  end
  object FDTable5: TFDTable
    Active = True
    IndexFieldNames = 'usernum;id'
    MasterSource = DataSource4
    MasterFields = 'dbnumber'
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'titles'
    Left = 176
    Top = 272
    object FDTable5usernum: TIntegerField
      FieldName = 'usernum'
      Origin = 'usernum'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object FDTable5name: TMemoField
      FieldName = 'name'
      Origin = 'name'
      BlobType = ftMemo
    end
    object FDTable5pagecount: TIntegerField
      FieldName = 'pagecount'
      Origin = 'pagecount'
    end
    object FDTable5count: TIntegerField
      FieldName = 'count'
      Origin = 'count'
    end
    object FDTable5maintenance: TBooleanField
      FieldName = 'maintenance'
      Origin = 'maintenance'
    end
    object FDTable5pagetype: TIntegerField
      FieldName = 'pagetype'
      Origin = 'pagetype'
    end
    object FDTable5url: TMemoField
      FieldName = 'url'
      Origin = 'url'
      BlobType = ftMemo
    end
    object FDTable5id: TIntegerField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object FDTable5ip: TMemoField
      FieldName = 'ip'
      Origin = 'ip'
      BlobType = ftMemo
    end
    object FDTable5time: TTimeField
      FieldName = 'time'
      Origin = '"time"'
      ProviderFlags = [pfInUpdate]
    end
  end
  object BindSourceDB1: TBindSourceDB
    DataSet = FDTable2
    ScopeMappings = <>
    Left = 56
    Top = 304
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 20
    Top = 5
    object LinkControlToField1: TLinkControlToField
      Category = #12463#12452#12483#12463' '#12496#12452#12531#12487#12451#12531#12464
      DataSource = BindSourceDB1
      FieldName = 'comment'
      Control = Memo1
      Track = False
    end
    object LinkControlToField2: TLinkControlToField
      Category = #12463#12452#12483#12463' '#12496#12452#12531#12487#12451#12531#12464
      DataSource = BindSourceDB1
      FieldName = 'code'
      Control = Memo2
      Track = False
    end
    object LinkListControlToField1: TLinkListControlToField
      Category = #12463#12452#12483#12463' '#12496#12452#12531#12487#12451#12531#12464
      DataSource = BindSourceDB2
      FieldName = 'name'
      Control = ListBox3
      FillExpressions = <>
      FillHeaderExpressions = <>
      FillBreakGroups = <>
    end
    object LinkListControlToField2: TLinkListControlToField
      Category = #12463#12452#12483#12463' '#12496#12452#12531#12487#12451#12531#12464
      DataSource = BindSourceDB3
      FieldName = 'dbname'
      Control = ListBox2
      FillExpressions = <>
      FillHeaderExpressions = <>
      FillBreakGroups = <>
    end
    object LinkListControlToField3: TLinkListControlToField
      Category = #12463#12452#12483#12463' '#12496#12452#12531#12487#12451#12531#12464
      DataSource = BindSourceDB1
      FieldName = 'comment'
      Control = ListBox1
      FillExpressions = <>
      FillHeaderExpressions = <>
      FillBreakGroups = <>
    end
    object LinkControlToField3: TLinkControlToField
      Category = #12463#12452#12483#12463' '#12496#12452#12531#12487#12451#12531#12464
      DataSource = BindSourceDB4
      FieldName = 'name'
      Control = Edit2
      Track = True
    end
    object LinkControlToField4: TLinkControlToField
      Category = #12463#12452#12483#12463' '#12496#12452#12531#12487#12451#12531#12464
      DataSource = BindSourceDB4
      FieldName = 'ip'
      Control = Edit1
      Track = True
    end
    object LinkControlToField5: TLinkControlToField
      Category = #12463#12452#12483#12463' '#12496#12452#12531#12487#12451#12531#12464
      DataSource = BindSourceDB5
      FieldName = 'log'
      Control = Memo3
      Track = False
    end
  end
  object BindSourceDB2: TBindSourceDB
    DataSet = FDTable5
    ScopeMappings = <>
    Left = 56
    Top = 240
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    VendorLib = 'C:\Program Files\PostgreSQL\18\bin\libpq.dll'
    Left = 56
    Top = 152
  end
  object BindSourceDB3: TBindSourceDB
    DataSet = FDTable4
    ScopeMappings = <>
    Left = 56
    Top = 368
  end
  object DataSource4: TDataSource
    DataSet = FDTable4
    Left = 176
    Top = 184
  end
  object DataSource5: TDataSource
    DataSet = FDTable5
    Left = 176
    Top = 336
  end
  object BindSourceDB4: TBindSourceDB
    DataSet = FDTable1
    ScopeMappings = <>
    Left = 56
    Top = 432
  end
  object FDTable3: TFDTable
    Active = True
    IndexFieldNames = 'dbid;id'
    MasterSource = DataSource5
    MasterFields = 'id'
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'weblog'
    Left = 320
    Top = 432
  end
  object BindSourceDB5: TBindSourceDB
    DataSet = FDTable3
    ScopeMappings = <>
    Left = 56
    Top = 504
  end
end
