unit Welcome_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, jpeg, pngimage, StdCtrls, DB, ADODB, ShellAPI;

type
  TfrmWelcome = class(TForm)
    imgBackdrop: TImage;
    lblHeader: TLabel;
    lblSubHeader: TLabel;
    lblTagline: TLabel;
    Label3: TLabel;
    Button1: TButton;
    imgExit: TImage;
    lblHelp: TLabel;
    procedure imgExitClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lblFlavourClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lblHelpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmWelcome: TfrmWelcome;
  arrFlavour: Array of String;
  lblFlavour: TLabel;

implementation

uses P1SDK, frmLogIn_U; // Project One SDK, Linked to frmDevKit
{$R *.dfm}
{ TfrmWelcome }

procedure TfrmWelcome.Button1Click(Sender: TObject);
begin

  frmLogIn.show;
  frmWelcome.Hide;

end;

procedure TfrmWelcome.FormCreate(Sender: TObject);
begin
  // Dynamically create lblFlavour
  lblFlavour := TLabel.Create(self);
  With lblFlavour do
  begin
    Parent := self;
    Left := 580;
    Top := 624;
    font.Color := clWhite;
    font.Size := 10;
    font.Style := [fsbold];
    Alignment := taCenter;
    Width := 288;
    OnClick := lblFlavourClick;
  end;
end;

procedure TfrmWelcome.FormShow(Sender: TObject);
var
  tFlavour: TextFile;
  sFlavour: String;
begin
  // Load Flavour Text
  assignFile(tFlavour, 'DataFiles\FlavourText.txt');
  Reset(tFlavour);

  while NOT Eof(tFlavour) do
  begin
    SetLength(arrFlavour, length(arrFlavour) + 1);
    readLN(tFlavour, sFlavour);
    arrFlavour[length(arrFlavour) - 1] := sFlavour;
  end;

  SetLength(arrFlavour, length(arrFlavour) + 1);
  arrFlavour[length(arrFlavour) - 1] := 'Try the ' + frmDevKit.MostBought + '!';

  lblFlavour.Caption := arrFlavour[Random(length(arrFlavour))];
  CloseFile(tFlavour);
end;

procedure TfrmWelcome.imgExitClick(Sender: TObject);
begin

  Application.Terminate;

end;

procedure TfrmWelcome.lblFlavourClick(Sender: TObject);
begin
  lblFlavour.Caption := arrFlavour[Random(length(arrFlavour))];
end;

procedure TfrmWelcome.lblHelpClick(Sender: TObject);
begin

//Open the GitHub ReadMe File
  ShellExecute(Handle, 'open', PChar('https://github.com/HAILSTORM10/Project-One-Pot/blob/ddf5d21e4c8c4fcc941bbe36d9fa2235931dc6c6/README.md'), nil, nil,
    SW_SHOWNORMAL);
end;

end.
