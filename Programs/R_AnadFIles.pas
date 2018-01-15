unit R_AnadFIles;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, MemDS,
  DBAccess, IBC,
  Vcl.StdCtrls;

type
  TR_AnadFilesFRM = class(TForm)
    CompanySQL: TIBCQuery;
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
    CompanySRC: TDataSource;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    cn:TIBCConnection;
  procedure CreateFile(Const BaseFolder:String);
  public
    { Public declarations }
    IN_BaseFolder:string;
    IN_SeminarSerial:Integer;
    procedure CreateTheFIle;

  function CreateSeminarRequestFile(Const SeminarSerial:Integer):boolean;
  end;

var
  R_AnadFilesFRM: TR_AnadFilesFRM;

implementation

{$R *.dfm}

uses U_Database, G_generalProcs, G_KyrSQL;

procedure TR_AnadFilesFRM.FormCreate(Sender: TObject);
begin
  cn:=U_databaseFRM.DataConnection;
end;

procedure TR_AnadFilesFRM.CreateFile(Const BaseFolder:String);
var
  FIleName:String;
begin



end;

function TR_AnadFilesFRM.CreateSeminarRequestFile(Const SeminarSerial:Integer):boolean;

var
  Frm:TR_AnadFilesFRM;
  BaseFolder:string;
  param:G_generalProcs.TParameterRecord;
  FileName:String;
  qr:TksQuery;
  seminarName:String;
  UseFolder:String;
  FnAME:sTRING;


begin

  //fs2.ShowReport(True);
//exit;

  param:=  gpGetGeneralParam(cn,'T00');
  baseFOlder:=param.P_String3;
  if trim(baseFOlder)='' then begin
    result:=false;
    exit;
  end;

  if not DirectoryExists(baseFOlder) then begin
      ShowMessage('Base Directory does NOT EXISTS: '+BaseFolder);
      result:=false;
      exit;
  end;


  qr:=TksQuery.Create(cn,'select * from Seminar where serial_number = :SeminarSerial');
  try
    qr.ParamByName('seminarSerial').Value:=SeminarSerial;
    qr.Open;
    if qr.IsEmpty then begin
      result:=false;
      exit;
    end;
    SeminarName:=trim(qr.FieldByName('Seminar_name').AsString);
    qr.Close;

  finally
    qr.free;
  end;

  useFolder:=baseFOlder+'\'+SeminarName+'_'+IntToStr(SeminarSerial);
  if not DirectoryExists(useFOlder) then begin
    showMessage(useFolder);
    if not CreateDir(useFOlder) then begin
      ShowMessage('cannot Create Directory: '+UseFolder);
      result:=false;
      exit;
    end;
  end;




  

end;


procedure TR_AnadFilesFRM.CreateTheFIle;
begin
  CreateFIle(IN_BaseFolder);
end;

end.
