unit G_KyrSQL;

// CLASS:
//*****************************************
// Easiest Function for single line. Use this one if you don't need transaction control
//** CANNOT user quoted params. provide them in params array instead
//ksExecSQL(cn,'delete from unit_measure where serial_number = :serial',['4']);
//
//
//*****************************************
// to Create query on the fly
{
  Try
    qr:=TksQuery.Create(cn,'select count(*) as cnt from hawb_item where fk_hawb_serial= :HawbSerial');
    qr.ParamByName('hawbSerial').Value:=HawbSerial;
    qr.Open;
    result:=qr.FieldByName('cnt').AsInteger;
  Finally
    qr.Free;
  End;
}

//*****************************************
// when you need commit for two or more tables
// **ERROR if you get explicit start transaction you need to check your connection
// var   m1:TksMultiSQL;
//try
//  m1:=TksMultiSQL.Create(cn)
//  .add('update unit_measure set xml_code = :code where serial_number= :serial',['zz','2'])
//  .add('update unit_measure set xml_code = :code where serial_number= :serial',['aa','3'])
//  .ExecSQL();
//finally
//  m1.Free();
//end;
//
// will fill the stringlist of the combo, with values from
// remember to set map displayed value if you want to show other value
// ksfillCombo(MainFRM.IBCConnection1,vatFLD.Items,'vat_category','code','rate' );
//
// will fill a TRZRadioGroup with values and display
//  ksfillRadioGroup(cn,ClearanceRGP,'TableName','Key','Description');

interface
uses
  SysUtils, Variants, Classes, Generics.Collections
  , IBCClasses, IBC, MemDS, Data.DB, Forms,
  DBAccess, Wwdbcomb, codeSiteLogging, CodeSiteMessage
  , RzDBRGrp
  ;
type
  TTransactionType = (trRead, trWrite);
  TStringArray = array of string;

  TksMultiSQLLine = class(TObject)
    private sqlString: string;
    private params: TStringList;
    private constructor Create(Sql: string; pParams: array of string);
    private destructor Destroy; override;
    private function display(): string;
    private function add(Sql: string; pParams: array of string): TksMultiSQLLine;
  end;

  TksMultiSQL = class(TObjectList<TksMultiSQLLine>)
    public name: string;
    private mQuery: TIBCSQL;
    private mUpdateTrans: TIBCTransaction;
    private mconnection: TIBCConnection;
    private function addLine(line: TksMultiSQLLine): TksMultiSQLLine;

    public constructor Create(connection: TIBCConnection; AOwnsObjects: Boolean =True);
    public destructor Destroy; override;
    public function add(Sql: string; params: array of string): TksMultiSQL;
    public function clearAll: boolean;
    public function getLine(index: integer): TksMultiSQLLine;
    public function ExecSQL(): TksMultiSQL;

  end;

  TksQuery = class(TIBCQuery)
  private
    fConnection: TIBCConnection;
    frTrans: TIBCTransaction;
    fwTrans: TIBCTransaction;
  public
    constructor Create(const connection: TIBCConnection; const SqlString:
      string); reintroduce;
    destructor Destroy; override;
  end;
function CreateTransaction(const connection: TIBCConnection; const TransType:  TTransactionType): TIBCTransaction; forward;

function ksExecSQLOld(const connection: TIBCConnection; const sql: string;  ParamsArray: array of string): boolean;
function ksExecSQLVar(const connection: TIBCConnection; const sql: string;  InArray: array of Variant): integer;

function ksCountRecSQL(const connection: TIBCConnection; const sql: string;  ParamsArray: array of string): Integer;
function ksCountRecVarSQL(const connection: TIBCConnection; const sql: string;  InArray: array of Variant): integer;

  //  function ksOpenTables(Tables: Array of TDataset):Boolean;
function ksOpenTables(Tables: array of TCustomDADataSet): Boolean;
function ksPostTables(Tables: array of TCustomDADataSet): Boolean;

function ksPrepSQL(const SqlString: string; const TableSQL: TIBCQuery): Boolean;
function ksGenerateSerial(const connection: TIBCConnection; const GenName:  string): integer;

  //  function ksfillCombo(Const connection: TIBCConnection; StrList:TStrings;Const tableName,fieldstored,fieldShown:String ):TStrings;
//  function ksfillCombo2(Const connection: TIBCConnection; StrList:TStrings;Const tableName,fieldstored,fieldShown:String;Const ShowEmpty:Boolean ):TStrings;
//  function ksfillRadioGroup(Const connection: TIBCConnection; RadioGroup:TrzDBRadioGroup;Const tableName,fieldValue,fieldShow:String ):TStrings;

implementation
//******************************************************************

//******************************************************************
//TKSQuery*************************************************

constructor TksQuery.Create(const connection: TIBCConnection; const SqlString:
  string);

// user will need to free this object!
//Transactions will be freed by owner which is the created query
var
  TableSQL: TIBCQuery;
begin
//  codesite.EnterMethod(Self,'creat');
  inherited create(nil);
  fConnection := connection;
  frTrans := createTransaction(fconnection, trRead);
  fwTrans := createTransaction(fconnection, trWrite);

  TableSQL := self;

  try
    TableSQL.Close;
    TableSQL.SQL.Clear;
    TableSQL.SQl.Add(SqlString);
    TableSQL.Connection := fconnection;
    TableSQL.AutoCommit := true;

    TableSQL.Transaction := frTrans;
    TableSQL.UpdateTransaction := fwTrans;
    if not TableSQL.prepared then
      TableSQL.prepare;
  except on E: Exception do
    begin
      raise exception.Create('ERROR ksCreateSQL:' + sqlString + ' ' +
        E.Message);
    end;

  end;

// codesite.ExitMethod(self,'create');
end;

destructor TksQuery.Destroy;
begin
  frTrans.Free;
  fWTrans.Free;
  inherited;
end;
//******************************************************************
// TksMultiSQLLine.Create(sql:String;params:array of String);
//******************************************************************

constructor TksMultiSQLLine.Create(sql: string; pParams: array of string);
var
  I: integer;
begin
  inherited create;
  self.sqlString := sql;
  self.params := TStringList.Create;

  for I := Low(pParams) to High(pParams) do
  begin
    params.Add(pParams[i]);
  end;
  if (params.Count = 100) then
    params[0] := '100';
end;

destructor TksMultiSQLLine.Destroy();
begin
  params.Free;
  inherited;
end;

function TksMultiSQLLine.display(): string;
begin
  result := self.sqlString + '---' + self.params.DelimitedText;

end;

function TksMultiSQLLine.add(Sql: string; pParams: array of string):
  TksMultiSQLLine;
var
  I: Integer;
begin
  self.sqlString := sql;
  self.params.Clear;

  for I := Low(pParams) to High(pParams) do
  begin
    params.Add(pParams[i]);
  end;
  result := self;

end;

//******************************************************************
// TksMultiSQL.Create;
//******************************************************************

constructor TksMultiSQL.Create(connection: TIBCConnection; AOwnsObjects: Boolean
  = True);
begin
  inherited create();
  OwnsObjects := true;
  Name := 'aaa';
  mconnection := connection;
  mUpdateTrans := CreateTransaction(connection, trWrite);
  mQuery := TIBCSQL.Create(nil);
  mQuery.AutoCommit := false;
//  mQuery.Transaction:=mReadTrans;
  mQuery.Transaction := mUpdateTrans;

end;

destructor TksMultiSQL.destroy;
//var
//  line :TksMultiSQLLine;
//  aObj:Tobject;
begin
  mconnection := nil;
  mUpdateTrans.Free;
  mQuery.Free;
  inherited;
// TObjectList will destroy List objects too! (which are TksMultiSQLLines)
// you can clear them if you want!
end;

function TksMultiSQL.add(Sql: string; params: array of string): TksMultiSQL;
var
  line: TksMultiSQLLine;
begin

  line := TksMultiSQLLine.Create(sql, params);
//  self.Items.ad
  addLine(line);
  result := self;

end;

function TksMultiSQL.addLine(line: TksMultiSQLLine): TksMultiSQLLine;
begin
  inherited add(line);
  result := line;
end;

function TksMultiSQL.getLine(index: Integer): TksMultiSQLLine;
begin
  result := self[index];
end;

function TksMultiSQL.clearAll: boolean;
begin
  result := false;
end;

function TksMultiSQL.ExecSQL(): TksMultiSQL;
var
  i, j: Integer;
  line: TksMultiSQLLine;
begin
  result := self;
//    Codesite.Send('TksMultiSQL',self);
  if (mUpdateTrans.Active) then
    mUpdateTrans.Rollback;

  mUpdateTrans.StartTransaction;
//    try

  for i := 0 to self.Count - 1 do
  begin
    line := self.items[i];
    mQuery.SQL.Clear;
        //mQUery.Params.Clear;
    mQuery.UnPrepare;
    mQuery.SQL.text := line.sqlString;
    if not mQuery.Prepared then
      mQuery.Prepare;

    if (mQuery.Params.Count > line.params.Count) then
    begin
          //ShowMessage('Params not correct');
      mQuery.Transaction.Rollback;
      raise Exception.Create('not enought parms in query');
    end;

    for j := 0 to mQuery.Params.Count - 1 do
    begin
      mQuery.Params[j].Value := Line.params[j];
    end;
    mQuery.Execute;
  end;

  if mUpdateTrans.Active then
    mUpdateTrans.Commit;

//   except on E: Exception do begin
//        mUpdateTrans.Rollback;
//        raise E;
//        end;
//
//    end;
end;

//****************************************************************************************

function CreateTransaction(const connection: TIBCConnection; const TransType:
  TTransactionType): TIBCTransaction;

begin
  try
    result := TIBCTransaction.Create(nil);
    if (transType = trWrite) then
    begin
      result.IsolationLevel := iblReadCommitted;
      result.Name := 'WriteTrans';
      result.DefaultConnection := connection;
    end
    else
    begin
      result.IsolationLevel := iblReadOnlyReadCommitted;
      result.Name := 'ReadTrans';
      result.DefaultConnection := connection;
    end;

  except
    Result := nil;

  end;

end;
//////////////

function ksExecSQLOld(const connection: TIBCConnection; const sql: string;
  ParamsArray: array of string): boolean;
var
  i: Integer;
  qr: TIBCSQL;
  wrTrans: TIBCTransaction;

begin
  try

    qr := TIBCSql.Create(nil);
    qr.Connection := connection;
    wrTrans := CreateTransaction(connection, trWrite);
    qr.Transaction := wrTrans;

    qr.AutoCommit := true;
    qr.SQL.Clear;
    qr.SQL.text := sql;
    qr.Prepare;

//      result :=false;
    if (qr.Params.Count <> Length(ParamsArray)) then
    begin
        //ShowMessage('Params not correct');
      raise Exception.Create('parameters number not correct');
    end;

    for i := 0 to (qr.Params.Count - 1) do
    begin
      qr.Params[i].AsString := ParamsArray[i];
    end;

    qr.Execute;
    result := qr.RowsAffected > 0;

  finally
    wrTrans.Free;
    qr.Free;
  end;

end;


function ksCountRecSQL(const connection: TIBCConnection; const sql: string; ParamsArray: array of string): Integer;
//better to use the newer version ksCountRecVarSQL which takes variants as parameters
var
  i: Integer;
  qr: TIBCQuery;
  wrTrans: TIBCTransaction;
  rdTrans: TIBCTransaction;

begin
  try

    qr := TIBCQuery.Create(nil);

    qr.Connection := connection;
    wrTrans := CreateTransaction(connection, trWrite);
    rdTrans := CreateTransaction(connection, trRead);
    qr.Transaction := rdTrans;
    qr.UpdateTransaction := wrTrans;

    qr.AutoCommit := true;
    qr.ReadOnly := true;
    qr.SQL.Clear;
    qr.SQL.text := sql;
    qr.FetchRows := 60000;

    qr.Prepare;

//      result :=false;
    if (qr.Params.Count <> Length(ParamsArray)) then
    begin
        //ShowMessage('Params not correct');
      raise Exception.Create('parameters not equal to params');
    end;

    for i := 0 to (qr.Params.Count - 1) do
    begin
      qr.Params[i].AsString := ParamsArray[i];
    end;

    qr.Open;
    result := qr.RecordCount;

  finally
    wrTrans.Free;
    rdTrans.Free;
    qr.Free;
  end;

end;


function ksCountRecVarSQL(const connection: TIBCConnection; const sql: string;  InArray: array of Variant): integer;
var
  i: Integer;
  qr: TIBCQuery;
  wrTrans: TIBCTransaction;
  rdTrans: TIBCTransaction;

  p, parameter: TDAParam;
  v: Variant;
  x:string;

begin
  try
    qr := TIBCQuery.Create(nil);

    qr.Connection := connection;
    wrTrans := CreateTransaction(connection, trWrite);
    rdTrans := CreateTransaction(connection, trRead);
    qr.Transaction := rdTrans;
    qr.UpdateTransaction := wrTrans;

    qr.AutoCommit := true;
    qr.ReadOnly := true;
    qr.SQL.Clear;
    qr.SQL.text := sql;
    qr.FetchRows := 20000;

    qr.ParamCheck:=true;
    //get the field type of each parameter from the server
    qr.Options.DescribeParams:=true;

    qr.Prepare;


//      result :=false;
    if (qr.Params.Count <> Length(InArray)) then   begin
        //ShowMessage('Params not correct');
      raise Exception.Create('parameters number not correct');
    end;

    for i := 0 to Length(InArray) - 1 do begin

      v := InArray[i];
      parameter := qr.Params[i];
      if VarIsNull(v) then begin  //this is how null is updated
        parameter.Clear
      end else  begin
        case  parameter.DataType of
        ftString,
        ftFixedChar:
          Parameter.AsString := v;
        ftWideString,
        ftFixedWideChar:
          Parameter.AsWideString := v;
        ftSmallint,
        ftInteger,
        ftWord,
        ftByte:
          Parameter.AsInteger := v;
        ftLongWord,
        ftLargeint:
          Parameter.AsLargeInt := v;
        ftShortint,
        ftFloat,
        ftSingle:
          Parameter.AsFloat := v;
        ftCurrency:
          Parameter.AsCurrency := v;
        ftDate:
          Parameter.AsDate := v;
        ftTime,
        ftDateTime,
        ftTimeStamp:
          Parameter.AsDateTime := v;
        else
          raise Exception.Create('Uknown type of Parameter');
        end;

      end;

    end;

    qr.Open;
    result := qr.RecordCount;

  finally
    wrTrans.Free;
    rdTrans.Free;
    qr.Free;
  end;


End;



function ksExecSQLVar(const connection: TIBCConnection; const sql: string;  InArray: array of Variant): integer;
var
  i: Integer;
  qr: TIBCSQL;
  wrTrans: TIBCTransaction;
  p, parameter: TDAParam;
  v: Variant;
  x:string;

begin
  try
    qr := TIBCSql.Create(nil);
    qr.Connection := connection;
    wrTrans := CreateTransaction(connection, trWrite);
    qr.Transaction := wrTrans;

    qr.AutoCommit := true;
    qr.SQL.Clear;
    qr.SQL.text := sql;
    qr.ParamCheck:=true;
    qr.DescribeParams:=true;

    qr.Prepare;

//      result :=false;
    if (qr.Params.Count <> Length(InArray)) then   begin
        //ShowMessage('Params not correct');
      raise Exception.Create('parameters number not correct');
    end;

    for i := 0 to Length(InArray) - 1 do begin
//    Parameter := FIBCQuery.ParamByName(P.ParamName);
      v := InArray[i];
      parameter := qr.Params[i];
      if VarIsNull(v) then begin  //this is how null is updated
        parameter.Clear
      end else  begin
        case  parameter.DataType of
        ftString,
        ftFixedChar:
          Parameter.AsString := v;
        ftWideString,
        ftFixedWideChar:
          Parameter.AsWideString := v;
        ftSmallint,
        ftInteger,
        ftWord,
        ftByte:
          Parameter.AsInteger := v;
        ftLongWord,
        ftLargeint:
          Parameter.AsLargeInt := v;
        ftShortint,
        ftFloat,
        ftSingle:
          Parameter.AsFloat := v;
        ftCurrency:
          Parameter.AsCurrency := v;
        ftDate:
          Parameter.AsDate := v;
        ftTime,
        ftDateTime,
        ftTimeStamp:
          Parameter.AsDateTime := v;
        else
          raise Exception.Create('Uknown type of Parameter');
        end;

      end;

    end;
    qr.Execute;
    result := qr.RowsAffected ;

  finally
    wrTrans.Free;
    qr.Free;
  end;



End;

//////////////
//function ksOpenTables(Tables: Array of TDataset):Boolean;

function ksOpenTables(Tables: array of TCustomDADataSet): Boolean;
var
  I: Integer;
//Table:TIBCQuery;
  Table: TCustomDADataSet;
//name:string;
begin
  for i := low(Tables) to High(Tables) do
  begin
    table := tables[i];
    if (not Table.Active) then
    begin
      Table.open;
    end
    else
      Table.Refresh;
  end;
  result := true;
end;

function ksPostTables(Tables: array of TCustomDADataSet): Boolean;
var
  I: Integer;
  Table: TCustomDADataSet;

begin
  for i := low(Tables) to High(Tables) do begin
    table := tables[i];
    if (Table.State in [dsInsert,dsEdit]) then begin
      Table.Post;
    end;
  end;
  result := true;
end;



function ksGenerateSerial(const connection: TIBCConnection; const GenName:
  string): integer;
var
  qr: TksQuery;
begin
  try
    qr := TksQuery.Create(connection, 'Select next value for ' + GenName +
      ' from RDB$DATABASE');
    qr.Open;
    result := qr.FieldByName('GEN_ID').AsInteger;
  finally
    qr.Free;
  end;

end;

//////////////

function ksPrepSQL(const SqlString: string; const TableSQL: TIBCQuery): Boolean;
begin
  TableSQL.Close;
  TableSQL.SQL.Clear;
  TableSQL.Fields.Clear;
  TableSQL.SQl.Add(SqlString);
  if not TableSQL.Prepared then
    TableSQL.Prepare;
  result := true;
end;
//////////////
{
function ksfillCombo(Const connection: TIBCConnection; StrList:TStrings;Const tableName,fieldstored,fieldShown:String ):TStrings;
 var
  tableSQL: TksQUery;
  str:String;
  val:String;
begin
 try
  StrList.Clear;
  if (trim(fieldShown)>'') then begin
  str:='select '+ fieldStored+ ', '+fieldShown+ ' from '+tableName;
  end else begin
  str:='select '+ fieldStored+ ' from '+tableName;

  end;

  tableSQL:=TksQuery.Create(connection,str);
  With TableSQL do begin
    Open;
    While ( NOT TableSQL.Eof)do begin
                val:=TableSQL.fieldbyName(fieldStored).AsString;
                if Trim(FieldShown)>'' then begin
                  val:=TableSQL.fieldbyName(fieldShown).AsString+#9+val;
                end;
                strList.add(val);
                TableSQL.Next;
    end;
    close;
  end;
     result:=StrList;
 finally
  tableSQL.Free;
 end;

 end;
}
 //////////////

 //////////////////////////////////////////////////////////////////////////////////////////

//////////////

end.

