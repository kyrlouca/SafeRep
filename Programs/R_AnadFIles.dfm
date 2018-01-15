object R_AnadFilesFRM: TR_AnadFilesFRM
  Left = 0
  Top = 0
  Caption = 'R_AnadFilesFRM'
  ClientHeight = 391
  ClientWidth = 797
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 368
    Top = 200
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
  end
  object CompanySQL: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO SEMINAR'
      
        '  (SERIAL_NUMBER, ANAD_NUMBER, FK_SEMINAR, FK_INSTRUCTOR, FK_EXA' +
        'MINER, FK_VENUE, FK_COMPANY_PERSON_SERIAL, SEMINAR_NAME, DATE_ST' +
        'ARTED, DATE_COMPLETED, DURATION_DAYS, DURATION_HOURS, AMOUNT_ANA' +
        'D, COMMENTS, ANAD_APPROVED, STATUS, IS_INVOICED, IS_CERTIFICATED' +
        ', MAX_CAPACITY, HAS_EXPIRY, EXPIRY_PERIOD, TYPE_MONO_POLY, SEM_C' +
        'ATEGORY, FK_COMPANY_INVOICED, PASS_PERCENTAGE, SPECIFICATION_NUM' +
        'BER)'
      'VALUES'
      
        '  (:SERIAL_NUMBER, :ANAD_NUMBER, :FK_SEMINAR, :FK_INSTRUCTOR, :F' +
        'K_EXAMINER, :FK_VENUE, :FK_COMPANY_PERSON_SERIAL, :SEMINAR_NAME,' +
        ' :DATE_STARTED, :DATE_COMPLETED, :DURATION_DAYS, :DURATION_HOURS' +
        ', :AMOUNT_ANAD, :COMMENTS, :ANAD_APPROVED, :STATUS, :IS_INVOICED' +
        ', :IS_CERTIFICATED, :MAX_CAPACITY, :HAS_EXPIRY, :EXPIRY_PERIOD, ' +
        ':TYPE_MONO_POLY, :SEM_CATEGORY, :FK_COMPANY_INVOICED, :PASS_PERC' +
        'ENTAGE, :SPECIFICATION_NUMBER)')
    SQLDelete.Strings = (
      'DELETE FROM SEMINAR'
      'WHERE'
      '  SERIAL_NUMBER = :Old_SERIAL_NUMBER')
    SQLUpdate.Strings = (
      'UPDATE SEMINAR'
      'SET'
      
        '  SERIAL_NUMBER = :SERIAL_NUMBER, ANAD_NUMBER = :ANAD_NUMBER, FK' +
        '_SEMINAR = :FK_SEMINAR, FK_INSTRUCTOR = :FK_INSTRUCTOR, FK_EXAMI' +
        'NER = :FK_EXAMINER, FK_VENUE = :FK_VENUE, FK_COMPANY_PERSON_SERI' +
        'AL = :FK_COMPANY_PERSON_SERIAL, SEMINAR_NAME = :SEMINAR_NAME, DA' +
        'TE_STARTED = :DATE_STARTED, DATE_COMPLETED = :DATE_COMPLETED, DU' +
        'RATION_DAYS = :DURATION_DAYS, DURATION_HOURS = :DURATION_HOURS, ' +
        'AMOUNT_ANAD = :AMOUNT_ANAD, COMMENTS = :COMMENTS, ANAD_APPROVED ' +
        '= :ANAD_APPROVED, STATUS = :STATUS, IS_INVOICED = :IS_INVOICED, ' +
        'IS_CERTIFICATED = :IS_CERTIFICATED, MAX_CAPACITY = :MAX_CAPACITY' +
        ', HAS_EXPIRY = :HAS_EXPIRY, EXPIRY_PERIOD = :EXPIRY_PERIOD, TYPE' +
        '_MONO_POLY = :TYPE_MONO_POLY, SEM_CATEGORY = :SEM_CATEGORY, FK_C' +
        'OMPANY_INVOICED = :FK_COMPANY_INVOICED, PASS_PERCENTAGE = :PASS_' +
        'PERCENTAGE, SPECIFICATION_NUMBER = :SPECIFICATION_NUMBER'
      'WHERE'
      '  SERIAL_NUMBER = :Old_SERIAL_NUMBER')
    SQLRefresh.Strings = (
      
        'SELECT SERIAL_NUMBER, ANAD_NUMBER, FK_SEMINAR, FK_INSTRUCTOR, FK' +
        '_EXAMINER, FK_VENUE, FK_COMPANY_PERSON_SERIAL, SEMINAR_NAME, DAT' +
        'E_STARTED, DATE_COMPLETED, DURATION_DAYS, DURATION_HOURS, AMOUNT' +
        '_ANAD, COMMENTS, ANAD_APPROVED, STATUS, IS_INVOICED, IS_CERTIFIC' +
        'ATED, MAX_CAPACITY, HAS_EXPIRY, EXPIRY_PERIOD, TYPE_MONO_POLY, S' +
        'EM_CATEGORY, FK_COMPANY_INVOICED, PASS_PERCENTAGE, SPECIFICATION' +
        '_NUMBER FROM SEMINAR'
      'WHERE'
      '  SERIAL_NUMBER = :SERIAL_NUMBER')
    SQLLock.Strings = (
      'SELECT NULL FROM SEMINAR'
      'WHERE'
      'SERIAL_NUMBER = :Old_SERIAL_NUMBER'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM SEMINAR'
      ''
      ') q')
    Connection = U_databaseFRM.DataConnection
    SQL.Strings = (
      'select * from person co where co.is_company='#39'Y'#39)
    Left = 32
    Top = 304
    object CompanySQLSERIAL_NUMBER: TIntegerField
      FieldName = 'SERIAL_NUMBER'
      Required = True
    end
    object CompanySQLSERIAL_QB: TIntegerField
      FieldName = 'SERIAL_QB'
    end
    object CompanySQLFK_COMPANY_SERIAL: TIntegerField
      FieldName = 'FK_COMPANY_SERIAL'
    end
    object CompanySQLLAST_NAME: TWideStringField
      FieldName = 'LAST_NAME'
      FixedChar = True
      Size = 30
    end
    object CompanySQLFIRST_NAME: TWideStringField
      FieldName = 'FIRST_NAME'
      FixedChar = True
      Size = 30
    end
    object CompanySQLNATIONAL_ID: TWideStringField
      FieldName = 'NATIONAL_ID'
      FixedChar = True
    end
    object CompanySQLNICKNAME: TWideStringField
      FieldName = 'NICKNAME'
      FixedChar = True
      Size = 30
    end
    object CompanySQLOCCUPATION: TWideStringField
      FieldName = 'OCCUPATION'
      Size = 160
    end
    object CompanySQLPHONE_MOBILE: TWideStringField
      FieldName = 'PHONE_MOBILE'
      FixedChar = True
      Size = 15
    end
    object CompanySQLPHONE_FIXED: TWideStringField
      FieldName = 'PHONE_FIXED'
      FixedChar = True
      Size = 15
    end
    object CompanySQLPHONE_ALTERNATE: TWideStringField
      FieldName = 'PHONE_ALTERNATE'
      FixedChar = True
      Size = 15
    end
    object CompanySQLFAX: TWideStringField
      FieldName = 'FAX'
      FixedChar = True
      Size = 15
    end
    object CompanySQLEMAIL: TWideStringField
      FieldName = 'EMAIL'
      Size = 160
    end
    object CompanySQLEMAIL_2: TSmallintField
      FieldName = 'EMAIL_2'
    end
    object CompanySQLADDRESS: TWideStringField
      FieldName = 'ADDRESS'
      Size = 160
    end
    object CompanySQLADDRESS_STREET: TWideStringField
      FieldName = 'ADDRESS_STREET'
      Size = 80
    end
    object CompanySQLADDRESS_POST_CODE: TWideStringField
      FieldName = 'ADDRESS_POST_CODE'
      FixedChar = True
      Size = 30
    end
    object CompanySQLADDRESS_CITY: TWideStringField
      FieldName = 'ADDRESS_CITY'
      FixedChar = True
      Size = 30
    end
    object CompanySQLADDRESS_DISTRICT: TWideStringField
      FieldName = 'ADDRESS_DISTRICT'
      FixedChar = True
      Size = 30
    end
    object CompanySQLDATE_STARTED: TDateField
      FieldName = 'DATE_STARTED'
    end
    object CompanySQLDATE_BIRTH: TDateField
      FieldName = 'DATE_BIRTH'
    end
    object CompanySQLDATE_USER: TDateField
      FieldName = 'DATE_USER'
    end
    object CompanySQLLIST_SOURCE: TWideStringField
      FieldName = 'LIST_SOURCE'
      Size = 160
    end
    object CompanySQLFACEBOOK: TWideStringField
      FieldName = 'FACEBOOK'
      Size = 160
    end
    object CompanySQLWEBSITE: TWideStringField
      FieldName = 'WEBSITE'
      Size = 160
    end
    object CompanySQLTWITTER: TWideStringField
      FieldName = 'TWITTER'
      Size = 160
    end
    object CompanySQLSTATUS_ACTIVE: TWideStringField
      FieldName = 'STATUS_ACTIVE'
      Required = True
      FixedChar = True
      Size = 1
    end
    object CompanySQLSEX: TWideStringField
      FieldName = 'SEX'
      Required = True
      FixedChar = True
      Size = 1
    end
    object CompanySQLIS_COMPANY: TWideStringField
      FieldName = 'IS_COMPANY'
      Required = True
      FixedChar = True
      Size = 1
    end
    object CompanySQLCOMPANY_OWNER: TWideStringField
      FieldName = 'COMPANY_OWNER'
      Size = 160
    end
    object CompanySQLCOMPANY_CONTACT: TWideStringField
      FieldName = 'COMPANY_CONTACT'
      Size = 160
    end
    object CompanySQLCOMPANY_REGISTRATION_DATE: TDateField
      FieldName = 'COMPANY_REGISTRATION_DATE'
    end
    object CompanySQLPHONE_CONTACT: TWideStringField
      FieldName = 'PHONE_CONTACT'
      FixedChar = True
      Size = 15
    end
    object CompanySQLCOMPANY_CONTACT_FIRST: TWideStringField
      FieldName = 'COMPANY_CONTACT_FIRST'
      FixedChar = True
      Size = 30
    end
    object CompanySQLCOMPANY_CONTACT_LAST: TWideStringField
      FieldName = 'COMPANY_CONTACT_LAST'
      FixedChar = True
      Size = 30
    end
    object CompanySQLCOMPANY_OWNER_REG: TWideStringField
      FieldName = 'COMPANY_OWNER_REG'
      FixedChar = True
      Size = 30
    end
    object CompanySQLCOMPANY_CONTACT_PHONE: TWideStringField
      FieldName = 'COMPANY_CONTACT_PHONE'
      FixedChar = True
      Size = 15
    end
    object CompanySQLCOMPANY_CONTACT_EMAIL: TWideStringField
      FieldName = 'COMPANY_CONTACT_EMAIL'
      Size = 50
    end
    object CompanySQLCOMPANY_CONTACT_FAX: TWideStringField
      FieldName = 'COMPANY_CONTACT_FAX'
      FixedChar = True
      Size = 15
    end
    object CompanySQLCOMPANY_SOCIAL_SEC: TWideStringField
      FieldName = 'COMPANY_SOCIAL_SEC'
      FixedChar = True
    end
    object CompanySQLCOMPANY_EMPLOYEES: TIntegerField
      FieldName = 'COMPANY_EMPLOYEES'
    end
    object CompanySQLPHONE_MOBILE_2: TWideStringField
      FieldName = 'PHONE_MOBILE_2'
      FixedChar = True
      Size = 15
    end
    object CompanySQLLINKED_IN: TWideStringField
      FieldName = 'LINKED_IN'
      FixedChar = True
      Size = 30
    end
    object CompanySQLJOB: TWideStringField
      FieldName = 'JOB'
      Size = 50
    end
  end
  object CompanySRC: TDataSource
    DataSet = CompanySQL
    Left = 112
    Top = 300
  end
end
