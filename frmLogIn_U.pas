unit frmLogIn_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls;

type
  TfrmLogIn = class(TForm)
    imgBackdrop: TImage;
    lblHeader: TLabel;
    lblSubheadder: TLabel;
    btnLogin: TButton;
    edtUser: TEdit;
    edtPass: TEdit;
    btnReg: TButton;
    procedure btnRegClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
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

uses Welcome_U, Dash_U, SignUp_U;
{$R *.dfm}

procedure TfrmLogIn.btnLoginClick(Sender: TObject);
Var
  tUsrDat: TextFile;
  sUser, sPass, sLine, sUID, sDecrypted: String;
  i, iStep: integer;
begin
  // Has data been entered?
  if (edtUser.Text = '') OR (edtPass.Text = '') then
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

  while Not Eof(tUsrDat) OR (sUser <> edtUser.Text) do
  begin

    ReadLn(tUsrDat, sLine);
    sUser := Copy(sLine, 1, POS('#', sLine) - 1);
    Delete(sLine, 1, POS('#', sLine));
    sPass := Copy(sLine, 1, POS('#', sLine) - 1);
    Delete(sLine, 1, POS('#', sLine));
    sUID := sLine;
  end;

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

  if sDecrypted <> edtPass.Text then
  begin
    Showmessage('Password Incorrect');
    exit;
  end;

  bLoggedIn := True;
  frmMain.show;
  frmLogIn.Hide;

end;

procedure TfrmLogIn.btnRegClick(Sender: TObject);
var
  tUsrDat: TextFile;
  sNewUser, sNewPass: string;
  bUser, bPass: boolean;
  i, iSpecial: integer;
begin

  frmSignUp.show;
  frmLogIn.Hide;

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

end.
