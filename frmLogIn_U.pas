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
    exit;
  end;

  // Password Decryption
  iStep := StrTOInt(sPass[1]) + StrTOInt(sPass[Length(sPass)]);
  sDecrypted := '';

  for i := 2 to Length(sPass) - 1 do
    sDecrypted := sDecrypted + Chr(ORD(sPass[i]) - iStep);
  // END Decryption

  if sDecrypted <> edtLPass.Text then
  begin
    Showmessage('Password Incorrect');
    exit;
  end;

  bLoggedIn := True;
  frmMain.show;
  frmLogIn.Hide;

end;

procedure TfrmLogIn.btnLRegClick(Sender: TObject);
begin

  pnlSignUp.Left := 1280;
  pnlSignUp.show;
  frmDevKit.PanelSlide(pnlSignUp, 'L');

end;

procedure TfrmLogIn.btnSRegClick(Sender: TObject);
var
  tUsrDat: TextFile;
  sUID, sEncrypted: string;
  i, iSpecial, iNum, iNum2, iStep: integer;
begin

  frmDevKit.CreateUser(edtSName.Text, edtSurname.Text, edtSPass.Text, 'C');

  { // Add a User

    // Ensure No blanks

    if (edtSName.Text = '') OR (edtSurname.Text = '') then
    begin
    Showmessage('Please enter Your Name and Surname');
    exit;
    end;

    if edtSPass.Text = '' then
    begin
    Showmessage('Please Enter a Password');
    exit;
    end;
    // END Blanks

    // Vet UserName

    iSpecial := 0;

    for i := 1 to Length(edtSName.Text) do
    if (NOT(UPCase(edtSName.Text[i]) IN ['A' .. 'Z', ' '])) then
    inc(iSpecial);

    for i := 1 to Length(edtSurname.Text) do
    if (NOT(UPCase(edtSurname.Text[i]) IN ['A' .. 'Z', ' '])) then
    inc(iSpecial);

    if iSpecial > 0 then
    begin
    Showmessage('Your name can consist only of letters and spaces');
    exit;
    end;
    // End Vet UserName

    // Vet Password
    iSpecial := 0;

    if Length(edtSPass.Text) < 8 then
    begin
    Showmessage('Password must consist of 8+ Characters');
    exit;
    end
    else
    begin

    for i := 1 to Length(edtSPass.Text) do
    if NOT(edtSPass.Text[i] IN ['A' .. 'Z', 'a' .. 'z']) then
    inc(iSpecial);

    if iSpecial <= 0 then
    begin
    Showmessage(inttostr(iSpecial));
    Showmessage('Your password must contain a special character');
    exit;
    end;

    end; // END If

    // END Vet Password

    // Encrypt Password
    iNum := Random(9) + 1;
    iNum2 := Random(9) + 1;
    iStep := iNum + iNum2;

    sEncrypted := inttostr(iNum);

    for i := 1 to Length(edtSPass.Text) do
    sEncrypted := sEncrypted + Chr(ORD(edtSPass.Text[i]) + iStep);

    sEncrypted := sEncrypted + inttostr(iNum2);

    // End Encryption

    AssignFile(tUsrDat, 'DataFiles\UserData.txt');

    // Create or modify credentials files
    if Not FileExists('DataFiles\UserData.txt') then
    begin
    Rewrite(tUsrDat);
    end
    else
    begin
    Append(tUsrDat);
    end;

    sUID := 'C' + UPCase(edtSName.Text[1]) + UPCase(edtSurname.Text[1]) + inttostr
    ((Random(11)) * 1000 + Random(1000));

    Writeln(tUsrDat,
    edtSName.Text + ' ' + edtSurname.Text + '~#' + sEncrypted + '~#' + sUID);
    CloseFile(tUsrDat);
    Showmessage('Created User: ' + edtSName.Text + '!' + #13 + 'User ID: ' +
    sUID);

    // End Credentials File }

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
