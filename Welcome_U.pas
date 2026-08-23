unit Welcome_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, jpeg, pngimage, StdCtrls, DB, ADODB;

type
  TfrmWelcome = class(TForm)
    imgBackdrop: TImage;
    lblHeader: TLabel;
    lblSubHeader: TLabel;
    lblTagline: TLabel;
    Label3: TLabel;
    Button1: TButton;
    procedure Image1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    iTemp: integer;
    tblCusts, tblEmps: TADOTable;
    // function TestFunc(): string;
  end;

var
  frmWelcome: TfrmWelcome;

implementation

uses P1SDK, frmLogIn_U, dmOnePot_U; // Project One SDK, Linked to frmDevKit
{$R *.dfm}
{ TfrmWelcome }

// function TfrmWelcome.TestFunc: string;
// begin
//
// end;

procedure TfrmWelcome.Button1Click(Sender: TObject);
begin

  frmLogIn.show;
  frmWelcome.Hide;

end;

procedure TfrmWelcome.FormShow(Sender: TObject);
begin
  tblCusts := dmOnePot.tblCustomers;
  tblEmps := dmOnePot.tblEmployees;
end;

procedure TfrmWelcome.Image1Click(Sender: TObject);
begin

  // frmDevKit.SizePicture(Image1, 5, 1);

end;

end.
