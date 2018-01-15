object MainFRM: TMainFRM
  Left = 0
  Top = 0
  Caption = 'MainFRM'
  ClientHeight = 373
  ClientWidth = 649
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
    Selected.Strings = (
      'SERIAL_NUMBER'#9'10'#9'SERIAL_NUMBER'
      'SERIAL_QB'#9'10'#9'SERIAL_QB'
      'FK_COMPANY_SERIAL'#9'10'#9'FK_COMPANY_SERIAL'
      'LAST_NAME'#9'30'#9'LAST_NAME'
      'FIRST_NAME'#9'30'#9'FIRST_NAME'
      'NATIONAL_ID'#9'20'#9'NATIONAL_ID'
      'NICKNAME'#9'30'#9'NICKNAME'
      'OCCUPATION'#9'160'#9'OCCUPATION'
      'PHONE_MOBILE'#9'15'#9'PHONE_MOBILE'
      'PHONE_FIXED'#9'15'#9'PHONE_FIXED'
      'PHONE_ALTERNATE'#9'15'#9'PHONE_ALTERNATE'
      'FAX'#9'15'#9'FAX'
      'EMAIL'#9'160'#9'EMAIL'
      'EMAIL_2'#9'10'#9'EMAIL_2'
      'ADDRESS'#9'160'#9'ADDRESS'
      'ADDRESS_STREET'#9'80'#9'ADDRESS_STREET'
      'ADDRESS_POST_CODE'#9'30'#9'ADDRESS_POST_CODE'
      'ADDRESS_CITY'#9'30'#9'ADDRESS_CITY'
      'ADDRESS_DISTRICT'#9'30'#9'ADDRESS_DISTRICT'
      'DATE_STARTED'#9'10'#9'DATE_STARTED'
      'DATE_BIRTH'#9'10'#9'DATE_BIRTH'
      'DATE_USER'#9'10'#9'DATE_USER'
      'LIST_SOURCE'#9'160'#9'LIST_SOURCE'
      'FACEBOOK'#9'160'#9'FACEBOOK'
      'WEBSITE'#9'160'#9'WEBSITE'
      'TWITTER'#9'160'#9'TWITTER'
      'STATUS_ACTIVE'#9'1'#9'STATUS_ACTIVE'
      'SEX'#9'1'#9'SEX'
      'IS_COMPANY'#9'1'#9'IS_COMPANY'
      'COMPANY_OWNER'#9'160'#9'COMPANY_OWNER'
      'COMPANY_CONTACT'#9'160'#9'COMPANY_CONTACT'
      'COMPANY_REGISTRATION_DATE'#9'10'#9'COMPANY_REGISTRATION_DATE'
      'PHONE_CONTACT'#9'15'#9'PHONE_CONTACT'
      'COMPANY_CONTACT_FIRST'#9'30'#9'COMPANY_CONTACT_FIRST'
      'COMPANY_CONTACT_LAST'#9'30'#9'COMPANY_CONTACT_LAST'
      'COMPANY_OWNER_REG'#9'30'#9'COMPANY_OWNER_REG'
      'COMPANY_CONTACT_PHONE'#9'15'#9'COMPANY_CONTACT_PHONE'
      'COMPANY_CONTACT_EMAIL'#9'50'#9'COMPANY_CONTACT_EMAIL'
      'COMPANY_CONTACT_FAX'#9'15'#9'COMPANY_CONTACT_FAX'
      'COMPANY_SOCIAL_SEC'#9'20'#9'COMPANY_SOCIAL_SEC'
      'COMPANY_EMPLOYEES'#9'10'#9'COMPANY_EMPLOYEES'
      'PHONE_MOBILE_2'#9'15'#9'PHONE_MOBILE_2'
      'LINKED_IN'#9'30'#9'LINKED_IN'
      'JOB'#9'50'#9'JOB'
      'IS_SAFE_COMPANY'#9'1'#9'IS_SAFE_COMPANY'
      'COMPANY_OWNER_ID'#9'30'#9'COMPANY_OWNER_ID')
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
    ShadeStyle = wwbsNormal
    TabOrder = 1
    TextOptions.Alignment = taCenter
    TextOptions.VAlignment = vaVCenter
    OnClick = wwButton1Click
  end
  object wwButton2: TwwButton
    Left = 432
    Top = 144
    Width = 75
    Height = 25
    Caption = 'wwButton2'
    Color = clBtnFace
    DitherColor = clWhite
    DitherStyle = wwdsDither
    NumGlyphs = 0
    ShadeStyle = wwbsNormal
    TabOrder = 2
    TextOptions.Alignment = taCenter
    TextOptions.VAlignment = vaVCenter
    OnClick = wwButton2Click
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
