unit Dash_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls, ComCtrls, StdCtrls, ADODB, DB, dmOnePot_U, Grids,
  DBGrids;

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
    Image1: TImage;
    Image2: TImage;
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
  tblStock: TADOTable;

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

procedure TfrmMain.btnRegisterClick(Sender: TObject);
begin

   frmDevKit.CreateUser(edtName.Text, edtSurname.Text, edtPass.Text, rgpRole.Items[rgpRole.ItemIndex][1]);

  // Add new user to DB
  frmLogIn.tblEmployees.Append;
  frmLogIn.tblEmployees['empID'] := P1SDK.sNewUID;
  frmLogIn.tblEmployees['empName'] := edtName.Text;
  frmLogIn.tblEmployees['empSurname'] := edtSurname.Text;
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
  tblStock := dmOnePot.tblStock

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
begin

  // pnlInventory.Top := -720;
  pnlInventory.Show;
  // frmdevKit.PanelSlide(pnlInventory, 'D');

end;

end.
