program OnePot_P;

uses
  Forms,
  Welcome_U in 'Welcome_U.pas' {frmWelcome};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmWelcome, frmWelcome);
  Application.Run;
end.
