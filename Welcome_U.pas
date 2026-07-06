unit Welcome_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, jpeg;

type
  TfrmWelcome = class(TForm)
    Image1: TImage;
    procedure Image1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    iTemp : integer;
//    function TestFunc(): string;
  end;



var
  frmWelcome: TfrmWelcome;

implementation
uses P1SDK; // Project One SDK, Linked to frmDevKit
{$R *.dfm}

{ TfrmWelcome }

//function TfrmWelcome.TestFunc: string;
//begin
//
//end;

procedure TfrmWelcome.Image1Click(Sender: TObject);
begin

frmDevKit.SizePicture(Image1, 5, 1);

end;

end.
