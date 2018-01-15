unit S_LoadDocs;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  System.IOUtils,
  StdCtrls, Mask, DBCtrls, Db, wwSpeedButton, wwDBNavigator,
  wwclearpanel, Buttons, ExtCtrls, wwdblook, Wwkeycb, Grids,
  DBAccess, IBC, MemDS, Wwdbigrd, Wwdbgrid, wwdbedit, vcl.Wwdotdot, vcl.Wwdbcomb,
  G_KyrSQL, RzButton, RzPanel, vcl.wwcheckbox, Vcl.ExtDlgs, vcl.wwbutton,
  RzLabel, RzDBLbl;
type
  TS_LoadDocsFRM = class(TForm)
    Panel1: TrzPanel;
    Panel4: TrzPanel;
    Panel3: TrzPanel;
    TableSRC: TDataSource;
    Panel5: TRzPanel;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Grid1: TwwDBGrid;
    Label3: TLabel;
    NameFLD: TwwDBEdit;
    TableSQL: TIBCQuery;
    WriteTrans: TIBCTransaction;
    ReadTrans: TIBCTransaction;
    Label4: TLabel;
    RzPanel1: TRzPanel;
    RzBitBtn1: TRzBitBtn;
    TableSQLCODE_KEY: TWideStringField;
    TableSQLDOC_NAME: TWideStringField;
    TableSQLDOC_BLOB: TBlobField;
    SavetoDB: TRzBitBtn;
    Button1: TButton;
    FileDialog1: TOpenDialog;
    wwButton1: TwwButton;
    Panel2: TRzPanel;
    RzPanel2: TRzPanel;
    RzPanel3: TRzPanel;
    TableSQLIS_SEND_TO_ALL: TWideStringField;
    TableSQLSERIAL_NUMBER: TIntegerField;
    Nav1: TwwDBNavigator;
    Nav1Button: TwwNavButton;
    Nav1Prior: TwwNavButton;
    Nav1Next: TwwNavButton;
    Nav1Button1: TwwNavButton;
    Nav1Insert: TwwNavButton;
    Nav1Delete: TwwNavButton;
    Nav1Post: TwwNavButton;
    Nav1Cancel: TwwNavButton;
    Label1: TLabel;
    Label6: TLabel;
    wwCheckBox2: TwwCheckBox;
    RzDBLabel1: TRzDBLabel;
    TableSQLPOLY_MONO: TWideStringField;
    wwCheckBox1: TwwCheckBox;
    Label5: TLabel;
    wwIncrementalSearch1: TwwIncrementalSearch;
    TableSQLDOC_PATH: TWideStringField;
    TableSQLDOC_TYPE: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure RzBitBtn1Click(Sender: TObject);
    procedure SavetoDBClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure wwButton1Click(Sender: TObject);
    procedure TableSQLNewRecord(DataSet: TDataSet);
    procedure Nav1InsertClick(Sender: TObject);
  private
    { Private declarations }
    cn:TIBCConnection;
  procedure WriteStreamToDatabase(Const CodeKey:String;Const FileName :String; Const MonoPOly:String);
//  procedure SaveToFile(Const CodeKey:String;Const FileName :String; Const MonoPOly:String);
  procedure SaveToFileXX(Const CodeKey:String;Const FileName :String; Const MonoPOly:String);
  procedure CopyAFile(Const DocSerial:Integer;Const FileName :String);
  procedure CopyModifiedFile(Const DocSerial:Integer;Const FileName :String);

  procedure SaveXX(Const SerialNumber:Integer;Const  FilePath, DocName :String);
  function FindHex(const FileName:String): Integer;

  procedure WriteFiles(Const SeminarSerial:Integer;Const DocType:String);

  public
    { Public declarations }
    MyInsertState:Boolean;
    IN_SeminarSerial:integer;
    IN_DocTYpe:String;
    Procedure CreateTheFiles;
  end;

var
  S_LoadDocsFRM: TS_LoadDocsFRM;

implementation

uses   U_Database, G_generalProcs;

{$R *.DFM}

procedure TS_LoadDocsFRM.RzBitBtn1Click(Sender: TObject);
begin
close;
end;

procedure TS_LoadDocsFRM.WriteStreamToDatabase(Const CodeKey:String;Const FileName :String; Const MonoPOly:String);
var
//  BlobField: TField;
  BlobField: TBlobField;
  BS: TStream;
  str2:String;
  qr:TksQuery;
  FS:TStream;
begin
  str2:='Select * from word_docs wd where wd.code_key = :CodeKey';
  qr:= TksQuery.Create(cn,str2);
  try
      qr.close;
      qr.ParamByName('CodeKey').Value:=CodeKey;
      qr.open;

      if qr.IsEmpty then
       exit;

      qr.Edit;
      BlobField := qr.FieldByName('doc_blob') as TBlobField;
      BS := qr.CreateBlobStream(BlobField,bmWrite);
      try
        Bs.Position:=0;
        FS := TFileStream.Create( filename, fmOpenRead );
        fs.Position:=0;
        try
          showMessage(intToStr(fs.Size));
          bs.CopyFrom(Fs,fs.Size);
          qr.FieldByName('doc_name').AsString:=filename;
          qr.Post;
        finally
          fs.Free;
        end;

      finally
          BS.Free;

      end;



  finally
    qr.Free;
  end;

end;



procedure TS_LoadDocsFRM.wwButton1Click(Sender: TObject);
VAR
  fileName:String;
begin
  FileName:='C:\Data\DelphiProjects\Safe_CRM\documents\H3.rtf';
  FindHex(FileName);
end;

function TS_LoadDocsFRM.FindHex(const FileName:String): Integer;
var
  AFile: TFileStream;
  BR: TBinaryReader;
  AInteger: Integer;
  ADouble: Double;
  AChar: Char;
  AString: String;
  size:Integer;
  goOn:Boolean;
  fByte:Byte;
  isPrev:boolean;
  gChar:Char;
  dCount:integer;
begin
  goOn:=true;
  isPrev:=False;
  dCount:=0;
  AFile := TFileStream.Create(filename, fmOpenRead);
  BR := TBinaryReader.Create(AFile, TEncoding.Unicode, false);
  {
  try
    while goOn do begin
          fByte := BR.ReadByte;
          Achar:=Chr(FByte);
          if           if (Achar='$')
                    if (Achar='$') and IsPrev then begin
//            Achar := BR.ReadChar;
            fByte := BR.ReadByte;
            GChar:=Chr(FByte);
            SHowMessage(Gchar);
            isPrev:=false;
          end;
          isPrev:= (AChar='$');
          goOn:= (Achar <> '~');
    end;
   }
  {
    // read a char and write it to the console
    AChar := BR.ReadChar;
    Writeln(AChar);
    // read a string and write it to the console
    AString := BR.ReadString;
    Writeln(AString);

    BR.Close;
  finally

    BR.Free;
    AFile.Free;
  end;
  }
end;

{
function TS_LoadDocsFRM.PosHex(const SubStr: AnsiString; const StrStream: TMemoryStream): Integer;
var
  SubLen, SrcLen, Len, I, J: Integer;

  C1: AnsiChar;
  Str: PAnsiChar;
begin
  SrcLen := StrStream.Size;
  SubLen := Length(SubStr);

  Result := 0;
  if (SubLen <= 0) or (SrcLen <= 0) or (SrcLen < SubLen) then Exit;

  StrStream.Position := 0;
  Str := StrStream.Memory;

  Len := SrcLen - SubLen + 1;
  C1 := SubStr[1];
  for I := 1 to Len do
  begin
    if Str[I] = C1 then
    begin
      Result := I;
      for J := 1 to SubLen-1 do
      begin
        if Str[I+J] <> SubStr[1+J] then
        begin
          Result := 0;
          break;
        end;
      end;
      if Result <> 0 then Exit;
    end;
  end;
end;
}

procedure TS_LoadDocsFRM.CopyaFile(Const DocSerial:Integer;Const FileName :String);
var
//  BlobField: TField;
  BlobField: TBlobField;
  BS: TStream;
  str2:String;
  qr:TksQuery;
  FS:TMemoryStream;

begin

  str2:='Select * from word_docs wd where wd.Serial_number = :SerialNumber';
  qr:= TksQuery.Create(cn,str2);
  try
      qr.close;
      qr.ParamByName('SerialNumber').Value:=DocSerial;
      qr.open;

      if qr.IsEmpty then
       exit;

      BlobField := qr.FieldByName('doc_blob') as TBlobField;
      BS := qr.CreateBlobStream(BlobField,bmRead);
      try
        fs:=TMemoryStream.Create;
        try
          fs.CopyFrom(bs,bs.Size);
          fs.SaveToFile(fileName);
        finally
          fs.Free;
        end;

      finally
        BS.Free;
      end;

  finally
    qr.Free;
  end;

end;


procedure TS_LoadDocsFRM.SaveToFileXX(Const CodeKey:String;Const FileName :String; Const MonoPOly:String);
var
  BlobField: TBlobField;
  BS: TStream;
  str2:String;
  qr:TksQuery;
  FS:TMemoryStream;
  binR:TbinaryReader;
  binW:TBinaryWriter;

begin
  str2:='Select * from word_docs wd where wd.code_key = :CodeKey';
  qr:= TksQuery.Create(cn,str2);
  try
      qr.close;
      qr.ParamByName('CodeKey').Value:=CodeKey;
      qr.open;

      if qr.IsEmpty then
       exit;

      BlobField := qr.FieldByName('doc_blob') as TBlobField;
      BS := qr.CreateBlobStream(BlobField,bmRead);
      try
        fs:=TMemoryStream.Create;
        try
          fs.CopyFrom(bs,bs.Size);
          fs.SaveToFile(fileName);
        finally
          fs.Free;
        end;

      finally
        BS.Free;
      end;

  finally
    qr.Free;
  end;

end;

procedure TS_LoadDocsFRM.SaveXX(Const SerialNumber:Integer;Const  FilePath, DocName :String);
var
  BlobField: TBlobField;
//  BS: TStream;
  str2:String;
  qr:TksQuery;
  CompQr:TksQuery;
//  FS:TMemoryStream;
begin

  str2:='Select * from word_docs wd where wd.serial_number = :SerialNumber';
  qr:= TksQuery.Create(cn,str2);
  try
      qr.close;
      qr.ParamByName('SerialNumber').Value:=SerialNumber;
      qr.open;

      if qr.IsEmpty then
       exit;
      qr.Edit;
      TBlobField(qr.FieldByName('doc_blob')).LoadFromFile(filePath);
      qr.FieldByName('doc_Name').AsString:=DocName;
      qr.FieldByName('doc_path').AsString:=filePath;
      qr.Post;
  finally
     qr.Free;
  end;


{
   fs := TFileStream.Create('filename', fmOpenRead);
IBCQuery.Open;
IBCQuery.Edit;
TBlobField(IBCQuery.FieldByName('blobfieldname')).LoadFromStream(fs);
IBCQuery.Post;
fs.Free;
}

{
IBCQuery.Open;
IBCQuery.Edit;
TBlobField(IBCQuery.FieldByName('blobfieldname')).LoadFromFile('filename');
IBCQuery.Post;
}

end;


procedure TS_LoadDocsFRM.TableSQLNewRecord(DataSet: TDataSet);
begin
  Dataset.FieldByName('Poly_mono').AsString:='M';
  Dataset.FieldByName('iS_send_to_all').AsString:='N';
  Dataset.FieldByName('DOC_TYPE').AsString:='WORD';
end;

procedure TS_LoadDocsFRM.SavetoDBClick(Sender: TObject);
var
  FileName:String;
  FIlePath:String;
  codeKey:String;
  SerialNumber:Integer;
begin
  if TableSQL.State in [dsEdit,dsInsert] then
    TableSQL.Post;

  if not FileDialog1.Execute then     begin
      showMessage('exit');
      Exit;
  end;

  filePath :=FileDialog1.FileName;
  FileName:=TPath.GetFileNameWithoutExtension(FilePath);
  SerialNumber:=TableSQL.FieldByName('Serial_Number').AsInteger;
  saveXX(SerialNumber,FilePath, filename);
  ksOpenTables([TableSQL]);

end;


procedure TS_LoadDocsFRM.FormActivate(Sender: TObject);
begin
  tableSQL.close;
  TableSQL.ParamByName('DocTYpe').Value:='WORD';
  TableSQL.Open;
end;

procedure TS_LoadDocsFRM.FormCreate(Sender: TObject);
begin
  cn:=  U_databaseFRM.DataConnection;
end;

procedure TS_LoadDocsFRM.Nav1InsertClick(Sender: TObject);
var
  FileName:String;
  FIlePath:String;
  codeKey:String;
  SerialNumber:Integer;
begin
  if TableSQL.State in [dsEdit,dsInsert] then
    TableSQL.Post;


  if not FileDialog1.Execute then     begin
      showMessage('exit');
      Exit;
  end;

  tableSQL.Insert;

  filePath :=FileDialog1.FileName;
  FileName:=TPath.GetFileNameWithoutExtension(FilePath);
  tableSQL.FieldByName('DOC_name').Value:=fileName;
  TableSQL.Post;

  SerialNumber:=TableSQL.FieldByName('Serial_Number').AsInteger;
  saveXX(SerialNumber,FilePath, filename);
  ksOpenTables([TableSQL]);
  NameFLD.SetFocus;
  abort;
end;

procedure TS_LoadDocsFRM.Button1Click(Sender: TObject);
begin
  WriteFiles(119,'abc');
end;

procedure TS_LoadDocsFRM.CreateTheFiles;
begin
  WriteFiles(IN_SeminarSerial,in_DocTYpe);
end;

procedure TS_LoadDocsFRM.WriteFiles(Const SeminarSerial:Integer;Const DocType:String);
var
  qr:TksQuery;
  compQr:TksQuery;
  param:G_generalProcs.TParameterRecord;
  baseFolder:String;
  SeminarFolder:String;
  useFolder:string;
  fileName:String;
  DocSerial:integer;
  codeKey:String;
  str2:string;
  SeminarName:String;
  fpath:string;
  fname:string;
  IsPoly:string;
  IsSendToAll:String;
  CompId:String;
  CompName:String;

begin

  param:=  gpGetGeneralParam(cn,'T00');
  baseFOlder:=Trim(param.P_String3);

  if not DirectoryExists(baseFOlder) then begin
      ShowMessage('Base Directory does NOT EXISTS: '+BaseFolder);
//      result:=false;
      exit;
  end;


  qr:=TksQuery.Create(cn,'select * from Seminar where serial_number = :SeminarSerial');
  try
    qr.ParamByName('seminarSerial').Value:=SeminarSerial;
    qr.Open;
    if qr.IsEmpty then begin
//      result:=false;
      exit;
    end;
    SeminarName:=trim(qr.FieldByName('Seminar_name').AsString);
    IsPoly:=qr.FieldByName('Type_mono_poly').AsString;
    qr.Close;

  finally
    qr.free;
  end;

  SeminarFolder:=baseFOlder+'\'+SeminarName+'_'+IntToStr(SeminarSerial);
  if  DirectoryExists(SeminarFOlder) then begin
    MessageDlg('Directory to write the Files already EXISTS. Delete first', mtError, [mbOK], 0);
    exit;
  end else begin
    if not CreateDir(SeminarFOlder) then begin
      ShowMessage('cannot Create Directory: '+SeminarFolder);
      exit;
    end;
  end;

//  fileName:='C:\Data\DelphiProjects\Safe_CRM\documents\Mono_anadForms\temp.doc';

  str2:='Select * from word_docs wd where wd.Poly_mono = :poly and wd.doc_type= :DocType';
  qr:= TksQuery.Create(cn,str2);
  try
      qr.close;
      qr.ParamByName('poly').Value:=isPoly;
      qr.ParamByName('DocTYpe').Value:=DocType;
      qr.open;
      while not qr.Eof do begin
      //for every document
        DocSerial:=qr.FieldByName('SERIAL_NUMBER').AsInteger;
        fileName:=qr.FieldByName('doc_name').AsString;
        IsSendToAll:=qr.FieldByName('Is_send_to_all').AsString;

        if IsSendToAll='N' then begin
          /////////file for the seminar
          fname:= SeminarFolder+'\'+fileName+'.doc';
          CopyaFile(DocSerial,fName);
        end else begin

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
              /////////file for a compnay in its own folder
              useFolder:=SeminarFolder+'\'+trim(compName);
              if  not DirectoryExists(useFOlder) then begin
                    if not CreateDir(useFOlder) then begin
                      ShowMessage('cannot Create Directory: '+UseFolder);
                      exit;
                    end;
              end;
              fname:=UseFOlder+'\'+Trim(compId)+'_'+fileName+'.doc';
              CopyaFile(DocSerial,fName);
              compQR.Next;
            end;
          finally
           CompQr.Free;
          end;

        end;
        qr.Next;
      end;

  finally
    qr.Free;
  end;

end;


procedure TS_LoadDocsFRM.CopyModifiedFile(Const DocSerial:Integer;Const FileName :String);
var
//  BlobField: TField;
  BlobField: TBlobField;
  BS: TStream;
  str2:String;
  qr:TksQuery;
  FS:TMemoryStream;

begin

  str2:='Select * from word_docs wd where wd.Serial_number = :SerialNumber';
  qr:= TksQuery.Create(cn,str2);
  try
      qr.close;
      qr.ParamByName('SerialNumber').Value:=DocSerial;
      qr.open;

      if qr.IsEmpty then
       exit;

      BlobField := qr.FieldByName('doc_blob') as TBlobField;
      BS := qr.CreateBlobStream(BlobField,bmRead);
      try
        fs:=TMemoryStream.Create;
        try
          fs.CopyFrom(bs,bs.Size);
          fs.SaveToFile(fileName);
        finally
          fs.Free;
        end;

      finally
        BS.Free;
      end;

  finally
    qr.Free;
  end;

end;


End.
