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
    tmrSlide: TTimer;
    procedure tmrSizePictureTimer(Sender: TObject);
    procedure tmrSlideTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function TestFunc: String;
    procedure SizePicture(Picture: TImage; Scale, Period: integer);
    procedure PanelSlide(Panel: TPanel; cDirection: Char; iSpeed: integer);
  end;

var
  frmDevKit: TfrmDevKit;
  // SizePicture
  iSPScale, iPSSpeed: integer;
  imgSPPicture: TImage;
  iSPDuration: integer;
  /// //
  arrFunctions: Array [1 .. 10] of boolean;
  // 1 for SizePicture

  pnlPSPanel: TPanel;
  cPSDirection: Char;

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

procedure TfrmDevKit.PanelSlide(Panel: TPanel; cDirection: Char;
  iSpeed: integer);
var
  iNum: integer;
begin
  {
    pnlPSPanel := Panel;
    cPSDirection := cDirection;
    iPSSpeed := iSpeed;

    case cDirection of

    'L':
    begin

    if Panel.Left > 0 then
    begin
    tmrSlide.enabled := true;
    Panel.Left := Panel.Left - iSpeed;
    end
    else
    tmrSlide.enabled := false;

    end;

    end; }

  case cDirection of

    'L':
      begin
        while Panel.Left <> 0 do
        begin
          if Panel.Left - iSpeed < 0then
          begin
            Panel.Left := 0;
          end
          else
          begin
            Panel.Left := Panel.Left - iSpeed;
            sleep(5);
          end; // End IF
        end; // End While
      end; // END L

    'R':
      begin

        while Panel.Left <> iNum do
        begin

          if Panel.Left + iSpeed > 1280 then
          begin
            Panel.Left := 1280;
          end
          else
          begin
            Panel.Left := Panel.Left + iSpeed;
            sleep(5);
          end; // END If
        end; // END While

      end; // END R
  end;

{  if cDirection = 'L' then
  begin
    iSpeed := iSpeed * -1;
    iNum := 0;
  end
  else
    iNum := 1280;

  while Panel.Left <> iNum do
  begin

    if Panel.Left + iSpeed < iNum then
    begin
      Panel.Left := iNum;
    end
    else
    begin
      Panel.Left := Panel.Left + iSpeed;
      sleep(5);
    end;
  end;}

end;

function TfrmDevKit.TestFunc: String;
begin
  result := 'YEEEEEEHAWWWWW';
end;

procedure TfrmDevKit.tmrSizePictureTimer(Sender: TObject);
begin

  if iSPDuration > 0 then
  begin
    // Its chai
    imgSPPicture.Height := imgSPPicture.Height + iSPScale;
    imgSPPicture.Width := imgSPPicture.Width + iSPScale;
    dec(iSPDuration);

  end;

end;

procedure TfrmDevKit.tmrSlideTimer(Sender: TObject);
begin

  PanelSlide(pnlPSPanel, cPSDirection, iPSSpeed);

end;

end.
