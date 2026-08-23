object frmDevKit: TfrmDevKit
  Left = 0
  Top = 0
  Caption = 'frmDevKit'
  ClientHeight = 231
  ClientWidth = 505
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object tmr60FPS: TTimer
    Enabled = False
    Interval = 17
    Left = 464
    Top = 16
  end
  object tmrDuration: TTimer
    Enabled = False
    Left = 320
    Top = 16
  end
  object tmrSizePicture: TTimer
    Enabled = False
    Interval = 17
    OnTimer = tmrSizePictureTimer
    Left = 392
    Top = 16
  end
  object tmrSlide: TTimer
    Enabled = False
    Interval = 17
    OnTimer = tmrSlideTimer
    Left = 16
    Top = 40
  end
end
