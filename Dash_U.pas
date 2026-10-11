unit Dash_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls, ComCtrls, StdCtrls, ADODB, DB, dmOnePot_U, Grids,
  DBGrids, Spin, CheckLst;

type
  TfrmMain = class(TForm)
    pgcMain: TPageControl;
    tabCustomer: TTabSheet;
    tabEmployee: TTabSheet;
    tabAdmin: TTabSheet;
    imgAdminBG: TImage;
    imgExitAdmin: TImage;
    imgExitEmp: TImage;
    imgExitCust: TImage;
    pnlInventory: TPanel;
    imgInventory: TImage;
    imgAccounts: TImage;
    imgMenu: TImage;
    imgLogOut: TImage;
    dbgStock: TDBGrid;
    btnBack: TButton;
    lbxRestock: TListBox;
    lblExpired: TLabel;
    btnRestock: TButton;
    btnIncStock: TButton;
    btnDecStock: TButton;
    btnDelStock: TButton;
    btnAddIngredient: TButton;
    btnBackup: TButton;
    btnRestore: TButton;
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
    edtCostPrice: TEdit;
    edtSellPrice: TEdit;
    btnMenuBack: TButton;
    btnMenuAdd: TButton;
    dbgMenu: TDBGrid;
    btnEditName: TButton;
    btnBackAccount: TButton;
    imgStats: TImage;
    pnlStats: TPanel;
    cmbStats: TComboBox;
    redStats: TRichEdit;
    lblMoney: TLabel;
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
    procedure btnMenuBackClick(Sender: TObject);
    procedure btnMenuAddClick(Sender: TObject);
    procedure btnEditNameClick(Sender: TObject);
    procedure btnBackAccountClick(Sender: TObject);
    procedure cmbStatsChange(Sender: TObject);
    procedure imgStatsClick(Sender: TObject);
    procedure btnRestockClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    tblStock, tblMenu, tblRecipe: TADOTable;
  end;

var
  frmMain: TfrmMain;

implementation

uses frmLogIn_U, P1SDK;
{$R *.dfm}

// Admin Code
procedure TfrmMain.btnAddIngredientClick(Sender: TObject);
begin
  tblStock.Append;
  tblStock['Ingredients'] := Inputbox('Adding an ingredient',
    'Ingredients Name:', 'Ben');
  tblStock['MaxQuantity'] := StrToInt(Inputbox('Adding an ingredient',
      'Maximum number we can hold:', '999'));
  tblStock['Quantity'] := StrToInt(Inputbox('Adding an ingredient',
      'How much we have:', '0'));
  tblStock['Cost'] := StrToInt(Inputbox('Adding an ingredient',
      'Cost per unit of item:', ''));
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

  sName := frmLogIn.tblCustomers['cusName'];

  if MessageDlg('Ban ' + sName + ' from resturant?', mtWarning, mbYesNo, 0)
    = mrYes then
  begin
    frmLogIn.tblCustomers.Delete;
    showmessage('Banned ' + sName + ' from resturant.');
  end;
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
    showmessage('Removed ' + sItem + ' from the stock list.');
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
begin
  // Add Basic item Details
  tblMenu.Append;

  tblMenu['Recipe'] := edtRecipe.text;
  tblMenu['PrepTime'] := sedPrepTime.Value;
  tblMenu['TimesSold'] := 0;
  tblMenu['rcpCost'] := 0;
  tblMenu['rcpSellPrice'] := 0;

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
            (Inputbox('Adding ' + edtRecipe.text + ' to menu',
              'How many portions of ' + tblStock['Ingredient'] + '?', '1'));
        end;
        // END ID Looping

        tblRecipe.Append;
        tblRecipe['Recipe'] := iMenuID;
        tblRecipe['Ingredient'] := iIngID;
        tblRecipe['rcpQuantity'] := iQuantity;
        tblRecipe.Post;

        tblStock.Next;
      end; // END WHILE

    end; // END if Checked

  end; // END For

  showmessage('Added ' + edtRecipe.text + '!');

end;

procedure TfrmMain.btnMenuBackClick(Sender: TObject);
begin
  pnlMenu.Top := -720;
end;

procedure TfrmMain.btnRegisterClick(Sender: TObject);
begin

  frmDevKit.CreateUser(edtName.text, edtSurname.text, edtPass.text,
    rgpRole.Items[rgpRole.ItemIndex][1]);

  // Add new user to DB
  frmLogIn.tblEmployees.Append;
  frmLogIn.tblEmployees['empID'] := P1SDK.sNewUID;
  frmLogIn.tblEmployees['empName'] := edtName.text;
  frmLogIn.tblEmployees['empSurname'] := edtSurname.text;
  frmLogIn.tblEmployees.Post;
  // END DB

end;

procedure TfrmMain.btnRestockClick(Sender: TObject);
var
  i: integer;
  tRestData: TextFile;
begin
  // Remember to charge for it
  tblStock.first;

  for i := 0 to lbxRestock.Items.Count - 1 do
  begin

    while NOT tblStock.Eof do
    begin

      if lbxRestock.Items[i] = tblStock['Ingredient'] then
      begin

        tblStock['Quantity'] := tblStock['MaxQuantity'];

      end;

    end; // END While

  end; // END For

  lbxRestock.Items.Clear;
  showmessage('All Listed Items Restocked!');

end;

procedure frmMain.btnBackAccountClick(Sender: TObject);
begin
  pnlAccounts.Top := -720;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  case frmLogIn.sUID[1] of
    'C':
      pgcMain.ActivePage := tabCustomer;
    'E':
      pgcMain.ActivePage := tabEmployee;
    'A':
      pgcMain.ActivePage := tabAdmin;
  end;

  pnlInventory.Hide;
  tblStock := dmOnePot.tblStock;
  tblMenu := dmOnePot.tblMenu;
  tblRecipe := dmOnePot.tblRecipe;

end;

procedure TfrmMain.imgAccountsClick(Sender: TObject);
begin
  pnlAccounts.Top := 0;
  pnlAccounts.Show;
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

  // pnlInventory.Top := -720;
  pnlInventory.Top := 0;
  pnlInventory.Show;
  // frmdevKit.PanelSlide(pnlInventory, 'D');

  // Determine Stock
  lbxRestock.Items.Clear;

  tblStock.first;
  while NOT tblStock.Eof do
  begin

    dtItem := tblStock['LastRestock'];
    dtExpire := dtItem + tblStock['ShelfLife'];

    if (dtExpire < date) or (tblStock['Quantity'] = 0) then
      lbxRestock.Items.Add(tblStock['Ingredient']);

    tblStock.Next;
  end; // END While
  // END Stock

end;

procedure TfrmMain.imgMenuClick(Sender: TObject);
begin

  pnlMenu.Top := 0;

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
var
  tRestData: TextFile;
  sMoney: string;
begin
  pnlStats.Top := 0;

  // Load Money
  AssignFile(tRestData, 'DataFiles\ResturantData.txt');

  if NOT FileExists('DataFiles\ResturantData.txt') then
  begin
    Rewrite(tRestData);
    Writeln('100000');
    lblMoney.Caption := FloatToStrF(100000, ffCurrency, 8, 2);
    CloseFile(tRestData);
    exit;
  end
  else
    Reset(tRestData);

  Readln(tRestData, sMoney);
  lblMoney.Caption := FloatToStrF(StrToFloat(sMoney), ffCurrency, 8, 2);
  CloseFile(tRestData);

end;

// END Admin

procedure TfrmMain.cmbStatsChange(Sender: TObject);
begin

  case cmbStats.ItemIndex of

    0:
      redStats.Lines.Add(frmDevKit.MostBought + ' is the most bought item');

  end;

end;

end.
