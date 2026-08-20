unit SignUp_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmSignUp = class(TForm)
    edtName: TEdit;
    edtSurname: TEdit;
    edtPass: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSignUp: TfrmSignUp;

implementation

uses frmLogIn_U;
{$R *.dfm}

procedure TfrmSignUp.Button1Click(Sender: TObject);
var
  tUsrDat: TextFile;
  sUID, sEncrypted: string;
  i, iSpecial, iNum, iNum2, iStep: integer;
begin
  // Add a User

  // Vet UserName

  if (edtName.Text = '') OR (edtSurname.Text = '') then
  begin
    Showmessage('Please enter Your Name and Surname');
    exit;
  end;

  if edtPass.Text = '' then
  begin
    Showmessage('Please Enter a Password');
    exit;
  end;

  iSpecial := 0;

  for i := 1 to Length(edtName.Text) do
    if (NOT(UPCase(edtName.Text[i]) IN ['A' .. 'Z', ' '])) then
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

  if Length(edtPass.Text) < 8 then
  begin
    Showmessage('Password must consist of 8+ Characters');
    exit;
  end
  else
  begin

    for i := 1 to Length(edtPass.Text) do
      if NOT(edtPass.Text[i] IN ['A' .. 'Z', 'a' .. 'z']) then
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

  for i := 1 to Length(edtPass.Text) do
    sEncrypted := sEncrypted + Chr(Ord(edtPass.Text[i]) + iStep);

  sEncrypted := sEncrypted + inttostr(iNum2);

  // End Encryption

  AssignFile(tUsrDat, 'UserData.txt');

  // Create or modify credentials files
  if Not FileExists('UserData.txt') then
  begin
    Rewrite(tUsrD at);
  end
  else
  begin
    Append(tUsrDat);
  end;

  sUID := 'C' + UPCase(edtName.Text[1]) + UPCase(edtSurname.Text[1]) + inttostr
    ((Random(11)) * 1000 + Random(100));

  Writeln(tUsrDat,
    edtName.Text + ' ' + edtSurname.Text + '#' + sEncrypted + '#' + sUID);
  CloseFile(tUsrDat);
  Showmessage('Created User: ' + edtName.Text + '!' + #13 + 'User ID: ' + sUID);
  frmLogin.show;
  frmSignUp.Hide;
end;

end.
