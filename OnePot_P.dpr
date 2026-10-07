program OnePot_P;

uses
  Forms,
  Welcome_U in 'Welcome_U.pas' {frmWelcome},
  frmLogIn_U in 'frmLogIn_U.pas' {frmLogIn},
  P1SDK in 'P1SDK.pas' {frmDevKit},
  Dash_U in 'Dash_U.pas' {frmMain},
  dmOnePot_U in 'dmOnePot_U.pas' {dmOnePot: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmOnePot, dmOnePot);
  Application.CreateForm(TfrmWelcome, frmWelcome);
  Application.CreateForm(TfrmLogIn, frmLogIn);
  Application.CreateForm(TfrmDevKit, frmDevKit);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
