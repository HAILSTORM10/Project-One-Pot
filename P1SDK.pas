unit P1SDK;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DateUtils, Math;

type
  TfrmDevKit = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }

    function MostProfit: string;
    function MostBought: string;
    procedure PanelSlide(Panel: TPanel; cDirection: Char);
    procedure CreateUser(sName, sSurname, sPass, sPhone: String;
      dtDOB: TDateTime; cRole: Char);
    procedure ListUserBookings;

  end;

var
  frmDevKit: TfrmDevKit;
  sNewUID: string;

implementation

uses frmLogIn_U, Dash_U, dmOnePot_U;
{$R *.dfm}
{ TfrmDevKit }

procedure TfrmDevKit.CreateUser(sName, sSurname, sPass, sPhone: String;
  dtDOB: TDateTime; cRole: Char);
var
  tUsrDat: TextFile;
  sEncrypted, sTemp: string;
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

  // Vet UserName to store in DB

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
      Showmessage('Your password must contain a special character');
      Abort;
    end;

  end; // END If

  // END Vet Password

  // Vet Phone Number to Store in DB
  if Length(sPhone) <> 10 then
  begin
    Showmessage('Phone Number to be entered in 0123456789 format');
    Abort;
  end;

  for i := 1 to Length(sPhone) do
    if NOT(sPhone[i] IN ['0' .. '9']) then
    begin
      Showmessage('Phone Number may only consist of digits');
      Abort;
    end;
  // End Vet Phone Number

  // Vet Date of Birth to Store in DB
  if YearOf(Now) - YearOf(dtDOB) < 15 then
  begin
    Showmessage('All users must be of 16 years or older');
    Abort;
  end;

  if YearOf(Now) - YearOf(dtDOB) > 120 then
  begin
    Showmessage(
      'The oldest recorded person, as of this apps creation, is 117. I`d say congratulations if I actually believed you.');
    Abort;
  end;
  // END Vet DOB

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

  frmLogIn.sUID := cRole + UPCase(sName[1]) + UPCase(sSurname[1]) + inttostr
    ((Random(11)) * 1000 + Random(1000));

  Writeln(tUsrDat,
    sName + ' ' + sSurname + '~#' + sEncrypted + '~#' + frmLogIn.sUID);
  CloseFile(tUsrDat);
  Showmessage('Created User: ' + sName + '!' + #13 + 'User ID: ' +
      frmLogIn.sUID);

  // End Credentials File

end;

procedure TfrmDevKit.ListUserBookings;
begin
  // Add User Bookings to lbxBookings
  frmMain.lbxBookings.clear;
  dmOnePot.tblReservations.first;
  while NOT dmOnePot.tblReservations.Eof do
  begin

    if dmOnePot.tblReservations['cusID'] = frmLogIn.sUID then
      frmMain.lbxBookings.Items.Add(dmOnePot.tblReservations['DateReserved']);

    dmOnePot.tblReservations.Next;
  end;
end;

function TfrmDevKit.MostBought: string;
var
  sHighest: string;
  iHighest: integer;
begin

  dmOnePot.tblMenu.first;
  iHighest := 0;

  while NOT dmOnePot.tblMenu.Eof do
  begin

    if dmOnePot.tblMenu['TimesSold'] > iHighest then
    begin
      sHighest := dmOnePot.tblMenu['Recipe'];
      iHighest := dmOnePot.tblMenu['TimesSold'];
    end;

    dmOnePot.tblMenu.Next;
  end;

  result := sHighest;

end;

function TfrmDevKit.MostProfit: string;
var
  iSold, iMenu: integer;
  rProfit, rCost, rHighest: real;
  sHighest: string;
begin

  rHighest := 0;
  // Loop through tblMenu to check for each Menu Item
  dmOnePot.tblMenu.first;

  while NOT dmOnePot.tblMenu.Eof do
  begin
    iMenu := dmOnePot.tblMenu['MenuID'];
    iSold := dmOnePot.tblMenu['TimesSold'];
    rCost := 0;

    dmOnePot.tblRecipe.first;
    while NOT dmOnePot.tblRecipe.Eof do
    begin
      // Loop through the Recipe to find ingredients needed
      if dmOnePot.tblRecipe['MenuID'] = iMenu then
      begin

        dmOnePot.tblStock.first;
        while NOT dmOnePot.tblStock.Eof do
        begin
          // Calculate cost based on number of ingredient required
          if dmOnePot.tblStock['IngID'] = dmOnePot.tblRecipe['IngID'] then
          begin
            rCost := rCost + (dmOnePot.tblStock['Cost'] * dmOnePot.tblRecipe
                ['rcpQuantity']);
          end;

          dmOnePot.tblStock.Next;
        end;
      end;

      dmOnePot.tblRecipe.Next;
    end;

    // rCost := rCost * iSold;
    rProfit := (rCost + (rCost * 20 / 100)) * iSold; // Apply 20% markup to cost of ingredients, then times sold

    if rHighest < rProfit then
    begin
      rHighest := rProfit;
      sHighest := dmOnePot.tblMenu['Recipe']
    end;

    dmOnePot.tblMenu.Next;
  end;

  result := sHighest;

end;

procedure TfrmDevKit.PanelSlide(Panel: TPanel; cDirection: Char);
var
  iLimit, iDirection, iSpeed: integer;
begin

  iSpeed := 90;

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

      if Panel.Top + iSpeed > iLimit then
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
