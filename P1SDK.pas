unit P1SDK;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  TfrmDevKit = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }

    procedure PanelSlide(Panel: TPanel; cDirection: Char);
    procedure CreateUser(sName, sSurname, sPass: String; cRole: Char);

  end;

var
  frmDevKit: TfrmDevKit;
  sNewUID: string;

implementation

{$R *.dfm}
{ TfrmDevKit }

procedure TfrmDevKit.CreateUser(sName, sSurname, sPass: String; cRole: Char);
var
  tUsrDat: TextFile;
  sEncrypted: string;
  i, iSpecial, iNum, iNum2, iStep: integer;
begin

  // Add a User

  // Ensure No blanks

  if (sName = '') OR (sSurname = '') then
  begin
    Showmessage('Please enter Your Name and Surname');
    Abort;
  end;

  if sPass = '' then
  begin
    Showmessage('Please Enter a Password');
    Abort;
  end;
  // END Blanks

  // Vet UserName

  iSpecial := 0;

  for i := 1 to Length(sName) do
    if (NOT(UPCase(sName[i]) IN ['A' .. 'Z', ' '])) then
      inc(iSpecial);

  for i := 1 to Length(sSurname) do
    if (NOT(UPCase(sSurname[i]) IN ['A' .. 'Z', ' '])) then
      inc(iSpecial);

  if iSpecial > 0 then
  begin
    Showmessage('Your name can consist only of letters and spaces');
    Abort;
  end;
  // End Vet UserName

  // Vet Password
  iSpecial := 0;

  if Length(sPass) < 8 then
  begin
    Showmessage('Password must consist of 8+ Characters');
    Abort;
  end
  else
  begin

    for i := 1 to Length(sPass) do
      if NOT(sPass[i] IN ['A' .. 'Z', 'a' .. 'z']) then
        inc(iSpecial);

    if iSpecial <= 0 then
    begin
      Showmessage(inttostr(iSpecial));
      Showmessage('Your password must contain a special character');
      Abort;
    end;

  end; // END If

  // END Vet Password

  // Encrypt Password
  iNum := Random(5) + 1;
  iNum2 := Random(5) + 1;
  iStep := iNum + iNum2;

  sEncrypted := inttostr(iNum);

  for i := 1 to Length(sPass) do
    sEncrypted := sEncrypted + Chr(ORD(sPass[i]) + iStep);

  sEncrypted := sEncrypted + inttostr(iNum2);

  // End Encryption

  AssignFile(tUsrDat, 'DataFiles\UserData.txt');

  // Create or modify credentials files
  if FileExists('DataFiles\UserData.txt') then
  begin
    Append(tUsrDat);
  end
  else
  begin
    Rewrite(tUsrDat);
  end;

  sNewUID := cRole + UPCase(sName[1]) + UPCase(sSurname[1]) + inttostr
    ((Random(11)) * 1000 + Random(1000));

  Writeln(tUsrDat, sName + ' ' + sSurname + '~#' + sEncrypted + '~#' + sNewUID);
  CloseFile(tUsrDat);
  Showmessage('Created User: ' + sName + '!' + #13 + 'User ID: ' + sNewUID);

  // End Credentials File

end;

procedure TfrmDevKit.PanelSlide(Panel: TPanel; cDirection: Char);
var
  iLimit, iDirection, iSpeed: integer;
begin

  iSpeed := 90;

  // case cDirection of

  { 'L':
    begin
    while Panel.Left <> 0 do
    begin
    if Panel.Left - iSpeed < 0then
    begin
    Panel.Left := 0;
    end
    else
    begin
    Panel.Left := Panel.Left - iSpeed;
    sleep(5);
    end; // End IF
    end; // End While
    end; // END L

    'R':
    begin

    while Panel.Left <> iNum do
    begin

    if Panel.Left + iSpeed > 1280 then
    begin
    Panel.Left := 1280;
    end
    else
    begin
    Panel.Left := Panel.Left + iSpeed;
    sleep(5);
    end; // END If
    end; // END While

    end; // END R
    end; }

  // end;

  case cDirection of

    'L':
      begin
        iSpeed := iSpeed * -1;
        iLimit := 0;
      end;

    'R':
      iLimit := 1280;

    'U':
      begin
        iSpeed := iSpeed * -1;
        iLimit := 0;
      end;

    'D':
      iLimit := 0;

  end;

  { if cDirection = 'L' then
    begin

    end
    else
    iNum := 1280; }

  if cDirection IN ['L', 'R'] then // Moving left or Right
  begin

    while Panel.Left <> iLimit do
    begin

      if Panel.Left + iSpeed < iLimit then
      begin
        Panel.Left := iLimit;
      end
      else
      begin
        Panel.Left := Panel.Left + iSpeed;
        sleep(5);
      end;
    end;

  end // End Moving Left or RIght
  else // Moving Up or Down
  begin
    while Panel.Left <> iLimit do
    begin

      if Panel.Top + iSpeed < iLimit then
      begin
        Panel.Top := iLimit;
      end
      else
      begin
        Panel.Top := Panel.Top + iSpeed;
        sleep(5);
      end;
    end;

  end; // ENd up Down
end;

end.
