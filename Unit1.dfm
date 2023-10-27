object Form1: TForm1
  Left = 0
  Top = 0
  AutoSize = True
  Caption = #1047#1072#1084#1077#1090#1082#1080
  ClientHeight = 316
  ClientWidth = 519
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 519
    Height = 316
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 513
    ExplicitHeight = 313
    object Label1: TLabel
      Left = 6
      Top = 2
      Width = 84
      Height = 13
      Caption = #1057#1087#1080#1089#1086#1082' '#1079#1072#1084#1077#1090#1086#1082':'
    end
    object ScrollBox1: TScrollBox
      Left = 4
      Top = 19
      Width = 373
      Height = 276
      TabOrder = 0
      object FileListBox1: TFileListBox
        Left = 0
        Top = 0
        Width = 369
        Height = 272
        Align = alClient
        ItemHeight = 13
        MultiSelect = True
        TabOrder = 0
        OnChange = FileListBox1Change
        ExplicitLeft = -3
      end
    end
    object Button1: TButton
      Left = 395
      Top = 19
      Width = 104
      Height = 30
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      TabOrder = 1
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 395
      Top = 55
      Width = 104
      Height = 30
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      TabOrder = 2
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 395
      Top = 265
      Width = 104
      Height = 30
      Caption = #1059#1076#1072#1083#1080#1090#1100
      TabOrder = 3
      OnClick = Button3Click
    end
  end
end
