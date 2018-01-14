unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, vcl.wwdbigrd, vcl.wwdbgrid,
  Data.DB, MemDS, DBAccess, IBC, vcl.wwbutton;

type
  TMainFRM = class(TForm)
    IBCDataSource1: TIBCDataSource;
    PersonSQL: TIBCQuery;
    wwDBGrid1: TwwDBGrid;
    wwButton1: TwwButton;
    procedure wwButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainFRM: TMainFRM;

implementation

{$R *.dfm}

uses U_Database, G_KyrSQL;

procedure TMainFRM.wwButton1Click(Sender: TObject);
begin
ksOpenTables([PersonSQL]);
end;

end.
