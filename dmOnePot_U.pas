unit dmOnePot_U;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TdmOnePot = class(TDataModule)
    conOnePot: TADOConnection;
    tblCustomers: TADOTable;
    dscCustomers: TDataSource;
    tblEmployees: TADOTable;
    dscEmployees: TDataSource;
    tblStock: TADOTable;
    dscStock: TDataSource;
    tblMenu: TADOTable;
    dscMenu: TDataSource;
    tblRecipe: TADOTable;
    dscRecipe: TDataSource;
    tblReservations: TADOTable;
    dscReservations: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmOnePot: TdmOnePot;

implementation

{$R *.dfm}

procedure TdmOnePot.DataModuleCreate(Sender: TObject);
begin
//conOnePot.Connected := true;

tblCustomers.Active := true;
tblEmployees.Active := true;
tblStock.Active := true;
tblMenu.Active := true;
tblRecipe.Active := true;
tblReservations.Active := true;
end;

end.
