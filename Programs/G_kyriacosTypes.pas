unit G_kyriacosTypes;
interface
uses classes,sysutils,IBC;

Type


TCustomerRecord= Record
        Name:string ;
        Code :Integer;
        District:String;
        CustomerAccount:Integer;
        IsPrivate:String;
        AUTHORITY_TO_AGENT :String;
        AUTHORITY_TO_DHL :String;        
        Comments:String;
        Telephone:String;
End;
TTariffRecord= Record
        UserKeyword:string ;
        Code :String;
        Description:String;
        IRate: Double;
        IPerQuantity:Double;
        IBase:double;
        Trl:Double;
End;

TSTariffRecord= Record
        Serial:Integer;
        UserKeyword:string ;
        Code :String;
        Description:String;
End;
{
  ThawbRec =Record
    SerialNumber:integer;
    HawbId:String;
    RelieveCode:string;
  End;
}

TSortInfo = record
    Table:TIBCQuery;
    CurrentSortField:String;
    CurrentSortClause :String;
    IsSorted:Boolean;
    IsSortedAsc:Boolean;
    SerialNumber:Integer;
  end;



implementation

end.


