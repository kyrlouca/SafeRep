unit R_word_issonos_1;

interface

uses
  Windows, Messages, SysUtils,System.DateUtils,System.math, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, wwSpeedButton, wwDBNavigator, Db, Wwdatsrc,
   DBAccess, IBC, MemDS, IBCError,  Grids, Wwdbigrd, Wwdbgrid, Wwkeycb, wwDialog, wwidlg,
  Mask, wwdbedit,  DBGrids, wwdbdatetimepicker, ppDB, ppCtrls,
  ppVar, ppPrnabl, ppClass, ppBands, ppProd, ppReport, ppComm, ppRelatv,
  ppCache, ppDBPipe,ppTypes,ppviewr, ppDesignLayer, ppParameter, RzButton,
  RzPanel, Vcl.Imaging.pngimage, VirtualTable, myChkBox, vcl.wwdblook, ppStrtch,
  ppSubRpt, Vcl.Imaging.jpeg;

type
  TReminderResult= Record
    daysLeft:Integer;
    DateFinal:Tdate;
  End;

  TR_Word_issonos_1FRM = class(TForm)
    Panel1: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    TableSQL: TIBCQuery;
    TableSRC: TDataSource;
    TablePIP: TppDBPipeline;
    GroupBox1: TGroupBox;
    PrintRBtn: TBitBtn;
    Panel11: TRzPanel;
    BitBtn1: TBitBtn;
    ppReport1: TppReport;
    ppParameterList3: TppParameterList;
    ppTitleBand3: TppTitleBand;
    ppLabel4: TppLabel;
    ppImage3: TppImage;
    ppHeaderBand3: TppHeaderBand;
    ppLine5: TppLine;
    ppLabel5: TppLabel;
    ddBand: TppDetailBand;
    ppFooterBand3: TppFooterBand;
    ppLine6: TppLine;
    ppSystemVariable5: TppSystemVariable;
    ppSystemVariable6: TppSystemVariable;
    ppDesignLayers3: TppDesignLayers;
    ppDesignLayer3: TppDesignLayer;
    ppDBText1: TppDBText;
    ppDBText5: TppDBText;
    ppLabel1: TppLabel;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppLabel8: TppLabel;
    ppLabel9: TppLabel;
    ppShape1: TppShape;
    ppVariable3: TppVariable;
    ppLabel10: TppLabel;
    ppLabel11: TppLabel;
    ppLabel12: TppLabel;
    ppDBText7: TppDBText;
    ppDBText8: TppDBText;
    ppDBText3: TppDBText;
    ppLabel13: TppLabel;
    ppLabel3: TppLabel;
    DaysLeftLBL: TppDBText;
    PersonSQL: TIBCQuery;
    PersonSRC: TDataSource;
    PersonPIP: TppDBPipeline;
    DaysLeftVrb: TppVariable;
    Label1: TLabel;
    CompanySFLD: TwwDBLookupCombo;
    Label2: TLabel;
    SeminarSFLD: TwwDBLookupCombo;
    Label3: TLabel;
    FromDateFLD: TwwDBDateTimePicker;
    ppLabel2: TppLabel;
    ppDBText2: TppDBText;
    ppLabel14: TppLabel;
    ppDBText4: TppDBText;
    ppLabel15: TppLabel;
    ppDBText6: TppDBText;
    PolyIssonosRPT: TppReport;
    ppParameterList1: TppParameterList;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppDetailBand1: TppDetailBand;
    ppSubReport1: TppSubReport;
    ppChildReport1: TppChildReport;
    ppDesignLayers2: TppDesignLayers;
    ppDesignLayer2: TppDesignLayer;
    ppDetailBand2: TppDetailBand;
    ppSubReport2: TppSubReport;
    ppChildReport2: TppChildReport;
    ppDesignLayers4: TppDesignLayers;
    ppDesignLayer5: TppDesignLayer;
    ppDetailBand3: TppDetailBand;
    ppSubReport3: TppSubReport;
    ppChildReport3: TppChildReport;
    ppPageStyle1: TppPageStyle;
    ppDesignLayer4: TppDesignLayer;
    ppPageStyle2: TppPageStyle;
    ppDesignLayer6: TppDesignLayer;
    PersonSQLSERIAL_NUMBER: TIntegerField;
    PersonSQLSERIAL_QB: TIntegerField;
    PersonSQLFK_COMPANY_SERIAL: TIntegerField;
    PersonSQLLAST_NAME: TWideStringField;
    PersonSQLFIRST_NAME: TWideStringField;
    PersonSQLNATIONAL_ID: TWideStringField;
    PersonSQLNICKNAME: TWideStringField;
    PersonSQLOCCUPATION: TWideStringField;
    PersonSQLPHONE_MOBILE: TWideStringField;
    PersonSQLPHONE_FIXED: TWideStringField;
    PersonSQLPHONE_ALTERNATE: TWideStringField;
    PersonSQLFAX: TWideStringField;
    PersonSQLEMAIL: TWideStringField;
    PersonSQLEMAIL_2: TSmallintField;
    PersonSQLADDRESS: TWideStringField;
    PersonSQLADDRESS_STREET: TWideStringField;
    PersonSQLADDRESS_POST_CODE: TWideStringField;
    PersonSQLADDRESS_CITY: TWideStringField;
    PersonSQLADDRESS_DISTRICT: TWideStringField;
    PersonSQLDATE_STARTED: TDateField;
    PersonSQLDATE_BIRTH: TDateField;
    PersonSQLDATE_USER: TDateField;
    PersonSQLLIST_SOURCE: TWideStringField;
    PersonSQLFACEBOOK: TWideStringField;
    PersonSQLWEBSITE: TWideStringField;
    PersonSQLTWITTER: TWideStringField;
    PersonSQLSTATUS_ACTIVE: TWideStringField;
    PersonSQLSEX: TWideStringField;
    PersonSQLIS_COMPANY: TWideStringField;
    PersonSQLCOMPANY_OWNER: TWideStringField;
    PersonSQLCOMPANY_CONTACT: TWideStringField;
    PersonSQLCOMPANY_REGISTRATION_DATE: TDateField;
    PersonSQLPHONE_CONTACT: TWideStringField;
    PersonSQLCOMPANY_CONTACT_FIRST: TWideStringField;
    PersonSQLCOMPANY_CONTACT_LAST: TWideStringField;
    PersonSQLCOMPANY_OWNER_REG: TWideStringField;
    PersonSQLCOMPANY_CONTACT_PHONE: TWideStringField;
    PersonSQLCOMPANY_CONTACT_EMAIL: TWideStringField;
    PersonSQLCOMPANY_CONTACT_FAX: TWideStringField;
    PersonSQLCOMPANY_SOCIAL_SEC: TWideStringField;
    PersonSQLCOMPANY_EMPLOYEES: TIntegerField;
    PersonSQLPHONE_MOBILE_2: TWideStringField;
    PersonSQLLINKED_IN: TWideStringField;
    PersonSQLJOB: TWideStringField;
    PersonSQLIS_SAFE_COMPANY: TWideStringField;
    ppDBText9: TppDBText;
    ppDBText10: TppDBText;
    ppImage1: TppImage;
    ppSubReport4: TppSubReport;
    ppChildReport4: TppChildReport;
    ppSubReport5: TppSubReport;
    ppChildReport5: TppChildReport;
    ppSubReport6: TppSubReport;
    ppChildReport6: TppChildReport;
    ppPageStyle3: TppPageStyle;
    ppDesignLayer8: TppDesignLayer;
    ppDesignLayers6: TppDesignLayers;
    ppDesignLayer9: TppDesignLayer;
    ppDetailBand4: TppDetailBand;
    ppPageStyle4: TppPageStyle;
    ppDesignLayer10: TppDesignLayer;
    ppDesignLayers7: TppDesignLayers;
    ppDesignLayer11: TppDesignLayer;
    ppDetailBand5: TppDetailBand;
    ppPageStyle5: TppPageStyle;
    ppDesignLayer12: TppDesignLayer;
    ppDesignLayers8: TppDesignLayers;
    ppDesignLayer13: TppDesignLayer;
    ppDetailBand6: TppDetailBand;
    ppImage2: TppImage;
    ppImage4: TppImage;
    ppImage5: TppImage;
    ppPageStyle6: TppPageStyle;
    ppDesignLayer14: TppDesignLayer;
    ppImage6: TppImage;
    ppDBText11: TppDBText;
    TableSQLSERIAL_NUMBER: TIntegerField;
    TableSQLFK_COMPANY_SERIAL: TIntegerField;
    TableSQLLAST_NAME: TWideStringField;
    TableSQLFIRST_NAME: TWideStringField;
    TableSQLFIRST_LAST_NAME: TWideStringField;
    TableSQLLAST_FIRST_NAME: TWideStringField;
    TableSQLNATIONAL_ID: TWideStringField;
    TableSQLNICKNAME: TWideStringField;
    TableSQLOCCUPATION: TWideStringField;
    TableSQLPHONE_MOBILE: TWideStringField;
    TableSQLPHONE_FIXED: TWideStringField;
    TableSQLPHONE_ALTERNATE: TWideStringField;
    TableSQLFAX: TWideStringField;
    TableSQLEMAIL: TWideStringField;
    TableSQLEMAIL_2: TSmallintField;
    TableSQLADDRESS: TWideStringField;
    TableSQLADDRESS_STREET: TWideStringField;
    TableSQLADDRESS_POST_CODE: TWideStringField;
    TableSQLADDRESS_CITY: TWideStringField;
    TableSQLADDRESS_DISTRICT: TWideStringField;
    TableSQLDATE_STARTED: TDateField;
    TableSQLDATE_BIRTH: TDateField;
    TableSQLDATE_USER: TDateField;
    TableSQLLIST_SOURCE: TWideStringField;
    TableSQLFACEBOOK: TWideStringField;
    TableSQLWEBSITE: TWideStringField;
    TableSQLTWITTER: TWideStringField;
    TableSQLSTATUS_ACTIVE: TWideStringField;
    TableSQLSEX: TWideStringField;
    TableSQLIS_COMPANY: TWideStringField;
    TableSQLCOMPANY_OWNER: TWideStringField;
    TableSQLCOMPANY_CONTACT: TWideStringField;
    TableSQLCOMPANY_REGISTRATION_DATE: TDateField;
    TableSQLPHONE_CONTACT: TWideStringField;
    ppDBText12: TppDBText;
    TableSQLCOMPANY_OWNER_ID: TWideStringField;
    TableSQLCOMPANY_OWENER_REG: TWideStringField;
    ppDBText13: TppDBText;
    ppDBText14: TppDBText;
    SeminarSQL: TIBCQuery;
    SeminarSQLSERIAL_NUMBER: TIntegerField;
    SeminarSQLANAD_NUMBER: TWideStringField;
    SeminarSQLFK_SEMINAR: TIntegerField;
    SeminarSQLFK_INSTRUCTOR: TIntegerField;
    SeminarSQLFK_EXAMINER: TIntegerField;
    SeminarSQLFK_VENUE: TIntegerField;
    SeminarSQLFK_COMPANY_PERSON_SERIAL: TIntegerField;
    SeminarSQLSEMINAR_NAME: TWideStringField;
    SeminarSQLDATE_STARTED: TDateField;
    SeminarSQLDATE_COMPLETED: TDateField;
    SeminarSQLDURATION_DAYS: TIntegerField;
    SeminarSQLDURATION_HOURS: TIntegerField;
    SeminarSQLAMOUNT_ANAD: TFloatField;
    SeminarSQLCOMMENTS: TWideStringField;
    SeminarSQLANAD_APPROVED: TWideStringField;
    SeminarSQLSTATUS: TWideStringField;
    SeminarSQLIS_INVOICED: TWideStringField;
    SeminarSQLIS_CERTIFICATED: TWideStringField;
    SeminarSQLMAX_CAPACITY: TIntegerField;
    SeminarSQLHAS_EXPIRY: TWideStringField;
    SeminarSQLEXPIRY_PERIOD: TIntegerField;
    SeminarSQLTYPE_MONO_POLY: TWideStringField;
    SeminarSQLSEM_CATEGORY: TWideStringField;
    SeminarSQLFK_COMPANY_INVOICED: TIntegerField;
    SeminarSQLPASS_PERCENTAGE: TIntegerField;
    SeminarSQLSPECIFICATION_NUMBER: TWideStringField;
    SeminarSRC: TDataSource;
    SeminarPIP: TppDBPipeline;
    procedure BitBtn2Click(Sender: TObject);
    procedure ppReport1PreviewFormCreate(Sender: TObject);
    procedure ppLabel10GetText(Sender: TObject; var Text: String);
    procedure FormActivate(Sender: TObject);
    procedure RzBitBtn1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure ppVariable1Calc(Sender: TObject; var Value: Variant);
    procedure FormCreate(Sender: TObject);
    procedure ppVariable2Calc(Sender: TObject; var Value: Variant);
    procedure ppVariable3Calc(Sender: TObject; var Value: Variant);
    procedure TableSQLCalcFields(DataSet: TDataSet);
    procedure PrintRBtnClick(Sender: TObject);
  private
    { Private declarations }
    cn:TIBCConnection;
  Function FindActionDate(const DateSeminar:TDate;Const isAfter,isDayUnit:Boolean;Const NumberOfUnits:Integer):Tdate;
  Function CalcDaysLeft():TReminderResult;
  procedure DisplayFilter;

  public
    { Public declarations }
    IN_SeminarSerial:Integer;
    IN_isCompleted:String;
    IN_HasDate:String;
    IN_DateRef:TDate;
    Procedure PrintTheSeminar();
    Procedure PrintOnePolyIssonos(Const SeminarSerial:integer; CompanySerial : Integer);

  end;

var
  R_Word_issonos_1FRM: TR_Word_issonos_1FRM;

implementation

uses U_Database,  G_KyrSQL;


{$R *.DFM}





procedure TR_Word_issonos_1FRM.BitBtn1Click(Sender: TObject);
begin
close;
end;

procedure TR_Word_issonos_1FRM.BitBtn2Click(Sender: TObject);
begin
close;

end;




procedure TR_Word_issonos_1FRM.ppReport1PreviewFormCreate(
  Sender: TObject);
begin
  (sender as TppReport).PreviewForm.WindowState := wsMaximized;
  TppViewer((sender as TppReport).PreviewForm.Viewer).ZoomSetting := zs100Percent;

end;


procedure TR_Word_issonos_1FRM.ppVariable1Calc(Sender: TObject; var Value: Variant);
begin
// value:=vt.FieldByName('DaysCalc').AsInteger;
end;

procedure TR_Word_issonos_1FRM.ppVariable2Calc(Sender: TObject; var Value: Variant);
begin
// value:=vt.FieldByName('ActionDate').AsDateTime;

end;

procedure TR_Word_issonos_1FRM.ppVariable3Calc(Sender: TObject; var Value: Variant);
begin
   value:=FromDateFLD.Date
end;

procedure TR_Word_issonos_1FRM.RzBitBtn1Click(Sender: TObject);
begin
  close;
end;




procedure TR_Word_issonos_1FRM.TableSQLCalcFields(DataSet: TDataSet);
var
  days:integer;
begin
//  Days:= Trunc(Dataset.FieldByName('date_targeted').AsDateTime - IN_DateRef);
//  Dataset.FieldByName('daysLeft').AsInteger:=days;
end;

Function TR_Word_issonos_1FRM.CalcDaysLeft():TReminderResult;
begin

end;



Function TR_Word_issonos_1FRM.FindActionDate(const DateSeminar:TDate;Const isAfter,isDayUnit:Boolean;Const NumberOfUnits:Integer):Tdate;
var
  mySign:Integer;
  DateReminder:TDate;
begin
  if isAfter then
    mySign:=1
  else
    mySign:=-1;

  try
    if IsDayUnit then
      DateReminder:= IncDay( DateSeminar, mySign * NumberOfUnits)
    else
      DateReminder:= IncMonth( DateSeminar, mySign * NumberOFUnits);

    Result:=Trunc( DateREminder);
  except
    result:=EncodeDate(1900,01,01);
  end;


end;



procedure TR_Word_issonos_1FRM.ppLabel10GetText(Sender: TObject;
  var Text: String);
begin
Text:= 'Reference Date :'+ FromDateFLD.Text;

end;

procedure TR_Word_issonos_1FRM.PrintRBtnClick(Sender: TObject);
begin
// working with person_seminar (the record of each person attending a seminar)
//for each person take the LATEST of each seminar type
// how to do that ? join two tables
// ---the first table is per person grouped by seminar type to get the latest date
// -- however, this table does not provide the individual SERIAL NUMBER of the seminar type- only the latest date of the groop
// therefore  we join the first table with another table (without the grouping)
// the join is performed on the person and the seminar type AND The DATE
// As a result, we get the indiviual MAX record of each in the table!!
// in this case, for each person, we get the latest of each seminar type
// add to that date the number of months after the date completed to find the expiry date!

PrintOnePolyIssonos(130,100003);

end;

Procedure TR_Word_issonos_1FRM.PrintTheSeminar();

Var
   FromDate:TDateTime;
   DaysLeft:integer;
begin

//fromDate:=FromDateFLD.Date;


     PolyIssonosRPT.Print;

end;


procedure TR_Word_issonos_1FRM.PrintOnePolyIssonos(Const SeminarSerial:integer;CompanySerial: Integer);
begin
     TableSQL.Close;
     TableSQL.ParamByName('SerialNumber').Value:=CompanySerial;
     TableSQL.Open;

     SeminarSQL.Close;
     SeminarSQL.ParamByName('SerialNumber').Value:=SeminarSerial;
     SeminarSQL.Open;

     PolyIssonosRPT.Print;

end;



procedure TR_Word_issonos_1FRM.FormActivate(Sender: TObject);
begin
ksOpenTables([TableSQL,PersonSQL]);

end;


procedure TR_Word_issonos_1FRM.FormCreate(Sender: TObject);
begin
  cn:=U_databaseFRM.DataConnection;
end;

procedure TR_Word_issonos_1FRM.DisplayFilter;
var
  SeminarSerial:Integer;
  CompanySerial:Integer;
begin
TableSQL.Close;
TableSQL.RestoreSQL;
//index:=sender.ItemIndex;

  seminarSerial:= SeminarSFLD.lookupTable.FieldByName('serial_number').AsInteger;
  if (Trim(SeminarSFLD.text)>'') and  (SeminarSerial >0)  then begin
    TableSQL.AddWhere('seminar_serial = :seminarSerial');
  end;

  CompanySerial:= CompanySFLD.lookupTable.FieldByName('serial_number').AsInteger;
  if (Trim(CompanySFLD.text)>'') and  (CompanySerial >0)  then begin
    TableSQL.AddWhere('company_serial = :CompanySerial');
  end;

  if TableSQL.FindParam('SeminarSerial')<>nil then begin
    TableSQL.ParamByName('seminarSerial').Value:=SeminarSerial;
  end;

  if TableSQL.FindParam('CompanySerial')<>nil then begin
    TableSQL.ParamByName('CompanySerial').Value:=CompanySerial;
  end;


  TableSQL.Open;
  if not PersonSQL.Active then
    PersonSQL.Open;


end;


end.
