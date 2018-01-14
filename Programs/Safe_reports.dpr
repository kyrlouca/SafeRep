program Safe_reports;

uses
  Vcl.Forms,
  Main in 'Main.pas' {MainFRM},
  U_Database in 'U_Database.pas' {U_databaseFRM: TDataModule},
  G_KyrSQL in 'G_KyrSQL.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TU_databaseFRM, U_databaseFRM);
  Application.CreateForm(TMainFRM, MainFRM);
  Application.Run;
end.
