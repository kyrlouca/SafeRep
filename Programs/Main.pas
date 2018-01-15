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
    wwButton2: TwwButton;
    procedure wwButton1Click(Sender: TObject);
    procedure wwButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainFRM: TMainFRM;

implementation

{$R *.dfm}

uses U_Database, G_KyrSQL, R_word_issonos_1, G_generalProcs, R_AnadFIles,
  S_LoadDocs;

procedure TMainFRM.wwButton1Click(Sender: TObject);
begin
 gpShowModal(TS_LoadDocsFRM);
end;

procedure TMainFRM.wwButton2Click(Sender: TObject);
begin
gpShowModal(TR_Word_issonos_1FRM);
end;

end.
