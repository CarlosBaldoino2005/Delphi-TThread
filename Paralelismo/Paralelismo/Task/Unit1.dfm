object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 193
  ClientWidth = 431
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 72
    Top = 56
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Button1: TButton
    Left = 72
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Normal'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 153
    Top = 88
    Width = 75
    Height = 25
    Caption = 'TTask'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 234
    Top = 88
    Width = 75
    Height = 25
    Caption = 'ITask'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 72
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Button4'
    TabOrder = 3
    OnClick = Button4Click
  end
end
