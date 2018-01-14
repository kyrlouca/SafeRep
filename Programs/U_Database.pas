unit U_Database;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBAccess, IBC, MemDS, IBCError, Db, DASQLMonitor, IBCSQLMonitor;

type

  TU_databaseFRM = class(TDataModule)
    DataConnection: TIBCConnection;
    DatabaseUpdateTrans: TIBCTransaction;
    IBCSQLMonitor1: TIBCSQLMonitor;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure CheckStatusActivity();
    procedure CheckStatusNormal();
    procedure CheckSemCategory();
    procedure  CheckPdfDocs();
  public
    { Public declarations }
     cn:TIBCConnection;
    procedure ConnectToDatabase;

  end;

var
  U_databaseFRM: TU_databaseFRM;

implementation

{$R *.DFM}

uses G_KyrSQL;

procedure TU_databaseFRM.ConnectToDatabase;
var
  FBClientPath: string;
  InFile: TextFile;
  LIne: string;
  ServerIP, DatabasePath: string;
  TextArray: array[1..3] of string;
  I: Integer;

  LStrings: TStringList;
  FileName: string;
begin

  FileName := ExtractFilePath(Application.ExeName) + 'DatabaseParams.txt';
  LStrings := TStringList.Create;
  try
    LStrings.Loadfromfile(FileName);
    if LStrings.Count < 2 then
    begin
      raise exception.create('File Must contain at least 2 lines');
    end;
    ServerIP := LStrings[0];
    DatabasePath := LStrings[1];
  finally
    FreeAndNil(LStrings);
  end;


  DataConnection.Server := ServerIP;
  DataConnection.database := DatabasePath;

  FbClientPath := ExtractFileDir(ExtractFilePath(Application.EXEName));
  FbClientPath := FBClientPath + '\gds32.dll';


  DataConnection.ClientLibrary := FBClientPath;
  if DataConnection.connected then
    DataConnection.Disconnect;

  DataConnection.Connect;
  if not DataConnection.Connected then
    ShowMessage('Cannot connect');

end;

procedure TU_databaseFRM.DataModuleCreate(Sender: TObject);
begin
  ConnectToDatabase;
  cn:=DataConnection;

 CheckStatusActivity();
 CheckStatusNormal();
 CheckSemCategory();
 CheckPdfDocs();
end;


procedure TU_databaseFRM.CheckStatusActivity();
begin
  ConnectToDatabase;
  cn:=DataConnection;

   if ksCountRecSQL(cn,'select STATUS from STATUS_ACTIVITY where STATUS= :VAL',['P'])=0 then begin
      ksExecSQLVar(cn,'insert into STATUS_ACTIVITY (STATUS,Order_number, DESCRIPTION,description_Greek) values( :ST,:o,:DS,:Gr)',['P',0,'Prepared','Σε Προετοιμασία']);
   end;

   if ksCountRecSQL(cn,'select STATUS from STATUS_ACTIVITY where STATUS= :VAL',['A'])=0 then begin
      ksExecSQLVar(cn,'insert into STATUS_ACTIVITY (STATUS,Order_number, DESCRIPTION,description_Greek) values( :ST,:o,:DS,:Gr)',['A',1,'Approved','Εγκεκριμένο']);
   end;

   if ksCountRecSQL(cn,'select STATUS from STATUS_ACTIVITY where STATUS= :VAL',['F'])=0 then begin
      ksExecSQLVar(cn,'insert into STATUS_ACTIVITY (STATUS, Order_number,DESCRIPTION,description_Greek) values( :ST,:o,:DS,:Gr)',['F',2,'Completed','Ολοκληρωμένο']);
   end;



end;


procedure TU_databaseFRM.CheckSemCategory();
begin
  ConnectToDatabase;
  cn:=DataConnection;

   if ksCountRecSQL(cn,'select sta.CATEGORY_CODE from sem_category sta where sta.CATEGORY_CODE= :seminarType',['N'])=0 then begin
      ksExecSQLVar(cn,'INSERT INTO sem_category (Category_code, TYPE_DESC_GR, TYPE_DESC_EN, IS_INVOICE, IS_CERTIFICATE,INVOICE_COMPANY,ORder_number) VALUES ( :S1, :S2,:S3, :S4, :S5,:s6,:s7)',
      ['N','Κανονικό','Normal','Y','Y','N',1]);
   end;

   if ksCountRecSQL(cn,'select sta.CATEGORY_CODE from sem_category sta where sta.CATEGORY_CODE= :seminarType',['P'])=0 then begin
      ksExecSQLVar(cn,'INSERT INTO sem_category (Category_code, TYPE_DESC_GR, TYPE_DESC_EN, IS_INVOICE, IS_CERTIFICATE,INVOICE_COMPANY,ORder_number) VALUES ( :S1, :S2,:S3, :S4, :S5,:s6,:s7)',
      ['P','Μελλοντικό','Planned','N','N','N',2]);
   end;

   if ksCountRecSQL(cn,'select sta.CATEGORY_CODE from sem_category sta where sta.CATEGORY_CODE= :seminarType',['M'])=0 then begin
      ksExecSQLVar(cn,'INSERT INTO sem_category (Category_code, TYPE_DESC_GR, TYPE_DESC_EN, IS_INVOICE, IS_CERTIFICATE,INVOICE_COMPANY,ORder_number) VALUES ( :S1, :S2,:S3, :S4, :S5,:s6,:s7)',
      ['M','Παρακολούθηση','Monitor','N','N','N',3]);
   end;

   if ksCountRecSQL(cn,'select sta.CATEGORY_CODE from sem_category sta where sta.CATEGORY_CODE= :seminarType',['C'])=0 then begin
      //αλλή εταιρεία διοργανώνει σεμινάριο, η SafeP  απλώς το κάνει και παίρνει προμήθεια (No certificates, inv the company)
      ksExecSQLVar(cn,'INSERT INTO sem_category (Category_code, TYPE_DESC_GR, TYPE_DESC_EN, IS_INVOICE, IS_CERTIFICATE,INVOICE_COMPANY,ORder_number) VALUES ( :S1, :S2,:S3, :S4, :S5,:s6,:s7)',
      ['C','Μόνο Προμήθεια','Commission','Y','N','Y',4]);
   end;

   if ksCountRecSQL(cn,'select sta.CATEGORY_CODE from sem_category sta where sta.CATEGORY_CODE= :seminarType',['O'])=0 then begin
      //Το σεμινάριο διοργανώθηκε από SAFE αλλά κάποιος άλλος κανει το σεμινάριο,  (ΥΕΣ certificates, Yes invoice, inv the company)
      ksExecSQLVar(cn,'INSERT INTO sem_category (Category_code, TYPE_DESC_GR, TYPE_DESC_EN, IS_INVOICE, IS_CERTIFICATE,INVOICE_COMPANY,ORder_number) VALUES ( :S1, :S2,:S3, :S4, :S5,:s6,:s7)',
      ['O','Ανάθεση σε Άλλο','Outsourced','Y','Y','Y',4]);
   end;


end;




procedure TU_databaseFRM.CheckPdfDocs();
begin
  ConnectToDatabase;
  cn:=DataConnection;

   if ksCountRecVarSQL(cn,'select Serial_number from word_docs wd where serial_number =:SerialNumber',[101])=0 then begin
      ksExecSQLVar(cn,'insert into word_docs  (serial_number,poly_Mono,is_send_to_all, doc_name) values (:s1,:s2,:s3,:s4)',
      [101,'P','Y','Mono Issonos 1']);
   end;
   if ksCountRecVarSQL(cn,'select Serial_number from word_docs wd where serial_number =:SerialNumber',[102])=0 then begin
      ksExecSQLVar(cn,'insert into word_docs  (serial_number,poly_Mono,is_send_to_all, doc_name) values (:s1,:s2,:s3,:s4)',
      [102,'P','Y','Mono Issonos 2']);
   end;
   if ksCountRecVarSQL(cn,'select Serial_number from word_docs wd where serial_number =:SerialNumber',[103])=0 then begin
      ksExecSQLVar(cn,'insert into word_docs  (serial_number,poly_Mono,is_send_to_all, doc_name) values (:s1,:s2,:s3,:s4)',
      [103,'P','Y','Mono Issonos 3']);
   end;
   if ksCountRecVarSQL(cn,'select Serial_number from word_docs wd where serial_number =:SerialNumber',[104])=0 then begin
      ksExecSQLVar(cn,'insert into word_docs  (serial_number,poly_Mono,is_send_to_all, doc_name) values (:s1,:s2,:s3,:s4)',
      [104,'P','Y','Mono Issonos 4']);
   end;
   if ksCountRecVarSQL(cn,'select Serial_number from word_docs wd where serial_number =:SerialNumber',[105])=0 then begin
      ksExecSQLVar(cn,'insert into word_docs  (serial_number,poly_Mono,is_send_to_all, doc_name) values (:s1,:s2,:s3,:s4)',
      [105,'P','Y','Mono Issonos 5']);
   end;


end;



procedure TU_databaseFRM.CheckStatusNormal();
begin
end;




end.

