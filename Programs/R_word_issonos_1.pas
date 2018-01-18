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
    CompanySQL: TIBCQuery;
    CompanySRC: TDataSource;
    CompanyPIP: TppDBPipeline;
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
    ppDBText12: TppDBText;
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
    PoliErgodotiRPT: TppReport;
    ppDetailBand7: TppDetailBand;
    ppSubReport7: TppSubReport;
    ppChildReport7: TppChildReport;
    ppDetailBand8: TppDetailBand;
    ppDBText15: TppDBText;
    ppDBText16: TppDBText;
    ppDBText17: TppDBText;
    ppPageStyle7: TppPageStyle;
    ppImage7: TppImage;
    ppDesignLayers9: TppDesignLayers;
    ppDesignLayer15: TppDesignLayer;
    ppDesignLayer16: TppDesignLayer;
    ppSubReport8: TppSubReport;
    ppChildReport8: TppChildReport;
    ppDetailBand9: TppDetailBand;
    ppPageStyle8: TppPageStyle;
    ppImage8: TppImage;
    ppDesignLayers10: TppDesignLayers;
    ppDesignLayer17: TppDesignLayer;
    ppDesignLayer18: TppDesignLayer;
    ppSubReport9: TppSubReport;
    ppChildReport9: TppChildReport;
    ppDetailBand10: TppDetailBand;
    ppPageStyle9: TppPageStyle;
    ppImage9: TppImage;
    ppDesignLayers11: TppDesignLayers;
    ppDesignLayer19: TppDesignLayer;
    ppDesignLayer20: TppDesignLayer;
    ppPageStyle12: TppPageStyle;
    ppDesignLayers14: TppDesignLayers;
    ppDesignLayer25: TppDesignLayer;
    ppDesignLayer26: TppDesignLayer;
    ppParameterList2: TppParameterList;
    ppDBText21: TppDBText;
    ppDBText22: TppDBText;
    ppDBText23: TppDBText;
    ppDBText24: TppDBText;
    ppDBText25: TppDBText;
    ppDBText26: TppDBText;
    ppDBText27: TppDBText;
    ppDBText28: TppDBText;
    ppDBText29: TppDBText;
    ppDBText31: TppDBText;
    ppDBText32: TppDBText;
    ppDBText33: TppDBText;
    PersonSQLCOMPANY_OWNER_ID: TWideStringField;
    CompanySQLSERIAL_NUMBER: TIntegerField;
    CompanySQLSERIAL_QB: TIntegerField;
    CompanySQLFK_COMPANY_SERIAL: TIntegerField;
    CompanySQLLAST_NAME: TWideStringField;
    CompanySQLFIRST_NAME: TWideStringField;
    CompanySQLNATIONAL_ID: TWideStringField;
    CompanySQLNICKNAME: TWideStringField;
    CompanySQLOCCUPATION: TWideStringField;
    CompanySQLPHONE_MOBILE: TWideStringField;
    CompanySQLPHONE_FIXED: TWideStringField;
    CompanySQLPHONE_ALTERNATE: TWideStringField;
    CompanySQLFAX: TWideStringField;
    CompanySQLEMAIL: TWideStringField;
    CompanySQLEMAIL_2: TSmallintField;
    CompanySQLADDRESS: TWideStringField;
    CompanySQLADDRESS_STREET: TWideStringField;
    CompanySQLADDRESS_POST_CODE: TWideStringField;
    CompanySQLADDRESS_CITY: TWideStringField;
    CompanySQLADDRESS_DISTRICT: TWideStringField;
    CompanySQLDATE_STARTED: TDateField;
    CompanySQLDATE_BIRTH: TDateField;
    CompanySQLDATE_USER: TDateField;
    CompanySQLLIST_SOURCE: TWideStringField;
    CompanySQLFACEBOOK: TWideStringField;
    CompanySQLWEBSITE: TWideStringField;
    CompanySQLTWITTER: TWideStringField;
    CompanySQLSTATUS_ACTIVE: TWideStringField;
    CompanySQLSEX: TWideStringField;
    CompanySQLIS_COMPANY: TWideStringField;
    CompanySQLCOMPANY_OWNER: TWideStringField;
    CompanySQLCOMPANY_CONTACT: TWideStringField;
    CompanySQLCOMPANY_REGISTRATION_DATE: TDateField;
    CompanySQLPHONE_CONTACT: TWideStringField;
    CompanySQLCOMPANY_CONTACT_FIRST: TWideStringField;
    CompanySQLCOMPANY_CONTACT_LAST: TWideStringField;
    CompanySQLCOMPANY_OWNER_REG: TWideStringField;
    CompanySQLCOMPANY_CONTACT_PHONE: TWideStringField;
    CompanySQLCOMPANY_CONTACT_EMAIL: TWideStringField;
    CompanySQLCOMPANY_CONTACT_FAX: TWideStringField;
    CompanySQLCOMPANY_SOCIAL_SEC: TWideStringField;
    CompanySQLCOMPANY_EMPLOYEES: TIntegerField;
    CompanySQLPHONE_MOBILE_2: TWideStringField;
    CompanySQLLINKED_IN: TWideStringField;
    CompanySQLJOB: TWideStringField;
    CompanySQLIS_SAFE_COMPANY: TWideStringField;
    CompanySQLCOMPANY_OWNER_ID: TWideStringField;
    ppDBText34: TppDBText;
    ppDBText35: TppDBText;
    ppDBText36: TppDBText;
    SafeCompanySQL: TIBCQuery;
    SafeCompanySQLSERIAL_NUMBER: TIntegerField;
    SafeCompanySQLSERIAL_QB: TIntegerField;
    SafeCompanySQLFK_COMPANY_SERIAL: TIntegerField;
    SafeCompanySQLLAST_NAME: TWideStringField;
    SafeCompanySQLFIRST_NAME: TWideStringField;
    SafeCompanySQLNATIONAL_ID: TWideStringField;
    SafeCompanySQLNICKNAME: TWideStringField;
    SafeCompanySQLOCCUPATION: TWideStringField;
    SafeCompanySQLPHONE_MOBILE: TWideStringField;
    SafeCompanySQLPHONE_FIXED: TWideStringField;
    SafeCompanySQLPHONE_ALTERNATE: TWideStringField;
    SafeCompanySQLFAX: TWideStringField;
    SafeCompanySQLEMAIL: TWideStringField;
    SafeCompanySQLEMAIL_2: TSmallintField;
    SafeCompanySQLADDRESS: TWideStringField;
    SafeCompanySQLADDRESS_STREET: TWideStringField;
    SafeCompanySQLADDRESS_POST_CODE: TWideStringField;
    SafeCompanySQLADDRESS_CITY: TWideStringField;
    SafeCompanySQLADDRESS_DISTRICT: TWideStringField;
    SafeCompanySQLDATE_STARTED: TDateField;
    SafeCompanySQLDATE_BIRTH: TDateField;
    SafeCompanySQLDATE_USER: TDateField;
    SafeCompanySQLLIST_SOURCE: TWideStringField;
    SafeCompanySQLFACEBOOK: TWideStringField;
    SafeCompanySQLWEBSITE: TWideStringField;
    SafeCompanySQLTWITTER: TWideStringField;
    SafeCompanySQLSTATUS_ACTIVE: TWideStringField;
    SafeCompanySQLSEX: TWideStringField;
    SafeCompanySQLIS_COMPANY: TWideStringField;
    SafeCompanySQLCOMPANY_OWNER: TWideStringField;
    SafeCompanySQLCOMPANY_CONTACT: TWideStringField;
    SafeCompanySQLCOMPANY_REGISTRATION_DATE: TDateField;
    SafeCompanySQLPHONE_CONTACT: TWideStringField;
    SafeCompanySQLCOMPANY_CONTACT_FIRST: TWideStringField;
    SafeCompanySQLCOMPANY_CONTACT_LAST: TWideStringField;
    SafeCompanySQLCOMPANY_OWNER_REG: TWideStringField;
    SafeCompanySQLCOMPANY_CONTACT_PHONE: TWideStringField;
    SafeCompanySQLCOMPANY_CONTACT_EMAIL: TWideStringField;
    SafeCompanySQLCOMPANY_CONTACT_FAX: TWideStringField;
    SafeCompanySQLCOMPANY_SOCIAL_SEC: TWideStringField;
    SafeCompanySQLCOMPANY_EMPLOYEES: TIntegerField;
    SafeCompanySQLPHONE_MOBILE_2: TWideStringField;
    SafeCompanySQLLINKED_IN: TWideStringField;
    SafeCompanySQLJOB: TWideStringField;
    SafeCompanySQLIS_SAFE_COMPANY: TWideStringField;
    SafeCompanySQLCOMPANY_OWNER_ID: TWideStringField;
    SafeCompany: TDataSource;
    SafePip: TppDBPipeline;
    ppDBText30: TppDBText;
    ppDBText37: TppDBText;
    ppDBText38: TppDBText;
    ppDBText39: TppDBText;
    ppDBText40: TppDBText;
    procedure BitBtn2Click(Sender: TObject);
    procedure ppReport1PreviewFormCreate(Sender: TObject);
    procedure ppLabel10GetText(Sender: TObject; var Text: String);
    procedure FormActivate(Sender: TObject);
    procedure RzBitBtn1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ppVariable3Calc(Sender: TObject; var Value: Variant);
    procedure PrintRBtnClick(Sender: TObject);
  private
    { Private declarations }
    cn:TIBCConnection;
  procedure CreatePolyReports(Const SeminarSerial:Integer;Const ReportType:String);
  function CreateCompleteFolder(Const SeminarSerial:Integer;Const CompanySerial:Integer):String;
  function CreateOneFolder(Const FolderName:String):Boolean;

  public
    { Public declarations }
    IN_SeminarSerial:Integer;
    IN_isCompleted:String;
    IN_HasDate:String;
    IN_DateRef:TDate;
    Procedure PrintTheSeminar();
  procedure PrintOnePolyIssonos(Const SeminarSerial:integer;CompanySerial: Integer;FileName:String);
  procedure PrintOnePolyErgodoti(Const SeminarSerial:integer;CompanySerial: Integer;FileName:String);

  end;

var
  R_Word_issonos_1FRM: TR_Word_issonos_1FRM;

implementation

uses U_Database,  G_KyrSQL, G_generalProcs;


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


procedure TR_Word_issonos_1FRM.ppVariable3Calc(Sender: TObject; var Value: Variant);
begin
   value:=FromDateFLD.Date
end;

procedure TR_Word_issonos_1FRM.RzBitBtn1Click(Sender: TObject);
begin
  close;
end;



procedure TR_Word_issonos_1FRM.ppLabel10GetText(Sender: TObject;
  var Text: String);
begin
Text:= 'Reference Date :'+ FromDateFLD.Text;

end;

procedure TR_Word_issonos_1FRM.PrintRBtnClick(Sender: TObject);
begin
//CreatePolyReports(129,'Issonos');
CreatePolyReports(129,'Ergodotis');

end;

Procedure TR_Word_issonos_1FRM.PrintTheSeminar();

Var
   FromDate:TDateTime;
   DaysLeft:integer;
begin

//fromDate:=FromDateFLD.Date;


     PolyIssonosRPT.Print;

end;


procedure TR_Word_issonos_1FRM.PrintOnePolyIssonos(Const SeminarSerial:integer;CompanySerial: Integer;FileName:String);
begin
     CompanySQL.Close;
     CompanySQL.ParamByName('SerialNumber').Value:=CompanySerial;
     CompanySQL.Open;

     SeminarSQL.Close;
     SeminarSQL.ParamByName('SerialNumber').Value:=SeminarSerial;
     SeminarSQL.Open;


     with PolyIssonosRPT do begin
       ShowPrintDialog := False;
        DeviceType := dtPDF;
        PDFSettings.OpenPDFFile :=false;
        TextFileName := fileName;
        Print;
     end;

end;



procedure TR_Word_issonos_1FRM.PrintOnePolyErgodoti(Const SeminarSerial:integer;CompanySerial: Integer;FileName:String);
begin
     CompanySQL.Close;
     CompanySQL.ParamByName('SerialNumber').Value:=CompanySerial;
     CompanySQL.Open;

     ksOpenTables([SafeCompanySQL]);

     SeminarSQL.Close;
     SeminarSQL.ParamByName('SerialNumber').Value:=SeminarSerial;
     SeminarSQL.Open;


     with PoliErgodotiRPT do begin
       ShowPrintDialog := False;
        DeviceType := dtPDF;
        PDFSettings.OpenPDFFile :=false;
        TextFileName := fileName;
        Print;
     end;

end;



procedure TR_Word_issonos_1FRM.FormActivate(Sender: TObject);
begin
ksOpenTables([CompanySQL,PersonSQL]);

end;


procedure TR_Word_issonos_1FRM.FormCreate(Sender: TObject);
begin
  cn:=U_databaseFRM.DataConnection;
end;


procedure TR_Word_issonos_1FRM.CreatePolyReports(Const SeminarSerial:Integer;Const ReportType:String);
var
I:integer;
 qr:TksQuery;
 Compqr:TksQuery;
 SeminarName:String;
 str2:string;
// isPoly:String;
 CompId,CompName:String;
 CompSerial:Integer;
// UseFolder:String;
// SeminarFolder:String;
 Path:String;
 fname:String;
// fileName:String;
// param:TParameterRecord;

begin



          str2:=
          '   select per.serial_number,per.National_id, per.Last_name from'
          +'          seminar_company semC left outer join'
          +'          person per on semc.fk_person_serial = per.serial_number'
          +'  where semC.fk_seminar_serial= :SeminarSerial';

          Compqr:= TksQuery.Create(cn,str2);
          try
            CompQR.close;
            CompQr.ParamByName('SeminarSerial').Value:=SeminarSerial;
            CompQr.open;
            while not CompQR.Eof do begin
              CompId:=CompQR.FieldByName('National_id').AsString;
              CompName:=CompQR.FieldByName('Last_name').AsString;
              CompSerial:=CompQR.FieldByName('serial_number').AsInteger;

              path:=CreateCompleteFolder(SeminarSerial,CompSerial);
              if ReportType ='Issonos' then begin
                fname:=path+'\'+'╦МТУПО емисвусеис гссомос сгласиас.pdf';
                if not FileExists(Fname) then begin
                  ShowMessage(fname);
                    PrintOnePolyIssonos(SeminarSerial,compSerial,fname);
                end;

              end else if ReportType ='Ergodotis' then begin
                fname:=path+'\'+'аитгсг еяцодотг циа суллетовг йаи еноусиодотгсг циа йатабокг воягцглатос.pdf';
                if not FileExists(Fname) then begin
//                  ShowMessage(fname);
                    PrintOnePolyErgodoti(SeminarSerial,compSerial,fname);
                end;

              end;
              compQR.Next;
            end;
          finally
           CompQr.Free;
          end;

end;


function TR_Word_issonos_1FRM.CreateCompleteFolder(Const SeminarSerial:Integer;Const CompanySerial:Integer):String;
var
  qr:TksQuery;
 CompId,CompName:String;
 baseFolder:string;
 UseFolder:String;
 SeminarFolder:String;
 PersonFolder:String;

 fname:String;
 fileName:String;
 param:TParameterRecord;
 SeminarName:String;
 PersonName:String;

begin

  param:=  gpGetGeneralParam(cn,'T00');
  baseFOlder:=Trim(param.P_String3);
  if not CreateOneFolder(BaseFOlder) then begin
    ShowMessage('cannot create'+ BaseFolder);
    result:='';
    exit;
  end;


  qr:=TksQuery.Create(cn,'select Seminar_name from Seminar where serial_number = :SeminarSerial');
  try
    qr.ParamByName('seminarSerial').Value:=SeminarSerial;
    qr.Open;
    if qr.IsEmpty then begin
      result:='';
      exit;
    end;
    SeminarName:=trim(qr.FieldByName('Seminar_name').AsString);
    qr.Close;
  finally
    qr.free;
  end;

  SeminarFolder:=baseFOlder+'\'+SeminarName+'_'+intToStr(SeminarSerial);
  if not CreateOneFolder(SeminarFOlder) then begin
    ShowMessage('cannot Create Seminar Directory: '+SeminarFolder);
    result:='';
    exit;
  end;


  qr:=TksQuery.Create(cn,'select Last_name from Person where serial_number = :PersonSerial');
  try
    qr.ParamByName('PersonSerial').Value:=CompanySerial;
    qr.Open;
    if qr.IsEmpty then begin
      result:='';
      exit;
    end;
    PersonName:=trim(qr.FieldByName('Last_name').AsString);
    qr.Close;
  finally
    qr.free;
  end;

  PersonFolder:=SeminarFolder+'\'+PersonName+'_'+IntToStr(CompanySerial);
  if not CreateOneFolder(PersonFOlder) then begin
    ShowMessage('cannot Create Directory for Company: '+PersonFolder);
    result:='';
    exit;
  end;
  result:=PersonFolder;

end;

function TR_Word_issonos_1FRM.CreateOneFolder(Const FolderName:String):Boolean;
begin
  result:=true;
  if not DirectoryExists(FOlderName) then begin
    result:= CreateDir(FolderName);
  end;

end;

end.
