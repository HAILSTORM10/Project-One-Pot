program OnePot_P;

uses
  Forms,
  Welcome_U in 'Welcome_U.pas' {frmWelcome},
  frmLogIn_U in 'frmLogIn_U.pas' {frmLogIn},
  P1SDK in 'P1SDK.pas' {frmDevKit},
  Dash_U in 'Dash_U.pas' {frmMain},
  SignUp_U in 'SignUp_U.pas' {frmSignUp},
  dmOnePot_U in 'dmOnePot_U.pas' {dmOnePot: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmWelcome, frmWelcome);
  Application.CreateForm(TfrmLogIn, frmLogIn);
  Application.CreateForm(TfrmDevKit, frmDevKit);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmSignUp, frmSignUp);
  Application.CreateForm(TdmOnePot, dmOnePot);
  Application.Run;
end.
