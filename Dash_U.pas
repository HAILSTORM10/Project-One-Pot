unit Dash_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls, ComCtrls, StdCtrls, ADODB, DB, dmOnePot_U, Grids,
  DBGrids, Spin, CheckLst, DateUtils;

type
  TfrmMain = class(TForm)
    pgcMain: TPageControl;
    tabCustomer: TTabSheet;
    tabEmployee: TTabSheet;
    tabAdmin: TTabSheet;
    imgAdminBG: TImage;
    imgExitAdmin: TImage;
    imgExitEmp: TImage;
    pnlInventory: TPanel;
    imgInventory: TImage;
    imgAccounts: TImage;
    imgMenu: TImage;
    imgLogOut: TImage;
    dbgStock: TDBGrid;
    lbxRestock: TListBox;
    lblExpired: TLabel;
    btnRestock: TButton;
    btnIncStock: TButton;
    btnDecStock: TButton;
    btnDelStock: TButton;
    btnAddIngredient: TButton;
    pnlAccounts: TPanel;
    dbgCustomers: TDBGrid;
    lblCustomers: TLabel;
    lblEmployees: TLabel;
    dbgEmployees: TDBGrid;
    btnBan: TButton;
    edtName: TEdit;
    edtSurname: TEdit;
    edtPass: TEdit;
    btnRegister: TButton;
    rgpRole: TRadioGroup;
    pnlMenu: TPanel;
    pgcMenu: TPageControl;
    tabEdit: TTabSheet;
    tabAdd: TTabSheet;
    clbMenuAdd: TCheckListBox;
    edtRecipe: TEdit;
    sedPrepTime: TSpinEdit;
    btnMenuAdd: TButton;
    dbgMenu: TDBGrid;
    btnEditName: TButton;
    imgStats: TImage;
    pnlStats: TPanel;
    cmbStats: TComboBox;
    redStats: TRichEdit;
    lblMoney: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    edtPhoneNumber: TEdit;
    dtpDOB: TDateTimePicker;
    Label5: TLabel;
    cbxPosition: TComboBox;
    imgBackgroundCus: TImage;
    imgExitCus: TImage;
    pnlBookingsCus: TPanel;
    lbxBookings: TListBox;
    lblMyBookinng: TLabel;
    redBookings: TRichEdit;
    lblMakeBooking: TLabel;
    dtpMakeBooking: TDateTimePicker;
    Label3: TLabel;
    spnPeople: TSpinEdit;
    btnDeleteBooking: TButton;
    Label4: TLabel;
    edtRequest: TEdit;
    Label6: TLabel;
    lblRequest: TLabel;
    btnMakeBooking: TButton;
    imgLoyal: TImage;
    imgBookings: TImage;
    imgLogOutCus: TImage;
    pnlLoyalty: TPanel;
    lblName: TLabel;
    redLoyalty: TRichEdit;
    imgBackgroundEMP: TImage;
    imgMenuEmp: TImage;
    pnlMenuEMP: TPanel;
    lbxMenu: TListBox;
    edtSearch: TEdit;
    btnAddtoCart: TButton;
    redReceipt: TRichEdit;
    btnRingUp: TButton;
    imgLogOutEMP: TImage;
    imgTables: TImage;
    pnlTables: TPanel;
    dbgTables: TDBGrid;
    lblTable: TLabel;
    redTables: TRichEdit;
    btnDeleteReservation: TButton;
    imgBackInv: TImage;
    Image1: TImage;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    imgBackStats: TImage;
    Label10: TLabel;
    imgMenuBack: TImage;
    Image2: TImage;
    Label11: TLabel;
    Image3: TImage;
    Label12: TLabel;
    imgBackLoyalty: TImage;
    Image4: TImage;
    Label13: TLabel;
    Image5: TImage;
    btnFire: TButton;
    procedure imgExitAdminClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgExitEmpClick(Sender: TObject);
    procedure imgInventoryClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure btnDecStockClick(Sender: TObject);
    procedure btnIncStockClick(Sender: TObject);
    procedure btnDelStockClick(Sender: TObject);
    procedure btnAddIngredientClick(Sender: TObject);
    procedure btnBanClick(Sender: TObject);
    procedure btnRegisterClick(Sender: TObject);
    procedure imgAccountsClick(Sender: TObject);
    procedure imgMenuClick(Sender: TObject);
    procedure btnMenuAddClick(Sender: TObject);
    procedure btnEditNameClick(Sender: TObject);
    procedure cmbStatsChange(Sender: TObject);
    procedure imgStatsClick(Sender: TObject);
    procedure btnRestockClick(Sender: TObject);
    procedure imgLogOutClick(Sender: TObject);
    procedure rgpRoleClick(Sender: TObject);
    procedure edtRequestChange(Sender: TObject);
    procedure btnMakeBookingClick(Sender: TObject);
    procedure imgBookingsClick(Sender: TObject);
    procedure lbxBookingsClick(Sender: TObject);
    procedure imgLoyalClick(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
    procedure imgMenuEmpClick(Sender: TObject);
    procedure btnAddtoCartClick(Sender: TObject);
    procedure btnRingUpClick(Sender: TObject);
    procedure dbgTablesCellClick(Column: TColumn);
    procedure imgTablesClick(Sender: TObject);
    procedure btnDeleteReservationClick(Sender: TObject);
    procedure imgBackInvClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure imgBackStatsClick(Sender: TObject);
    procedure imgMenuBackClick(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure imgBackLoyaltyClick(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure btnFireClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    tblStock, tblMenu, tblRecipe, tblReserve, tblCusts: TADOTable;
  end;

var
  frmMain: TfrmMain;
  arrCart: Array of String;

CONST
  arrWages: Array [0 .. 3] of Real = (800.00, 700.00, 300.00, 250.00);

implementation

uses frmLogIn_U, P1SDK, Welcome_U;
{$R *.dfm}

procedure TfrmMain.FormShow(Sender: TObject);
var
  tRestData: TextFile;
  sMoney: string;
begin
  // Load Appropriate Page
  case frmLogIn.sUID[1] of
    'C':
      pgcMain.ActivePage := tabCustomer;
    'E':
      pgcMain.ActivePage := tabEmployee;
    'A':
      pgcMain.ActivePage := tabAdmin;
  end;

  tblStock := dmOnePot.tblStock;
  tblMenu := dmOnePot.tblMenu;
  tblRecipe := dmOnePot.tblRecipe;
  tblReserve := dmOnePot.tblReservations;
  tblCusts := dmOnePot.tblCustomers;

  // Load Money
  AssignFile(tRestData, 'DataFiles\ResturantData.txt');

  if NOT FileExists('DataFiles\ResturantData.txt') then
  begin
    Rewrite(tRestData);
    Writeln(tRestData, '100000');
    lblMoney.Caption := FloatTOStrF(100000, ffCurrency, 8, 2);
    CloseFile(tRestData);
    exit;
  end
  else
    Reset(tRestData);

  Readln(tRestData, sMoney);
  lblMoney.Caption := FloatTOStrF(StrToFloat(sMoney), ffCurrency, 8, 2);
  CloseFile(tRestData);
  // End Money

  // Clear Past Reservations
  tblReserve.first;
  while NOT tblReserve.Eof do
  begin
    if tblReserve['Reserved'] then
      if tblReserve['DateReserved'] < Date then
      begin
        tblReserve.edit;
        tblReserve['cusID'] := '';
        tblReserve['Reserved'] := False;
        tblReserve['DateReserved'] := null;
        tblReserve['specRequests'] := '';
        tblReserve.Post;
      end;

    tblReserve.Next;
  end;

end;

// Admin Code

procedure TfrmMain.btnAddIngredientClick(Sender: TObject);
var
  sInput: string;
  i: integer;
begin

  tblStock.Append;

  // Vet Name to store
  sInput := Inputbox('Adding an ingredient', 'Ingredients Name:', 'Ben'); ;
  if Length(sInput) > 20 then
  begin
    Showmessage('Name should be 20 characters or less!');
    exit;
  end;
  tblStock['Ingredients'] := sInput;

  tblStock['MaxQuantity'] := StrToInt(Inputbox('Adding an ingredient',
      'Maximum number we can hold:', '999'));

  // Vet Quantity to store
  sInput := Inputbox('Adding an ingredient', 'How much we have:', '0');

  if StrToInt(sInput) < 0 then
  begin
    Showmessage('We cannot have negative amounts of ingredients!');
    exit;
  end;
  tblStock['Quantity'] := StrToInt(sInput);

  // Vet Currency to store
  sInput := (Inputbox('Adding an ingredient', 'Cost per unit of item:',
      '10.00'));

  if NOT(sInput = '') then
  begin
    for i := 1 to Length(sInput) do
      if NOT(sInput[i] IN ['0' .. '9', '.']) then
      begin
        Showmessage('Enter a valid real number');
        exit;
      end;
  end
  else
  begin
    Showmessage('Value cannot be blank!');
    exit;
  end;

  tblStock['Cost'] := StrToFloat(sInput);
  tblStock.Post;
end;

procedure TfrmMain.btnBackClick(Sender: TObject);
begin
  pnlInventory.Hide;
end;

procedure TfrmMain.btnBanClick(Sender: TObject);
var
  sName: string;
begin

  sName := frmLogIn.tblCustomers['cusName'] + frmLogIn.tblCustomers
    ['cusSurname'];

  if MessageDlg('Ban ' + sName + ' from resturant?', mtWarning, mbYesNo, 0)
    = mrYes then
  begin
    frmLogIn.tblCustomers.Delete;

  end
  else
  begin
    Showmessage('Operation Cancelled');
    exit;
  end;

  frmDevKit.DeleteUser(sName);
  Showmessage('Banned ' + sName + ' from resturant.');
end;

procedure TfrmMain.btnDecStockClick(Sender: TObject);
begin
  tblStock.edit;
  tblStock['Quantity'] := tblStock['Quantity'] - 1;
  tblStock.Post;
end;

procedure TfrmMain.btnDelStockClick(Sender: TObject);
var
  sItem: string;
begin

  sItem := tblStock['Ingredients'];

  if MessageDlg('Delete ' + sItem + '?', mtWarning, mbYesNo, 0) = mrYes then
  begin
    tblStock.Delete;
    Showmessage('Removed ' + sItem + ' from the stock list.');
  end;
end;

procedure TfrmMain.btnEditNameClick(Sender: TObject);
var
  sRecipe: string;
begin

  sRecipe := tblMenu['Recipe'];
  tblMenu.edit;
  tblMenu['Recipe'] := Inputbox('Renaming', 'Rename ' + sRecipe + ' to:',
    sRecipe);
  tblMenu.Post;
end;

procedure TfrmMain.btnFireClick(Sender: TObject);
var
  sMessage, sUser: string;
  bCurrent: boolean;
begin

  sUser := dmOnePot.tblEmployees['empName'] + ' ' + dmOnePot.tblEmployees
    ['empSurname'];

  // Check if current user is under fire
  bCurrent := False;
  if dmOnePot.tblEmployees['empID'] = frmLogIn.sUID then
  begin
    sMessage := 'Would you like to quit?';
    bCurrent := true;
  end
  else
    sMessage := 'Fire ' + sUser + '?';

  if MessageDlg(sMessage, mtWarning, mbYesNo, 0) = mrYes then
  begin
    dmOnePot.tblEmployees.Delete;
  end
  else
  begin
    Showmessage('Operation Cancelled!');
    exit;
  end;

  // Log Current user out if Quit
  if bCurrent then
  begin
    pnlAccounts.Top := -720;
    frmMain.Hide;
    frmWelcome.show;
  end;

  // Removes user from login text file
  frmDevKit.DeleteUser(sUser);
  Showmessage('Sucessfully removed ' + sUser);
end;

procedure TfrmMain.btnIncStockClick(Sender: TObject);
begin
  tblStock.edit;
  tblStock['Quantity'] := tblStock['Quantity'] + 1;
  tblStock.Post;
  // Remember to deduct money
end;

procedure TfrmMain.btnMenuAddClick(Sender: TObject);
var
  i, iMenuID, iIngID, iQuantity: integer;
  bContinue: boolean;
begin

  // Vet Name
  if Length(edtRecipe.Text) > 25 then
  begin
    Showmessage('Recipe name should be 25 Characters or less');
    edtRecipe.SetFocus;
    exit;
  end;
  if edtRecipe.Text = '' then
  begin
    Showmessage('Recipe name cannot be blank');
    edtRecipe.SetFocus;
    exit;
  end;

  // Vet preptime
  if sedPrepTime.Value <= 0 then
  begin
    Showmessage('Prep time should be greater than 0');
    exit;
  end;

  // Ensure atleast one ingredient checked
  bContinue := False;
  for i := 1 to clbMenuAdd.Count - 1 do
    if clbMenuAdd.Checked[i] then
      bContinue := true;
  if NOT bContinue then
  begin
    Showmessage('Select at least 1 ingredient');
    exit;
  end;

  // Add Basic item Details
  tblMenu.Append;

  tblMenu['Recipe'] := edtRecipe.Text;
  tblMenu['PrepTime'] := sedPrepTime.Value;
  tblMenu['TimesSold'] := 0;

  tblMenu.Post;

  // Link Menu and ingredients through tblRecipe
  for i := 0 to clbMenuAdd.Items.Count - 1 do
  begin

    if clbMenuAdd.Checked[i] then
    begin

      iMenuID := tblMenu['MenuID'];

      // Loop through tblStock to find ingredient ID
      tblStock.first;
      while NOT tblStock.Eof do
      begin

        if tblStock['Ingredient'] = clbMenuAdd.Items[i] then
        begin
          iIngID := tblStock['IngID'];
          iQuantity := StrToInt
            (Inputbox('Adding ' + edtRecipe.Text + ' to menu',
              'How many portions of ' + tblStock['Ingredient'] + '?', '1'));

          tblRecipe.Append;
          tblRecipe['MenuID'] := iMenuID;
          tblRecipe['IngID'] := iIngID;
          tblRecipe['rcpQuantity'] := iQuantity;
          tblRecipe.Post;

        end;
        // END ID Looping

        tblStock.Next;
      end; // END WHILE

    end; // END if Checked

  end; // END For

  Showmessage('Added ' + edtRecipe.Text + '!');

end;

procedure TfrmMain.btnRegisterClick(Sender: TObject);
begin

  frmDevKit.CreateUser(edtName.Text, edtSurname.Text, edtPass.Text,
    edtPhoneNumber.Text, dtpDOB.Date, rgpRole.Items[rgpRole.ItemIndex][1]);

  // Add new user to DB
  frmLogIn.tblEmployees.Append;
  frmLogIn.tblEmployees['empID'] := frmLogIn.sUID;
  frmLogIn.tblEmployees['empName'] := edtName.Text;
  frmLogIn.tblEmployees['empSurname'] := edtSurname.Text;
  frmLogIn.tblEmployees['empPhoneNumber'] := edtPhoneNumber.Text;
  frmLogIn.tblEmployees['empDOB'] := dtpDOB.Date;

  // Assign Role and Wage
  if cbxPosition.ItemIndex = -1 then
  begin
    frmLogIn.tblEmployees['empPosition'] := 'Manager';
    frmLogIn.tblEmployees['empWage'] := 900;
  end
  else
  begin
    frmLogIn.tblEmployees['empPosition'] := cbxPosition.Text;
    frmLogIn.tblEmployees['empWage'] := arrWages[cbxPosition.ItemIndex];
  end;

  frmLogIn.tblEmployees.Post;
  // END DB

end;

procedure TfrmMain.btnRestockClick(Sender: TObject);
var
  i: integer;
  tRestData: TextFile;
  rCost: Real;
begin
  tblStock.first;
  rCost := 0;

  for i := 0 to lbxRestock.Items.Count - 1 do
  begin

    while NOT tblStock.Eof do
    begin

      if lbxRestock.Items[i] = tblStock['Ingredient'] then
      begin

        rCost := rCost + tblStock['Cost'] *
          (tblStock['MaxQuantity'] - tblStock['Quantity']);
        tblStock['Quantity'] := tblStock['MaxQuantity'];

        if rCost > StrToFloat(lblMoney.Caption) then
        begin
          Showmessage('No monee :(');
          lblMoney.Caption := '0.00';
          exit;
        end;

      end;
      tblStock.Next;
    end; // END While

  end; // END For

  // Save monetary changes to label and file
  lblMoney.Caption := FloatTOStrF(StrToFloat(lblMoney.Caption) - rCost,
    ffCurrency, 8, 2);

  AssignFile(tRestData, 'DataFiles\ResturantData.txt');
  Rewrite(tRestData);
  Writeln(tRestData, FloatTOStr(rCost));
  CloseFile(tRestData);

  lbxRestock.Items.Clear;
  Showmessage('All Listed Items Restocked!');

end;

procedure TfrmMain.Image1Click(Sender: TObject);
begin
  pnlAccounts.Top := -720;
end;

procedure TfrmMain.imgBackStatsClick(Sender: TObject);
begin
  pnlStats.Top := -720;
end;

procedure TfrmMain.imgBackInvClick(Sender: TObject);
begin
  pnlInventory.Top := -720;
end;

procedure TfrmMain.imgAccountsClick(Sender: TObject);
begin

  frmDevKit.PanelSlide(pnlAccounts, 'D');

end;

procedure TfrmMain.imgExitAdminClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmMain.imgExitEmpClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmMain.imgInventoryClick(Sender: TObject);
var
  dtItem, dtExpire: TDateTime;
begin
  pnlInventory.show;
  frmDevKit.PanelSlide(pnlInventory, 'D');

  // Determine Stock
  lbxRestock.Items.Clear;

  tblStock.first;
  while NOT tblStock.Eof do
  begin

    dtItem := tblStock['LastRestock'];
    dtExpire := dtItem + tblStock['ShelfLife'];

    if (dtExpire < Date) or (tblStock['Quantity'] = 0) then
      lbxRestock.Items.Add(tblStock['Ingredient']);

    tblStock.Next;
  end; // END While
  // END Stock

end;

procedure TfrmMain.imgLogOutClick(Sender: TObject);
begin
  // Clear User Details and return to log in
  frmLogIn.show;
  frmMain.Hide;
  frmLogIn.bLoggedIn := False;

  frmLogIn.sUID := '';
  frmLogIn.sUser := '';
end;

procedure TfrmMain.imgMenuBackClick(Sender: TObject);
begin
  pnlMenu.Top := -720;
end;

procedure TfrmMain.imgMenuClick(Sender: TObject);
begin

  frmDevKit.PanelSlide(pnlMenu, 'D');
  // Add ingredients to List Box on "Add" Tab

  tblStock.first;

  while NOT tblStock.Eof do
  begin
    clbMenuAdd.Items.Add(tblStock['Ingredient']);
    tblStock.Next;
  end;
  // END Ingredients

end;

procedure TfrmMain.imgStatsClick(Sender: TObject);
begin
  // pnlStats.Top := 0;
  frmDevKit.PanelSlide(pnlStats, 'D');
end;

procedure TfrmMain.rgpRoleClick(Sender: TObject);
begin

  // Only display position box if not manager
  if rgpRole.ItemIndex = 1 then
  begin
    cbxPosition.show;
  end
  else
  begin
    cbxPosition.Hide;
    cbxPosition.ItemIndex := -1;
  end;

end;

procedure TfrmMain.cmbStatsChange(Sender: TObject);
begin

  case cmbStats.ItemIndex of

    0:
      redStats.Lines.Add(frmDevKit.MostBought + ' is the most bought item');

    1:
      redStats.Lines.Add(frmDevKit.MostProfit + ' is the most profitable item');

    2:
      redStats.Lines.Add(frmDevKit.MostLoyal + ' is the most loyal customer')
  end;

end;

// END Admin Code

// Customer Code

procedure TfrmMain.Image3Click(Sender: TObject);
begin
  pnlBookingsCus.Top := -720;
end;

procedure TfrmMain.imgBackLoyaltyClick(Sender: TObject);
begin
  pnlLoyalty.Top := -720;
end;

procedure TfrmMain.edtRequestChange(Sender: TObject);
begin
  lblRequest.Caption := 'Characters remaining: ' + IntToStr
    (40 - Length(edtRequest.Text))
end;

procedure TfrmMain.btnMakeBookingClick(Sender: TObject);
var
  iPeople: integer;
  bSuccess: boolean;
begin

  iPeople := spnPeople.Value;
  tblReserve.first;
  bSuccess := False;

  // Vet SpecRequest to add to DB
  if Length(edtRequest.Text) > 40 then
  begin
    Showmessage('Please limit your request to 40 characters or less');
    exit;
  end;
  // Vet party size
  if spnPeople.Value < 0 then
  begin
    Showmessage('Party size must be greater than 0');
    exit;
  end;

  while NOT tblReserve.Eof do
  begin
    // If table isn't reserved and can seat everyone, book it
    if NOT tblReserve['Reserved'] then
    begin
      if iPeople <= tblReserve['Seating'] then
      begin
        tblReserve.edit;
        tblReserve['CusID'] := frmLogIn.sUID;
        tblReserve['Reserved'] := true;
        tblReserve['DateReserved'] := Dateof(dtpMakeBooking.Date);
        tblReserve['SpecRequests'] := edtRequest.Text;
        tblReserve.Post;
        bSuccess := true;
        break;
      end
      else
        tblReserve.Next;

    end;

    tblReserve.Next;
  end;

  // Report outcome to user
  if NOT bSuccess then
  begin
    Showmessage('Unable to make booking!' + #13 +
        'No tables are available on ' + DateToStr
        (dtpMakeBooking.Date) + ' for ' + IntToStr(spnPeople.Value)
        + ' people!');
    exit;
  end
  else
  begin
    Showmessage('Created booking on ' + DateToStr(dtpMakeBooking.Date)
        + ' for ' + IntToStr(spnPeople.Value) + ' successfully!' + #13 +
        'Look forward to seeing you!');
  end;

  // clear details
  spnPeople.Value := 0;
  edtRequest.Text := '';
  lblRequest.Hide;

  // Increase number of total bookings made by user
  tblCusts.first;
  while NOT tblCusts.Eof do
  begin
    if tblCusts['cusID'] = frmLogIn.sUID then
    begin
      tblCusts.edit;
      tblCusts['cusTotalReservations'] := tblCusts['cusTotalReservations'] + 1;
      tblCusts.Post;
      break;
    end;
    tblCusts.Next;
  end;

  // List all of the users bookings
  frmDevKit.ListUserBookings;

end;

procedure TfrmMain.imgBookingsClick(Sender: TObject);
begin

  frmDevKit.PanelSlide(pnlBookingsCus, 'D');
  frmDevKit.ListUserBookings;

  // Disallow past dates from being chosen
  dtpMakeBooking.MinDate := Date;

end;

procedure TfrmMain.lbxBookingsClick(Sender: TObject);
begin

  // Find Reservation then Display Details
  tblReserve.first;
  while NOT tblReserve.Eof do
  begin

    if (tblReserve['cusID'] = frmLogIn.sUID) AND
      (tblReserve['DateReserved'] = lbxBookings.Items[lbxBookings.ItemIndex])
      then
    begin

      with redBookings.Lines do
      begin
        Clear;
        Add('Date: ' + FormatDateTime('dddd, dd mmmm yyyy',
            tblReserve['DateReserved']));
        Add('Table Number: ' + IntToStr(tblReserve['TableNumber']));
        Add('Special Requests: ' + tblReserve['specRequests']);

      end; // END With
    end; // END If

    tblReserve.Next;
  end; // END While

end;

procedure TfrmMain.imgLoyalClick(Sender: TObject);
var
  dtJoinDate, dtBirthday: TDateTime;
  iReservations: integer;
begin

  frmDevKit.PanelSlide(pnlLoyalty, 'D');
  lblName.Caption := frmLogIn.sUser;

  // Loop table for customer details
  tblCusts.first;
  while NOT tblCusts.Eof do
  begin

    if tblCusts['cusID'] = frmLogIn.sUID then
    begin
      dtJoinDate := tblCusts['CusJoinDate'];
      dtBirthday := tblCusts['cusDOB'];
      iReservations := tblCusts['cusTotalReservations'];
      break;
    end;

    tblCusts.Next;
  end;

  with redLoyalty.Lines do
  begin
    Clear;
    Add('Member since ' + FormatDateTime('mmmm dd, yyyy', dtJoinDate));
    Add('Total Reservations you`ve made: ' + IntToStr(iReservations));

    // Determine Loyalty Status based on reservations
    case iReservations of

      0 .. 4:
        Add('Member Status: Bronze');

      5 .. 9:
        Add('Member Status: Silver');

      10 .. 14:
        Add('Member Status: Gold');

    else
      Add('Member Status: Platinum');

    end; // END Case

    if FormatDateTime('dd mmmm', dtBirthday) = FormatDateTime('dd mmmm', Date)
      then
      Add(#13 + 'Happy Birthday!');

  end; // END With

end;
// End Customer Code

// Employee Code

procedure TfrmMain.imgMenuEmpClick(Sender: TObject);
begin

  frmDevKit.PanelSlide(pnlMenuEMP, 'D');
  frmDevKit.LoadMenu;
  frmMain.edtSearch.Clear;

  // Set up redReceipt
  with redReceipt do
  begin
    Clear;
    Paragraph.TabCount := 2;
    Paragraph.Tab[0] := 100;
    Paragraph.Tab[1] := 200;
    Lines.Add('Item' + #9 + 'Price');
    Lines.Add('--------------------------------------------')
  end;
end;

procedure TfrmMain.edtSearchChange(Sender: TObject);
begin

  // Reload Menu if Search is blank
  if NOT(edtSearch.Text = '') then
  begin
    lbxMenu.Clear;

    tblMenu.first;
    while NOT tblMenu.Eof do
    begin
      // If sSearch is found in Recipe, display it
      if POS(UpperCase(edtSearch.Text), UpperCase(tblMenu['Recipe'])) > 0 then
        lbxMenu.Items.Add(tblMenu['Recipe']);

      tblMenu.Next;
    end; // END While

  end; // END If

  if edtSearch.Text = '' then
  begin
    frmDevKit.LoadMenu;
  end;

end;

procedure TfrmMain.btnRingUpClick(Sender: TObject);
var
  i: integer;
  rTotal: Real;
  tMoney: TextFile;
  sMoney: string;
begin

  // Calculate total to charge and Use stock
  rTotal := 0;

  for i := 0 to Length(arrCart) - 1 do
  begin
    rTotal := rTotal + frmDevKit.ItemPrice(arrCart[i]);
    frmDevKit.DecreaseStock(arrCart[i]);
  end;

  // Update Admin Panel and Textfile
  AssignFile(tMoney, 'DataFiles\ResturantData.txt');
  Reset(tMoney);
  Readln(tMoney, sMoney);
  CloseFile(tMoney);

  lblMoney.Caption := FloatTOStrF((StrToFloat(sMoney)) + rTotal, ffCurrency, 8,
    2);

  AssignFile(tMoney, 'DataFiles\ResturantData.txt');
  Rewrite(tMoney);
  Writeln(tMoney, FloatTOStr(StrToFloat(sMoney) + rTotal));
  CloseFile(tMoney);

  Showmessage('Charged ' + FloatTOStrF(rTotal, ffCurrency, 8, 2) + #13 +
      'Don`t forget to thank the customer!');

  // Clear for next use
  SetLength(arrCart, 0);
  redReceipt.Clear;
  pnlMenuEMP.Top := -720;
end;

procedure TfrmMain.btnAddtoCartClick(Sender: TObject);
var
  sItem: string;
begin
  // Add selected item to array and receipt
  sItem := lbxMenu.Items[lbxMenu.ItemIndex];
  SetLength(arrCart, Length(arrCart) + 1);
  arrCart[Length(arrCart) - 1] := sItem;

  redReceipt.Lines.Add(sItem + #9 + FloatTOStrF(frmDevKit.ItemPrice(sItem),
      ffCurrency, 8, 2));

end;

procedure TfrmMain.dbgTablesCellClick(Column: TColumn);
begin

  // If table is booked, display details

  with redTables.Lines do
  begin
    Clear;
    if tblReserve['Reserved'] then
    begin

      Add('Table Number: ' + #9 + IntToStr(tblReserve['TableNumber']));
      Add('Date: ' + #9 + DateToStr(tblReserve['DateReserved']));

      // Loop Table to find Customer Name
      tblCusts.first;
      while NOT tblCusts.Eof do
      begin

        if tblCusts['cusID'] = tblReserve['cusID'] then
        begin
          Add('Reserved by: ' + #9 + tblCusts['cusName'] + ' ' + tblCusts
              ['cusSurname']);
          break;
        end; // END If

        tblCusts.Next;
      end; // END While

      if NOT(tblReserve['SpecRequests'] = null) then
        Add('Special Request:' + #9 + tblReserve['SpecRequests']);
    end
    // END If Reserved
    else
      Add('Table has no booking!');

  end; // END With
end;

procedure TfrmMain.imgTablesClick(Sender: TObject);
begin

  frmDevKit.PanelSlide(pnlTables, 'D');

  // Set up redTables
  with redTables do
  begin
    Clear;
    Paragraph.TabCount := 2;
    Paragraph.Tab[0] := 100;
    Paragraph.Tab[1] := 150;
  end;

end;

procedure TfrmMain.Image4Click(Sender: TObject);
begin
  pnlTables.Top := -720;
end;

procedure TfrmMain.Image5Click(Sender: TObject);
begin
  pnlMenuEMP.Top := -720;
end;

procedure TfrmMain.btnDeleteReservationClick(Sender: TObject);
begin

  if MessageDlg('Delete The Selected Reservation?', mtWarning, mbYesNo, 0)
    = mrYes then
  begin
    tblReserve.edit;
    tblReserve['CusID'] := null;
    tblReserve['Reserved'] := False;
    tblReserve['DateReserved'] := null;
    tblReserve['SpecRequests'] := null;
    tblReserve.Post;
    Showmessage('Successfully Deleted the Reservation!');

  end
  else
    Showmessage('Deletion Cancelled');
end;

// END Employee Code

end.
