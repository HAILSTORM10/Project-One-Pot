unit frmLogIn_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls;

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
  private
    { Private declarations }
  public
    { Public declarations }
    sUser: String;
    bLoggedIn: boolean;
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
  sUser, sPass, sLine, sUID, sDecrypted: String;
  i, iStep: integer;
begin
  // Has data been entered?
  if (edtUser.Text = '') OR (edtLPass.Text = '') then
  begin
    Showmessage('Please provide both a Username and Password!');
    exit;
  end;

  if NOT FileExists('UserData.txt') then
  begin
    Showmessage('Create a User');
    exit;
  end;

  // Loop through file and find user + pass
  AssignFile(tUsrDat, 'UserData.txt');
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
var
  tUsrDat: TextFile;
  sNewUser, sNewPass: string;
  bUser, bPass: boolean;
  i, iSpecial: integer;
begin

  // pnlLogin.Enabled := False;
  // pnlSignUp.Enabled := True;
  frmDevKit.PanelSlide(pnlSignUp, 'L', 90);

  { frmSignUp.show;
    frmLogIn.Hide; }

  { // Add a User

    // Vet UserName
    bUser := false;

    while NOT bUser do
    begin

    sNewUser := InputBox('User Creation', 'Enter your name', '');

    if sNewUser = '' then
    begin
    Showmessage('User Creation Cancelled');
    exit;
    end;

    if Length(sNewUser) < 3 then // Longer than 3 Chars?
    begin
    Showmessage('Enter a name longer than 3 characters');
    end
    else // No special Chars?
    begin

    iSpecial := 0;

    for i := 1 to Length(sNewUser) do
    if NOT(sNewUser[i] IN ['A' .. 'Z', 'a' .. 'z', ' ']) then
    inc(iSpecial);

    if iSpecial > 0 then
    begin
    Showmessage('Your name can consist only of letters and spaces');
    end
    else
    bUser := True;

    end; // END Check

    end; // END While
    // End Vet UserName

    // Vet Password
    iSpecial := 0;
    bPass := false;

    while NOT bPass do
    begin

    sNewPass := InputBox('User Creation', 'Enter your Password', '');

    if sNewPass = '' then
    begin
    Showmessage('User Creation Cancelled');
    exit;
    end;

    if Length(sNewPass) < 8 then
    begin
    Showmessage('Password must consist of 8+ Characters');
    end
    else
    begin

    for i := 1 to Length(sNewPass) do
    if NOT(sNewPass[i] IN ['A' .. 'Z', 'a' .. 'z']) then
    inc(iSpecial);

    if iSpecial <= 0 then
    begin
    Showmessage('Your password must contain a special character');
    end
    else
    bPass := True;

    end; // END If

    end; // END While
    // END Vet Password

    AssignFile(tUsrDat, 'UserData.txt');

    // Create or modify credentials files
    if Not FileExists('UserData.txt') then
    begin
    Rewrite(tUsrDat);
    end
    else
    begin
    Append(tUsrDat);
    end;

    Writeln(tUsrDat, sNewUser + '#' + sNewPass);
    CloseFile(tUsrDat);
    Showmessage('Created User: ' + sNewUser + '!'); }

end;

procedure TfrmLogIn.btnSRegClick(Sender: TObject);
var
  tUsrDat: TextFile;
  sUID, sEncrypted: string;
  i, iSpecial, iNum, iNum2, iStep: integer;
begin
  // Add a User

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

  AssignFile(tUsrDat, 'UserData.txt');

  // Create or modify credentials files
  if Not FileExists('UserData.txt') then
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
  Showmessage('Created User: ' + edtSName.Text + '!' + #13 + 'User ID: ' + sUID);
  frmLogIn.show;
  frmSignUp.Hide;
  // End Credentials File

  // Add new user to DB
  dmOnePot.tblCustomers.Append;
  dmOnePot.tblCustomers['CusID'] := sUID;
  dmOnePot.tblCustomers['CusName'] := edtSName.Text;
  dmOnePot.tblCustomers['CusSurname'] := edtSurname.Text;
  dmOnePot.tblCustomers.Post;
  // END DB
end;

procedure TfrmLogIn.imgExitClick(Sender: TObject);
begin
Application.Terminate;
end;

end.
