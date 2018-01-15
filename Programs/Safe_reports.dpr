program Safe_reports;

uses
  Vcl.Forms,
  Main in 'Main.pas' {MainFRM},
  G_KyrSQL in 'G_KyrSQL.pas',
  U_Database in 'U_Database.pas' {U_databaseFRM: TDataModule},
  R_word_issonos_1 in 'R_word_issonos_1.pas' {R_Word_issonos_1FRM},
  G_generalProcs in 'G_generalProcs.pas',
  R_AnadFIles in 'R_AnadFIles.pas' {R_AnadFilesFRM},
  S_LoadDocs in 'S_LoadDocs.pas' {S_LoadDocsFRM};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TU_databaseFRM, U_databaseFRM);
  Application.CreateForm(TMainFRM, MainFRM);
  Application.CreateForm(TU_databaseFRM, U_databaseFRM);
  Application.CreateForm(TR_Word_issonos_1FRM, R_Word_issonos_1FRM);
  Application.CreateForm(TR_AnadFilesFRM, R_AnadFilesFRM);
  Application.CreateForm(TS_LoadDocsFRM, S_LoadDocsFRM);
  Application.Run;
end.
