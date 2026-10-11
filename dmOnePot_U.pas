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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmOnePot: TdmOnePot;

implementation

{$R *.dfm}

end.
