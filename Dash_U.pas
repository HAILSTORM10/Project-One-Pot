unit Dash_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls, ComCtrls, StdCtrls;

type
  TfrmMain = class(TForm)
    PageControl1: TPageControl;
    tabCustomer: TTabSheet;
    tabEmployee: TTabSheet;
    tabAdmin: TTabSheet;
    imgAdminBG: TImage;
    Button1: TButton;
    Panel1: TPanel;
    imgExit: TImage;
    procedure Button1Click(Sender: TObject);
    procedure imgExitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.Button1Click(Sender: TObject);
VAr
Sline, sWord : string;
i : integer;
begin

end;

procedure TfrmMain.imgExitClick(Sender: TObject);
begin
Application.Terminate;
end;

end.
