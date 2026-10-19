unit frmLogIn_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls, Grids, DBGrids, ADODB, DB;

type
  TfrmLogIn = class(TForm)
    imgLIBackdrop: TImage;
    lblLHeader: TLabel;
    lblLSubheadder: TLabel;
    btnLogin: TButton;
    edtUser: TEdit;
    edtLPass: TEdit;
    btnLReg: TButton;
    pnlLogin: TPanel;
    pnlSignUp: TPanel;
    imgSBackdrop: TImage;
    edtSName: TEdit;
    edtSPass: TEdit;
    edtSurname: TEdit;
    btnSReg: TButton;
    lblSHeader: TLabel;
    lblSSubheader: TLabel;
    btnBack: TButton;
    imgExit: TImage;
    procedure btnLRegClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure btnSRegClick(Sender: TObject);
    procedure imgExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sUser, sUID: String;
    bLoggedIn: boolean;
    tblCustomers, tblEmployees: TADOTable;
  end;

var
  frmLogIn: TfrmLogIn;
  sPass: string;

implementation

uses Welcome_U, Dash_U, SignUp_U, P1SDK, dmOnePot_U;
{$R *.dfm}

procedure TfrmLogIn.btnBackClick(Sender: TObject);
begin
  // pnlSignUp.Enabled := False;
  // pnlLogin.Enabled := True;
  // frmDevKit.PanelSlide(pnlSignUp, 'R', 90);

  pnlSignUp.Hide;

end;

procedure TfrmLogIn.btnLoginClick(Sender: TObject);
Var
  tUsrDat: TextFile;
  sPass, sLine, sDecrypted: String;
  i, iStep: integer;
begin
  // Has data been entered?
  if (edtUser.Text = '') OR (edtLPass.Text = '') then
  begin
    Showmessage('Please provide both a Username and Password!');
    exit;
  end;

  // Admin Log In
  if (edtUser.Text = 'Admin') AND (edtLPass.Text = 'Admin') then
  begin
    sUID := 'Admin';
    frmMain.Show;
    frmLogIn.Hide;
    exit;
  end;

  // Regular Login
  if NOT FileExists('DataFiles\UserData.txt') then
  begin
    Showmessage('Create a User');
    exit;
  end;

  // Loop through file and find user + pass
  AssignFile(tUsrDat, 'DataFiles\UserData.txt');
  Reset(tUsrDat);

  repeat
    ReadLn(tUsrDat, sLine);
    sUser := Copy(sLine, 1, POS('~#', sLine) - 1);
    Delete(sLine, 1, POS('~#', sLine) + 1);
    sPass := Copy(sLine, 1, POS('~#', sLine) - 1);
    Delete(sLine, 1, POS('~#', sLine) + 1);
    sUID := sLine;

    // Showmessage(sUser + sPass + sUID);
  until EOF(tUsrDat) OR (sUser = edtUser.Text);

  if sUser <> edtUser.Text then
  begin
    Showmessage('User Not Found');
    CloseFile(tUsrDat);
    exit;
  end;

  // Password Decryption
  iStep := StrTOInt(sPass[1]) + StrTOInt(sPass[Length(sPass)]);
  sDecrypted := '';

  for i := 2 to Length(sPass) - 1 do
    sDecrypted := sDecrypted + Chr(ORD(sPass[i]) - iStep);
  // END Decryption

  // Showmessage(sDecrypted + ' ' + edtLPass.Text);

  if sDecrypted <> edtLPass.Text then
  begin
    Showmessage('Password Incorrect');
    CloseFile(tUsrDat);
    exit;
  end;

  CloseFile(tUsrDat);

  bLoggedIn := True;
  frmMain.Show;
  frmLogIn.Hide;
  edtUser.Clear;
  edtLPass.Clear;

end;

procedure TfrmLogIn.btnLRegClick(Sender: TObject);
begin

  pnlSignUp.Left := 1280;
  pnlSignUp.Show;
  frmDevKit.PanelSlide(pnlSignUp, 'L');

end;

procedure TfrmLogIn.btnSRegClick(Sender: TObject);
begin

  frmDevKit.CreateUser(edtSName.Text, edtSurname.Text, edtSPass.Text, 'C');

  // Add new user to DB
  tblCustomers.Append;
  tblCustomers['CusID'] := sUID;
  tblCustomers['CusName'] := edtSName.Text;
  tblCustomers['CusSurname'] := edtSurname.Text;
  tblCustomers.Post;
  // END DB


end;

procedure TfrmLogIn.FormShow(Sender: TObject);
begin
  tblCustomers := dmOnePot.tblCustomers;
  tblEmployees := dmOnePot.tblEmployees;

end;

procedure TfrmLogIn.imgExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

end.
