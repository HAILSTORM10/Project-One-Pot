program OnePot_P;

uses
  Forms,
  Welcome_U in 'Welcome_U.pas' {frmWelcome},
  frmLogIn_U in 'frmLogIn_U.pas' {frmLogIn},
  P1SDK in 'P1SDK.pas' {frmDevKit};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmWelcome, frmWelcome);
  Application.CreateForm(TfrmLogIn, frmLogIn);
  Application.CreateForm(TfrmDevKit, frmDevKit);
  Application.Run;
end.
