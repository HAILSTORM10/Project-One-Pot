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
    lbxOutofStock: TListBox;
    lblOutofStock: TLabel;
    lbxExpired: TListBox;
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
  tblStock, tblMenu, tblRecipe: TADOTable;

implementation

uses frmLogIn_U, P1SDK;
{$R *.dfm}

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

  // Determine Expired Stock
  lbxExpired.Items.Clear;

  tblStock.first;
  while NOT tblStock.Eof do
  begin

    dtItem := tblStock['LastRestock'];
    dtExpire := dtItem + tblStock['ShelfLife'];

    if dtExpire < date then
    begin

      lbxExpired.Items.Add(tblStock['Ingredient']);

    end;

    tblStock.Next;
  end; // END While
  // END Expired

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

end.
