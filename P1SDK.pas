unit P1SDK;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  TfrmDevKit = class(TForm)
    tmr60FPS: TTimer;
    tmrDuration: TTimer;
    tmrSizePicture: TTimer;
    procedure tmrSizePictureTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function TestFunc: String;
    procedure SizePicture(Picture: TImage; Scale, Period: integer);
  end;

var
  frmDevKit: TfrmDevKit;
  // SizePicture
  iSPScale: integer;
  imgSPPicture: TImage;
  iSPDuration: integer;
  /// //
  arrFunctions: Array [1 .. 10] of boolean;
  // 1 for SizePicture

implementation

{$R *.dfm}
{ TfrmDevKit }

procedure TfrmDevKit.SizePicture(Picture: TImage; Scale, Period: integer);
begin

  { iSizePicture := 0;
    tmrDuration.interval := Period * 1000; // Speed of animation
    tmrDuration.enabled := true;
    tmr60FPS.enabled := true; }

  iSPDuration := Period * 60;
  tmrSizePicture.enabled := true;

  iSPScale := Scale;
end;

function TfrmDevKit.TestFunc: String;
begin
  result := 'YEEEEEEHAWWWWW';
end;

procedure TfrmDevKit.tmrSizePictureTimer(Sender: TObject);
begin

  if iSPDuration > 0 then
  begin
//Its chai
  imgSPPicture.Height := imgSPPicture.Height + iSPScale;
  imgSPPicture.Width := imgSPPicture.Width + iSPScale;
  dec(iSPDuration);

  end;

end;

end.
