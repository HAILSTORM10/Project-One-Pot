unit Dash_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls, ComCtrls, StdCtrls;

type
  TfrmMain = class(TForm)
    pnlCustomers: TPanel;
    imgCustomerBG: TImage;
    btnReservations: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

end.
