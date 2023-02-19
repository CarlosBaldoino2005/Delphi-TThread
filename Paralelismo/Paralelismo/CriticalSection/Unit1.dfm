object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 528
  ClientWidth = 641
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 139
    Height = 25
    Caption = 'Direto'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 153
    Top = 8
    Width = 139
    Height = 25
    Caption = 'CriticalSection'
    TabOrder = 1
    OnClick = Button2Click
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 39
    Width = 625
    Height = 314
    DataSource = DataSource1
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Memo1: TMemo
    Left = 8
    Top = 359
    Width = 625
    Height = 161
    TabOrder = 3
  end
  object Button3: TButton
    Left = 298
    Top = 8
    Width = 143
    Height = 25
    Caption = 'Monitor'
    TabOrder = 4
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 496
    Top = 8
    Width = 107
    Height = 25
    Caption = 'Button4'
    TabOrder = 5
    OnClick = Button4Click
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=D:\Projetos\Workshop\Exemplos_Firedac\Workshop\BD\ERP.d' +
        'b3'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    Left = 544
    Top = 56
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    SQL.Strings = (
      'SELECT * FROM CLIENTE')
    Left = 552
    Top = 144
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 528
    Top = 264
  end
end
