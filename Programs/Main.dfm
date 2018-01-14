object MainFRM: TMainFRM
  Left = 0
  Top = 0
  Caption = 'MainFRM'
  ClientHeight = 225
  ClientWidth = 405
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object wwDBGrid1: TwwDBGrid
    Left = 64
    Top = 97
    Width = 320
    Height = 120
    IniAttributes.Delimiter = ';;'
    IniAttributes.UnicodeIniFile = False
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = IBCDataSource1
    TabOrder = 0
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
  end
  object wwButton1: TwwButton
    Left = 296
    Top = 40
    Width = 75
    Height = 25
    Caption = 'wwButton1'
    Color = clBtnFace
    DitherColor = clWhite
    DitherStyle = wwdsDither
    NumGlyphs = 0
    ShadeStyle = wwbsNormal
    TabOrder = 1
    TabStop = True
    TextOptions.Alignment = taCenter
    TextOptions.VAlignment = vaVCenter
    OnClick = wwButton1Click
  end
  object IBCDataSource1: TIBCDataSource
    DataSet = PersonSQL
    Left = 224
    Top = 16
  end
  object PersonSQL: TIBCQuery
    Connection = U_databaseFRM.DataConnection
    SQL.Strings = (
      'Select * from person')
    Active = True
    Left = 56
    Top = 32
  end
end
